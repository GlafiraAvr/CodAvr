unit RightsManagerDModule;

interface

uses
  SysUtils, Classes, IBDatabase, DB, IBCustomDataSet, DModule, Forms, Windows,
  RxMemDS, SysInfo, IBSQL;


const
  GROUP_RUK = 1;
  GROUP_DISP_CDP = 2;
  CDP_DISTRICT_ID = 1;

type
  TFillUserType=(futAll, futByHost);

  TOnCurrentUserChange=procedure(NewUserName, NewUserGroupName: string) of object;

  TDM_RightsManager = class(TDataModule)
    dset: TIBDataSet;
    tran: TIBTransaction;
    IBDB: TIBDatabase;
    md_Users: TRxMemoryData;
    md_UsersID: TIntegerField;
    md_UsersUSER_NAME: TStringField;
    md_UsersIB_NAME: TStringField;
    dset2: TIBDataSet;
    md_UsersIB_PWD: TStringField;
    md_UsersID_GROUP: TIntegerField;
    md_UsersEXTERNAL_ID: TIntegerField;
    md_UsersGROUP_NAME: TStringField;
    tran_repname: TIBTransaction;
    IBSQL: TIBSQL;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    F_CurrentUserGroupID: integer;
    F_CurrentDistrictID: integer;
    F_DistrictRegions: set of byte;
    F_CurrentUserName: string;
    F_CurrentUserIBName: string;
    F_EditFormGUIDList: TStringList;
    F_IsCurrentUserDisp: boolean;
    F_IsCurrentUserDispCDP: boolean;    
    F_IsCurrentHostDispHost: boolean;
    F_OnCurrentUserChange: TOnCurrentUserChange;
    procedure FillEditFormGUIDList;
    procedure FillUserRights;
    function Connect: boolean;
    procedure Disconnect;
  private
    F_CurrentUserID, F_intGroupsID: integer;
    F_GroupsID: string;
    procedure SetGroupsID;
    procedure SetCurrentDistrictParams;
  public
    procedure FillUsers(AFillUserType: TFillUserType);
    procedure ClearUsers;
    function IsCurrentUserCanEditForm(FormGUID: string): boolean;
    function IsCurrentDistrictHasAccesToRegion(RegionID: integer): boolean;
    procedure SetCurrentUser(IBUserName: string);
    function LocateUser(UserName: string; var IBUserName: string; var IBUserPwd: string): boolean;
    procedure SetCurrentUserRights;
    property CurrentUserIBName: string read F_CurrentUserIBName;
    property CurrentUserName: string read F_CurrentUserName;
    property CurrentUserGroupID: integer read F_CurrentUserGroupID;
    property CurrentDistrictID: integer read F_CurrentDistrictID;
    property IsCurrentUserDisp: boolean read F_IsCurrentUserDisp;
    property IsCurrentUserDispCDP: boolean read F_IsCurrentUserDispCDP;    
    property IsCurrentHostDispHost: boolean read F_IsCurrentHostDispHost write F_IsCurrentHostDispHost;
    property OnCurrentUserChange: TOnCurrentUserChange read F_OnCurrentUserChange
              write F_OnCurrentUserChange;
    function AddReportName(ReportName:String):boolean;
  end;

var
  DM_RightsManager: TDM_RightsManager;

implementation

{$R *.dfm}

uses HelpFunctions, ApplicationSettings, GlobalData, StringConsts;

procedure TDM_RightsManager.ClearUsers;
begin
  md_Users.Close;
end;

function TDM_RightsManager.Connect: boolean;
const
  USER_NAME='avr_ib';
  PASSWORD='avr_ib_pwd';
begin
  {Не удалять}
  {
  Result:=true;
  try
    with IBDB do
    begin
      DatabaseName:=AppSettings.Get_MainDB_Path;
      Params.Add('user_name='+USER_NAME);
      Params.Add('password='+PASSWORD);
      Params.Add('lc_ctype=WIN1251');
      Connected:=true;
    end;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar(E.Message+'(TDM_RightsManager.Connect)'),
          gc_strDispAVR, MB_OK+MB_ICONERROR);
      Result:=false;
    end;
  end;
  }
  {/Не удалять}

  DM_Main.Connect(USER_NAME, PASSWORD);

  //DM_Main.ConnectVDS('','');
