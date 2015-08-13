unit BoltsNGForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AddressFrame, ExtCtrls, DB, BoltsDModule, RxLookup, DBCtrls,
  ToolEdit, RXDBCtrl, StdCtrls, Mask, DBCtrlsEh, BoltsVocCacheDModule,
  Grids, DBGridEh, Buttons, ComCtrls, GridEditForm;

type
  Tfrm_BoltsNG = class(Tfrm_GridEdit)
    pnl_Fields: TPanel;
    frame_Address: Tframe_Address;
    pnl_Grid: TPanel;
    dbl_BrigOpen: TRxDBLookupCombo;
    dbl_BrigClose: TRxDBLookupCombo;
    Label2: TLabel;
    Label4: TLabel;
    tp_Open: TDBDateTimeEditEh;
    tp_Close: TDBDateTimeEditEh;
    dp_Close: TDBDateEdit;
    dp_Open: TDBDateEdit;
    Label3: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    dbl_Diameter: TRxDBLookupCombo;
    ed_ClosePlace: TDBEdit;
    Label6: TLabel;
    ds_Diam: TDataSource;
    ds_BrigClose: TDataSource;
    ds_BrigOpen: TDataSource;
    DBGrid: TDBGridEh;
    StatusBar: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure btn_InsertClick(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure tp_CloseChange(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    procedure EnableFields( _value: boolean );
    procedure EnableEditBtns( _value: boolean );
    procedure EnablePostBtns( _value: boolean );
  protected
    procedure BuildEnables; override;
    function IsFieldsCorrect: boolean; override;
    procedure ShowMsg( _msg: string ); override;
  private
    F_FirstDepDTTM: TDateTime;
  public
    property FirstDepDTTM: TDateTime read F_FirstDepDTTM write F_FirstDepDTTM;
  end;

implementation

{$R *.dfm}

uses  HelpFunctions, StringConsts;

procedure Tfrm_BoltsNG.FormCreate(Sender: TObject);
begin
  with frame_Address do
  begin
    DataSource := ds_Main;
    HouseTypeDataField := 'FK_CLOSEDBOLTS_HOUSETYPE';
    Street1DataField := 'FK_CLOSEDBOLTS_STREETS';
    HouseNumDataField := 'HOUSENUM';
    AddAddressDataField := 'ADDITIONALADDRESS';

    frame_Address.ShowMsgProc := ShowMsg;
  end;
end;

procedure Tfrm_BoltsNG.btn_InsertClick(Sender: TObject);
begin
  inherited;
  frame_Address.dbl_Street1.SetFocus;
end;

procedure Tfrm_BoltsNG.btn_EditClick(Sender: TObject);
begin
  inherited;
  dp_Open.SetFocus;
end;

function Tfrm_BoltsNG.IsFieldsCorrect: boolean;
var
  CloseDate: string;
  OpenDate: string;
begin
  Result := false;

  {Проверяем даты}
  //CloseDate:=DateTimeToStr(trunc(dp_Close.Date)+StrToTime(tp_Close.Text));
  CloseDate:=dp_Close.Field.AsString;

  if (F_FirstDepDTTM<>-1) and (trunc(F_FirstDepDTTM)<>0) and
    (ds_Main.DataSet.FieldByName('CloseDate').AsDateTime<F_FirstDepDTTM) then
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

  if ds_Main.State=dsEdit then
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
  {/Проверяем даты}

  if not frame_Address.IsFieldsCorrect then exit;

  //if IsDBLEmpty(dbl_BrigClose) then
  if trim(dbl_BrigClose.Text) = '' then
  begin
    ActiveControl:=dbl_BrigClose;
    ShowMsg( 'Введите бригадира, ответственного за перекрытие' );
    exit;
  end;

  //if (ds_Main.DataSet.State=dsEdit) and (IsDBLEmpty(dbl_BrigOpen)) then
  if ( ds_Main.DataSet.State=dsEdit ) and ( trim( dbl_BrigOpen.Text ) = '' ) then
  begin
    ActiveControl:=dbl_BrigOpen;
    ShowMsg( 'Введите бригадира, ответственного за открытие' );
    exit;
  end;

  //if IsDBLEmpty(dbl_Diameter) then
  if trim( dbl_Diameter.Text ) = '' then
  begin
    ActiveControl:=dbl_Diameter;
    ShowMsg( 'Введите диаметр' );
    exit;
  end;

  Result := true;
end;

procedure Tfrm_BoltsNG.ShowMsg(_msg: string);
begin
  if trim( F_ConstMessage ) <> '' then _msg := F_ConstMessage;
  StatusBar.SimpleText := _msg
end;

procedure Tfrm_BoltsNG.BuildEnables;
var
  _IsBr: boolean;
begin

  {В зависимости от состояния набора данных енеблим контролы}
  if F_IsReadOnly then
  begin
    EnableFields( false );
    EnableEditBtns( false );
    EnablePostBtns( false );
    DBGrid.Enabled := true;
  end else
  begin
    _IsBr := ds_Main.DataSet.State = dsBrowse;
    EnableFields(not _IsBr);
    DBGRid.Enabled := _IsBr;
    btn_Insert.Enabled := _IsBr;
    btn_Edit.Enabled := _IsBr and ( ds_Main.DataSet.FieldByName('CALC_IsCanEditRec').AsBoolean );
    btn_Delete.Enabled := _IsBr and ( ds_Main.DataSet.FieldByName('CALC_IsCanDelRec').AsBoolean );
    btn_Post.Enabled := false;
    btn_Cancel.Enabled := not _IsBr;
  end;
end;

procedure Tfrm_BoltsNG.EnableEditBtns(_value: boolean);
begin
  btn_Insert.Enabled := _value;
  btn_Edit.Enabled := _value;
  btn_Delete.Enabled := _value;
end;

procedure Tfrm_BoltsNG.EnableFields(_value: boolean);
begin
  frame_Address.EnableFields(_value);

  dp_Close.Enabled := _value;
  tp_Close.Enabled := _value;
  dbl_BrigClose.Enabled := _value;
  dbl_Diameter.Enabled := _value;
  ed_ClosePlace.Enabled := _value;
  dp_Open.Enabled := _value;
  tp_Open.Enabled := _value;
  dbl_BrigOpen.Enabled := _value;
end;

procedure Tfrm_BoltsNG.EnablePostBtns(_value: boolean);
begin
  btn_Post.Enabled := _value;
  btn_Cancel.Enabled := _value;
end;

procedure Tfrm_BoltsNG.tp_CloseChange(Sender: TObject);
begin
  btn_Post.Enabled := ( ds_Main.DataSet.State <> dsBrowse );
end;

procedure Tfrm_BoltsNG.DBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
   if (ds_Main.DataSet.FieldByName('fk_closedbolts_brigadieropen').AsInteger<>-1) and
      (not ds_Main.DataSet.FieldByName('fk_closedbolts_brigadieropen').IsNull) then
   with DBGrid do
   begin
      Canvas.Brush.Color := clGrayText;
      DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;

end.
