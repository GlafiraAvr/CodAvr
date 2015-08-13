unit SvodkaGekDModule_vds;  //by Glasha 02.02.2012

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class,DModule, IBDatabase, RxMemDS,
  FR_DSet, FR_DBSet, DB, IBCustomDataSet;

type
  Tdm_SvodkaGek_vds = class(Tdm_NGReportBase)
    Dset: TIBDataSet;
    frDBDataSet1: TfrDBDataSet;
    ResultDset: TRxMemoryData;
    tran: TIBTransaction;
    ResultDsetid: TIntegerField;
    ResultDsetordernumber: TIntegerField;
    ResultDsetregion: TStringField;
    ResultDsetadress: TStringField;
    ResultDsetapplicantfio: TStringField;
    ResultDsetapplicantphone: TStringField;
    ResultDsetmessagename: TStringField;
    ResultDsetadditionalinfo: TStringField;
    ResultDsetdateComing: TStringField;
    ResultDsetdateclosed: TStringField;
    ResultDsetdistrict: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
  {input}
  F_DtBeg:TDateTime;
  F_DtEnd:TDateTime;
  F_RecordCount:integer;
  {output}
function GetRecordCount():integer;

    { Private declarations }
   procedure startTran();
  public

  procedure Init();
  property DtBeg:TdateTime read F_DtBeg write F_Dtbeg;
  property DtEnd:TDateTime read F_DtEnd write F_DtEnd;

//  procedure Init();
  function PrepareDset: boolean;
  property RecordCount:integer read F_RecordCount ;
  function FillResultDset: boolean;
    { Public declarations }
  end;

var
  dm_SvodkaGek_vds: Tdm_SvodkaGek_vds;

implementation

{$R *.dfm}

procedure  Tdm_SvodkaGek_vds.startTran;
begin
try
 if tran.InTransaction
  then tran.Rollback;
 tran.StartTransaction;
except on E:exception do
 begin
   tran.Rollback;
    raise Exception.Create(E.Message+'(Tdm_SvodkaGek.StartTran)');
 end;
end;
end;

function  Tdm_SvodkaGek_vds.GetRecordCount:integer;
begin
Result:=0;
try
  startTran;
  MyOpenSql(dset,Format('select count(*) from '+
                 'orders_vds o left join departures_vds dd on o.id=dd.fk_departures_orders '+
                 'left join s_messagetypes   mt on o.fk_orders_messagetypes=mt.id '+
                 'where o.datecoming>='' %s '' and o.datecoming<='' %s '' and  '+
                 'dd.id=(select min(id) from departures_vds dd1 '+
                 'where dd1.fk_departures_orders=dd.fk_departures_orders) ',
                 [datetimeToStr(f_dtbeg),datetimeToStr(f_dtend)])
                 );

  Result:=dset.Fields[0].asinteger;
 except
  on e:Exception  do begin
  tran.Rollback;
    raise Exception.Create(E.Message+'(Tdm_SvodkaGek.recordCount)');
  end;
 end;
end;

function Tdm_SvodkaGek_vds.FillResultdset:boolean;
var i:integer;
begin

try
 startTran;

 MyOpenSql(dset,Format('select o.id,o.ordernumber,o.datecoming ,o.fk_orders_regions,sr.name region, '+
          '(select * from get_adres2(o.fk_orders_streets, '+
          'o.housenum, '+
          ' o.housingnum, '+
          'o.porchnum, '+
          'o.floornum, '+
           'o.apartmentnum'+
         ')) adress,'+
        'o.applicantfio, '+
        'o.applicantphone, '+
        'mt.messagename, '+
        'dd.additionalinfo, '+
        'o.dateclosed ,'+
        ' sd.name district'+
        ' from orders_vds o left join departures_vds dd on o.id=dd.fk_departures_orders '+
        ' left join s_messagetypes   mt on o.fk_orders_messagetypes=mt.id'+
        ' left join s_regions sr on sr.id=o.fk_orders_regions'+
        ' left join s_district_vds sd on o.fk_orders_district=sd.id'+
        ' where o.datecoming>='' %s '' and o.datecoming<='' %s '' and  '+
                 ' dd.id=(select min(id) from departures_vds dd1 '+
                 ' where dd1.fk_departures_orders=dd.fk_departures_orders) '+
                 ' order by 4,3',
                 [datetimeToStr(f_dtbeg),datetimeToStr(f_dtend)])
                 );
 dset.First;
 while not dset.Eof do
 begin
    ResultDset.Append;
    for i:=0 to resultdset.FieldCount-2 do begin
     if dset.Fieldbyname(ResultDset.Fields[i].FieldName).IsNull then
       ResultDset.Fields[i].Value:=''
     else
       ResultDset.Fields[i].Value:=
     dset.Fieldbyname(ResultDset.Fields[i].FieldName).asString;
     end;
    ResultDset.FieldByName('additionalinfo').Value:='';
    // ResultDset.FieldByName('dateclosed').Value:='';
    if not dset.Fieldbyname('additionalinfo').IsNull then
      ResultDset.FieldByName('additionalinfo').Value:=
        dset.Fieldbyname('additionalinfo').AsString;

    if not dset.FieldByName('dateclosed').IsNull then
       ResultDset.FieldByName('dateclosed').Value:=
        dset.Fieldbyname('dateclosed').asstring;
    ResultDset.Post;

    dset.Next;
  end;
except
on e:Exception  do begin
  tran.Rollback;
  raise Exception.Create(E.Message+'(Tdm_SvodkaGek.FillResultDset)');
  end;
end;
result:= true;
end;

function Tdm_SvodkaGek_vds.PrepareDset:boolean;
begin
 Result:=false;

  ResetProgressFields;

  starttran;
  try
  ResultDset.Close;
  ResultDset.Open;
    FillResultDset;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(Tdm_SvodkaGek.PrepareDsets)');
    end;
  end;

  Result:=true;
end;


procedure  Tdm_SvodkaGek_vds.Init();
begin
f_RecordCount:=getrecordCount;
end;
procedure Tdm_SvodkaGek_vds.DataModuleCreate(Sender: TObject);
begin
  inherited;
  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
end;

procedure Tdm_SvodkaGek_vds.DataModuleDestroy(Sender: TObject);
begin
  inherited;
Dset.Close;
ResultDset.Close;
ResultDset.Free;
end;

end.
