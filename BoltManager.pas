unit BoltManager;

interface

uses BoltsNGForm, BoltsDModule, BoltsVocCacheDModule, DB, GridFormManager;

type
  TBoltManager=class(TGridFormManager)
  private
    F_Form: Tfrm_BoltsNG;
    F_DM: Tdm_Bolts;
    F_VocCache: Tdm_BoltsVocCache;
  private
    procedure SetCurrentBrigCloseFromOrder(const Value: integer);
    procedure SetOfficialPostID(const Value: integer);
    procedure SetFirstDepDTTM(const Value: TDateTime);
    procedure OpenVocs;
  protected
    procedure CreateForms; override;
    procedure AttachCtrlsAndEvents; override;
    function GetFormGUID: string; override;
  public
    property CurrentBrigCloseFromOrder: integer write SetCurrentBrigCloseFromOrder;
    property OfficialPostID: integer write SetOfficialPostID;
    property FirstDepDTTM: TDateTime write SetFirstDepDTTM;
    function Show: boolean; override;
  end;

implementation

uses AppGUIDS;

procedure TBoltManager.AttachCtrlsAndEvents;
begin
  F_Form.ds_Main.DataSet := F_DM.dset_Main;

  F_Form.ds_Diam.DataSet := F_VocCache.cds_Diam;
  F_Form.ds_BrigClose.DataSet := F_VocCache.cds_BrigClose;
  F_Form.ds_BrigOpen.DataSet := F_VocCache.cds_BrigOpen;
end;

procedure TBoltManager.CreateForms;
begin
  F_Form := CreateForm( Tfrm_BoltsNG ) as Tfrm_BoltsNG;
  F_DM := CreateDM( Tdm_Bolts ) as Tdm_Bolts;
  F_VocCache := CreateVocCache( Tdm_BoltsVocCache ) as Tdm_BoltsVocCache;
end;

function TBoltManager.GetFormGUID: string;
begin
  Result := BOLTSFORMGUID;
end;

procedure TBoltManager.OpenVocs;
begin
  F_VocCache.ReopenVocDsets;
  F_Form.frame_Address.ReopenVocDsets;
end;

procedure TBoltManager.SetCurrentBrigCloseFromOrder(const Value: integer);
begin
  F_DM.CurrentBrigCloseFromOrder := Value;
end;

procedure TBoltManager.SetFirstDepDTTM(const Value: TDateTime);
begin
  F_Form.FirstDepDTTM := Value;
end;

procedure TBoltManager.SetOfficialPostID(const Value: integer);
begin
  F_DM.OfficialPostID := Value;
end;

function TBoltManager.Show: boolean;
begin
  OpenVocs;
  F_DM.OpenDset;
  F_Form.ShowModal;
end;

end.
