unit BWorkChangeForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, WorkDModule, StdCtrls, RxLookup, Buttons, ExtCtrls;

type
  TOnChangeActOpt = procedure (_ChangeActOpt: TChangeActionOption) of object;

  Tfrm_BWorkChange = class(TForm)
    ds_BWork: TDataSource;
    dbl_BWork: TRxDBLookupCombo;
    Label1: TLabel;
    ds_BWorkAtt: TDataSource;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    Bevel1: TBevel;
    procedure btn_okClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
  protected
    F_OnChangeActOpt: TOnChangeActOpt;
  public
    property OnChangeActOpt: TOnChangeActOpt read F_OnChangeActOpt
      write F_OnChangeActOpt;
  end;


implementation

{$R *.dfm}

procedure Tfrm_BWorkChange.btn_okClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure Tfrm_BWorkChange.btn_exitClick(Sender: TObject);
begin
  Close;
end;

end.
