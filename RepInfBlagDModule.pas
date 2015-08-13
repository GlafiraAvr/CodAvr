unit RepInfBlagDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, FR_DSet, FR_DBSet, DB, RxMemDS,
  IBCustomDataSet, IBDatabase;

type
  Tdm_NGRepInfBlag = class(Tdm_NGReportBase)
    Resultdset: TRxMemoryData;
    frDBDataSet1: TfrDBDataSet;
    tran: TIBTransaction;
    dset: TIBDataSet;
    dset_region: TIBDataSet;
    Resultdsetid_order: TIntegerField;
    Resultdsetordernumber: TStringField;
    Resultdsetadress: TStringField;
    ResultdsetPlan_kol: TIntegerField;
    ResultdsetPlan_SQUARE: TFloatField;
    ResultdsetFact_kol: TIntegerField;
    ResultdsetFact_SQUARE: TFloatField;
    ResultdsetASFCOMPANY: TStringField;
    dset_adress: TIBDataSet;
    ResultdsetRegion: TStringField;
    Resultdsetprim: TStringField;
  private
    { Private declarations }
    F_BegDate:TDateTime;
    F_EndDate:TDateTime;
    F_Blag:integer;


    function _PrepBaseInfo(persent:integer):boolean;

  public
    { Public declarations }
    property  BegDate:TDateTime write  F_BegDate;
    property  EndDate:TDateTime write F_EndDate;
    property  Blag:integer write  F_Blag;
    function PrepareDset: boolean;
  end;

var
  dm_NGRepInfBlag: Tdm_NGRepInfBlag;

implementation

{$R *.dfm}
uses  HelpFunctions;
function Tdm_NGRepInfBlag.PrepareDset: boolean;
begin
  ResetProgressFields;

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try

    ResultDset.Close;
    ResultDset.Open;

    Result := _PrepBaseInfo(100);

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_RepBlag2.PrepareDset)' );
    end;
  end;
  Result:=true;
end;


function Tdm_NGRepInfBlag._PrepBaseInfo(persent:integer):boolean;
var
 _progress_shag,excwt_plan: integer;
  exwt:string;
  id_order:integer;

const SQLadrs='select distinct  exw.fk_excavations_orders id_order,'+
         ' o.fk_orders_regions, '+
         ' o.ordernumber,sr.name region,sa.name company, '+
         ' (select * from get_adres(o.fk_orders_housetypes,o.fk_orders_streets,o.housenum,o.additionaladdress)) adress '+
         ' from  excavations exw left join orders   o on o.id=exw.fk_excavations_orders'+
         ' left join s_regions  sr on o.fk_orders_regions=sr.id '+
         ' left join s_asfcompany sa on exw.fk_excavations_asfcompany=sa.id'+
         '  where exw.dtime >''%s'' and exw.dtime<=''%s'' and '+
         '  exw.fk_excavations_excwt in %s'+
         ' order by 2,3';

SQLCount='select exw.fk_excavations_orders,fk_excavations_excwt excwt, count(exw.id) kol,sum(exw.square) SQUARE'+
         ' from   excavations exw '+
         ' where exw.fk_excavations_orders=%d'+
         ' and  exw.fk_excavations_excwt in %s'+
         ' group by 1,2';

   procedure get_exwt();
   begin
     case F_Blag of
      1: begin exwt:='(5,13)';  excwt_plan:=13; end;
      2:  begin exwt:='(6,14)'; excwt_plan:=14; end;
     end;
   end;
begin
 get_exwt();
 MyOpenIBDS(dset_adress,Format(SQLadrs,[DateTimeToStr(F_BegDate),DateTimeToStr(F_EndDate),exwt]));
 _progress_shag := GetProgressShagLength( persent, dset_adress.RecordCount );
 dset_adress.First;
 while  not dset_adress.Eof do
 begin
   if F_IsStopProgress then exit;
   IncProgressStatus( _progress_shag );
      ResultDset.Append;
        ResultDset.FieldByName('Plan_kol').AsInteger:=0;
        ResultDset.FieldByName('Plan_SQUARE').AsFloat:=0;
        ResultDset.FieldByName('Fact_kol').AsInteger:=0;
        ResultDset.FieldByName('Fact_SQUARE').AsFloat:=0;
      id_order:=dset_adress.FieldByName('id_order').asinteger;
      ResultDset.FieldByName('id_order').AsInteger:=id_order;
      ResultDset.FieldByName('ordernumber').AsString:=dset_adress.FieldByName( 'ordernumber').asstring;
      ResultDset.FieldByName('region').AsString:=dset_adress.FieldByName('region').asstring;
      ResultDset.FieldByName('adress').AsString:=dset_adress.FieldByName('adress').asstring;
      ResultDset.FieldByName('ASFCOMPANY').AsString:=dset_adress.FieldByName('COMPANY').asstring;
      if trim(ResultDset.FieldByName('ASFCOMPANY').AsString)='' then
        ResultDset.FieldByName('ASFCOMPANY').AsString:='Собств. силами';
      MyOpenIBDS(dset,Format(SQLCount,[id_order,exwt]));
      dset.First;
      while  not dset.Eof do
      begin
        if dset.FieldByName('excwt').AsInteger=excwt_plan then
         begin
           ResultDset.FieldByName('Plan_kol').AsInteger:=dset.FieldByName('kol').asinteger;
           ResultDset.FieldByName('Plan_SQUARE').AsFloat:=dset.FieldByName('SQUARE').asfloat;
         end
         else
          begin
           ResultDset.FieldByName('Fact_kol').AsInteger:=dset.FieldByName('kol').asinteger;
           ResultDset.FieldByName('Fact_SQUARE').AsFloat:=dset.FieldByName('SQUARE').asfloat;
         end;
        dset.Next;
      end;
      if (ResultDset.FieldByName('Plan_kol').AsInteger=0) and (ResultDset.FieldByName('Fact_kol').AsInteger>0) then
        ResultDset.FieldByName('Prim').AsString:='вне плана';
      ResultDset.Post;
   dset_adress.Next;
 end;


end;

end.
