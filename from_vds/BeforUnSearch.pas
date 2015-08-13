unit BeforUnSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons,
   AppEvnts, Menus, StdCtrls,  ToolWin, ComCtrls,
   sfexec, MenuManager,NGReportManager,NGReportManager_vds,ApplicationSettings;

type
  Tfor_univ_serch = class(TForm)
    sp_ns: TSpeedButton;
    sb_vds: TSpeedButton;
    Cansel: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure CanselClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
     F_MenuMgr: TMenuManager;
  public
    { Public declarations }
  end;

var
  for_univ_serch: Tfor_univ_serch;
 

implementation

{$R *.dfm}

procedure Tfor_univ_serch.FormCreate(Sender: TObject);
begin
F_MenuMgr:=TMenuManager.Create;
F_MenuMgr.AddNGRepToCtrl( sp_ns, rnUniversalSearch2, true );
F_MenuMgr.AddNGRepvdsToCtrl( sb_vds,    rnUniversalSearch2_vds,     true );
end;

procedure Tfor_univ_serch.CanselClick(Sender: TObject);
begin
Close;
end;

procedure Tfor_univ_serch.FormDestroy(Sender: TObject);
begin
 F_MenuMgr.Free;
end;

end.