end;

procedure TDM_RightsManager.DataModuleCreate(Sender: TObject);
var
  user_name, user_pwd: string;
begin
  F_EditFormGUIDList:=TStringList.Create;
  Connect;
  SetGroupsID;
  SetCurrentDistrictParams;
  
end;

procedure TDM_RightsManager.DataModuleDestroy(Sender: TObject);
begin
  F_EditFormGUIDList.Free;
  Disconnect;
end;

procedure TDM_RightsManager.Disconnect;
begin
  if IBDB.Connected then
    IBDB.Connected:=false;
end;

procedure TDM_RightsManager.FillEditFormGUIDList;
var
  FormGUID: string;
begin
  F_EditFormGUIDList.Clear;

  MyOpenIBDS(dset, Format(
    ' select distinct f.guid'+
    ' from sec_forms f, sec_rightforms rf,'+
    '  sec_users u, sec_userrights ur'+
    ' where (u.id=%d)'+
    ' and (ur.id_user=u.id)'+
    ' and (rf.id_right=ur.id_right)'+
    ' and (f.id=rf.id_form)', [F_CurrentUserID]));

  dset.First;
  while not dset.Eof do
  begin
    FormGUID:=trim(dset.FieldByName('GUID').AsString);
    F_EditFormGUIDList.Add(FormGUID);
    dset.Next;
  end;
end;

procedure TDM_RightsManager.FillUsers(AFillUserType: TFillUserType);
var
  _AddCond: string;
begin
  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
    md_Users.Close;
    md_Users.Open;

    case AFillUserType of
      futAll: _AddCond:='';
      futByHost: _AddCond:=Format(' and (su.id_group in %s)', [F_GroupsID]);
    end;

    MyOpenIBDS(dset,
      ' select su.id, su.name, su.ib_name, su.ib_pwd,'+
      ' su.id_group, su.external_id, sg.external_table, sg.name group_name'+
      ' from sec_users su, sec_groups sg'+
      ' where (su.id_group=sg.id)'+_AddCond+
      ' order by su.name');

    dset.First;
    while not dset.Eof do
    begin
       md_Users.Append;

       md_Users.FieldByName('ID').AsInteger:=dset.FieldByName('id').AsInteger;
       md_Users.FieldByName('IB_NAME').AsString:=trim(dset.FieldByName('ib_name').AsString);
       md_Users.FieldByName('IB_PWD').AsString:=trim(dset.FieldByName('ib_pwd').AsString);
       md_Users.FieldByName('ID_GROUP').AsInteger:=dset.FieldByName('id_group').AsInteger;
       md_Users.FieldByName('EXTERNAL_ID').AsInteger:=dset.FieldByName('external_id').AsInteger;
       md_Users.FieldByName('GROUP_NAME').AsString:=dset.FieldByName('group_name').AsString;

       if (trim(dset.FieldByName('external_table').AsString)='')  or (AnsiUpperCase(trim(dset.FieldByName('name').AsString))<>'')  then
       begin
          md_Users.FieldByName('USER_NAME').AsString:=AnsiUpperCase(trim(dset.FieldByName('name').AsString));
       end else
       begin
          MyOpenIBDS(dset2, Format('select name from %s where id=%d',
            [dset.FieldByName('EXTERNAL_TABLE').AsString, dset.FieldByName('EXTERNAL_ID').AsInteger]));
          md_Users.FieldByName('USER_NAME').AsString:=AnsiUpperCase(trim(dset2.FieldByName('name').AsString));
       end;

      md_Users.Post;
      dset.Next;
    end;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(TDM_RightsManager.FillUsers)');
    end;
  end;
end;

function TDM_RightsManager.IsCurrentUserCanEditForm(FormGUID: string): boolean;
var
  Index: integer;
begin
  Result:=F_EditFormGUIDList.Find(trim(FormGUID), Index);
end;

function TDM_RightsManager.LocateUser(UserName: string; var IBUserName,
  IBUserPwd: string): boolean;
begin
  Result:=md_Users.Locate('user_name', AnsiUpperCase(trim(UserName)), []);

  if Result then
  begin
    IBUserName:=md_Users.FieldByName('IB_NAME').AsString;
    IBUserPwd:=md_Users.FieldByName('IB_PWD').AsString;
  end;
