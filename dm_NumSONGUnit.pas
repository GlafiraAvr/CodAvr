unit dm_NumSONGUnit;

interface

uses
  SysUtils, Classes, DB, RxMemDS, IBCustomDataSet, IBDatabase, DModule;

type
  Tdm_NumSONG = class(TDataModule)
    tran1562: TIBTransaction;
    dset: TIBDataSet;
    ResultDset: TRxMemoryData;
    ResultDsetid: TIntegerField;
    ResultDsetNum1562: TIntegerField;
    ResultDsetDatatime: TDateTimeField;
    ResultDsetphone: TStringField;
    ResultDsetadres: TStringField;
    ResultDsethouse: TStringField;
    ResultDsetappartment: TStringField;
    ResultDsetnfloor: TStringField;
    ResultDsetpodesd: TStringField;
    ResultDsetkodpodesd: TStringField;
    ResultDsetPLACE: TStringField;
    ResultDsetABONENT: TStringField;
    ResultDsetRegions: TStringField;
    ResultDsetkodclass: TStringField;
    ResultDsetABOUT: TStringField;
    ResultDsetWORKS: TStringField;
    ResultDsetSTATUS: TStringField;
    ResultDsetAVAR: TStringField;
    ResultDsetREGL: TDateTimeField;
    ResultDsetid_order: TIntegerField;
    ResultDsetis_closed: TIntegerField;
    ResultDsetdttm_in_work: TDateTimeField;
    ResultDsetdttm_in: TDateTimeField;
    ResultDsetfk_id_stat: TIntegerField;
    ResultDsetchecked: TIntegerField;
    ResultDsetdttm_out: TDateTimeField;
    ResultDsetordernumber: TIntegerField;
    ResultDsetmhid: TIntegerField;
    dset_tmp: TIBDataSet;
  private
    { Private declarations }
    F_Condition: string;
    procedure FillResultDset;    
  public
    { Public declarations }
    property Condition: string read F_Condition write F_Condition;
    function PrepareDset: boolean;
    procedure StartTransaction;
    procedure StopTransaction;
    procedure CommitTransaction;
    procedure RollBackTransaction;    
        
  end;

var
  dm_NumSONG: Tdm_NumSONG;

implementation

{$R *.dfm}

uses HelpFunctions, StringConsts;

procedure Tdm_NumSONG.FillResultDset;
var
  leak_cond: string;
  i: integer;
begin

  ResultDset.Close;
  ResultDset.Open;


  MyOpenIBDS(dset,
    ' select sp.id, Num1562, Datatime '+
    ', PHONE, street_name, house, appartment, nfloor, podesd, kodpodesd '+
    ', PLACE, ABONENT, REGION, kodclass, ABOUT, WORKS '+
    ', (select ss.name from s_stat ss where ss.id_stat = mh.fk_id_s_stat) STATUS '+
    ', AVAR, REGL '+
    ', cw.fk_id_avr_order id_order '+
    ', cw.is_closed, cw.dttm_in_work '+
    ', mh.dttm_in , mh.fk_id_s_stat , mh.checked , mh.dttm_out , mh.id mhid '+
    ' from message_history mh '+
    ' join spisok1562 sp on ((sp.id = mh.FK_ID_SPISOK1562) and (mh.FK_ID_SENDER = 1)) '+
    ' join cardwork cw on ( cw.fk_id_spisok1562 = sp.id )'+
    F_Condition+
    ' order by 3 ');//+


  dset.First;
  while not dset.Eof do
  begin
          ResultDset.Append;
    for i:=0 to ResultDset.FieldCount-2 do
      ResultDset.FieldByName(dset.Fields[i].FieldName).Value:=dset.Fields[i].Value;
    if dset.FieldByName('id_order').AsInteger > 0 then
     begin
        MyOpenIBDS(dset_tmp,
          ' select ordernumber from orders where id = '+ dset.FieldByName('id_order').AsString );
        ResultDset.FieldByName('ordernumber').AsString := dset_tmp.fieldByName('ordernumber').AsString;
      end
      else
        ResultDset.FieldByName('ordernumber').AsString := '';
    ResultDset.Post;
    dset.Next;
  end;
  dset.Close;
end;


function Tdm_NumSONG.PrepareDset: boolean;
begin
  FillResultDset;
//  FillRegionList;

  Result:=true;
end;

procedure Tdm_NumSONG.StartTransaction;
begin
  DM_Main.Connect1562_1('AVR1562', 'avr1562_pwd');

  if tran1562.InTransaction then tran1562.Rollback;
  tran1562.DefaultDatabase:= DM_Main.IBDatabase1562_1;
  tran1562.StartTransaction;


end;

procedure Tdm_NumSONG.StopTransaction;
begin
  tran1562.Commit;
end;

procedure Tdm_NumSONG.CommitTransaction;
begin
  if tran1562.InTransaction then tran1562.Commit;
end;

procedure Tdm_NumSONG.RollBackTransaction;
begin
  if tran1562.InTransaction then tran1562.Rollback;
end;


end.
