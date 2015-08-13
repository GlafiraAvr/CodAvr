unit NaledRepDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, FR_DSet, FR_DBSet, DB,
  IBCustomDataSet, IBDatabase, kbmMemTable;

type
  Tdm_NaledRep = class(Tdm_NGReportBase)
    Dset: TIBDataSet;
    frDBResult: TfrDBDataSet;
    ResultDset: TkbmMemTable;
    ResultDsetordernumber: TStringField;
    ResultDsetRegions: TStringField;
    ResultDsetadres: TStringField;
    ResultDsetdlname: TStringField;
    ResultDsetsquare: TIntegerField;
    tran: TIBTransaction;
    DsetID: TIntegerField;
    DsetORDERNUMBER: TIntegerField;
    DsetREGIONS: TIBStringField;
    DsetADRES: TIBStringField;
    DsetDLNAME: TIBStringField;
    DsetDATECOMING: TDateTimeField;
    DsetDTTM_OPEN: TDateTimeField;
    DsetFK_NALED_OFFICIALOPEN: TIntegerField;
    DsetDTTM_CLOSED: TDateTimeField;
    DsetFK_NALED_OFFICIALCLOSED: TIntegerField;
    DsetSQUARE: TFloatField;
    DsetVOLUME: TFloatField;
    ResultDsetdatecoming: TDateTimeField;
    ResultDsetdttm_closed: TDateTimeField;
    ResultDsets_dttm_closed: TStringField;
  private
    { Private declarations }
    F_DtBeg: TDateTime;
    F_DtEnd: TDateTime;
    F_RegionsID: string;
    F_typ:integer;
    F_AsfCompanyId:string;
    procedure FillResultDset;
  public
    { Public declarations }
    property DtBeg: TDateTime read F_DtBeg write F_DtBeg;
    property DtEnd: TDateTime read F_DtEnd write F_DtEnd;
    property RegionsID: string read F_RegionsID write F_RegionsID;
    function PrepareDset: boolean;
    property _typ:integer write F_typ;
    property AsfCompanyId:string write F_AsfCompanyId;
  end;

var
  dm_NaledRep: Tdm_NaledRep;

implementation

{$R *.dfm}

uses HelpFunctions;

function Tdm_NaledRep.PrepareDset: boolean;
begin
   Result := true;

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    FillResultDset;
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_NaledRep.PrepareDset)' );
    end;
  end;
end;

procedure Tdm_NaledRep.FillResultDset;
var i: integer;
    RegCondition: string;
    AsfCompanyCond:string;
 function setTyp():string;
 begin
 result:='';
  case f_typ of
   0: result:='';
   1: result:=' and n.dttm_closed is not null ';
   2: result:=' and n.dttm_closed is null ';
  end;

 end;
begin

  if F_RegionsID <> '' then RegCondition := ' and (o.fk_orders_regions in '+ F_RegionsID + ') '
      else RegCondition := '';
 if F_AsfCompanyId <> ''  then  AsfCompanyCond :=' and (n.fk_naled_asfcompany in '+F_AsfCompanyId +') '
    else AsfCompanyCond:='';
  MyOpenIBDS( Dset,
    ' select o.id, o.ordernumber' +
    ' , (select name from s_Regions where id=o.fk_orders_regions) Regions' +
    ' , (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,  o.housenum, o.additionaladdress)) adres' +
    ' , (select dl.name from s_damagelocality dl where dl.id = o.fk_orders_damagelocality) dlname'+
    ' , o.datecoming '+
    ' , n.dttm_open , n.fk_naled_officialopen , n.dttm_closed , n.fk_naled_officialclosed , n.square , n.volume '+
    '  from naled n '+
    '  join orders o on (n.fk_naled_orders = o.id) '+
    ' where (n.square is not null)   ' +
    ' and ( n.dttm_open < ''' + DateToStr( F_DtEnd + 1 ) + ''' )' +
    ' and ( n.dttm_open >= ''' + DateToStr( F_DtBeg ) + ''' )' +
    RegCondition+ AsfCompanyCond+
    SetTyp()+
    ' order by 2' );

  if ResultDset.Active then ResultDset.Close;
  ResultDset.Open;


  dset.first;
  while not dset.eof do
    begin
     ResultDset.Append;
     for i:= 0 to ResultDset.FieldCount - 2 do
        begin
           //

         ResultDset.Fields[i] := dset.FieldByName(ResultDset.Fields[i].FieldName);
        end;
         if (dset.FieldByName('dttm_closed').IsNull) then
              ResultDset.FieldByName('s_dttm_closed').AsString := ' '
              else ResultDset.FieldByName('s_dttm_closed').AsString :=
                        ResultDset.FieldByName('dttm_closed').AsString;

       ResultDset.Post;
     dset.Next;
    end;
end;


end.
