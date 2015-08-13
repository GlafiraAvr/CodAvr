unit WarningForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TResultAnswer = (raSave, raNoSave, raReturn);

  Tfrm_Warning = class(TForm)
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure Button1Click(Sender: TObject);
  private
    F_ResultAnswer: integer;
  public
    property ResultAnswer: integer read F_ResultAnswer write F_ResultAnswer;
  end;

  function ShowWarningDlg: TResultAnswer;


implementation

{$R *.dfm}

function ShowWarningDlg: TResultAnswer;
var
  frm_Warning: Tfrm_Warning;
begin
  frm_Warning:=Tfrm_Warning.Create(nil);
  try
    frm_Warning.ShowModal;
    case frm_Warning.ResultAnswer of
      1: Result:=raSave;
      2: Result:=raNoSave;
      3: Result:=raReturn;
    end;
  finally
    frm_Warning.Free;
  end;
end;



procedure Tfrm_Warning.Button1Click(Sender: TObject);
begin
  ResultAnswer := (Sender as TButton).Tag;
  Close;
end;


end.
