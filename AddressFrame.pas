unit AddressFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, RxLookup, AddressDModule, Mask, DBCtrls;

type
  TProcMsg = procedure(msg: string) of object;

  Tframe_Address = class(TFrame)
    gb_Address: TGroupBox;
    lbl_Street1: TLabel;
    lbl_Street2: TLabel;
    lbl_HouseNum: TLabel;
    dbl_Street1: TRxDBLookupCombo;
    dbl_HouseType: TRxDBLookupCombo;
    dbl_Street2: TRxDBLookupCombo;
    ed_HouseNum: TDBEdit;
    ed_AddAddress: TDBEdit;
    ds_Street1: TDataSource;
    ds_HouseType: TDataSource;
    ds_Street2: TDataSource;
    lbl_AddAddress: TLabel;
    procedure dbl_HouseTypeChange(Sender: TObject);
    procedure dbl_Street2Change(Sender: TObject);
  private
    F_DM: Tdm_Address;
    F_DataSource: TDataSource;
    F_HouseTypeDataField: string;
    F_Street1DataField: string;
    F_HouseNumDataField: string;
    F_AddAddressDataField: string;
    F_OldAfterScroll: TDataSetNotifyEvent;
    F_ShowMsgProc: TProcMsg;
    procedure NewAfterScroll(DataSet: TDataSet);
    procedure HouseTypeChange;
    procedure ShowMsg(_msg: string);
  public
    property DataSource: TDataSource read F_DataSource write F_DataSource;
    property HouseTypeDataField: string read F_HouseTypeDataField
      write F_HouseTypeDataField;
    property Street1DataField: string read F_Street1DataField
      write F_Street1DataField;
    property HouseNumDataField: string read F_HouseNumDataField
      write F_HouseNumDataField;
    property AddAddressDataField: string read F_AddAddressDataField
      write F_AddAddressDataField;
    property ShowMsgProc: TProcMsg read F_ShowMsgProc write F_ShowMsgProc;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ReopenVocDsets;
    function IsFieldsCorrect: boolean;
    procedure EnableFields(_value: boolean);
  end;

implementation

{$R *.dfm}

uses HelpFunctions;

{ Tframe_Address }

constructor Tframe_Address.Create(AOwner: TComponent);
begin
  inherited Create( AOwner);
  F_DM := Tdm_Address.Create(nil);
  ds_HouseType.DataSet := F_DM.cds_HouseType;
  ds_Street1.DataSet := F_DM.cds_Street1;
  ds_Street2.DataSet := F_DM.cds_Street2;
end;

destructor Tframe_Address.Destroy;
begin
  F_DM.Free;
  inherited Destroy;
end;

procedure Tframe_Address.ReopenVocDsets;
begin
  dbl_HouseType.DataSource := F_DataSource;
  dbl_Street1.DataSource := F_DataSource;
  ed_HouseNum.DataSource := F_DataSource;
  ed_AddAddress.DataSource := F_DataSource;

  dbl_HouseType.DataField := F_HouseTypeDataField;
  dbl_Street1.DataField := F_Street1DataField;
  ed_HouseNum.DataField := F_HouseNumDataField;
  ed_AddAddress.DataField := F_AddAddressDataField;

  F_OldAfterScroll := F_DataSource.DataSet.AfterScroll;
  F_DataSource.DataSet.AfterScroll := NewAfterScroll; 

  F_DM.ReopenVocDsets;
end;

procedure Tframe_Address.HouseTypeChange;
begin
  case F_DataSource.DataSet.FieldByName( F_HouseTypeDataField ).AsInteger of
    0: //Улица, № дома
      begin
        lbl_HouseNum.Visible:=true;
        lbl_Street2.Visible:=false;
        ed_HouseNum.Visible:=true;
        dbl_Street2.Visible:=false;

        ed_HouseNum.DataSource:=F_DataSource;
      end;
    1: //Пересечение улиц
      begin
        lbl_HouseNum.Visible:=false;
        lbl_Street2.Visible:=true;
        ed_HouseNum.Visible:=false;
        dbl_Street2.Visible:=true;

        ed_HouseNum.DataSource:=nil;
        FixDBLValue(StrToInt(trim(F_DataSource.DataSet.FieldByName(F_HouseNumDataField).AsString)), dbl_Street2);
      end;
    2: //Местность
      begin
        lbl_HouseNum.Visible:=false;
        lbl_Street2.Visible:=false;
        ed_HouseNum.Visible:=false;
        dbl_Street2.Visible:=false;

        ed_HouseNum.DataSource:=nil;
      end;
    end; //end case
end;

procedure Tframe_Address.NewAfterScroll(DataSet: TDataSet);
begin
  if Assigned(F_OldAfterScroll) then
    F_OldAfterScroll(DataSet);

  HouseTypeChange;
end;

procedure Tframe_Address.dbl_HouseTypeChange(Sender: TObject);
begin
  case ds_HouseType.DataSet.FieldByName('ID').AsInteger of
    0: F_DataSource.DataSet.FieldByName(F_HouseNumDataField).AsString:='';
    1: F_DataSource.DataSet.FieldByName(F_HouseNumDataField).AsString:='-1';
  end;

  HouseTypeChange;
end;

procedure Tframe_Address.ShowMsg(_msg: string);
begin
  if Assigned( F_ShowMsgProc ) then
    F_ShowMsgProc( _msg );
end;

function Tframe_Address.IsFieldsCorrect: boolean;
begin
  Result := false;

  if IsDBLEmpty(dbl_Street1) then
  begin
    dbl_Street1.SetFocus;
    ShowMsg( 'Введите наименование улицы' );
    exit;
  end;

  if (F_DataSource.DataSet.FieldByName( F_HouseTypeDataField ).AsInteger=0) and
      (trim(ed_HouseNum.Text)='') then
  begin
    ed_HouseNum.SetFocus;
    ShowMsg( 'Введите номер дома' );
    exit;
  end;

  if (F_DataSource.DataSet.FieldByName( F_HouseTypeDataField ).AsInteger=1) and
      (IsDBLEmpty(dbl_Street2)) then
  begin
    dbl_Street2.SetFocus;
    ShowMsg( 'Введите наименование 2-ой улицы' );
    exit;
  end;

  Result := true;
end;

procedure Tframe_Address.dbl_Street2Change(Sender: TObject);
begin
  if ( F_DataSource.DataSet.FieldByName( F_HouseTypeDataField ).AsInteger = 1) and
          ( F_DataSource.State in [dsEdit, dsInsert]) then
    F_DataSource.DataSet.FieldByName( F_HouseNumDataField ).AsString:=ds_Street2.DataSet.FieldByName('ID').AsString;
end;

procedure Tframe_Address.EnableFields(_value: boolean);
begin
  dbl_Street1.Enabled := _value;
  dbl_HouseType.Enabled := _value;
  dbl_Street2.Enabled := _value;
  ed_HouseNum.Enabled := _value;
  ed_AddAddress.Enabled := _value;

  {
  lbl_Street1.Enabled := _value;
  lbl_Street2.Enabled := _value;
  lbl_HouseNum.Enabled := _value;
  lbl_AddAddress.Enabled := _value;
  }
end;

end.
