unit SvodVedLukAndPGDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DB, RxMemDS, IBDatabase,
  IBCustomDataSet, DModule, FR_DSet, FR_DBSet;

type
  Tdm_SvodVedLukAndPG = class(Tdm_NGReportBase)
    md_Result: TRxMemoryData;
    md_Resultreg_name: TStringField;
    md_Resultluk_count: TIntegerField;
    md_Resultpg_count: TIntegerField;
    dset: TIBDataSet;
    tran: TIBTransaction;
    frDS_Result: TfrDBDataSet;
  private
    F_DtBeg,
    F_DtEnd: TDate;
    function FillResultDset: boolean;
  public
    property DtBeg: TDate read F_DtBeg write F_DtBeg;
    property DtEnd: TDate read F_DtEnd write F_DtEnd;
    function PrepareDset: boolean;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_SvodVedLukAndPG }

const
  REG_ARR: array[0..1, 0..8] of string=
  (
    ('1',           '2',        '3',               '4',         '5',          '6',           '7',                 '8',           '9'),
    ('Дзержинский', 'Киевский', 'Коминтерновский', 'Ленинский', 'Московский', 'Октябрьский', 'Орджоникидзевский', 'Фрунзенский', 'Червонозаводский')
  );


function Tdm_SvodVedLukAndPG.FillResultDset: boolean;
  function GetLukCount(id_reg: string): integer;
  begin
    MyOpenIBDS(dset,
      ' select count(*) luk_count'+
      ' from orders'+
      ' where IsClosed=1'+
      ' and ((fk_orders_damageplace=13) or (HOODCOUNT>0)) '+   // 13 - установка люков
      ' and fk_orders_regions='+id_reg+
      ' and DateComing>'''+DateToStr(F_DtBeg)+''''+
      ' and DateComing<='''+DateToStr(F_DtEnd+1)+'''');
    Result:=dset.FieldByName('luk_count').AsInteger;
  end;

  function GetPGCount(id_reg: string): integer;
  begin
    MyOpenIBDS(dset,
      ' select count(*) pg_count'+
      ' from orders'+
      ' where IsClosed=1'+
      ' and fk_orders_messagetypes=3001'+  // 3001 - замена ПГ
      ' and fk_orders_regions='+id_reg+
      ' and DateComing>'''+DateToStr(F_DtBeg)+''''+
      ' and DateComing<='''+DateToStr(F_DtEnd+1)+'''');
    Result:=dset.FieldByName('pg_count').AsInteger;
  end;

var
  i, progress_shag: integer;
begin
  Result:=false;

  progress_shag:=GetProgressShagLength(100, High(REG_ARR[0])+1 );

  md_Result.Close;
  md_Result.Open;

  for i:=low(REG_ARR[0]) to High(REG_ARR[0]) do
  begin
    if F_IsStopProgress then exit;

    md_Result.Append;

    md_Result.FieldByName('reg_name').AsString:=REG_ARR[1, i];
    md_Result.FieldByName('luk_count').AsInteger:=GetLukCount(REG_ARR[0, i]);
    md_Result.FieldByName('pg_count').AsInteger:=GetPGCount(REG_ARR[0, i]);

    md_Result.Post;

    IncProgressStatus(progress_shag);
  end;

  Result:=true;
end;

function Tdm_SvodVedLukAndPG.PrepareDset: boolean;
begin
  ResetProgressFields;

  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
    Result:=FillResultDset;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+' (Tdm_SvodVedLukAndPG.PrepareDset)');
    end;
  end;
end;

end.
