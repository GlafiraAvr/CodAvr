unit WorkDModule;

interface

uses
  SysUtils, Classes, DModule, IBDatabase, DB, IBCustomDataSet,
  GlobalVocCacheDModule, kbmMemTable, IBSQL, RxMemDS, TrudoZatratDModule;

type
  TChangeAction = ( caInsertWorks, caDeleteWorks, caDeleteWorksWithOldAttach, caResetWorksAttach,
                     caInsertMaters, caDeleteMaters, caDeleteMatersWithOldAttach, caResetMatersAttach);
  TChangeActionOption = set of TChangeAction;
  TShowMode = (smAll, smAttached, smFree);

  Tdm_Work = class(TDataModule)
    tran: TIBTransaction;
    dset_BWork: TIBDataSet;
    dset_BWorkID: TIntegerField;
    dset_BWorkID_ORDER: TIntegerField;
    dset_BWorkID_DEPARTURE: TIntegerField;
    dset_BWorkID_BWORK: TIntegerField;
    mt_BWork: TkbmMemTable;
    dset_BWorklpBWORK: TStringField;
    dset_Work: TIBDataSet;
    dset_WorkID: TIntegerField;
    dset_WorkFK_DEPWORKS_DEPARTURE: TIntegerField;
    dset_WorkFK_DEPWORKS_ORDER: TIntegerField;
    dset_WorkFK_DEPWORKS_WORK: TIntegerField;
    dset_WorkFK_DEPWORKS_DIAMETER: TIntegerField;
    dset_WorkQUANTITY: TIBBCDField;
    dset_WorkWORK_TIME: TIBBCDField;
    dset_WorkFK_DEPWORKS_BWORK: TIntegerField;
    mt_Works: TkbmMemTable;
    mt_Diam: TkbmMemTable;
    dset_WorklpWORK: TStringField;
    dset_WorklpDIAM: TIntegerField;
    dset_WorkclcWORKTIME: TFloatField;
    dset_WorkclcWT_INFO: TStringField;
    sql_InsertWorks: TIBSQL;
    dset: TIBDataSet;
    IBSQL: TIBSQL;
    dset_WorkFK_DEPWORKS_DEPBWORK: TIntegerField;
    md_FastAdd: TRxMemoryData;
    md_FastAddBWork: TStringField;
    md_FastAddid_bwork: TIntegerField;
    md_FastAddis_add_work: TBooleanField;
    md_FastAddis_add_mater: TBooleanField;
    dset_Mater: TIBDataSet;
    dset_MaterID: TIntegerField;
    dset_MaterFK_DEPMATERS_ORDER: TIntegerField;
    dset_MaterFK_DEPMATERS_DEPARTURE: TIntegerField;
    dset_MaterFK_DEPMATERS_DEPBWORK: TIntegerField;
    dset_MaterFK_DEPMATERS_MATER: TIntegerField;
    dset_MaterFK_DEPMATERS_DIAMETER: TIntegerField;
    dset_MaterFK_DEPMATERS_BWORK: TIntegerField;
    dset_MaterQUANTITY: TIBBCDField;
    mt_Maters: TkbmMemTable;
    dset_MaterlpMater: TStringField;
    dset_MaterlpDiam: TIntegerField;
    sql_InsertMaters: TIBSQL;
    md_FastAddis_add_bwork: TBooleanField;
    dset_WorkclcFULL_WORKTIME: TFloatField;
    dset_WorkADDITIONALINFO: TIBStringField;
    dset_WorkclcMEASUR_QUANTITY: TFloatField;
    dset_WorkMEASUR_QUANTITY: TIBBCDField;
    dset_WorklpMEASUREMENT: TStringField;
    dset_WorkclcWORK: TStringField;
    dset_WorkFK_DEPWORKS_OFFICPOST_INS: TIntegerField;
    dset_Workclc_IS_CAN_EDIT: TBooleanField;
    dset_WorkEXC_DEPTH: TIBBCDField;
    dset_WorkEXC_WIDTH: TIBBCDField;
    dset_WorkEXC_LENGTH: TIBBCDField;
    mt_WorkAtt: TkbmMemTable;
    dset_WorkNUM_WORK: TIntegerField;
    dset_WorkSQUARE_ASF: TIBBCDField;
    dset_WorkSENT_1562: TSmallintField;
    dset_Workboolsent_1562: TBooleanField;
    dset_WorkFACT_DATETIME: TDateTimeField;
    procedure dset_BWorkAfterInsert(DataSet: TDataSet);
    procedure dset_BWorkAfterPost(DataSet: TDataSet);
    procedure dset_WorkAfterInsert(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure dset_WorkCalcFields(DataSet: TDataSet);
    procedure dset_WorklpDIAMGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dset_WorkBeforePost(DataSet: TDataSet);
    procedure dset_BWorkBeforeDelete(DataSet: TDataSet);
    procedure dset_WorkFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure dset_BWorkAfterScroll(DataSet: TDataSet);
    procedure dset_MaterlpDiamGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dset_MaterAfterInsert(DataSet: TDataSet);
    procedure dset_MaterFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure md_FastAddis_add_bworkChange(Sender: TField);
    procedure DataModuleDestroy(Sender: TObject);
    procedure dset_WorkFK_DEPWORKS_WORKChange(Sender: TField);
  private
    F_OrderID: integer;
    F_DepID: integer;
    F_ChangeActionOption: TChangeActionOption;
    F_ShowMode: TShowMode;
    F_TrudoZatrat: Tdm_TrudoZatrat;
    F_DefaultOfficPostIns: integer;
    F_MaxNUMWORK: integer;
    F_IsRecalcWorkTime: boolean;
    procedure AttachToGVC;
    procedure SetWorkDate(Value: TDateTime);
    procedure AddWorksByBWork( _DepBWorkID, _BWorkID: integer );
    procedure AddMatersByBWork( _DepBWorkID, _BWorkID: integer );
    procedure DeleteWorks( _DepBWorkID: integer );
    procedure DeleteMaters( _DepBWorkID: integer );
    procedure ResetWorksAttach( _DepBWorkID: integer );
    procedure ResetMatersAttach( _DepBWorkID: integer );
    procedure ChangeWorksAndMaters( _DepBWorkID, _BWorkID: integer );
    procedure OpenWork;
    procedure OpenMater;
    procedure SetShowMode(Value: TShowMode);
    procedure RefilterWorks;
    procedure RefilterMaters;
    function GetWorkKindID( _WorkID: integer ): integer;
  public
    property OrderID: integer read F_OrderID write F_OrderID;
    property DepID: integer read F_DepID write F_DepID;
    property ChangeActionOption: TChangeActionOption read F_ChangeActionOption
      write F_ChangeActionOption;
    property WorkDate: TDateTime write SetWorkDate;
    property ShowMode: TShowMode read F_ShowMode write SetShowMode;
    procedure StartTran;
    procedure CommitTran;
    procedure RollbackTran;
    procedure OpenDset;
    procedure FillFastAdd;
    procedure PostFastAdd;
    procedure RecalcWorkTimeForAll;
    procedure WorkMoveUp;
    procedure WorkMoveDown;    
  end;

implementation

{$R *.dfm}

uses Variants, HelpFunctions, GlobalData;

{ Tdm_Work }


procedure Tdm_Work.AttachToGVC;
var
  _AttList: TList;
begin
  _AttList := TList.Create;
  try
    _AttList.Add( mt_BWork );
    _AttList.Add( mt_Works );
    _AttList.Add( mt_Diam );
    _AttList.Add( mt_Maters );
    _AttList.Add( mt_WorkAtt );

    dm_GlobalVocCache.CheckVocs( _AttList );
  finally
    _AttList.Free;
  end;
end;

procedure Tdm_Work.CommitTran;
begin
  if tran.InTransaction then tran.Commit;
end;

procedure Tdm_Work.OpenDset;
begin
  AttachToGVC;

  dset_BWork.Close;
  dset_BWork.ParamByName( 'pOrderID' ).AsInteger := F_OrderID;
  dset_BWork.ParamByName( 'pDepID' ).AsInteger := F_DepID;
  dset_BWork.Open;

  OpenWork;
  OpenMater;


  dset_Work.Last;
  F_MaxNUMWORK := dset_Work.RecordCount;
end;

procedure Tdm_Work.RollbackTran;
begin
  if tran.InTransaction then tran.Rollback;
end;

procedure Tdm_Work.StartTran;
begin
  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
end;

procedure Tdm_Work.dset_BWorkAfterInsert(DataSet: TDataSet);
begin
  F_ChangeActionOption := [];
  dset_BWork.FieldByName( 'id_order' ).AsInteger := F_OrderID;
  dset_BWork.FieldByName( 'id_departure' ).AsInteger := F_DepID;
end;

procedure Tdm_Work.dset_BWorkAfterPost(DataSet: TDataSet);
begin
  dset_BWork.Refresh;
  ChangeWorksAndMaters( DataSet.FieldByName( 'ID' ).AsInteger,
    DataSet.FieldByName( 'id_BWork' ).AsInteger );
end;

procedure Tdm_Work.dset_WorkAfterInsert(DataSet: TDataSet);
begin
  dset_Work.FieldByName( 'FK_DEPWORKS_ORDER' ).AsInteger := F_OrderID;
  dset_Work.FieldByName( 'FK_DEPWORKS_DEPARTURE' ).AsInteger := F_DepID;
  dset_Work.FieldByName( 'FK_DEPWORKS_DIAMETER' ).AsInteger := -1;
  dset_Work.FieldByName( 'QUANTITY' ).AsFloat := 1;
  dset_Work.FieldByName( 'Sent_1562' ).AsInteger := 0;
  dset_Work.FieldByName( 'FK_DEPWORKS_OFFICPOST_INS' ).AsInteger := F_DefaultOfficPostIns;
  F_MaxNUMWORK := F_MaxNUMWORK + 1;
  dset_Work.FieldByName( 'NUM_WORK' ).AsInteger := F_MaxNUMWORK;
  dset_Work.FieldByName('FACT_DATETIME').AsDateTime:=now();
end;

procedure Tdm_Work.SetWorkDate(Value: TDateTime);
begin
  F_TrudoZatrat.WorkDate := Value;
end;

procedure Tdm_Work.DataModuleCreate(Sender: TObject);
begin
  F_IsRecalcWorkTime := false;
  F_ShowMode := smAll;
  F_DefaultOfficPostIns := DM_Main.GetIDOfficialPost( g_IDOfficial );
  F_TrudoZatrat := Tdm_TrudoZatrat.Create( nil );
end;

procedure Tdm_Work.dset_WorkCalcFields(DataSet: TDataSet);
  function _Okrug( _val: double ): double;
  begin
    Result := trunc( _val * 100 )/100;
  end;
begin
  inherited;
  with DataSet do
  begin
    if ( not F_IsRecalcWorkTime ) and ( State in [dsInsert, dsEdit ] ) then
    begin
      F_TrudoZatrat.WorkID := FieldByName( 'FK_DEPWORKS_WORK' ).AsInteger;
      F_TrudoZatrat.DiamID := FieldByName( 'FK_DEPWORKS_DIAMETER' ).AsInteger;
      if F_TrudoZatrat.CalcTZFromVC then
      begin
        FieldByName( 'clcWORKTIME' ).AsFloat := F_TrudoZatrat.TrudoZatrat;
        FieldBYName( 'clcMEASUR_QUANTITY' ).AsFloat := F_TrudoZatrat.KolEd;
        FieldByName( 'clcWT_INFO' ).AsString :=
          FormatFloat( '0.##', F_TrudoZatrat.TrudoZatrat ) + ' на ' +
          FormatFloat( '0.##', F_TrudoZatrat.KolEd ) + ' ед.';
      end else
      begin
        FieldByName( 'clcWORKTIME' ).Clear;
        FieldBYName( 'clcMEASUR_QUANTITY' ).AsFloat := 1;
        FieldByName( 'clcWT_INFO' ).AsString := 'Соответствующее значение не задано';
      end;
    end;



    //////////////////////////////////////////

    if FieldByName( 'MEASUR_QUANTITY' ).AsFloat >0 then
      FieldByName( 'clcFULL_WORKTIME' ).AsFloat :=
        _Okrug( ( FieldByName( 'WORK_TIME' ).AsFloat/FieldByName( 'MEASUR_QUANTITY' ).AsFloat  ) * FieldByName( 'QUANTITY' ).AsFloat );

    FieldByName( 'clcWORK' ).AsString := GetFullWorkName( FieldByName( 'lpWORK' ).AsString, FieldByName( 'lpMEASUREMENT' ).AsString );
    FieldByName( 'clc_IS_CAN_EDIT' ).AsBoolean := ( FieldByName( 'FK_DEPWORKS_OFFICPOST_INS' ).AsInteger = F_DefaultOfficPostIns );
  end;
  /////////////////////
  if not DataSet.FieldByName('sent_1562').IsNull then
  if DataSet.FieldByName('sent_1562').AsInteger=1 then
   Dataset.FieldByName('boolsent_1562').AsBoolean:=true
  else
   Dataset.FieldByName('boolsent_1562').AsBoolean:=false;
end;

procedure Tdm_Work.dset_WorklpDIAMGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  if dset_Work.FieldByName( 'FK_DEPWORKS_DIAMETER' ).AsInteger > 0 then
    Text := Sender.AsString
  else
    Text := '';
end;

procedure Tdm_Work.dset_WorkBeforePost(DataSet: TDataSet);
begin
  with DataSet do
  begin
    if ( State in [dsInsert, dsEdit] ) then
    begin
      if not F_IsRecalcWorkTime then
      begin
        FieldByName( 'WORK_TIME' ).AsFloat := FieldByName( 'clcWORKTIME' ).AsFloat;
        FieldByName( 'MEASUR_QUANTITY' ).AsFloat := FieldByName( 'clcMEASUR_QUANTITY' ).AsFloat;
      end else
      begin
        F_TrudoZatrat.WorkID := FieldByName( 'FK_DEPWORKS_WORK' ).AsInteger;
        F_TrudoZatrat.DiamID := FieldByName( 'FK_DEPWORKS_DIAMETER' ).AsInteger;
        if F_TrudoZatrat.CalcTZFromVC then
        begin
          FieldByName( 'WORK_TIME' ).AsFloat := F_TrudoZatrat.TrudoZatrat;
          FieldBYName( 'MEASUR_QUANTITY' ).AsFloat := F_TrudoZatrat.KolEd;
        end else
        begin
          FieldByName( 'WORK_TIME' ).AsFloat := 0;
          FieldBYName( 'MEASUR_QUANTITY' ).AsFloat := 1;
        end;
      end;
    end;
  end;
end;

procedure Tdm_Work.AddWorksByBWork(_DepBWorkID,_BWorkID: integer);
begin
  MyOpenIBDS( dset,
    ' select bww.id_bwork, bww.id_work, bww.id_diam,' +
    ' wt.hour_summer, wt.hour_winter' +
    ' from s_bwork_work bww' +
    ' left join s_worktime wt' +
    ' on ( wt.id_work = bww.id_work ) and ( wt.id_diam = bww.id_diam )' +
    ' where bww.id_bwork = ' + IntToStr( _BWorkID ) );

  dset.First;
  while not dset.Eof do
  begin
    sql_InsertWorks.Close;
    sql_InsertWorks.ParamByName( 'pOrderID' ).AsInteger := F_OrderID;
    sql_InsertWorks.ParamByName( 'pDepID' ).AsInteger := F_DepID;
    sql_InsertWorks.ParamByName( 'pBWorkID' ).AsInteger := _BWorkID;
    sql_InsertWorks.ParamByName( 'pWorkID' ).AsInteger := dset.FieldByName( 'id_work' ).AsInteger;
    sql_InsertWorks.ParamByName( 'pDiamID' ).AsInteger := dset.FieldByName( 'id_diam' ).AsInteger;
    sql_InsertWorks.ParamByName( 'pDepBWorkID' ).AsInteger := _DepBWorkID;
    sql_InsertWorks.ParamByName( 'pOfficPostInsID' ).AsInteger := F_DefaultOfficPostIns;
    sql_InsertWorks.ParamByName('pSent_1562').AsInteger:=0;
    if F_TrudoZatrat.IsSummerPeriod then
      sql_InsertWorks.ParamByName( 'pWorkTime' ).AsFloat := dset.FieldByName( 'hour_summer' ).AsFloat
    else
      sql_InsertWorks.ParamByName( 'pWorkTime' ).AsFloat := dset.FieldByName( 'hour_winter' ).AsFloat;
    //sql_InsertWorks.ParamByName( 'pSQUARE_ASF' ).AsFloat := dset.FieldByName( 'SQUARE_ASF' ).AsFloat;
    sql_InsertWorks.ExecQuery;

    dset.Next;
  end;
  dset.Close;
end;

procedure Tdm_Work.ChangeWorksAndMaters( _DepBWorkID, _BWorkID: integer );
var
  _IsChanged: boolean;
begin
  {Малые работы}
  _IsChanged := false;
  if caDeleteWorksWithOldAttach in F_ChangeActionOption then
  begin
    DeleteWorks( _DepBWorkID );
    _IsChanged := true;
  end;
  if caResetWorksAttach in F_ChangeActionOption then
  begin
    ResetWorksAttach( _DepBWorkID );
    _IsChanged := true;
  end;
  if caInsertWorks in F_ChangeActionOption then
  begin
    AddWorksByBWork( _DepBWorkID, _BWorkID );
    _IsChanged := true;
  end;

  if _IsChanged then OpenWork;
  {/Малые работы}

  //

  {Материалы}
  _IsChanged := false;
  if caDeleteMatersWithOldAttach in F_ChangeActionOption then
  begin
    DeleteMaters( _DepBWorkID );
    _IsChanged := true;
  end;
  if caResetMatersAttach in F_ChangeActionOption then
  begin
    ResetMatersAttach( _DepBWorkID );
    _IsChanged := true;
  end;
  if caInsertMaters in F_ChangeActionOption then
  begin
    AddMatersByBWork( _DepBWorkID, _BWorkID );
    _IsChanged := true;
  end;

  if _IsChanged then OpenMater;
  {/Материалы}
end;

procedure Tdm_Work.OpenWork;
begin
  dset_Work.Close;
  dset_Work.ParamByName( 'pOrderID' ).AsInteger := F_OrderID;
  dset_Work.ParamByName( 'pDepID' ).AsInteger := F_DepID;
  dset_Work.Open;
end;


procedure Tdm_Work.DeleteWorks(_DepBWorkID: integer);
begin
  MyExecIBSQL( IBSQL,
    ' delete from departureworks' +
    ' where FK_DEPWORKS_ORDER = ' + IntToStr( F_OrderID ) +
    ' and FK_DEPWORKS_DEPARTURE = ' + IntToStr( F_DepID ) +
    ' and FK_DEPWORKS_DEPBWORK = ' + IntToStr( _DepBWorkID )  );
end;

procedure Tdm_Work.dset_BWorkBeforeDelete(DataSet: TDataSet);
var
  _DepBWorkID: integer;
begin
  _DepBWorkID := DataSet.FieldByName( 'ID' ).AsInteger;

  {Подработы}
  if caDeleteWorks in F_ChangeActionOption then
    DeleteWorks( _DepBWorkID )
  else
    ResetWorksAttach( _DepBWorkID );
  OpenWork;
  {/Подработы}
  //
  {Материалы}
  if caDeleteMaters in F_ChangeActionOption then
    DeleteMaters( _DepBWorkID )
  else
    ResetMatersAttach( _DepBWorkID );
  OpenMater;
  {/Материалы}
end;

procedure Tdm_Work.ResetWorksAttach(_DepBWorkID: integer);
begin
  MyExecIBSQL( IBSQL,
    ' update departureworks set' +
    ' FK_DEPWORKS_BWORK = null,' +
    ' FK_DEPWORKS_DEPBWORK = null' +
    ' where FK_DEPWORKS_ORDER = ' + IntToStr( F_OrderID ) +
    ' and FK_DEPWORKS_DEPARTURE = ' + IntToStr( F_DepID ) +
    ' and FK_DEPWORKS_DEPBWORK = ' + IntToStr( _DepBWorkID ) );
end;

procedure Tdm_Work.dset_WorkFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  case F_ShowMode of
    smAll: Accept := true;
    smAttached: Accept := ( DataSet.FieldByName( 'FK_DEPWORKS_DEPBWORK' ).AsInteger = dset_BWork.FieldByName( 'ID' ).AsInteger );
    smFree: Accept := DataSet.FieldByName( 'FK_DEPWORKS_DEPBWORK' ).IsNull;
  end;
end;

procedure Tdm_Work.SetShowMode(Value: TShowMode);
begin
  F_ShowMode := Value;
  RefilterWorks;
  RefilterMaters;
end;

procedure Tdm_Work.RefilterWorks;
begin
  dset_Work.DisableControls;
  try
    dset_Work.Filtered := false;
    dset_Work.Filtered := true;
  finally
    dset_Work.EnableControls;
  end;
end;

procedure Tdm_Work.dset_BWorkAfterScroll(DataSet: TDataSet);
begin
  if F_ShowMode = smAttached then
  begin
    RefilterWorks;
    RefilterMaters;
  end;
end;

procedure Tdm_Work.FillFastAdd;
begin
  md_FastAdd.Close;
  md_FastAdd.Open;

  with dm_GlobalVocCache do
  begin
    mt_s_bwork.First;
    while not mt_s_bwork.Eof do
    begin
      if ( mt_s_bwork.FieldByName( 'id' ).AsInteger > 0) and
       ( mt_s_bwork.FieldByName( 'activity' ).IsNull )
      then
      begin
        md_FastAdd.Append;
        md_FastAdd.FieldByName( 'BWork' ).AsString := mt_s_bwork.FieldByName( 'name' ).AsString;
        md_FastAdd.FieldByName( 'id_bwork' ).AsInteger := mt_s_bwork.FieldByName( 'id' ).AsInteger;
        md_FastAdd.FieldByName( 'is_add_bwork' ).AsBoolean := false;
        md_FastAdd.FieldByName( 'is_add_work' ).AsBoolean := false;
        md_FastAdd.FieldByName( 'is_add_mater' ).AsBoolean := false;
        md_FastAdd.Post;
      end;

      mt_s_bwork.Next;
    end;
  end;
  md_FastAdd.First;
end;

procedure Tdm_Work.OpenMater;
begin
  dset_Mater.Close;
  dset_Mater.ParamByName( 'pOrderID' ).AsInteger := F_OrderID;
  dset_Mater.ParamByName( 'pDepID' ).AsInteger := F_DepID;
  dset_Mater.Open;
end;

procedure Tdm_Work.dset_MaterlpDiamGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if dset_Mater.FieldByName( 'FK_DEPMATERS_DIAMETER' ).AsInteger > 0 then
    Text := Sender.AsString
  else
    Text := '';
end;

procedure Tdm_Work.dset_MaterAfterInsert(DataSet: TDataSet);
begin
  dset_Mater.FieldByName( 'FK_DEPMATERS_ORDER' ).AsInteger := F_OrderID;
  dset_Mater.FieldByName( 'FK_DEPMATERS_DEPARTURE' ).AsInteger := F_DepID;
  dset_Mater.FieldByName( 'FK_DEPMATERS_DIAMETER' ).AsInteger := -1;
end;

procedure Tdm_Work.AddMatersByBWork(_DepBWorkID,
  _BWorkID: integer);
begin
  MyOpenIBDS( dset,
    ' select id_bwork, id_mater, id_diam' +
    ' from s_bwork_mater' +
    ' where id_bwork = ' + IntToStr( _BWorkID ) );

  dset.First;
  while not dset.Eof do
  begin
    sql_InsertMaters.Close;
    sql_InsertMaters.ParamByName( 'pOrderID' ).AsInteger := F_OrderID;
    sql_InsertMaters.ParamByName( 'pDepID' ).AsInteger := F_DepID;
    sql_InsertMaters.ParamByName( 'pDepBWorkID' ).AsInteger := _DepBWorkID;
    sql_InsertMaters.ParamByName( 'pMaterID' ).AsInteger := dset.FieldByName( 'id_mater' ).AsInteger;
    sql_InsertMaters.ParamByName( 'pDiamID' ).AsInteger := dset.FieldByName( 'id_diam' ).AsInteger;
    sql_InsertMaters.ParamByName( 'pBWorkID' ).AsInteger := _BWorkID;
    sql_InsertMaters.ExecQuery;

    dset.Next;
  end;
  dset.Close;
end;

procedure Tdm_Work.DeleteMaters(_DepBWorkID: integer);
begin
  MyExecIBSQL( IBSQL,
    ' delete from departurematers' +
    ' where FK_DEPMATERS_ORDER = ' + IntToStr( F_OrderID ) +
    ' and FK_DEPMATERS_DEPARTURE = ' + IntToStr( F_DepID ) +
    ' and FK_DEPMATERS_DEPBWORK = ' + IntToStr( _DepBWorkID ) );
end;

procedure Tdm_Work.ResetMatersAttach(_DepBWorkID: integer);
begin
  MyExecIBSQL( IBSQL,
    ' update departurematers  set' +
    ' FK_DEPMATERS_DEPBWORK = null,' +
    ' FK_DEPMATERS_BWORK = null' +
    ' where FK_DEPMATERS_ORDER = ' + IntToStr( F_OrderID ) +
    ' and FK_DEPMATERS_DEPARTURE = ' + IntToStr( F_DepID ) +
    ' and FK_DEPMATERS_DEPBWORK = ' + IntToStr( _DepBWorkID ) );
end;

procedure Tdm_Work.dset_MaterFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  case F_ShowMode of
    smAll: Accept := true;
    smAttached: Accept := ( DataSet.FieldByName( 'FK_DEPMATERS_DEPBWORK' ).AsInteger = dset_BWork.FieldByName( 'ID' ).AsInteger );
    smFree: Accept := DataSet.FieldByName( 'FK_DEPMATERS_DEPBWORK' ).IsNull;
  end;
end;

procedure Tdm_Work.RefilterMaters;
begin
  dset_Mater.DisableControls;
  try
    dset_Mater.Filtered := false;
    dset_Mater.Filtered := true;
  finally
    dset_Mater.EnableControls;
  end;
end;

procedure Tdm_Work.md_FastAddis_add_bworkChange(Sender: TField);
begin
  md_FastAdd.FieldByName( 'is_add_work' ).AsBoolean := Sender.AsBoolean;
  md_FastAdd.FieldByName( 'is_add_mater' ).AsBoolean := Sender.AsBoolean;
end;

procedure Tdm_Work.PostFastAdd;
begin
  dset_BWork.DisableControls;
  try
    md_FastAdd.First;
    while not md_FastAdd.Eof do
    begin
      if md_FastAdd.FieldByName( 'is_add_bwork' ).AsBoolean then
      begin
        dset_BWork.Append;

        F_ChangeActionOption := [];
        if md_FastAdd.FieldByName( 'is_add_work' ).AsBoolean then
          F_ChangeActionOption := F_ChangeActionOption + [caInsertWorks];
        if md_FastAdd.FieldByName( 'is_add_mater' ).AsBoolean then
          F_ChangeActionOption := F_ChangeActionOption + [caInsertMaters];

        dset_BWork.FieldByName( 'id_bwork' ).AsInteger := md_FastAdd.FieldByName( 'id_bwork' ).AsInteger;
        dset_BWork.Post;
      end;

      md_FastAdd.Next;
    end;
  finally
    dset_BWork.EnableControls;
  end;
end;

procedure Tdm_Work.DataModuleDestroy(Sender: TObject);
begin
  F_TrudoZatrat.Free;
end;

procedure Tdm_Work.RecalcWorkTimeForAll;
var
  _bmark: string;
begin
  dset_Work.DisableControls;
  _bmark := dset_Work.Bookmark;
  F_IsRecalcWorkTime := true;
  try
    dset_Work.First;
    while not dset_Work.Eof do
    begin
      dset_Work.Edit;
      dset_Work.Post;
      dset_Work.Next;
    end;
  finally
    F_IsRecalcWorkTime := false;
    dset_Work.Bookmark := _bmark;
    dset_Work.EnableControls;
  end;
end;

function Tdm_Work.GetWorkKindID(_WorkID: integer): integer;
begin
  if not mt_WorkAtt.Active then mt_WorkAtt.Open;

  if mt_WorkAtt.Locate( 'ID', _WorkID, [] ) then
    Result := mt_WorkAtt.FieldByName( 'id_workkind' ).AsInteger
  else
    Result := -1;
end;

procedure Tdm_Work.dset_WorkFK_DEPWORKS_WORKChange(Sender: TField);
var
  _WorkKindID: integer;
begin
  if ( dset_Work.State in [ dsInsert, dsEdit ] ) then
  begin
    _WorkKindID := GetWorkKindID( dset_Work.FieldByName( 'FK_DEPWORKS_WORK' ).AsInteger );
    if _WorkKindID = WORKKIND_RASKOP_ID then
    begin
      dset_Work.FieldByName( 'FK_DEPWORKS_DIAMETER' ).AsInteger := -1;
      dset_Work.FieldByName( 'QUANTITY' ).AsFloat := 1;
    end else
    begin
      dset_Work.FieldByName( 'exc_depth' ).Clear;
      dset_Work.FieldByName( 'exc_width' ).Clear;
      dset_Work.FieldByName( 'exc_length' ).Clear;
     // dset_Work.FieldByName( 'SQUARE_ASF' ).Clear;
    end;
  end;
end;

procedure Tdm_Work.WorkMoveUp;
var _lastnum: integer;
begin
  //
  _lastnum := dset_Work.FieldByName( 'NUM_WORK' ).AsInteger;
  if not(dset_Work.State = dsEdit) then
   dset_Work.Edit;
  dset_Work.FieldByName( 'NUM_WORK' ).AsInteger := _lastnum - 1;
  dset_Work.Post;
  dset_Work.Prior;
  dset_Work.Edit;
  dset_Work.FieldByName( 'NUM_WORK' ).AsInteger := _lastnum;
  dset_Work.Post;

  dset_Work.Close;
  dset_Work.Open;

  dset_Work.Locate( 'NUM_WORK' ,_lastnum - 1, []);
end;

procedure Tdm_Work.WorkMoveDown;
var _lastnum: integer;
begin
  //
  if not(dset_Work.State = dsEdit) then
   dset_Work.Edit;
  _lastnum := dset_Work.FieldByName( 'NUM_WORK' ).AsInteger;
  dset_Work.FieldByName( 'NUM_WORK' ).AsInteger := _lastnum + 1;
  dset_Work.Post;
  dset_Work.Next;
  dset_Work.Edit;
  dset_Work.FieldByName( 'NUM_WORK' ).AsInteger := _lastnum;
  dset_Work.Post;

  dset_Work.Close;
  dset_Work.Open;

  dset_Work.Locate( 'NUM_WORK' ,_lastnum + 1, []);
end;

end.

