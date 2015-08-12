unit CanselForm;
{$define save in base}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,DModule, IBDatabase, IBSQL, StdCtrls, Buttons, ComCtrls, DB,
  IBCustomDataSet, DBCtrls, Mask,
  workSQL;

type
 TProcSent1562=(Import_Denied,RallBack1562,TelRequestInOch);

  Tfrm_cansel1562 = class(TForm)
    btn_write: TBitBtn;
    btn_ok: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    tran_numsorders: TIBTransaction;
    btn_cansel: TBitBtn;
    sb_ProcessStaus: TStatusBar;
    DataSource1: TDataSource;
    IBSQL1: TIBSQL;
    Reason: TMemo;
    edit_department: TEdit;
    BitBtn1: TBitBtn;
    main_dset: TIBDataSet;
    procedure btn_writeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure reasonChange(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_canselClick(Sender: TObject);

  private
    { Private declarations }
    F_table:string;
    F_id_order:integer;
    F_Edit:boolean;
    F_ID1562:TStringList;
    F_ordernumber:string;
    F_DateOrder:TDateTime;
    function ALLFields():boolean;
    procedure SetStatus(str:string);
    procedure EnableEdit(Enable:boolean);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;id_o:integer;tab:string;OrderNumber:String;
DateopenOrder:TDateTime);
    property table:string write F_Table;
    property id_order:integer write F_id_order;
    property Enabled:boolean  write EnableEdit;
    property ID1562:TStringList write F_ID1562;
    procedure SaveDate(sent_Proc:TProcSent1562);
  end;

var
  frm_cansel1562: Tfrm_cansel1562;

const
    SQL='update %s set department=''%s'', cansel_reason=''%s'',state_outer=1, state_inner=2 where id_order=%d';
    Select_SQL='select department,cansel_reason,state_inner from %s  where id_order=:id_order and state_inner>=1 and   trim(recived_from)<>''По телефону''';

    Modify_SQL='update %s set department=:department, '+
               ' cansel_reason=:cansel_reason,state_outer=2, state_inner=2, '+
               ' id_Officials_Closed=%d, DateClosed=:dateClose where id_order=:id_order and id_1562=:id_1562 ';
implementation

{$R *.dfm}
 uses GlobalData,StringConsts;
constructor Tfrm_cansel1562.Create(AOwner: TComponent;id_o:integer;tab:string;OrderNumber:String;
DateopenOrder:TDateTime);
begin
inherited Create(AOwner);
F_table:=tab;
F_id_order:=id_o;
F_ordernumber:=OrderNumber;
F_DateOrder:=DateopenOrder;


end;
function Tfrm_cansel1562.ALLFields():boolean;
begin
if reason.Text='' then
begin
   SetStatus('Введите причину!');
   reason.SetFocus;
   result:=false;
   exit;
end;
if edit_department.Text='' then
begin
   SetStatus('Введите службу!');
   edit_department.SetFocus;
   result:=false;
   exit;
end;


result:=true;
end;

procedure Tfrm_cansel1562.btn_writeClick(Sender: TObject);
begin
 try
  if AllFields() then
  begin
   IBSQL1.SQL.Text:=Format(Modify_SQL,[F_Table,  g_IDOfficial]);
   IBSQL1.ParamByName('department').AsString:= trim(edit_department.Text);
   IBSQL1.ParamByName('cansel_reason').AsString:=trim( reason.Lines.Text);
    IBSQL1.ParamByName('id_order').asinteger:=F_id_order;
    btn_ok.Enabled:=true;
    btn_write.Enabled:=false;

    SetStatus('Изменения сохранены!');
  end;
 except    on E:exception do
  begin
   application.MessageBox(PAnsiChar('Ошибка при записи информации отказа!!  '+E.message),'Ошибка', MB_OK+MB_ICONERROR);
    SetStatus('Попробуйте изменить значение полей');
    Reason.SetFocus;
    exit;
// ModalResult := idAbort;
///   Raise e;
  end;
 end;

end;

