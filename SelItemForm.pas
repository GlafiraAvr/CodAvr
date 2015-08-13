unit SelItemForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet,  StdCtrls, CheckLst, Buttons,
  RxLookup, IBDatabase;

type
  TWordCase=(wcDefault, wcUpper, wcLower, wcName);

  Tfrm_SelItem = class(TForm)
    chlb_Items: TCheckListBox;
    btn_Ok: TBitBtn;
    btn_exit: TBitBtn;
    RxDBLookupCombo1: TRxDBLookupCombo;
    ds_Items: TDataSource;
    procedure btn_exitClick(Sender: TObject);
    procedure RxDBLookupCombo1Change(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
  public
    function IsHasChecked: boolean;
    constructor Create(ACaption: string);
  end;

implementation

{$R *.dfm}

procedure Tfrm_SelItem.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_SelItem.RxDBLookupCombo1Change(Sender: TObject);
var
  i, _id, _ItemIndex: integer;
begin
  _id := ds_Items.DataSet.FieldByName( 'id' ).AsInteger;
  for i:=0 to chlb_Items.Count-1 do
    if integer( chlb_Items.Items.Objects[i] ) = _id then
    begin
      _ItemIndex := i;
      break;
    end;

  chlb_Items.ItemIndex := _ItemIndex;
end;

procedure Tfrm_SelItem.btn_OkClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

function Tfrm_SelItem.IsHasChecked: boolean;
var
  i: integer;
begin
  Result := false;
  for i:=0 to chlb_Items.Count-1 do
    if chlb_Items.Checked[i] then
    begin
      Result := true;
      break;
    end;
end;

constructor Tfrm_SelItem.Create(ACaption: string);
begin
  inherited Create(nil);
  if trim( ACaption ) <> '' then
    Caption := ACaption;
end;

end.
