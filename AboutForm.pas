unit AboutForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ver, ExtCtrls;

type
  TAboutFrm = class(TForm)
    ExitBtn: TBitBtn;
    Label1: TLabel;
    pVersion: TPanel;
    edVersion: TEdit;
    lVersion: TLabel;
    procedure ExitBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;


implementation

{$R *.dfm}

procedure TAboutFrm.ExitBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TAboutFrm.FormCreate(Sender: TObject);
begin
  edVersion.Text := TempVersion;

end;

end.