end;

procedure TDM_RightsManager.SetGroupsID;
var
  _HostName: string;
  _HostID: integer;
  _HostMac  : string;
   HostIP :string; //для заполнения таблицы NewHost
  ListMac   : Tstringlist;
  ListIP    : Tstringlist;
  i         : integer;
  flagwork  : boolean;
begin
  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
    _HostName:=AnsiUpperCase(trim(GetComputerName));
    _HostID:=-1;
    _HostMac:='';


//******************************************************************************
//*************** проверка Host и Mac ******************************************
{
    MyOpenIBDS(dset, 'select id, name, mac from sec_hosts');
    dset.First;
    while not dset.Eof do
    begin
      if AnsiUpperCase(trim(dset.FieldByName('name').AsString))=_HostName then
      begin
        _HostID:=dset.FieldByName('id').AsInteger;
        _HostMac:=AnsiUpperCase(trim(dset.FieldByName('mac').AsString));  // получаем mac-адресс сетевой карточки из БД
        break;
      end;
      dset.Next;
    end;

    flagwork:=false;
    if (_HostID<>-1) then
    begin
      ListMac:=TstringList.create;
      ListIP:=TstringList.create;
      getfindmac(ListMac,ListIP);
      for i:=0 to ListMac.Count-1 do
      begin
        if _HostMac=AnsiUpperCase( trim(ListMac[i]) )then
        begin
          flagwork:=true;
          break;
        end;
      end;
      ListMac.Free;
      ListIP.Free;
    end;
    if not flagwork then
    begin // Если mac-адресса не равны или нет хста выходим из программы
      Application.MessageBox('Пожалуйста обратитесь к разработчикам.','Внимание!!! Работа программы невозможна',MB_OK);
      Application.Terminate;
    end;
}
//******************************************************************************

    MyOpenIBDS(dset, 'select id, name, mac, ip from new_hosts');
    dset.First;
    while not dset.Eof do
    begin
      if AnsiUpperCase(trim(dset.FieldByName('name').AsString))=_HostName then
      begin
        _HostID:=dset.FieldByName('id').AsInteger;
        _HostMac:=AnsiUpperCase(trim(dset.FieldByName('mac').AsString));  // получаем mac-адресс сетевой карточки из БД
        break;
      end;
      dset.Next;
    end;
    if _HostID=-1 then
    begin
      //**
      ListMac:=TstringList.create;
      ListIP:=TstringList.create;
      getfindmac(ListMac,ListIP);
      for i:=0 to ListMac.Count-1 do
      begin
        DM_Main.IBQNewHost.ParamByName('pname').AsString:=_HostName;
        DM_Main.IBQNewHost.ParamByName('pmac').AsString:=AnsiUpperCase( trim(ListMac[i]) );
        DM_Main.IBQNewHost.ParamByName('pip').AsString:=AnsiUpperCase( trim(ListIP[i]) );
        try
          DM_Main.IBQNewHost.Transaction.StartTransaction;
          DM_Main.IBQNewHost.ExecSQL;
        finally
          DM_Main.IBQNewHost.Transaction.Commit;
        end;
      end;
        ListMac.Free;
        ListIP.Free;
    end;




//******************************************************************************
 _HostID:=-1;
//******************************************************************************

    MyOpenIBDS(dset, 'select id, name from sec_hosts');
    dset.First;
    while not dset.Eof do
    begin
      if AnsiUpperCase(trim(dset.FieldByName('name').AsString))=_HostName then
      begin
        _HostID:=dset.FieldByName('id').AsInteger;
        break;
      end;
      dset.Next;
    end;

//******************************************************************************

    F_IsCurrentHostDispHost:=false;
    F_GroupsID:='';
    MyOpenIBDS(dset, 'select id_group from sec_grouphosts where id_host='+IntToStr(_HostID));
    dset.First;
    F_intGroupsID:= 0;
    while not dset.Eof do
    begin
      if dset.FieldByName('id_group').AsInteger=GROUP_DISP_CDP then
        F_IsCurrentHostDispHost:=true;
      if F_intGroupsID <> 1 then
        F_intGroupsID := dset.FieldByName('id_group').AsInteger;

      F_GroupsID:=F_GroupsID+','+dset.FieldByName('id_group').AsString;
      dset.Next;
    end;
    Delete(F_GroupsID, 1, 1);
    F_GroupsID:=trim(F_GroupsID);

    if F_GroupsID='' then
      F_GroupsID:='('+IntToStr(GROUP_RUK)+')'
    else
      F_GroupsID:='('+F_GroupsID+')';

    tran.Commit;
  except
    on E:Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(TDM_RightsManager.SetCurrentGroupID)');
    end;
  end;
