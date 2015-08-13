unit FastAddWorkForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGridEh, DB, StdCtrls, Buttons;

type
  Tfrm_FastAddWork = class(TForm)
    Grid: TDBGridEh;
    Panel1: TPanel;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    ds_Main: TDataSource;
    procedure btn_exitClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

procedure Tfrm_FastAddWork.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_FastAddWork.btn_okClick(Sender: TObject);
begin
  if ds_Main.DataSet.State in [dsInsert, dsEdit] then ds_Main.DataSet.Post;
  ModalResult := mrOk;
end;

end.
