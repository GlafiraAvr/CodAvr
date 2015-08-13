unit WorkBuffDModule;

interface

uses
  SysUtils, Classes, IBDatabase, DB, kbmMemTable, DModule, IBCustomDataSet,
  GlobalVocCacheDModule, IBSQL, kbmMemBinaryStreamFormat, TrudoZatratDModule;

type
  TRecState = (rsDeleted,    //удаленна€ запись
               rsOriginal,   //немен€вша€с€ запись
               rsModifed,    //измененна€ запись
               rsInserted);  //вставленна€ запись

  Tdm_WorkBuff = class(TDataModule)
    mt_DepWorks: TkbmMemTable;
    mt_DepWorksDepID: TIntegerField;
    mt_DepWorksOrderID: TIntegerField;
    mt_DepWorksID: TIntegerField;
    mt_DepWorksWorkID: TIntegerField;
    mt_DepWorksDiamID: TIntegerField;
    mt_DepWorksQuantity: TFloatField;
    mt_DepWorksAddInfo: TStringField;
    mt_DepWorksREC_STATE: TSmallintField;
    dset_tmp: TIBDataSet;
    mt_s_work: TkbmMemTable;
    mt_s_diam: TkbmMemTable;
    mt_DepWorkslp_Work: TStringField;
    sql_DeleteWork: TIBSQL;
    sql_UpdateWork: TIBSQL;
    sql_InsertWork: TIBSQL;
    mt_DepWorkslp_Diam: TStringField;
    tran: TIBTransaction;
    mt_DepWorksOfficPostInsID: TIntegerField;
    mt_DepWorksIS_CAN_EDIT: TBooleanField;
    mt_DepWorksTrudoZatrat: TFloatField;
    mt_DepWorksTZ_KolEd: TFloatField;
    mt_DepWorksexc_depth: TFloatField;
    mt_DepWorksexc_width: TFloatField;
    mt_DepWorksexc_length: TFloatField;
    mt_WorkAtt: TkbmMemTable;
    mt_DepWorksSQUARE_ASF: TFloatField;
    mt_DepWorkssentto1562: TBooleanField;
    mt_DepWorksFact_DateTime: TDateTimeField;
    procedure mt_DepWorksFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure mt_DepWorksAfterInsert(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure mt_DepWorksWorkIDChange(Sender: TField);
  private
    F_OrderID,
    F_DepID: integer;
    F_IsDataChanged: boolean;
    F_OnDataChange: TNotifyEvent;
    F_OnBeforePost: TDataSetNotifyEvent;
    F_DefaultOfficPostInsID: integer;
    F_CurrentStartDate: TDateTime;
    F_IsLoadingData: boolean;
    procedure OpenVocs;
    procedure SetIsDataChanged( Value: boolean );
    function GetWorkKind( _WorkID: integer ): integer;
  public
    property OnDataChange: TNotifyEvent read F_OnDataChange write F_OnDataChange;
    property OnBeforePost: TDataSetNotifyEvent read F_OnBeforePost write F_OnBeforePost;
    property CurrentStartDate: TDateTime read F_CurrentStartDate write F_CurrentStartDate;
    property OrderID: integer read F_OrderID write F_OrderID;
    property DepID: integer read F_DepID write F_DepID;
    property IsDataChanged: boolean read F_IsDataChanged;
    procedure LoadData;
    procedure SaveModifedData;
    procedure ResetBuff;
    procedure Insert;
    procedure Edit;
    procedure Post;
    procedure Cancel;
    procedure Delete;
  end;

implementation

{$R *.dfm}

uses HelpFunctions, GlobalData;

{ Tdm_WorkBuff }

procedure Tdm_WorkBuff.LoadData;
begin
  ResetBuff;

  OpenVocs;

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    F_IsLoadingData := true;
    try
      MyOpenIBDS( dset_tmp,
        ' select dw.ID,' +
        '     dw.FK_DEPWORKS_DEPARTURE,' +
        '     dw.FK_DEPWORKS_ORDER,' +
        '     dw.FK_DEPWORKS_WORK,' +
        '     dw.FK_DEPWORKS_DIAMETER,' +
        '     dw.QUANTITY,' +
        '     dw.ADDITIONALINFO,' +
        '     dw.EXC_DEPTH,' +
        '     dw.EXC_WIDTH,' +
        '     dw.EXC_LENGTH,' +
        '     dw.FK_DEPWORKS_OFFICPOST_INS' +
        '    , dw.SQUARE_ASF '+
        '    , dw.SENT_1562 '+  //glasha 2012
        '    , dw.fact_DateTime '+  //glasha 2012
        ' from departureworks dw' +
        ' left join s_works sw on sw.id = dw.FK_DEPWORKS_WORK' +
        ' left join s_tubediameter sd on sd.id = dw.FK_DEPWORKS_DIAMETER' +
        ' where' +
        '     (dw.FK_DEPWORKS_ORDER = ' + IntToStr( F_OrderID ) + ' ) and' +
        '     (dw.FK_DEPWORKS_DEPARTURE = ' + IntToStr( F_DepID ) + ')' +
        ' order by dw.ID' );

      dset_tmp.First;
      while not dset_tmp.Eof do
      begin
        mt_DepWorks.Append;
        {
        mt_DepWorks.FieldByName( 'ID' ).AsInteger := dset_tmp.FieldByName( 'ID' ).AsInteger;
        mt_DepWorks.FieldByName( 'OrderID' ).AsInteger := dset_tmp.FieldByName( 'FK_DEPWORKS_ORDER' ).AsInteger;
        mt_DepWorks.FieldByName( 'DepID' ).AsInteger := dset_tmp.FieldByName( 'FK_DEPWORKS_DEPARTURE' ).AsInteger;
        mt_DepWorks.FieldByName( 'WorkID' ).AsInteger := dset_tmp.FieldByName( 'FK_DEPWORKS_WORK' ).AsInteger;
        mt_DepWorks.FieldByName( 'DiamID' ).AsInteger := dset_tmp.FieldByName( 'FK_DEPWORKS_DIAMETER' ).AsInteger;
        mt_DepWorks.FieldByName( 'Quantity' ).AsFloat := dset_tmp.FieldByName( 'QUANTITY' ).AsFloat;
        mt_DepWorks.FieldByName( 'AddInfo' ).AsString := dset_tmp.FieldByName( 'ADDITIONALINFO' ).AsString;
        mt_DepWorks.FieldByName( 'exc_depth' ).AsFloat := dset_tmp.FieldByName( 'EXC_DEPTH' ).AsFloat;
        mt_DepWorks.FieldByName( 'exc_width' ).AsFloat := dset_tmp.FieldByName( 'EXC_WIDTH' ).AsFloat;
        mt_DepWorks.FieldByName( 'exc_length' ).AsFloat := dset_tmp.FieldByName( 'EXC_LENGTH' ).AsFloat;
        mt_DepWorks.FieldByName( 'OfficPostInsID' ).AsInteger := dset_tmp.FieldByName( 'FK_DEPWORKS_OFFICPOST_INS' ).AsInteger;
        mt_DepWorks.FieldByName( 'IS_CAN_EDIT' ).AsBoolean := ( dset_tmp.FieldByName( 'FK_DEPWORKS_OFFICPOST_INS' ).AsInteger = F_DefaultOfficPostInsID );
        mt_DepWorks.FieldByName( 'REC_STATE' ).AsInteger := Ord( rsOriginal );
        }
        mt_DepWorks[ 'ID' ] := dset_tmp[ 'ID' ];
        mt_DepWorks[ 'OrderID' ] := dset_tmp[ 'FK_DEPWORKS_ORDER' ];
        mt_DepWorks[ 'DepID' ] := dset_tmp[ 'FK_DEPWORKS_DEPARTURE' ];
        mt_DepWorks[ 'WorkID' ] := dset_tmp[ 'FK_DEPWORKS_WORK' ];
        mt_DepWorks[ 'DiamID' ] := dset_tmp[ 'FK_DEPWORKS_DIAMETER' ];
        mt_DepWorks[ 'Quantity' ] := dset_tmp[ 'QUANTITY' ];
        mt_DepWorks[ 'AddInfo' ] := dset_tmp[ 'ADDITIONALINFO' ];
        mt_DepWorks[ 'exc_depth' ] := dset_tmp[ 'EXC_DEPTH' ];
        mt_DepWorks[ 'exc_width' ] := dset_tmp[ 'EXC_WIDTH' ];
        mt_DepWorks[ 'exc_length' ] := dset_tmp[ 'EXC_LENGTH' ];
        mt_DepWorks[ 'SQUARE_ASF' ] := dset_tmp[ 'SQUARE_ASF' ];
        mt_DepWorks[ 'OfficPostInsID' ] := dset_tmp[ 'FK_DEPWORKS_OFFICPOST_INS' ];
        mt_DepWorks[ 'IS_CAN_EDIT' ] := ( dset_tmp.FieldByName( 'FK_DEPWORKS_OFFICPOST_INS' ).AsInteger = F_DefaultOfficPostInsID );
        mt_DepWorks[ 'sentto1562' ] := (dset_tmp.fieldByName('SENT_1562').AsInteger=1); //glasha 2012
        mt_DepWorks[ 'Fact_DateTime' ]:=dset_tmp['fact_DateTime'];//glasha 2012
        mt_DepWorks[ 'REC_STATE' ] := Ord( rsOriginal );

        mt_DepWorks.Post;

        dset_tmp.Next;
      end;
      dset_tmp.Close;
    finally
      F_IsLoadingData := false;
    end;
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_WorkBuff.LoadData)' );
    end;
  end;

  mt_DepWorks.Filtered := true;
  SetIsDataChanged( false );
