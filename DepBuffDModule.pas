unit DepBuffDModule;

interface

uses
  SysUtils, Classes, BaseBuffDModule, DB, kbmMemTable, IBDatabase,
  IBCustomDataSet;

type
  Tdm_DepBuff = class(Tdm_BaseBuff)
    mt_BuffDataStartDate: TDateTimeField;
    mt_BuffDataEndDate: TDateTimeField;
    mt_BuffDataBrigID: TIntegerField;
    mt_BuffDataAddInfo: TStringField;
    mt_BuffDataID: TIntegerField;
    procedure mt_BuffDataAfterInsert(DataSet: TDataSet);
  private
    function GenID: integer;
  private
    //procedure OpenVocs; override;
    procedure FillBuffData; override;
  public
    //procedure SaveData; override;
  end;

implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_DepBuff }

procedure Tdm_DepBuff.FillBuffData;
begin
//
end;

function Tdm_DepBuff.GenID: integer;
begin
  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    MyOpenIBDS( dset,
      ' select NEW_GEN_DEP_VALUE' +
      ' from GET_NEW_GEN_DEP_VALUE' );
    Result := dset.FieldByName( 'NEW_GEN_DEP_VALUE' ).AsInteger;
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_DepBuff.GenID)' );
    end;
  end;
end;

procedure Tdm_DepBuff.mt_BuffDataAfterInsert(DataSet: TDataSet);
begin
  inherited;
  mt_BuffData.FieldByName( 'ID' ).AsInteger := GenID;
end;

end.
