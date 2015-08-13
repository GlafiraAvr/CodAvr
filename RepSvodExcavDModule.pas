unit RepSvodExcavDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, IBDatabase, DModule, DB,
  kbmMemTable, IBCustomDataSet, FR_DSet, FR_DBSet, ItemSelecter;

type
  Tdm_RepSvodExcav = class(Tdm_NGReportBase)
    tran: TIBTransaction;
    ResultDset: TkbmMemTable;
    dset_tmp: TIBDataSet;
    ResultDsetOrderNumber: TIntegerField;
    ResultDsetDateComing: TDateTimeField;
    ResultDsetDateClosed: TDateTimeField;
    ResultDsetid_region: TIntegerField;
    ResultDsetid_damageplace: TIntegerField;
    ResultDsetRegion: TStringField;
    ResultDsetDamageplace: TStringField;
    ResultDsetDamagelocality: TStringField;
    ResultDsetTubematerial: TStringField;
    ResultDsetAdres: TStringField;
    ResultDsetExcDate: TDateTimeField;
    ResultDsetAdditionalInfo: TStringField;
    ResultDsetExcWt: TStringField;
    ResultDsetMainGr: TIntegerField;
    ResultDsetID: TIntegerField;
    frDset: TfrDBDataSet;
  private
    F_BeginDate,
    F_EndDate: TDateTime;
    F_RegItemList: TSelItemList;
    F_isFinish:integer;
    procedure FillResultDset;
  public
    property BeginDate: TDateTime read F_BeginDate write F_BeginDate;
    property EndDate: TDateTime read F_EndDate write F_EndDate;
    property RegItemList: TSelItemList read F_RegItemList write F_RegItemList;
    procedure PrepareDset;
    property isFinish: integer write F_isFinish;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_RepSvodExcav }

procedure Tdm_RepSvodExcav.FillResultDset;
var
  _reg: set of byte;
  i: integer;
 function addFinish():string;
 begin
  F_isFinish:=F_isFinish-1;
  if F_isFinish<0 then
   result:=' null'
  else
   result:=IntToStr(F_isFinish);
 end;
begin
  ResultDset.Close;
  ResultDset.Open;

  _reg := [];
  for i:=0 to F_RegItemList.Count-1 do
  begin
    _reg := _reg + [ F_RegItemList.Items[i].ID ];
  end;

  if _reg = [] then _reg := [1,2,3,4,5,6,7,8,9];

  MyOpenIBDS( dset_tmp,
    ' select * from rep_svod_excav(' +
    '''' + DateToStr( F_BeginDate ) + ''',' +
    '''' + DateToStr( F_EndDate + 1 ) + ''','+addFinish+')' );

  dset_tmp.First;
  while not dset_tmp.Eof do
  begin
    if dset_tmp.FieldByName( 'id_region' ).AsInteger in _reg then
    begin
      ResultDset.Append;
      ResultDset.FieldByName( 'ID' ).AsInteger := dset_tmp.FieldByName( 'id_order' ).AsInteger;
      ResultDset.FieldByName( 'OrderNumber' ).AsInteger := dset_tmp.FieldByName( 'OrderNumber' ).AsInteger ;
      ResultDset.FieldByName( 'DateComing' ).AsDateTime := dset_tmp.FieldByName( 'DateComing' ).AsDateTime ;
      ResultDset.FieldByName( 'DateClosed' ).AsDateTime := dset_tmp.FieldByName( 'DateClosed' ).AsDateTime ;
      ResultDset.FieldByName( 'id_region' ).AsInteger := dset_tmp.FieldByName( 'id_region' ).AsInteger ;
      ResultDset.FieldByName( 'id_damageplace' ).AsInteger := dset_tmp.FieldByName( 'id_damageplace' ).AsInteger ;
      ResultDset.FieldByName( 'Region' ).AsString := dset_tmp.FieldByName( 'Region' ).AsString ;
      ResultDset.FieldByName( 'Damageplace' ).AsString := dset_tmp.FieldByName( 'Damageplace' ).AsString ;
      ResultDset.FieldByName( 'Damagelocality' ).AsString := dset_tmp.FieldByName( 'Damagelocality' ).AsString ;
      ResultDset.FieldByName( 'Tubematerial' ).AsString := dset_tmp.FieldByName( 'Tubematerial' ).AsString ;
      ResultDset.FieldByName( 'Adres' ).AsString := dset_tmp.FieldByName( 'Adres' ).AsString ;
      ResultDset.FieldByName( 'ExcDate' ).AsDateTime := dset_tmp.FieldByName( 'ExcDate' ).AsDateTime ;
      ResultDset.FieldByName( 'AdditionalInfo' ).AsString := dset_tmp.FieldByName( 'AdditionalInfo' ).AsString ;
      ResultDset.FieldByName( 'ExcWt' ).AsString := dset_tmp.FieldByName( 'ExcWt' ).AsString ;
      ResultDset.FieldByName( 'MainGr' ).AsInteger := 1 ;
      ResultDset.Post;
    end;
    dset_tmp.Next;
  end;
  dset_tmp.Close;
end;

procedure Tdm_RepSvodExcav.PrepareDset;
begin
  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    FillResultDset;
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_RepSvodExcav.PrepareDset)' );
    end;
  end;
end;

end.