end;

procedure Tdm_WorkBuff.OpenVocs;
var
  _AttachList: TList;
  i: integer;
  _dset: TDataSet;
begin
  _AttachList := TList.Create;
  try
    _AttachList.Add( mt_s_work );
    _AttachList.Add( mt_s_diam );
    _AttachList.Add( mt_WorkAtt );
    dm_GlobalVocCache.CheckVocs( _AttachList );

    for i := 0 to _AttachList.Count - 1 do
    begin
      _dset := TDataSet( _AttachList.Items[i] );
      if not _dset.Active then _dset.Open;
    end;
  finally
    _AttachList.Free;
  end;
end;

procedure Tdm_WorkBuff.Insert;
begin
  mt_DepWorks.Append;
end;

procedure Tdm_WorkBuff.Edit;
begin
  mt_DepWorks.Edit;
end;

procedure Tdm_WorkBuff.Post;
  procedure _InsertTrudoZatrat;
  var
    _tz: Tdm_TrudoZatrat;
  begin
    if Assigned( F_OnBeforePost ) then
      F_OnBeforePost( nil );

    _tz := Tdm_TrudoZatrat.Create( nil );
    try
      _tz.WorkDate := F_CurrentStartDate;
      _tz.WorkID := mt_DepWorks.FieldByName( 'WorkID' ).AsInteger;
      _tz.DiamID := mt_DepWorks.FieldByName( 'DiamID' ).AsInteger;
      if _tz.CalcTZFromVC then
      begin
        mt_DepWorks.FieldByName( 'TrudoZatrat' ).AsFloat := _tz.TrudoZatrat;
        mt_DepWorks.FieldByName( 'TZ_KolEd' ).AsFloat := _tz.KolEd;
      end else
      begin
        mt_DepWorks.FieldByName( 'TrudoZatrat' ).AsFloat := 0;
        mt_DepWorks.FieldByName( 'TZ_KolEd' ).AsFloat := 1;
      end;
    finally
      _tz.Free;
    end;
  end;
