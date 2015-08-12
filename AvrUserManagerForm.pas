unit AvrUserManagerForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AvrUserManagerDModule, CheckLst, ExtCtrls, IBDatabase,
  DB, IBCustomDataSet, Menus, Buttons, IBSQL, RxLookup, RxMemDS;

type
  Tfrm_AvrUserManager = class(TForm)
    pnl_Btns: TPanel;
    Panel1: TPanel;
    lb_Users: TListBox;
    chlb_Rights: TCheckListBox;
    dset: TIBDataSet;
    tran_sel: TIBTransaction;
    pm_Users: TPopupMenu;
    N1: TMenuItem;
    dset2: TIBDataSet;
    btn_Apply: TBitBtn;
    tran_exec: TIBTransaction;
    IBSQL: TIBSQL;
    btn_Exit: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    N2: TMenuItem;
    pm_Rights: TPopupMenu;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    dbl_Groups: TRxDBLookupCombo;
    ds_Groups: TDataSource;
    Label3: TLabel;
    dset_Groups: TRxMemoryData;
    dset_Groupsid: TIntegerField;
    dset_Groupsname: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lb_UsersClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure btn_ApplyClick(Sender: TObject);
    procedure chlb_RightsClickCheck(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure dbl_GroupsChange(Sender: TObject);
  private
    procedure FillUsersListBox;
    procedure FillRightsListBox;
    procedure FillRightsListBoxByUser(UserID: integer);
    procedure FillGroup;
    procedure GetRightsByUser(UserID: integer);
    procedure SetRightsToUser(UserID: integer);
    procedure AddUser;
    procedure SetPwdToUser(UserID: integer);
    procedure DeleteUser(UserID: integer);
    procedure CheckedAllRights(value: boolean);
    procedure EnableApply(value: boolean);
  public
  end;


implementation

{$R *.dfm}

uses HelpFunctions, AddUserForm, SetPwdForm;

{ Tfrm_AvrUserManager }


procedure Tfrm_AvrUserManager.AddUser;
var
  frm: Tfrm_AddUser;
begin
  frm:=Tfrm_AddUser.Create(nil);
  try
    if frm.ShowModal=mrOk then
      FillUsersListBox;
  finally
    frm.Free;
  end;
end;

procedure Tfrm_AvrUserManager.FillRightsListBox;
begin
  chlb_Rights.Clear;

  MyOpenIBDS(dset,
  ' select id, name'+
  ' from sec_rights');

  dset.First;
  while not dset.Eof do
  begin
    chlb_Rights.AddItem(dset.FieldByName('name').AsString, ptr(dset.FieldByName('id').AsInteger));
    dset.Next;
  end;
end;

procedure Tfrm_AvrUserManager.FillUsersListBox;
var
  _AddCond: string;
begin
  lb_Users.Clear;

  if dset_Groups.FieldByName('id').AsInteger>0 then
    _AddCond:=Format(' and (su.id_group=%d)', [dset_Groups.FieldByName('id').AsInteger])
  else
    _AddCond:='';

  MyOpenIBDS(dset,
    ' select su.id, su.name, su.id_group, su.external_id, sg.external_table'+
    ' from sec_users su, sec_groups sg'+
    ' where (su.id_group=sg.id)'+_AddCond+
    ' order by su.name');

    dset.First;
    while not dset.Eof do
    begin
       if trim(dset.FieldByName('external_table').AsString)='' then
       begin
          lb_Users.AddItem(dset.FieldByName('name').AsString, ptr(dset.FieldByName('id').AsInteger));
       end else
       begin
          MyOpenIBDS(dset2, Format('select id, name from %s where id=%d',
            [dset.FieldByName('EXTERNAL_TABLE').AsString, dset.FieldByName('EXTERNAL_ID').AsInteger]));
          lb_Users.AddItem(dset2.FieldByName('name').AsString, ptr(dset.FieldByName('id').AsInteger));
       end;
      dset.Next;
    end;
  dset.Close;
  dset2.Close;
end;

procedure Tfrm_AvrUserManager.GetRightsByUser(UserID: integer);
var
  i: integer;
begin
  if UserID>0 then
  begin
    FillRightsListBoxByUser(UserID);

    MyOpenIBDS(dset, Format(
      ' select id_right'+
      ' from sec_userrights'+
      ' where id_user=%d', [UserID]));

    for i:=0 to chlb_Rights.Count-1 do
    begin
      chlb_RIghts.Checked[i]:=false;
      dset.First;
      while not dset.Eof do
      begin
        if Integer(chlb_Rights.Items.Objects[i])=dset.FieldByName('id_right').AsInteger then
        begin
          chlb_Rights.Checked[i]:=true;
          break;
        end;
        dset.Next;
      end;
    end;
    dset.Close;
  end;
end;

procedure Tfrm_AvrUserManager.FormCreate(Sender: TObject);
begin
  tran_sel.StartTransaction;
  dset_Groups.Open;
  FillGroup;
end;

procedure Tfrm_AvrUserManager.FormDestroy(Sender: TObject);
begin
  dset_Groups.Close;
  if tran_sel.InTransaction then
    tran_sel.Commit;
end;

procedure Tfrm_AvrUserManager.lb_UsersClick(Sender: TObject);
var
  UserID: integer;
begin
  UserID:=Integer(lb_Users.Items.Objects[lb_Users.ItemIndex]);
  GetRightsByUser(UserID);
  EnableApply(false);
end;

procedure Tfrm_AvrUserManager.N1Click(Sender: TObject);
begin
  AddUser;
end;

procedure Tfrm_AvrUserManager.btn_ApplyClick(Sender: TObject);
var
  UserID: integer;
begin
  if lb_Users.ItemIndex>-1 then
  begin
    UserID:=Integer(lb_Users.Items.Objects[lb_Users.ItemIndex]);
    SetRightsToUser(UserID);
    GetRightsByUser(UserID);

    EnableApply(false);
  end
end;

procedure Tfrm_AvrUserManager.SetRightsToUser(UserID: integer);
var
  i: integer;
begin
  if UserID>0 then
  begin
    if tran_exec.InTransaction then
      tran_exec.Rollback;
    tran_exec.StartTransaction;
    try
      MyExecIBSQL(IBSQL, 'delete from sec_userrights where id_user='+IntToStr(UserID));
      for i:=0 to chlb_Rights.Count-1 do
        if chlb_Rights.Checked[i] then
        begin
          MyExecIBSQL(IBSQL, Format(
            ' insert into sec_userrights(id_user, id_right)'+
            ' values(%d, %d)',
            [UserID, Integer(chlb_Rights.Items.Objects[i])]));
        end;

      tran_exec.Commit;
    except
      on E: Exception do
      begin
        tran_Exec.Rollback;
        raise Exception.Create(E.Message+'Tfrm_AvrUserManager.SetRightsToUser');
      end;
    end;
  end;
end;

procedure Tfrm_AvrUserManager.chlb_RightsClickCheck(Sender: TObject);
begin
  EnableApply(true);
end;

procedure Tfrm_AvrUserManager.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_AvrUserManager.DeleteUser(UserID: integer);
begin
  if UserID>0 then
  begin
    if tran_exec.InTransaction then
      tran_exec.Rollback;
    tran_exec.StartTransaction;
    try
      MyExecIBSQL(IBSQL, 'delete from sec_users where id='+IntToStr(UserID));;

      tran_exec.Commit;
    except
      on E: Exception do
      begin
        tran_exec.Rollback;
        raise Exception.Create(E.Message+'(Tfrm_AvrUserManager.DeleteUser)');
      end;
    end;
  end;
end;

procedure Tfrm_AvrUserManager.N2Click(Sender: TObject);
var
  UserID: integer;
begin
  if lb_Users.ItemIndex>-1 then
  begin
    UserID:=Integer(lb_Users.Items.Objects[lb_Users.ItemIndex]);
    DeleteUser(UserID);
    FillUsersListBox;
    //FillRightsListBox;
    chlb_Rights.Clear;
  end
end;

procedure Tfrm_AvrUserManager.CheckedAllRights(value: boolean);
var
  i: integer;
begin
  for i:=0 to chlb_Rights.Count-1 do
    chlb_Rights.Checked[i]:=value;
end;

procedure Tfrm_AvrUserManager.N3Click(Sender: TObject);
begin
  CheckedAllRights(true);
  EnableApply(true);
end;

procedure Tfrm_AvrUserManager.N4Click(Sender: TObject);
begin
  CheckedAllRights(false);
  EnableApply(true);
end;

procedure Tfrm_AvrUserManager.EnableApply(value: boolean);
begin
  if value then
  begin
    if lb_Users.ItemIndex>-1 then
      btn_Apply.Enabled:=true
    else
      btn_Apply.Enabled:=false;
  end else btn_Apply.Enabled:=false;
end;

procedure Tfrm_AvrUserManager.SetPwdToUser(UserID: integer);
var
  frm: Tfrm_SetPwd;
begin
  frm:=Tfrm_SetPwd.Create(nil);
  try
    frm.UserID:=UserID;
    frm.ShowModal;
  finally
    frm.Free;
  end;
end;

procedure Tfrm_AvrUserManager.N6Click(Sender: TObject);
var
  UserID: integer;
begin
  if lb_Users.ItemIndex>-1 then
  begin
    UserID:=Integer(lb_Users.Items.Objects[lb_Users.ItemIndex]);
    SetPwdToUser(UserID);
  end
end;

procedure Tfrm_AvrUserManager.FillRightsListBoxByUser(UserID: integer);
  function IsDisp: boolean;
  begin
    MyOpenIBDS(dset, 'select name from sec_users where id='+IntToStr(UserID));
    Result:=dset.FieldByName('name').IsNull;
  end;
begin
  if UserID>0 then
  begin
    chlb_Rights.Clear;

    MyOpenIBDS(dset,
      ' select distinct sr.name, sr.id'+
      ' from sec_rights sr, sec_grouprights sgr, sec_users su'+
      ' where (sr.id=sgr.id_right) and (sgr.id_group=su.id_group)'+
      ' and (su.id='+IntToStr(UserID)+')'+
      ' order by sr.id');

    dset.First;
    while not dset.Eof do
    begin
      chlb_Rights.AddItem(dset.FieldByName('name').AsString, ptr(dset.FieldByName('id').AsInteger));
      dset.Next;
    end;
  end;
end;

procedure Tfrm_AvrUserManager.dbl_GroupsChange(Sender: TObject);
begin
  FillUsersListBox;
end;

procedure Tfrm_AvrUserManager.FillGroup;
  procedure AddGroup(id: integer; name: string);
  begin
    dset_Groups.Append;
    dset_Groups.FieldByName('id').AsInteger:=id;
    dset_Groups.FieldByName('name').AsString:=name;
    dset_Groups.Post;
  end;

begin
  AddGroup(-1, 'бяе');

  MyOpenIBDS(dset, 'select id, name from sec_groups');
  dset.First;
  while not dset.Eof do
  begin
    AddGroup(dset.FieldByName('id').AsInteger, dset.FieldByName('name').AsString);
    dset.Next;
  end;

  ResetDBL(dbl_Groups);
end;

end.
