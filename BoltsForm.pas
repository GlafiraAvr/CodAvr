unit BoltsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseGridForm, DB, IBCustomDataSet, IBDatabase, StdCtrls,
  Buttons, Mask, DBCtrls, RxLookup, ExtCtrls, Grids, DBGrids, DBCtrlsEh,
  ToolEdit, RXDBCtrl, ComCtrls;

const
  BEZ_VIEZDA='БЕЗ ВЫЕЗДА';

type
  Tfrm_Bolts = class(Tfrm_BaseGrid)
    dbl_BrigClose: TRxDBLookupCombo;
    dp_Close: TDBDateEdit;
    tp_Close: TDBDateTimeEditEh;
    Label1: TLabel;
    Label2: TLabel;
    dbl_Diameter: TRxDBLookupCombo;
    Label5: TLabel;
    dset_BrigClose: TIBDataSet;
    dset_BrigOpen: TIBDataSet;
    dset_Diameter: TIBDataSet;
    ds_BrigClose: TDataSource;
    ds_BrigOpen: TDataSource;
    ds_diameter: TDataSource;
    dset_mainID: TIntegerField;
    dset_mainFK_CLOSEDBOLTS_ORDERS: TIntegerField;
    dset_mainCLOSEDATE: TDateTimeField;
    dset_mainFK_CLOSEDBOLTS_BRIGADIERSCLOSE: TIntegerField;
    dset_mainOPENDATE: TDateTimeField;
    dset_mainFK_CLOSEDBOLTS_BRIGADIEROPEN: TIntegerField;
    dset_mainFK_CLOSEDBOLTS_TUBEDIAM: TIntegerField;
    dset_mainFK_CLOSEDBOLTS_HOUSETYPE: TIntegerField;
    dset_mainFK_CLOSEDBOLTS_STREETS: TIntegerField;
    dset_mainHOUSENUM: TIBStringField;
    dset_mainADDITIONALADDRESS: TIBStringField;
    dset_mainADRES: TIBStringField;
    Label3: TLabel;
    dp_Open: TDBDateEdit;
    dbl_BrigOpen: TRxDBLookupCombo;
    Label4: TLabel;
    ed_ClosePlace: TDBEdit;
    dset_mainCLOSEPLACE: TIBStringField;
    Label6: TLabel;
    dset_mainBRIGCLOSE: TIBStringField;
    dset_mainBRIGOPEN: TIBStringField;
    dset_mainTUBEDIAM: TIntegerField;
    tp_Open: TDBDateTimeEditEh;
    procedure btn_EditClick(Sender: TObject);
    procedure btn_InsertClick(Sender: TObject);override;
    procedure dbg_MainDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure CtrlsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dset_mainBRIGCLOSEGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dset_mainBRIGOPENGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
  protected
    class function GetGUID: string; override;
  protected
    procedure EnableOpenCtrls(value: boolean);

    procedure InitVocDsetList; override;
    procedure EnableCtrls(value: boolean);override;
    function IsDateCorrect: boolean; override;
    function IsDataFieldsCorrect: boolean; override;
  private
    F_FirstDepDTTM: TDateTime;
    FCurrentBrigCloseFromOrder: integer;
  public
    property FirstDepDTTM: TDateTime read F_FirstDepDTTM write F_FirstDepDTTM;
    property CurrentBrigCloseFromOrder: integer read FCurrentBrigCloseFromOrder write FCurrentBrigCloseFromOrder;
  end;

implementation

{$R *.dfm}

uses HelpFunctions, AppGUIDS, StringConsts;

{ Tfrm_Bolts }

procedure Tfrm_Bolts.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);

  dp_Close.Enabled:=value;
  tp_Close.Enabled:=value;
  dbl_BrigClose.Enabled:=value;
  dbl_Diameter.Enabled:=value;
  ed_ClosePlace.Enabled:=value;
  dp_Open.Enabled:=value;

  tp_Open.Enabled:=value;
  dbl_BrigOpen.Enabled:=value;
end;

procedure Tfrm_Bolts.btn_InsertClick(Sender: TObject);
begin
  inherited btn_InsertClick(Sender);
  dset_Main.FieldByName('fk_closedbolts_orders').AsInteger:=F_OrderID;
  dset_Main.FieldByName('CLOSEDATE').AsDateTime := CrazyNow;
  dset_Main.FieldByName('fk_closedbolts_housetype').AsInteger:=0;
  dset_Main.FieldByName('fk_closedbolts_streets').AsInteger:=-1;
  dset_Main.FieldByName('fk_closedbolts_brigadiersclose').AsInteger := -1;
  dset_Main.FieldByName('fk_closedbolts_brigadieropen').AsInteger:=-1;
  dset_Main.FieldByName('fk_closedbolts_tubediam').AsInteger:=-1;

  EnableOpenCtrls(false);
  dbl_Street.SetFocus;
end;

procedure Tfrm_Bolts.EnableOpenCtrls(value: boolean);
begin
  dp_Open.Enabled:=value;
  tp_Open.Enabled:=value;
  dbl_BrigOpen.Enabled:=value;
end;

function Tfrm_Bolts.IsDateCorrect: boolean;
var
  CloseDate: string;
  OpenDate: string;
