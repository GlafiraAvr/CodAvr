unit EquipmentUsedForm; // теперь это будет "Запланированное оборудование для благооустройства"
                        // вот такие странные и нелогичные превращения
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseGridForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, Mask, DBCtrls, RxLookup, ExtCtrls, DBCtrlsEh,
  ToolEdit, RXDBCtrl, ComCtrls;

type
  Tfrm_EquipmentUsed = class(Tfrm_BaseGrid)
    tp_Time: TDBDateTimeEditEh;
    dbl_Regions: TRxDBLookupCombo;
    dbl_Equipments: TRxDBLookupCombo;
    dset_Regions: TIBDataSet;
    dset_Equipments: TIBDataSet;
    ds_Regions: TDataSource;
    ds_Equipments: TDataSource;
    dp_Time: TDBDateEdit;
    dset_mainID: TIntegerField;
    dset_mainUSEDDATE: TDateTimeField;
    dset_mainFK_EQUIPUSED_REGIONS: TIntegerField;
    dset_mainFK_EQUIPUSED_EQUIPMENT: TIntegerField;
    lbl_Info: TLabel;
    lbl_Time: TLabel;
    lbl_Region: TLabel;
    lbl_Equipment: TLabel;
    dset_mainREGION: TIBStringField;
    dset_mainEQUIP: TIBStringField;
    procedure btn_InsertClick(Sender: TObject);override;
    procedure FormCreate(Sender: TObject);
  protected
    class function GetGUID: string; override;
  private
    F_ShiftDate: TDate;
  protected
    procedure InitVocDsetList; override;
    procedure OpenMainDataset; override;
    procedure EnableCtrls(value: boolean); override;
    function IsDateCorrect: boolean; override;
    function IsDataFieldsCorrect: boolean; override;
  public
  end;

var
  frm_EquipmentUsed: Tfrm_EquipmentUsed;

implementation

{$R *.dfm}

uses HelpFunctions, AppGUIDS, shiftnumform, GlobalData;

{ Tfrm_EquipmentUsed }

procedure Tfrm_EquipmentUsed.EnableCtrls(value: boolean);
begin
  tp_Time.Visible:=false;//value;
  dbl_Regions.Visible:=value;
  dbl_Equipments.Visible:=value;
  btn_Post.Visible:=value;
  btn_Cancel.Visible:=value;
  lbl_Time.Visible:=false;//value;
  lbl_Region.Visible:=value;
  lbl_Equipment.Visible:=value;
  lbl_Info.Visible:=not value;
end;

function Tfrm_EquipmentUsed.IsDataFieldsCorrect: boolean;
begin
  Result:=false;

  if IsDBLEmpty(dbl_Regions) then
  begin
    ActiveControl:=dbl_Regions;
    exit;
  end;

  if IsDBLEmpty(dbl_Equipments) then
  begin
    ActiveControl:=dbl_Equipments;
    exit;
  end;

  Result:=true;
end;

function Tfrm_EquipmentUsed.IsDateCorrect: boolean;
var
  InsertDate: string;
begin
  Result:=false;

  InsertDate:=DateTimeToStr(trunc(dp_Time.Date)+StrToTime(tp_Time.Text));

  if IsDateLess(DateTimeToStr(Now), InsertDate) then
  begin
    MessageDlg('Дата не может быть больше текущей', mtError, [mbOk], 0);
    exit;
  end;



  Result:=true;
end;

procedure Tfrm_EquipmentUsed.OpenMainDataset;
begin
  dset_Main.ParamByName('pDate1').AsDateTime := StrToDateTime( DateToStr(F_ShiftDate) + ' ' + g_ShiftStartTime );
  dset_Main.ParamByName('pDate2').AsDateTime := StrToDateTime( DateToStr(F_ShiftDate+1) + ' ' + g_ShiftStartTime );
  dset_Main.Open;
end;

procedure Tfrm_EquipmentUsed.btn_InsertClick(Sender: TObject);
begin
  inherited btn_InsertClick(Sender);
  dset_Main.FieldByName('USEDDATE').AsDateTime:= Now; {trunc(F_ShiftDate) + Frac(Time)} ;
  dset_Main.FieldByName('FK_EQUIPUSED_REGIONS').AsInteger:=-1;
  dset_Main.FieldByName('FK_EQUIPUSED_EQUIPMENT').AsInteger:=-1;
end;

class function Tfrm_EquipmentUsed.GetGUID: string;
begin
  Result:=EQUIPMENTUSEDFORMGUID;
end;

procedure Tfrm_EquipmentUsed.InitVocDsetList;
begin
  inherited;
  F_VocDsetList.Add(dset_Regions);
  F_VocDsetList.Add(dset_Equipments);
end;

procedure Tfrm_EquipmentUsed.FormCreate(Sender: TObject);
var
  _ShiftNum: integer;
begin
  inherited;
  GetShiftsNumAndDate(_ShiftNum, F_ShiftDate);
end;

end.