begin
  with mt_DepWorks do
  begin
    if State in [ dsInsert, dsEdit ] then
    begin
      if State = dsInsert then
      begin
        FieldByName( 'REC_STATE' ).AsInteger := Ord( rsInserted );
       if  FieldByName('fact_DateTime').IsNull then
          FieldByName('fact_DateTime').AsDateTime:=Now();
      end else
      if ( State = dsEdit ) then
      begin
        if FieldByName( 'REC_STATE' ).AsInteger = Ord( rsOriginal ) then
          FieldByName( 'REC_STATE' ).AsInteger := Ord( rsModifed );
      end;
      _InsertTrudoZatrat;
      Post;
      SetIsDataChanged( true );
    end;
  end;
end;

procedure Tdm_WorkBuff.Cancel;
begin
  mt_DepWorks.Cancel;
end;

procedure Tdm_WorkBuff.Delete;
begin
  if mt_DepWorks.FieldByName( 'REC_STATE' ).AsInteger = Ord( rsInserted ) then
  begin
    mt_DepWorks.Delete;
  end else
  begin
    mt_DepWorks.Edit;
    mt_DepWorks.FieldByName( 'REC_STATE' ).AsInteger := Ord( rsDeleted );
    mt_DepWorks.Post;
  end;
  SetIsDataChanged( true );