begin
  Result:=false;

  //CloseDate:=DateTimeToStr(trunc(dp_Close.Date)+StrToTime(tp_Close.Text));
  CloseDate:=dp_Close.Field.AsString;

  if (F_FirstDepDTTM<>-1) and (trunc(F_FirstDepDTTM)<>0) and (dset_Main.FieldByName('CloseDate').AsDateTime<F_FirstDepDTTM) then
  begin
    Caption:=DateTimeToStr(F_FirstDepDTTM);

    Application.MessageBox('Дата перекрытия задвижки не может быть меньше даты первичного выезда',
                            gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;                            
  end;

  if not HelpFunctions.IsDateCorrect(CloseDate) then
  begin
    Application.MessageBox('Проверте правильность ввода даты перекрытия задвижки',
                            gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;
  end;


  if IsDateLess(DateTimeToStr(Now), CloseDate) then
  begin
    Application.MessageBox('Дата перекрытия задвижки не может быть больше текущей',
                            gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;
  end;

  if dset_main.State=dsEdit then
  begin
    //OpenDate:=DateTimeToStr(trunc(dp_Open.Date)+StrToTime(tp_Open.Text));
    OpenDate:=dp_Open.Field.AsString;

    if not HelpFunctions.IsDateCorrect(OpenDate) then
    begin
      Application.MessageBox('Проверте правильность ввода даты открытия задвижки',
                              gc_strDispAVR, MB_OK+MB_ICONERROR);
      exit;
    end;

    if IsDateLess(DateTimeToStr(Now), OpenDate) then
    begin
      Application.MessageBox('Дата открытия задвижки не может быть больше текущей',
                              gc_strDispAVR, MB_OK+MB_ICONERROR);
      exit;
    end;
    if IsDateLess(OpenDate, CloseDate) then
    begin
      Application.MessageBox('Дата открытия задвижки не может быть больше даты перекрытия задвижки',
                              gc_strDispAVR, MB_OK+MB_ICONERROR);
      exit;
    end;
  end;

  Result:=true;
end;

function Tfrm_Bolts.IsDataFieldsCorrect: boolean;
begin
  Result:=false;

  if IsDBLEmpty(dbl_Street) then
  begin
    ActiveControl:=dbl_Street;
    ProcessStatus:='Введите наименование улицы';
    exit;
  end;

  if (dset_HouseType.FieldByName('ID').AsInteger=0) and
      (trim(ed_HouseNum.Text)='') then
  begin
    ActiveControl:=ed_HouseNum;
    ProcessStatus:='Введите номер дома';
    exit;
  end;

  if (dset_HouseType.FieldByName('ID').AsInteger=1) and
      (IsDBLEmpty(dbl_Street2)) then
  begin
    ActiveControl:=dbl_Street2;
    ProcessStatus:='Введите наименование 2-ой улицы';
    exit;
  end;

  if IsDBLEmpty(dbl_BrigClose) then
  begin
    ActiveControl:=dbl_BrigClose;
    ProcessStatus:='Введите бригадира, ответственного за перекрытие';
    exit;
  end;

  if (dset_Main.State=dsEdit) and (IsDBLEmpty(dbl_BrigOpen)) then
  begin
    ActiveControl:=dbl_BrigOpen;
    ProcessStatus:='Введите бригадира, ответственного за открытие';
    exit;
  end;

  if IsDBLEmpty(dbl_Diameter) then
  begin
    ActiveControl:=dbl_Diameter;
    ProcessStatus:='Введите диаметр';
    exit;
  end;

  Result:=true;
end;

procedure Tfrm_Bolts.btn_EditClick(Sender: TObject);
begin
  inherited btn_EditClick(Sender);

  if dset_Main.FieldByName('OpenDate').IsNull then
    dset_Main.FieldByName('OpenDate').AsDateTime:=CrazyNow;
  if (dset_Main.FieldByName('fk_closedbolts_brigadieropen').IsNull) or
      (dset_Main.FieldByName('fk_closedbolts_brigadieropen').AsInteger=-1) then
  begin
    dset_Main.FieldByName('fk_closedbolts_brigadieropen').AsInteger := CurrentBrigCloseFromOrder {-1};
    dset_BrigOpen.Locate( 'ID', CurrentBrigCloseFromOrder, [] );
   (* dset_Main.FieldByName('fk_closedbolts_brigadieropen').AsInteger:=
      dset_Main.FieldByName('fk_closedbolts_brigadiersclose').AsInteger; *)
  end;

  EnableOpenCtrls(true);

  dp_Open.SetFocus;
end;

procedure Tfrm_Bolts.dbg_MainDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
const
   OPENBOLTS_COLOR: TColor=clGrayText;
begin
   if (dset_Main.FieldByName('fk_closedbolts_brigadieropen').AsInteger<>-1) and
      (not dset_Main.FieldByName('fk_closedbolts_brigadieropen').IsNull) then
   with Sender as TDBGrid do
   begin
      Canvas.Brush.Color:=OPENBOLTS_COLOR;
      DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

procedure Tfrm_Bolts.CtrlsChange(Sender: TObject);
begin
  inherited CtrlsChange(Sender);
  ProcessStatus:='';
end;

procedure Tfrm_Bolts.FormCreate(Sender: TObject);
begin
  inherited;
  F_FirstDepDTTM:=-1;
  FCurrentBrigCloseFromOrder := -1;
end;

class function Tfrm_Bolts.GetGUID: string;
begin
  Result:=BOLTSFORMGUID;
end;

procedure Tfrm_Bolts.dset_mainBRIGCLOSEGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if dset_Main.FieldByName('fk_closedbolts_brigadiersclose').AsInteger=-1 then
    Text:=''
  else
    Text:=Sender.AsString;
end;

procedure Tfrm_Bolts.dset_mainBRIGOPENGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if dset_Main.FieldByName('fk_closedbolts_brigadieropen').AsInteger=-1 then
    Text:=''
  else
    Text:=Sender.AsString;
end;

procedure Tfrm_Bolts.InitVocDsetList;
begin
  inherited;
  F_VocDsetList.Add(dset_Diameter);
  F_VocDsetList.Add(dset_BrigClose);
  F_VocDsetList.Add(dset_BrigOpen);
end;

end.
