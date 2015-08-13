unit VocWorkerPostForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  Tfrm_VocWorkerPost = class(Tfrm_BaseVoc)
    ed_Name: TDBEdit;
    dset_MainVocID: TIntegerField;
    dset_MainVocNAME_: TIBStringField;
    dset_MainVocACTIVITY: TSmallintField;
  protected
    class function IsCurrentUserCanEdit: boolean; override;
  protected
    procedure EnableCtrls(value: boolean); override;
  public
  end;


implementation

uses RightsManagerDModule, AppGUIDS;

{$R *.dfm}

{ Tfrm_VocWorkerPost }

procedure Tfrm_VocWorkerPost.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);
  ed_Name.Visible := value;
end;

class function Tfrm_VocWorkerPost.IsCurrentUserCanEdit: boolean;
begin
  Result := ( DM_RightsManager.IsCurrentUserCanEditForm(  ALLVOCFORMGUID ) or
              DM_RightsManager.IsCurrentUserCanEditForm(  DEP_VOC ) );
end;

end.
