unit EditDisconnectionsFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, DBCtrls, RxLookup, ExtCtrls, DisconnectionsDModule,
  DB;

type
  TEditDisconnectionsForm = class(TForm)
    Bevel1: TBevel;
    dbl_Street: TRxDBLookupCombo;
    ed_house: TDBEdit;
    ed_dop: TDBEdit;
    l_street: TLabel;
    l_house: TLabel;
    l_dop: TLabel;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    DataSource1: TDataSource;
    procedure btn_okClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EditDisconnectionsForm: TEditDisconnectionsForm;

implementation

{$R *.dfm}

procedure TEditDisconnectionsForm.btn_okClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TEditDisconnectionsForm.btn_exitClick(Sender: TObject);
begin
  dbl_Street.DataSource.DataSet.Cancel;
  Close;
end;

procedure TEditDisconnectionsForm.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState); 
begin
  if Key=VK_ESCAPE then Close;
  if Key=VK_RETURN then
  begin
    if (Sender is TRxDBLookupCombo) then
    begin
      if not (Sender as TRxDBLookupCombo).IsDropDown then
        SelectNext(ActiveControl, true, true);
    end else SelectNext(ActiveControl, true, true);
  end;

end;

end.