procedure Tfrm_cansel1562.FormShow(Sender: TObject);
begin
{$ifdef save in base}
try
if  not main_dset.Active then begin
 main_dset.SelectSQL.Text:=Format(Select_SQL,[F_Table]);
 main_dset.ModifySQL.Text:=Format(Modify_SQL,[F_Table,  g_IDOfficial]);
 main_dset.ParamByName('id_order').AsInteger:=F_id_order;
 if not  tran_numsorders.InTransaction then
   tran_numsorders.StartTransaction;
 main_dset.Open;
 reason.Lines.Text:=main_dset.fieldbyname('cansel_reason').AsString;
 edit_department.Text:=main_dset.fieldbyname('DEPARTMENT').AsString;
 end;
{$endif}
 btn_write.Enabled:=F_Edit;
 btn_ok.Enabled:=false;
except on e:exception do begin
raise e;
exit;
end;
end;


//main_dset.Edit;
end;

procedure Tfrm_cansel1562.SetStatus(str:string);
begin
  sb_ProcessStaus.SimpleText:=str;
end;

procedure Tfrm_cansel1562.reasonChange(Sender: TObject);
begin
btn_ok.Enabled:=false;
btn_write.Enabled:=true;
SetStatus('Изменения не сохранены!')
end;

procedure Tfrm_cansel1562.btn_okClick(Sender: TObject);
begin
ModalResult := mrOk;

end;

procedure Tfrm_cansel1562.btn_canselClick(Sender: TObject);
begin
ModalResult := mrCancel;
end;

procedure Tfrm_cansel1562.SaveDate(sent_Proc:TProcSent1562);
var frm_SQL:Tdm_workSQL;
  i:integer;
  department ,reason:string;
  from:integer;
begin
if F_Table='numsorders' then from:=1
else   from:=0;

try
  main_dset.Close;
  if tran_numsorders.Active then
  tran_numsorders.Commit;
  reason:=  IBSQL1.ParamByName('cansel_reason').AsString;
  department:= IBSQL1.ParamByName('department').AsString;
  IBSQL1.ParamByName('DateClose').AsDateTime:=Now();

  frm_SQL:=Tdm_workSQL.Create(nil);


  case sent_Proc of
    Import_Denied:  for i:=0 to F_ID1562.count-1 do
                      frm_SQL.Import_Denied(StrToInt(F_ID1562.Strings[i]),department,reason );
    RallBack1562:    for i:=0 to F_ID1562.count-1 do
                     frm_SQL.RallBack1562(StrToInt(F_ID1562.Strings[i]), F_id_order,2,f_orderNumber,f_DateOrder);
    TelRequestInOch: for i:=0 to F_ID1562.count-1 do
                      frm_SQL.DirectionTelRequestInOchistvod(StrToInt(F_ID1562.Strings[i]), from);
end;


{$ifdef save in base}
  try
      tran_numsorders.StartTransaction;
      for i:=0 to F_ID1562.count-1 do begin
        IBSQL1.ParamByName('id_1562').AsInteger:=StrToInt(F_ID1562.Strings[i]);
        IBSQL1.ExecQuery;
      end;
      tran_numsorders.Commit;
  except  on e:exception do  begin
        tran_numsorders.Rollback;
        Application.MessageBox(PANSIChar('Ошибка при сохранении отказа'+ #13+e.message),gc_strDispAVR,MB_OK+MB_ICONERROR);
       Raise e;
       exit;
  end;
 end;
{$endif}

EXCEPT   ON E:EXCEPTION DO begin
 Application.MessageBox(PANSIChar('Ошибка при сохранении отказа '+#13+e.message),gc_strDispAVR,MB_OK+MB_ICONERROR);
 rAISE;
  exit;
end;
end;
 frm_SQL.Free;
end;


procedure Tfrm_cansel1562.EnableEdit(Enable:boolean);
begin
 Reason.ReadOnly:=not Enable;
 edit_department.ReadOnly:=not Enable;
 btn_write.Enabled:=Enable;
 F_Edit:=Enable;
end;

end.
