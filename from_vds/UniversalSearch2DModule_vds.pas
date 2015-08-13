unit UniversalSearch2DModule_vds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, IBDatabase, DB, IBCustomDataSet,
  DModule, RxMemDS, Report_HelpClasses, FR_DSet, FR_DBSet;

type
  TSortType=(stOrderNumberAndDatecoming, stRegions, stAdres);

  TRegionRec=record
    id: integer;
    name: string;
    dmg_count: integer;
  end;

  TPRegionRec=^TRegionRec;

  Tdm_UniversalSearch2_vds = class(Tdm_NGReportBase)
    tran: TIBTransaction;
    dset: TIBDataSet;
    ResultDset: TRxMemoryData;
    ResultDsetid: TIntegerField;
    ResultDsetRegions: TStringField;
    ResultDsetDamageType: TStringField;
    ResultDsetAdres: TStringField;
    ResultDsetid_region: TIntegerField;
    ResultDsetptr_add_info: TIntegerField;
    frDS_Result: TfrDBDataSet;
    ResultDsetMessageTypes: TStringField;
    ResultDsetFullOrderNum: TStringField;
    ResultDsetDateClosed: TStringField;
    ResultDsetOrderNumber: TStringField;
    ResultDsetDateComing: TDateTimeField;
    ResultDsetstart_regions: TStringField;
    ResultDsetend_region: TStringField;
    ResultDsetpr_startregion: TStringField;
    ResultDsetpr_endregion: TStringField;
    ResultDsetnumber: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    F_Condition: string;
    F_SortType: TSortType;
    F_IsAscSort: boolean;
    F_strStartDate: string;
    F_strFinishedDate: string;
    F_RecordCount: integer;
    F_RegionList: TList;

    procedure FillRegionList;
    procedure FillResultDset;
    procedure ClearRegionList;
    procedure SetSortType(Value: TSortType);
  public
    property Condition: string read F_Condition write F_Condition;
    property SortType: TSortType read F_SortType write SetSortType;
    property strStartDate: string read F_strStartDate write F_strStartDate;
    property strFinishedDate: string read F_strFinishedDate write F_strFinishedDate;
    property IsAscSort: boolean read F_IsAscSort write F_IsAscSort;

    function GetRecordCount: integer;
    function PrepareDset: boolean;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tdm_UniversalSearch2_vds.ClearRegionList;
var
  i: integer;
begin
  for i:=0 to F_RegionList.Count-1 do
    if Assigned(F_RegionList.Items[i]) then
      Dispose(TPRegionRec(F_RegionList.Items[i]));
  F_RegionList.Clear;    
end;

procedure Tdm_UniversalSearch2_vds.DataModuleCreate(Sender: TObject);
begin
  inherited;
  F_Condition:='';
  F_strStartDate:='';
  F_strFinishedDate:='';
  F_RegionList:=TList.Create;

  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
end;

procedure Tdm_UniversalSearch2_vds.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  ClearRegionList;
  F_RegionList.Free;
  if tran.InTransaction then
    tran.Commit;
end;

procedure Tdm_UniversalSearch2_vds.FillRegionList;
var
  pReg: TPRegionRec;
  i: integer;
begin
  ClearRegionList;

  MyOpenIBDS(dset,
    ' select id, name from s_regions'+
    ' where id>-1 and activity is null'+
    ' order by name');

  dset.First;
  while not dset.Eof do
  begin
    new(pReg);
    pReg.id:=dset.FieldByName('id').AsInteger;
    pReg.name:=dset.FieldByName('name').AsString;
    pReg.dmg_count:=0;
    F_RegionList.Add(pReg);

    dset.Next;
  end;

  ResultDset.First;
  while not ResultDset.Eof do
  begin
    for i:=0 to F_RegionList.Count-1 do
    begin
      pReg:=TPRegionRec(F_RegionList.Items[i]);
      if pReg.id=ResultDset.FieldByName('id_region').AsInteger then
      begin
        ResultDset.Edit;
        ResultDset.FieldByName('ptr_add_info').AsInteger:=Integer(pReg);
        ResultDset.Post;
        pReg.dmg_count:=pReg.dmg_count+1;
        break;
      end;
    end;

    ResultDset.Next;
  end;
end;

procedure Tdm_UniversalSearch2_vds.FillResultDset;
  function GetSortCondition: string;
  var
    s: string;
  begin
    if F_IsAscSort then s:='asc'
    else s:='desc';

    case F_SortType of
      stOrderNumberAndDatecoming:
        Result:=' order by number, DateComing '+s+' ';
      stRegions:
        Result:=' order by 6 '+s;
      stAdres:
        Result:=' order by 8 '+s;
      else Result:='';
    end;
  end;
var
  i, progress_shag: integer;
begin
  ResetProgressFields;
  progress_shag:=GetProgressShagLength(100, F_RecordCount);

  ResultDset.Close;
  ResultDset.Open;

  MyOpenIBDS(dset,
//    ' select id, OrderNumber, DateComing, DateClosed,'+
//    ' o.OrderNumber FullOrderNum,'+
    ' select distinct  o.id,o.ordernumber as number,  (select FullOrderNum from get_fullordernum(o.OrderNumber, o.fk_orders_district)) OrderNumber, DateComing,DateClosed, '+
    ' (select messagename from S_MessageTypes_vds where id=o.fk_orders_messagetypes) MessageTypes,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
    ' (select name from s_DamageType_vds where id=o.fk_orders_damagetype) DamageType,'+
    ' (select adres from get_adres_vds(o.fk_orders_streets, o.housenum,'+
    '     o.housingnum, o.PorchNum, o.floornum, o.apartmentnum, o.porchkod)) adres,'+
    ' fk_orders_regions id_region,'+
    ' rv.startdate start_region, rv.enddate end_region '+
    ' from orders_vds o '+
    F_Condition+
    GetSortCondition);


  dset.First;
  while not dset.Eof do
  begin
    ResultDset.Append;
    for i:=0 to dset.FieldCount-1 do
   //   if   dset.Fields[i].FieldName='DateClosed' then
     //       ResultDset.FieldByName(dset.Fields[i].FieldName).Value:=DateToStr()
      ResultDset.FieldByName(dset.Fields[i].FieldName).Value:=dset.Fields[i].AsString;
    if  not dset.FieldByName('start_region').IsNull then
       ResultDset.FieldByName('pr_startregion').AsString:='Ð'
    else
      ResultDset.FieldByName('pr_startregion').AsString:='';
    if not dset.FieldByName('end_region').IsNull then
       ResultDset.FieldByName('pr_endregion').AsString:='Â'
    else
      ResultDset.FieldByName('pr_endregion').AsString:='';
    ResultDset.Post;

    IncProgressStatus(progress_shag);
    dset.Next;
  end;
  dset.Close;
end;

function Tdm_UniversalSearch2_vds.GetRecordCount: integer;
begin
  MyOpenIBDS(dset, 'select count(distinct o.id) kol from orders_vds o '+F_Condition);
  Result:=dset.FieldByName('kol').AsInteger;
  dset.Close;
  F_RecordCount:=Result;
end;

function Tdm_UniversalSearch2_vds.PrepareDset: boolean;
begin
  FillResultDset;
  FillRegionList;

  Result:=true;
end;

procedure Tdm_UniversalSearch2_vds.SetSortType(Value: TSortType);
begin
  if Value<>F_SortType then
  begin
    F_IsAscSort:=true;
    F_SortType:=Value;
  end else F_IsAscSort:=not F_IsAscSort;
end;

end.
