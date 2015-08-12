unit AddUserForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, AvrUserManagerDModule, Buttons, RxLookup,
  IBDatabase, DB, IBCustomDataSet, IBSQL;

type
  TUserType=(utLookup, utNormal);

  Tfrm_AddUser = class(TForm)
    ed_Name: TEdit;
    dbl_Name: TRxDBLookupCombo;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    Label1: TLabel;
    dset_Lookup: TIBDataSet;
    tran_sel: TIBTransaction;
    ds_Lookup: TDataSource;
    IBSQL: TIBSQL;
    tran_Exec: TIBTransaction;
    ed_pwd: TEdit;
    Label2: TLabel;
    Bevel1: TBevel;
    ed_ConfPwd: TEdit;
    Label3: TLabel;
    dset_tmp: TIBDataSet;
    dbl_Groups: TRxDBLookupCombo;
    dset_Groups: TIBDataSet;
    ds_groups: TDataSource;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure dbl_GroupsChange(Sender: TObject);
  private
    function GetUserType: TUserType;
    procedure ChangeUserType;
    function IsDataFieldsCorrect: boolean;
  public
  end;

implementation

{$R *.dfm}

uses HelpFunctions;

{ Tfrm_AddUser }

procedure Tfrm_AddUser.ChangeUserType;
  procedure SetVis(dblName, edName: boolean);
  begin
    dbl_Name.Visible:=dblName;
    ed_Name.Visible:=edName;
  end;
var
  _AddCond: string;
begin
  case GetUserType of
    utLookup:
      begin
        if trim(dset_Groups.FieldByName('external_condition').AsString)='' then
          _AddCond:=''
        else
          _AddCond:=' and '+dset_Groups.FieldByName('external_condition').AsString;  

        MyOpenIBDS(dset_Lookup,
          Format(
            ' select id, name'+
            ' from %s'+
            ' where (activity is null)'+
            ' and (id>0)'+_AddCond+
            ' order by name', [dset_Groups.FieldByName('external_table').AsString]));
        SetVis(true, false);
      end;
    utNormal:
      begin
        SetVis(false, true);
      end;
    else SetVis(false, false);
  end;
end;

procedure Tfrm_AddUser.FormShow(Sender: TObject);
begin
  ChangeUserType;
end;

procedure Tfrm_AddUser.FormCreate(Sender: TObject);
begin
  tran_sel.StartTransaction;
  dset_Groups.Open;
  HelpFunctions.FixDBLValue(dset_Groups.FieldByName('id').AsInteger, dbl_Groups);
end;

procedure Tfrm_AddUser.FormDestroy(Sender: TObject);
begin
  if tran_sel.InTransaction then
    tran_sel.Commit;
end;

procedure Tfrm_AddUser.btn_cancelClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_AddUser.btn_okClick(Sender: TObject);
begin
  if not IsDataFieldsCorrect then exit;

  if tran_Exec.InTransaction then
    tran_Exec.Rollback;
  tran_Exec.StartTransaction;
  try
    case GetUserType of
      utLookup:
        begin
          MyExecIBSQL(IBSQL,Format(
            ' insert into sec_users(id_group, external_id, ib_pwd)'+
            ' values(%d, %d, %s)',
            [dset_Groups.FieldByName('id').AsInteger, dset_Lookup.FieldByName('ID').AsInteger, QuotedStr(trim(ed_pwd.Text))]));
        end;
      utNormal:
        begin
          MyExecIBSQL(IBSQL,Format(
            ' insert into sec_users(id_group, name, ib_pwd)'+
            ' values(%d, %s, %s)',
            [dset_Groups.FieldByName('id').AsInteger, QuotedStr(AnsiUpperCase(ed_Name.Text)), QuotedStr(trim(ed_pwd.Text))]));
        end;
    end;
    tran_Exec.Commit;
  except
    on E: Exception do
    begin
      tran_Exec.Rollback;
      raise Exception.Create(E.Message+'(Tfrm_AddUser.btn_okClick)');
    end;
  end;

  ModalResult:=mrOk;
end;

function Tfrm_AddUser.GetUserType: TUserType;
begin
  if dset_Groups.FieldByName('external_table').IsNull then
    Result:=utNormal
  else
    Result:=utLookup;
end;

function Tfrm_AddUser.IsDataFieldsCorrect: boolean;
begin
  Result:=false;

  case GetUserType of
    utLookup:
      begin
        if trim(dbl_Name.Text)='' then
        begin
          Application.MessageBox('Выберите имя пользователя из списка', 'Ошибка', MB_OK+MB_ICONERROR);
          exit;
        end;

        MyOpenIBDS(dset_tmp,
          ' select count(*) kol'+
          ' from sec_users'+
          ' where external_id='+dset_Lookup.FieldByName('id').AsString+
          ' and id_group='+dset_Groups.FieldByName('id').AsString);

        if dset_tmp.FieldByName('kol').AsInteger>0 then
        begin
          Application.MessageBox('Такой пользователь уже есть в списке пользователей', 'Ошибка', MB_OK+MB_ICONERROR);
          exit;
        end;
      end;
    utNormal:
      begin
        if trim(ed_Name.Text)='' then
        begin
          Application.MessageBox('Введите имя пользователя', 'Ошибка', MB_OK+MB_ICONERROR);
          exit;
        end;

        MyOpenIBDS(dset_tmp, Format(
          ' select count(*) kol'+
          ' from sec_users'+
          ' where name like(%s)',
          [QuotedStr(AnsiUpperCase(trim(ed_Name.Text)))]));

        if dset_tmp.FieldByName('kol').AsInteger>0 then
        begin
          Application.MessageBox('Пользователь с таким именем уже есть в списке', 'Ошибка', MB_OK+MB_ICONERROR);
          exit;
        end;
      end;
  end;

  if trim(ed_Pwd.Text)<>trim(ed_ConfPwd.Text) then
  begin
    Application.MessageBox('Введенные пароли не совпадают', 'Ошибка', MB_OK+MB_ICONERROR);
    exit;
  end;

  Result:=true;
end;

procedure Tfrm_AddUser.dbl_GroupsChange(Sender: TObject);
begin
  ChangeUserType;
end;

end.
