unit OptPlanDepForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DateSelForm, StdCtrls, Buttons, Mask, ToolEdit,DModule, DB,
  IBCustomDataSet, DBCtrlsEh, ExtCtrls, IBDatabase, Spin;

type
  Tfrm_OptPlanDep = class(Tfrm_DateSel)
    pnl_opt: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ds_main: TDataSource;
    dset: TIBDataSet;
    tran: TIBTransaction;
    sp_excav: TSpinEdit;
    sp_Tripper: TSpinEdit;
    sp_pumping: TSpinEdit;
    dsetSAVEDDATE: TDateField;
    dsetEXCAV: TIntegerField;
    dsetTIPPER: TIntegerField;
    dsetPUMPING: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure dp_DateChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
  private
    { Private declarations }

    F_excav,F_tripper,F_pumping:integer;
    F_readOnly:boolean;
      procedure LocValues( Dt:TDate);
  protected
    procedure SetReadOnly(v:boolean);
  public
    { Public declarations }
    property _excav:integer read F_excav;
    property _triper:integer read F_tripper;
    property _pumping:integer read F_pumping;
    property _ReadOnly:boolean write setReadOnly;

  end;

var
  frm_OptPlanDep: Tfrm_OptPlanDep;

implementation

{$R *.dfm}

procedure Tfrm_OptPlanDep.FormShow(Sender: TObject);
begin
  inherited;
  if dset.Active then
    dset.Close;
 dset.Open;
 LocValues(dp_Date.Date);

end;

procedure Tfrm_OptPlanDep.LocValues( Dt:TDate);
 var  V: Variant;

begin
 if dset.Active then
 begin
  V:=dset.Lookup('SavedDate',VarArrayOf([dp_date.Date]),'EXCAV;TIPPER;PUMPING');
  if not (VarType(V) in [varNull]) then begin
   F_excav:=V[0];
   F_tripper:=V[1];
   F_pumping:=V[2];
  end;
 end;
 sp_excav.Value:=F_excav;
 sp_Tripper.Value:=F_tripper;
 sp_pumping.Value:=F_pumping;

end;

procedure Tfrm_OptPlanDep.dp_DateChange(Sender: TObject);
begin
  inherited;
  LocValues(dp_Date.Date);
end;

procedure Tfrm_OptPlanDep.FormDestroy(Sender: TObject);
begin
  inherited;
if dset.Active then dset.Close;
end;

procedure Tfrm_OptPlanDep.SetReadOnly(v:boolean);
begin
 pnl_opt.Enabled:=not v;
 
 F_readOnly:=v;
end;

procedure Tfrm_OptPlanDep.btn_OkClick(Sender: TObject);
begin
  inherited;
  F_excav:=sp_excav.Value;
  F_tripper:=sp_tripper.Value;
  F_pumping:=sp_pumping.Value;
end;

end.
