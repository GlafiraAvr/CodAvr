unit SubOrderFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DBCtrlsEh, StdCtrls, Mask, ToolEdit, RXDBCtrl, DBCtrls, RxLookup,
  DB, SuborderVADModule, SubOrderDModule, Buttons;

type
  TOnShowMsg = procedure(_msg: string) of object;

  Tframe_SubOrder = class(TFrame)
    de_Begin: TDBDateEdit;
    te_Begin: TDBDateTimeEditEh;
    lbl_BeginDate: TLabel;
    lbl_BeginTime: TLabel;
    gb_Address: TGroupBox;
    dbl_Street: TRxDBLookupCombo;
    ed_HouseNum: TDBEdit;
    ed_ApartMent: TDBEdit;
    lbl_Street: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    dbl_SubOrderMsg: TRxDBLookupCombo;
    dbl_SubOrderAbon: TRxDBLookupCombo;
    lbl_SubOrderMsg: TLabel;
    lbl_SubOrderAbon: TLabel;
    ds_Street: TDataSource;
    ds_SubOrderMsg: TDataSource;
    ds_SubOrderAbon: TDataSource;
    ds_Main: TDataSource;
    ds_Brig: TDataSource;
    ds_Official: TDataSource;
    dbl_Region: TRxDBLookupCombo;
    lbl_Region: TLabel;
    ds_Region: TDataSource;
    ed_PhoneNum: TDBEdit;
    lbl_PhoneNum: TLabel;
    lbl_AddInfo: TLabel;
    mem_AddInfo: TDBMemo;
    dbl_Official: TRxDBLookupCombo;
    lbl_Official: TLabel;
    lbl_Brig: TLabel;
    dbl_Brig: TRxDBLookupCombo;
    de_End: TDBDateEdit;
    lbl_EndDate: TLabel;
    lbl_EndTime: TLabel;
    te_End: TDBDateTimeEditEh;
  private
    F_OnShowMsg: TOnShowMsg;
    procedure ShowMsg( _msg: string );
    procedure SetIsReadOnly(Value: boolean);
  public
    property OnShowMsg: TOnShowMsg read F_OnShowMsg write F_OnShowMsg;
    function IsFieldsCorrect: boolean;
    property IsReadOnly: boolean write SetIsReadOnly;
  end;

implementation

{$R *.dfm}

{ Tframe_SubOrder }

function Tframe_SubOrder.IsFieldsCorrect: boolean;
var
  _dset: TDataSet;
begin
  Result := false;

  _dset := ds_Main.DataSet;

  if _dset.FieldByName('DTTM_Begin').IsNull then
  begin
    ShowMsg( 'Введите дату и время поступления' );
    de_Begin.SetFocus;
    exit;
  end;

  if _dset.FieldByName('DTTM_Begin').AsDateTime > Now then
  begin
    ShowMsg( 'Дата и время поступления не могут быть больше текущих' );
    de_Begin.SetFocus;
    exit;
  end;

  if (_dset.FieldByName( 'id_street' ).AsInteger = -1 ) or
      ( trim( dbl_Street.Text ) = '' ) then
  begin
    ShowMsg( 'Введите наименование улицы' );
    dbl_Street.SetFocus;
    exit;
  end;

  if (_dset.FieldByName( 'id_region' ).AsInteger = -1 ) or
      ( trim( dbl_Region.Text ) = '' ) then
  begin
    ShowMsg( 'Введите наименование района' );
    dbl_Region.SetFocus;
    exit;
  end;


  if trim( _dset.FieldByName( 'house_num' ).AsString ) = '' then
  begin
    ShowMsg( 'Введите номер дома' );
    ed_HouseNum.SetFocus;
    exit;
  end;

  Result := true;
end;

procedure Tframe_SubOrder.SetIsReadOnly(Value: boolean);
begin
  Enabled := not Value;
end;

procedure Tframe_SubOrder.ShowMsg(_msg: string);
begin
  if Assigned( F_OnShowMsg ) then
    F_OnShowMsg( _msg );
end;

end.
