unit NumSOForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGridEh, NumSOBuffDModule,
  DB, ComCtrls, DBCtrls, Mask;

type
  Tfrm_NumSO = class(TForm)
    pnl_Btns: TPanel;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    Grid: TDBGridEh;
    ds_BuffData: TDataSource;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    DBE_Region: TDBEdit;
    L1: TLabel;
    DBE_abonent: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    dbe_phone: TDBEdit;
    Label3: TLabel;
    dbe_adres: TDBEdit;
    dme_about: TDBMemo;
    Label4: TLabel;
    procedure btn_okClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure GridDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
  private
    F_Buff: Tdm_NumSOBuff;
    F_RO: boolean;
  public
    property RO: boolean read F_RO write F_RO;
    constructor Create( AOwner: TComponent; ABuff: Tdm_NumSOBuff );
  end;


implementation

{$R *.dfm}

{ Tfrm_NumSO }

constructor Tfrm_NumSO.Create(AOwner: TComponent; ABuff: Tdm_NumSOBuff);
begin
  inherited Create( AOwner );
  F_Buff := ABuff;

  ds_BuffData.DataSet := F_Buff.mt_BuffData;
end;

procedure Tfrm_NumSO.btn_okClick(Sender: TObject);
begin
  if ds_BuffData.DataSet.State in [ dsInsert, dsEdit ] then
    ds_BuffData.DataSet.Post;
    
  ModalResult := mrOk;
end;

procedure Tfrm_NumSO.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_NumSO.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not (F_Buff.IsReadOnly or RO) then
  begin
    if ( Key = VK_DELETE ) and ( ssCtrl in Shift ) then
     
    begin
      if Application.MessageBox( 'Удалить текущую запись?', 'Внимание', MB_YESNO ) = ID_YES then
        F_Buff.DeleteCurrentRec;
    end ;


    if ( Key = VK_RETURN ) and ( ssCtrl in Shift ) then
    begin
      btn_okClick( nil );
    end;
  end;
end;

procedure Tfrm_NumSO.FormShow(Sender: TObject);
var
  _en: boolean;
  i:integer;
begin
  Grid.ReadOnly := F_Buff.IsReadOnly or RO ;
  for i:=1 to 6 do
     Grid.Columns[i].ReadOnly:=true;
  btn_Ok.Enabled := not (F_Buff.IsReadOnly or RO);
  Grid.Columns[7].ReadOnly:=not btn_Ok.Enabled;
  if F_Buff.IsReadOnly then
    StatusBar1.SimpleText := ''
  else
    StatusBar1.SimpleText := '"Ctrl+Delete" - удаление записи';
  Grid.SetFocus;
end;

procedure Tfrm_NumSO.GridDrawDataCell(Sender: TObject; const Rect: TRect;
  Field: TField; State: TGridDrawState);
begin
if (Field.FieldName='Date_Recive_Request') and (Field.Value.asinteger=0) then
 Field.Text:='';
end;

end.
