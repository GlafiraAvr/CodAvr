unit WaitProcessForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  Tfrm_WaitProcess = class(TForm)
    Animate1: TAnimate;
    Label1: TLabel;
    lbl_info: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure setMessage(const infomessage:String);
  end;

var
  frm_WaitProcess: Tfrm_WaitProcess;

implementation

{$R *.dfm}
procedure Tfrm_WaitProcess.setMessage( const infomessage:String);
begin
   lbl_info.Caption:=infomessage;
   
   Application.ProcessMessages;
end;

procedure Tfrm_WaitProcess.FormShow(Sender: TObject);
begin
  lbl_info.Caption:='';
  Animate1.StartFrame:=4;
  Application.ProcessMessages;
end;

end.
