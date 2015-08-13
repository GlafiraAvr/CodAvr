unit VocTeamsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, RxLookup, TeamFrame;

type
  Tfrm_VocTeams = class(Tfrm_BaseVoc)
    frame: Tframe_Team;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_PostClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure framebtn_AddClick(Sender: TObject);
    procedure framebtn_DelClick(Sender: TObject);
  protected
    class function IsCurrentUserCanEdit: boolean; override;
  private
    procedure IsNeedToSave(value: boolean);
  public
  end;


implementation

uses RightsManagerDModule, AppGUIDS;

{$R *.dfm}

procedure Tfrm_VocTeams.FormShow(Sender: TObject);
begin
//  inherited;
  frame.IsReadOnly:=F_ReadOnly;
  frame.Mode:=ftmVoc;
  frame.Start;

  IsNeedToSave(false);
end;

procedure Tfrm_VocTeams.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  inherited;
end;

procedure Tfrm_VocTeams.btn_PostClick(Sender: TObject);
begin
//  inherited;
  frame.Save;
  IsNeedToSave(false);
end;

procedure Tfrm_VocTeams.btn_CancelClick(Sender: TObject);
begin
//  inherited;
  frame.dbl_BrigChange(nil);
  IsNeedToSave(false);
end;

procedure Tfrm_VocTeams.FormDestroy(Sender: TObject);
begin
  inherited;
  frame.Stop;
end;

procedure Tfrm_VocTeams.framebtn_AddClick(Sender: TObject);
begin
  inherited;
  frame.btn_AddClick(Sender);
  IsNeedToSave(true);
end;

procedure Tfrm_VocTeams.framebtn_DelClick(Sender: TObject);
begin
  inherited;
  frame.btn_DelClick(Sender);
  IsNeedToSave(true);
end;

procedure Tfrm_VocTeams.IsNeedToSave(value: boolean);
begin
  if F_ReadOnly then
  begin
    btn_Post.Enabled:=false;
    btn_Cancel.Enabled:=false;
  end else
  begin
    btn_Post.Enabled:=value;
    btn_Cancel.Enabled:=value;
  end;
end;

class function Tfrm_VocTeams.IsCurrentUserCanEdit: boolean;
begin
  Result := ( DM_RightsManager.IsCurrentUserCanEditForm(  ALLVOCFORMGUID ) or
              DM_RightsManager.IsCurrentUserCanEditForm(  DEP_VOC ) );
end;

end.
