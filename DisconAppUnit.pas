unit DisconAppUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGridEh, DBCtrls, FrPreviewForm, dm_AVRDisconnUnit;

type
  TAVRDisconnResultForm = class(TForm)
    pBottom: TPanel;
    pMain: TPanel;
    btLoadSnapShot: TButton;
    btSendAndSave: TButton;
    btClose: TButton;
    grid: TDBGridEh;
    pTop: TPanel;
    DBNavigator1: TDBNavigator;
    btSave: TButton;
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
    F_frPreview: Tfrm_FrPreview;
    F_Path: string;
  public
    { Public declarations }
  end;

var
  AVRDisconnResultForm: TAVRDisconnResultForm;


implementation

{$R *.dfm}

procedure TAVRDisconnResultForm.btCloseClick(Sender: TObject);
begin
 close;
end;

end.
