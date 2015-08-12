unit AdresDepNS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Buttons, RxLookup, NGDepDModule, Mask, DBCtrls,
  ComCtrls;

type
  Tfrm_AdresDep = class(TForm)
    lbl_Street2: TLabel;
    lbl_Housenum: TLabel;
    Label20: TLabel;
    Label2: TLabel;
    dbl_Street2: TRxDBLookupCombo;
    dbl_Street: TRxDBLookupCombo;
    btn_Cancel: TBitBtn;
    btn_Ok: TBitBtn;
    ds_main: TDataSource;
    ds_street: TDataSource;
    ds_street_2: TDataSource;
    dbl_DamageLocality: TRxDBLookupCombo;
    Label12: TLabel;
    ds_locality: TDataSource;
    dbe_dopadress: TDBEdit;
    dbe_houseNum: TDBEdit;
    StatusBar: TStatusBar;
    cb_housetype: TComboBox;
    procedure dbl_HouseTypesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
    procedure cb_housetypeChange(Sender: TObject);
  private
    { Private declarations }
    F_readoly:boolean;
    procedure ChangeHouseTyp();
    procedure SetReadOnly(RO:boolean);
    function isFieldsCorrect():boolean;
    procedure SetStatus(mes:string);
  public
    { Public declarations }
    property IsREadOnly :boolean read F_readoly write SetReadOnly;
  end;

var
  frm_AdresDep: Tfrm_AdresDep;

implementation

{$R *.dfm}

procedure  Tfrm_AdresDep.SetReadOnly(RO:boolean);
var i:integer;
begin
  btn_ok.Enabled:=not Ro;
 for i:=0 to  Self.ComponentCount-1 do  begin
  if Self.Components[i].ClassNameIs('TRxDBLookupCombo') then
     (Self.Components[i] as TRxDBLookupCombo).ReadOnly:=RO;
  if Self.Components[i].ClassNameIs('TDBEdit') then
     (Self.Components[i] as TDBEdit ).ReadOnly:=RO;
   if Self.Components[i].ClassNameIs('TComboBox') then
     (Self.Components[i] as TComboBox ).Enabled:= not RO;
  end;
 F_readoly:=RO;
end;

procedure Tfrm_AdresDep.dbl_HouseTypesChange(Sender: TObject);
begin

 ChangeHouseTyp

end;

procedure Tfrm_AdresDep.ChangeHouseTyp();
begin
 if  cb_housetype.itemIndex=0 then
begin
  lbl_Housenum.Visible:=true;
  dbe_houseNum.Visible:=true;
  lbl_Street2.Visible:=false;
  dbl_Street2.Visible:=false;
  dbl_Street2.DataField:='FK_DEPARURE_ID_STREET';
end;

if  cb_housetype.itemIndex=1 then
begin
  lbl_Housenum.Visible:=false;
  dbe_houseNum.Visible:=false;
  lbl_Street2.Visible:=true;
  dbl_Street2.Visible:=true;
  dbl_Street2.DataField:='housenum';
end;

if  cb_housetype.itemIndex=2 then
begin
  lbl_Housenum.Visible:=false;
  dbe_houseNum.Visible:=false;
  lbl_Street2.Visible:=False;
  dbl_Street2.Visible:=false;
    dbl_Street2.DataField:='FK_DEPARURE_ID_STREET';
end;

end;

procedure Tfrm_AdresDep.FormShow(Sender: TObject);
var index:integer;
begin
 if  ds_main.DataSet.FieldByName('FK_DEPARURE_HOUSETYPES').IsNull then
   index:=0
  else
    index:=ds_main.DataSet.FieldByName('FK_DEPARURE_HOUSETYPES').AsInteger;
 cb_housetype.itemIndex:=index;
 ChangeHouseTyp();
end;

function Tfrm_AdresDep.isFieldsCorrect():boolean;
begin
  if ds_main.DataSet.FieldByName('FK_DEPARURE_ID_STREET').IsNull then
    begin
      dbl_Street.SetFocus;
      SetStatus('¬ведите улмцу!');
   //   ¬ведите местность
      Result:=false;
      Exit;
    end;
  if ds_main.DataSet.FieldByName('FK_departures_DAMAGELOCALITY').IsNull then
    begin
      dbl_DamageLocality.SetFocus;
      SetStatus('¬ведите местность');
      Result:=false;
      Exit;
    end;
  Result:=true;

end;

procedure Tfrm_AdresDep.SetStatus(mes:string);
begin
  StatusBar.SimpleText:=mes;
end;

procedure Tfrm_AdresDep.btn_OkClick(Sender: TObject);
begin
if isFieldsCorrect() then
begin
 ds_main.DataSet.FieldByName('FK_DEPARURE_HOUSETYPES').AsInteger:=cb_housetype.itemIndex;
 ModalResult:=mrOk;
end;
end;

procedure Tfrm_AdresDep.cb_housetypeChange(Sender: TObject);
begin
   ds_main.DataSet.FieldByName('housenum').AsString:='';
   ChangeHouseTyp();
end;

end.