end;

procedure Tdm_WorkBuff.mt_DepWorksFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := ( DataSet.FieldByName( 'REC_STATE' ).AsInteger <> Ord( rsDeleted ) );
end;

procedure Tdm_WorkBuff.SaveModifedData;


  procedure _SetCommonParams( _ibsql: TIBSQL );
  begin
    with _ibsql do
    begin
      ParamByName( 'pWorkID' ).AsInteger := mt_DepWorks.FieldByName( 'WorkID' ).AsInteger;
      ParamByName( 'pDiamID' ).AsInteger := mt_DepWorks.FieldByName( 'DiamID' ).AsInteger;
      ParamByName( 'pQuantity' ).AsFloat := mt_DepWorks.FieldByName( 'Quantity' ).AsFloat;
      ParamByName( 'pAddInfo' ).AsString := mt_DepWorks.FieldByName( 'AddInfo' ).AsString;
      ParamByName( 'pWorkTime' ).AsFloat := mt_DepWorks.FieldByName( 'TrudoZatrat' ).AsFloat;
      ParamByName( 'pMeasurQuantity' ).AsFloat := mt_DepWorks.FieldByName( 'TZ_KolEd' ).AsFloat;
      ParamByName( 'pExcDepth' ).Value := mt_DepWorks[ 'exc_depth' ];
      ParamByName( 'pExcWidth' ).Value := mt_DepWorks[ 'exc_width' ];
      ParamByName( 'pExcLength' ).Value := mt_DepWorks[ 'exc_length' ];
      ParamByName( 'pSQUAREASF' ).Value := mt_DepWorks[ 'SQUARE_ASF' ];
      if mt_DepWorks[ 'sentto1562' ] then
          ParamByName( 'pSent_1562' ).Value :=1
      else
          ParamByName( 'pSent_1562' ).Value :=0;
    end;
  end;
