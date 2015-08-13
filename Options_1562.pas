unit Options_1562;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Spin,ApplicationSettings;

type
  Tfrm_options1562 = class(TForm)
    Automat: TCheckBox;
    Interval: TSpinEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure AutomatClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_options1562: Tfrm_options1562;


implementation

{$R *.dfm}

procedure Tfrm_options1562.BitBtn1Click(Sender: TObject);
begin
 if  Automat.Checked then
  AppSettings.Set_Interval(Interval.Value*60000)
 else
  AppSettings.Set_Interval(0);
 ModalResult := mrOk;
end;

procedure Tfrm_options1562.BitBtn2Click(Sender: TObject);
begin
Close;
end;

procedure Tfrm_options1562.AutomatClick(Sender: TObject);
begin
   interval.Enabled:=Automat.Checked;
end;

procedure Tfrm_options1562.FormShow(Sender: TObject);
begin
   interval.Enabled:=Automat.Checked;
end;

end.
