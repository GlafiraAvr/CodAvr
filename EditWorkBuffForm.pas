unit EditWorkBuffForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, RxLookup, Mask, DBCtrls, ExtCtrls,
  ComCtrls;

type
  Tfrm_EditWorkBuff = class(TForm)
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    ds_WorkAtt: TDataSource;
    ds_DiamAtt: TDataSource;
    ds_Main: TDataSource;
    dbl_Work: TRxDBLookupCombo;
    Label1: TLabel;
    ed_AddInfo: TDBEdit;
    Label4: TLabel;
    Bevel1: TBevel;
    pnl_Other: TPanel;
    pnl_Exc: TPanel;
    dbl_Diam: TRxDBLookupCombo;
    Label2: TLabel;
    Label3: TLabel;
    ed_Quantity: TDBEdit;
    ed_Length: TDBEdit;
    ed_Width: TDBEdit;
    ed_Depth: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ed_SQUARE_ASF: TDBEdit;
    Label8: TLabel;
    DBCheckBox2: TDBCheckBox;
    procedure btn_okClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbl_WorkChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure AddPnlVisibleBuild;
    function IsFieldsCorrect: boolean;
  public
  end;

implementation

{$R *.dfm}

uses HelpFunctions, GlobalData;

procedure Tfrm_EditWorkBuff.btn_okClick(Sender: TObject);
begin
  if IsFieldsCorrect then
    ModalResult := mrOk;
end;

procedure Tfrm_EditWorkBuff.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_EditWorkBuff.FormShow(Sender: TObject);
begin
  dbl_Work.SetFocus;
  AddPnlVisibleBuild;
end;

procedure Tfrm_EditWorkBuff.dbl_WorkChange(Sender: TObject);
begin
  AddPnlVisibleBuild
end;

procedure Tfrm_EditWorkBuff.AddPnlVisibleBuild;
  procedure _VisibPnls( _exc, _other: boolean );
  begin
    pnl_Exc.Visible := _exc;
    pnl_Other.Visible := _other;
  end;
begin
  if ds_WorkAtt.DataSet.FieldByName( 'id_workkind' ).AsInteger = WORKKIND_RASKOP_ID then
    _VisibPnls( true, false )
  else
    _VisibPnls( false, true );
end;

procedure Tfrm_EditWorkBuff.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  procedure _Next;
  begin
    SelectNext( ActiveControl, true, true );
  end;
begin
  if ( Key=VK_RETURN ) and not( ssCtrl in Shift ) then
  begin
    if (Sender is TRxDBLookupCombo) then
    begin
      if not (Sender as TRxDBLookupCombo).IsDropDown then
        _Next;
    end else _Next;
  end;
end;

function Tfrm_EditWorkBuff.IsFieldsCorrect: boolean;
begin
  Result := false;

  if IsDBLEmpty( dbl_Work ) then
  begin
    Application.MessageBox( 'Введите подработу!', 'Внимание', MB_OK + MB_ICONWARNING );
    dbl_Work.SetFocus;
    exit;
  end;

  if pnl_Exc.Visible then
  begin
    if trim( ed_Length.Text ) = '' then
    begin
      Application.MessageBox( 'Введите длину!', 'Внимание', MB_OK + MB_ICONWARNING );
      ed_Length.SetFocus;
      exit;
    end;

    if trim( ed_Width.Text ) = '' then
    begin
      Application.MessageBox( 'Введите ширину!', 'Внимание', MB_OK + MB_ICONWARNING );
      ed_Width.SetFocus;
      exit;
    end;

    if trim( ed_Depth.Text ) = '' then
    begin
      Application.MessageBox( 'Введите глубину!', 'Внимание', MB_OK + MB_ICONWARNING );
      ed_Depth.SetFocus;
      exit;
    end;
  end;

  Result := true;
end;

end.