begin
  if F_IsDataChanged then
  begin
    if tran.InTransaction then tran.Rollback;
    tran.StartTransaction;
    try
      mt_DepWorks.Filtered := false;
      mt_DepWorks.First;
      while not mt_DepWorks.Eof do
      begin
        case mt_DepWorks.FieldByName( 'REC_STATE' ).AsInteger of
          Ord( rsDeleted ):
            begin
              with sql_DeleteWork do
              begin
                sql_DeleteWork.Close;
                ParamByName( 'pID' ).AsInteger := mt_DepWorks.FieldByName( 'ID' ).AsInteger;
                ExecQuery;
              end;
            end;
          Ord( rsModifed ):
            begin
              if mt_DepWorks.FieldByName( 'WorkID' ).AsInteger <= 0 then
                raise Exception.Create( 'Ќе задано поле WorkID' );
              with sql_UpdateWork do
              begin
                sql_UpdateWork.Close;
                _SetCommonParams( sql_UpdateWork );
                ParamByName( 'pID' ).AsInteger := mt_DepWorks.FieldByName( 'ID' ).AsInteger;
                ExecQuery;
              end;
            end;
          Ord( rsInserted ):
            begin
              if mt_DepWorks.FieldByName( 'WorkID' ).AsInteger <= 0 then
                raise Exception.Create( 'Ќе задано поле WorkID' );
              with sql_InsertWork do
              begin
                sql_InsertWork.Close;
                ParamByName( 'pOrderID' ).AsInteger := F_OrderID;
                ParamByName( 'pDepID' ).AsInteger := F_DepID;
                ParamByName( 'pOfficPostInsID' ).AsInteger := mt_DepWorks.FieldByName( 'OfficPostInsID' ).AsInteger;
                _SetCommonParams( sql_InsertWork );
                ExecQuery;
              end;
            end;
        end;
        mt_DepWorks.Next;
      end;
      tran.Commit;
    except
      on E: Exception do
      begin
        tran.Rollback;
        raise Exception.Create( E.Message + '(Tdm_WorkBuff.SaveModifedData)' );
      end;
    end;
  end;

  LoadData;
end;

procedure Tdm_WorkBuff.mt_DepWorksAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName( 'DiamID' ).AsInteger := -1;
  DataSet.FieldByName( 'Quantity' ).AsFloat := 1;
  DataSet.FieldByName( 'OfficPostInsID' ).AsInteger := F_DefaultOfficPostInsID;
  DataSet.FieldByName( 'IS_CAN_EDIT' ).AsBoolean := true;
 
end;

procedure Tdm_WorkBuff.SetIsDataChanged(Value: boolean);
begin
  F_IsDataChanged := Value;
  if Assigned( F_OnDataChange ) then
    F_OnDataChange( nil );
end;

procedure Tdm_WorkBuff.ResetBuff;
begin
  mt_DepWorks.Close;
  mt_DepWorks.Open;
end;

procedure Tdm_WorkBuff.DataModuleCreate(Sender: TObject);
begin
  F_DefaultOfficPostInsID := DM_Main.GetIDOfficialPost( g_IDOfficial );
  F_IsLoadingData := false;

  OpenVocs;
end;

procedure Tdm_WorkBuff.mt_DepWorksWorkIDChange(Sender: TField);
var
  _WorkKind: integer;
begin
  if ( not F_IsLoadingData ) and ( mt_DepWorks.State in [ dsInsert, dsEdit ] ) then
  begin
    _WorkKind := GetWorkKind( mt_DepWorks.FieldByName( 'WorkID' ).AsInteger );
    if _WorkKind = WORKKIND_RASKOP_ID then
    begin
      mt_DepWorks.FieldByName( 'DiamID' ).AsInteger := -1;
      mt_DepWorks.FieldByName( 'Quantity' ).AsFloat := 1;
    end else
    begin
      mt_DepWorks.FieldByName( 'exc_depth' ).Clear;
      mt_DepWorks.FieldByName( 'exc_width' ).Clear;
      mt_DepWorks.FieldByName( 'exc_length' ).Clear;
      mt_DepWorks.FieldByName( 'SQUARE_ASF' ).Clear;      
    end;
  end;
end;

function Tdm_WorkBuff.GetWorkKind(_WorkID: integer): integer;
begin
  if not mt_WorkAtt.Active then mt_WorkAtt.Open;
  if mt_WorkAtt.Locate( 'ID', _WorkID, [] ) then
    Result := mt_WorkAtt.FieldByName( 'id_workkind' ).AsInteger
  else
    Result := -1;
end;

end.
