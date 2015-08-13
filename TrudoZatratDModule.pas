unit TrudoZatratDModule;

interface

uses
  SysUtils, Classes, DModule, IBDatabase, DB, IBCustomDataSet,
  GlobalVocCacheDModule, kbmMemTable, Variants;

type
  Tdm_TrudoZatrat = class(TDataModule)
    dset_tmp: TIBDataSet;
    tran: TIBTransaction;
    mt_WorkTimeAtt: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    F_IsSummerPeriod: boolean;
    procedure CalcTZ( _dset: TDataSet );
  private
    F_WorkID,
    F_DiamID: integer;
    procedure SetWorkDate( const Value: TDateTime );
  private
    F_TrudoZatrat: double;
    F_KolEd: double;
  public
    property WorkDate: TDateTime write SetWorkDate;
    property WorkID: integer read F_WorkID write F_WorkID;
    property DiamID: integer read F_DiamID write F_DiamID;
  public
    property TrudoZatrat: double read F_TrudoZatrat;
    property KolEd: double read F_KolEd;
    property IsSummerPeriod: boolean read F_IsSummerPeriod;
    function CalcTZFormDB: boolean; //получить трудозатраты из бызы
    function CalcTZFromVC: boolean; //получить трудозатраты из кеша справочников
  end;

implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_TrudoZatrat }

function Tdm_TrudoZatrat.CalcTZFormDB: boolean;
begin
  Result := false;

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    MyOpenIBDS( dset_tmp,
      ' select hour_summer, hour_winter,' +
      ' measur_quantity' +
      ' from s_worktime' +
      ' where ( id_work = ' + IntToStr( F_WorkID ) + ' ) and' +
      ' ( id_diam = ' + IntToStr( F_DiamID ) + ' )' );

    if not dset_tmp.IsEmpty then
    begin
      CalcTZ( dset_tmp );
      Result := true;
    end;
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_TrudoZatrat.CalcTZ)' );
    end;
  end;
end;

procedure Tdm_TrudoZatrat.DataModuleCreate(Sender: TObject);
begin
  F_WorkID := -1;
  F_DiamID := -1;
  F_IsSummerPeriod := false;
end;

procedure Tdm_TrudoZatrat.SetWorkDate(const Value: TDateTime);
var
  _Year, _Month, _Day: Word;
  _BeginSummer, _EndSummer: TDateTime;
begin
  DecodeDate( Value, _Year, _Month, _Day );

  _BeginSummer := EncodeDate( _Year, 4, 15 );
  _EndSummer := EncodeDate( _Year, 10, 15 );

  F_IsSummerPeriod := ( ( Value >= _BeginSummer ) and ( Value < _EndSummer ) );
end;

function Tdm_TrudoZatrat.CalcTZFromVC: boolean;
begin
  Result := false;

  dm_GlobalVocCache.CheckVoc( mt_WorkTimeAtt );
  if not mt_WorkTimeAtt.Active then mt_WorkTimeAtt.Open;

  if  mt_WorkTimeAtt.Locate( 'id_work;id_diam', VarArrayOf( [F_WorkID, F_DiamID] ), [] ) then
  begin
    CalcTZ( mt_WorkTimeAtt );
    Result := true;
  end;
end;

procedure Tdm_TrudoZatrat.DataModuleDestroy(Sender: TObject);
begin
  mt_WorkTimeAtt.Close;
end;

procedure Tdm_TrudoZatrat.CalcTZ(_dset: TDataSet);
begin
  if F_IsSummerPeriod then
    F_TrudoZatrat := _dset.FieldByName( 'hour_summer' ).AsFloat
  else
    F_TrudoZatrat := _dset.FieldByName( 'hour_winter' ).AsFloat;

  F_KolEd := _dset.FieldByName( 'measur_quantity' ).AsFloat;
end;

end.