end;

procedure TDM_RightsManager.SetCurrentUser(IBUserName: string);
begin
  if md_Users.Locate('ib_name', IBUserName, []) then
  begin
    F_CurrentUserID:=md_Users.FieldByName('ID').AsInteger;
    F_CurrentUserGroupID:=md_Users.FieldByName('ID_GROUP').AsInteger;
    F_CurrentUserName:=md_Users.FieldByName('USER_NAME').AsString;
    F_CurrentUserIBName:=md_Users.FieldByName('IB_NAME').AsString;
    F_IsCurrentUserDispCDP:=(md_Users.FieldByName('ID_GROUP').AsInteger = GROUP_DISP_CDP);
    F_IsCurrentUserDisp:=(md_Users.FieldByName('ID_GROUP').AsInteger >= GROUP_DISP_CDP)and(md_Users.FieldByName('ID_GROUP').AsInteger<>3)and(md_Users.FieldByName('ID_GROUP').AsInteger<=11) ;
    g_IDOfficial:=md_Users.FieldByName('EXTERNAL_ID').AsInteger;
    if Assigned(F_OnCurrentUserChange) then
      F_OnCurrentUserChange(md_Users.FieldByName('USER_NAME').AsString, md_Users.FieldByName('GROUP_NAME').AsString);
  end else
    raise Exception.Create('Не могу найти пользователя '+IBUserName+' (TDM_RightsManager.SetCurrentUser)');
end;

procedure TDM_RightsManager.SetCurrentUserRights;
begin
  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
    FillEditFormGUIDList;
    FillUserRights;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(TDM_RightsManager.SetCurrentUserRights)');
    end;
  end;
end;

procedure TDM_RightsManager.FillUserRights;
begin
//
end;

procedure TDM_RightsManager.SetCurrentDistrictParams;
begin
  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    MyOpenIBDS( dset, 'select id_district from db_consts' );
    F_CurrentDistrictID := dset.FieldByName( 'id_district' ).AsInteger;

    if F_CurrentDistrictID = 1 then
    begin
      MyOpenIBDS( dset,
        ' select fk_district'+
        ' from sec_groups'+
        ' where id=' + IntToStr( F_intGroupsID ) );
      if not dset.Eof then
        F_CurrentDistrictID := dset.FieldByName( 'fk_district' ).AsInteger;
    {
     case F_intGroupsID of // мне влом пока что добавлять поле в таблицу, поэтому для тестирования будет так:
      4 : F_CurrentDistrictID := 10 ; //Оператор Червонозав. рай-на
      5 : F_CurrentDistrictID := 8 ;  //Диспетчер Ор., Фр., Моск. р-ов
     end;}
    end;

    MyOpenIBDS( dset,
      ' select id_region'+
      ' from db_districtregion'+
      ' where id_district=' + IntToStr( F_CurrentDistrictID ) );

    dset.First;
    while not dset.Eof do
    begin
      F_DistrictRegions := F_DistrictRegions + [ dset.FieldByName('id_region').AsInteger ];
      dset.Next;
    end;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + ' (TDM_RightsManager.SetCurrentDistrictID)' );
    end;
  end;
end;

function TDM_RightsManager.IsCurrentDistrictHasAccesToRegion(
  RegionID: integer): boolean;
begin
  Result := ( RegionID in F_DistrictRegions );
end;

{вставляет им яотчета при формировании отчет
name - имя отчета}

function TDM_RightsManager.AddReportName(ReportName:String):boolean;
begin
 result:=false;
 try
   tran_repname.StartTransaction;
   try
     IBSQL.ParamByName('name').AsString:=ReportName;
     IBSQL.ParamByName('iduser').AsInteger:=F_CurrentUserID;
     IBSQL.ExecQuery;
     tran_repname.Commit;
     result:=true;
   except
    tran_repname.Rollback
   end;
 except
 end;

end;

end.


