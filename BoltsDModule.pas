unit BoltsDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseEditDModule, IBDatabase, DB, IBCustomDataSet, GridEditDModule;

type
  Tdm_Bolts = class(Tdm_GridEdit)
    dset_MainID: TIntegerField;
    dset_MainFK_CLOSEDBOLTS_ORDERS: TIntegerField;
    dset_MainCLOSEDATE: TDateTimeField;
    dset_MainFK_CLOSEDBOLTS_BRIGADIERSCLOSE: TIntegerField;
    dset_MainOPENDATE: TDateTimeField;
    dset_MainFK_CLOSEDBOLTS_BRIGADIEROPEN: TIntegerField;
    dset_MainFK_CLOSEDBOLTS_TUBEDIAM: TIntegerField;
    dset_MainFK_CLOSEDBOLTS_HOUSETYPE: TIntegerField;
    dset_MainFK_CLOSEDBOLTS_STREETS: TIntegerField;
    dset_MainHOUSENUM: TIBStringField;
    dset_MainADDITIONALADDRESS: TIBStringField;
    dset_MainCLOSEPLACE: TIBStringField;
    dset_MainBRIGCLOSE: TIBStringField;
    dset_MainBRIGOPEN: TIBStringField;
    dset_MainTUBEDIAM: TIntegerField;
    dset_MainADRES: TIBStringField;
    dset_MainFK_CLOSEDBOLTS_OFFICIALPOST_INS: TIntegerField;
    dset_MainCALC_IsCanEditRec: TBooleanField;
    dset_MainCALC_IsCanDelRec: TBooleanField;
    procedure dset_MainAfterInsert(DataSet: TDataSet);
    procedure OnFieldChange(Sender: TField);
    procedure dset_MainAfterEdit(DataSet: TDataSet);
    procedure dset_MainBRIGCLOSEGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dset_MainBRIGOPENGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dset_MainCalcFields(DataSet: TDataSet);
  private
    F_CurrentBrigCloseFromOrder: integer;
    F_OfficialPostID: integer;
  public
    property CurrentBrigCloseFromOrder: integer read F_CurrentBrigCloseFromOrder
      write F_CurrentBrigCloseFromOrder;
    property OfficialPostID: integer read F_OfficialPostID write F_OfficialPostID;
  end;

implementation

{$R *.dfm}

{ Tdm_Bolts }

procedure Tdm_Bolts.dset_MainAfterInsert(DataSet: TDataSet);
begin
  inherited;
  with dset_Main do
  begin
    FieldByName('fk_closedbolts_orders').AsInteger := F_OrderID;
    FieldByName('fk_closedbolts_housetype').AsInteger := 0;
    FieldByName('fk_closedbolts_streets').AsInteger := -1;
    FieldByName('fk_closedbolts_brigadiersclose').AsInteger := -1;
    FieldByName('fk_closedbolts_brigadieropen').AsInteger := -1;
    FieldByName('fk_closedbolts_tubediam').AsInteger := -1;
    FieldByName('fk_closedbolts_officialpost_ins').AsInteger := F_OfficialPostID;
  end;
end;

procedure Tdm_Bolts.OnFieldChange(Sender: TField);
begin
  if Assigned( F_OnMyFieldChange ) then
    F_OnMyFieldChange( Sender );
end;

procedure Tdm_Bolts.dset_MainAfterEdit(DataSet: TDataSet);
begin
  inherited;
  with dset_Main do
  begin
    if FieldByName('OpenDate').IsNull then FieldByName('OpenDate').AsDateTime:=Now;
    if (FieldByName('fk_closedbolts_brigadieropen').IsNull) or
      (FieldByName('fk_closedbolts_brigadieropen').AsInteger=-1)
    then FieldByName('fk_closedbolts_brigadieropen').AsInteger := CurrentBrigCloseFromOrder {-1};
  end;
end;

procedure Tdm_Bolts.dset_MainBRIGCLOSEGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if dset_Main.FieldByName('fk_closedbolts_brigadiersclose').AsInteger = -1 then
    Text := ''
  else
    Text := Sender.AsString;
end;

procedure Tdm_Bolts.dset_MainBRIGOPENGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if dset_Main.FieldByName('fk_closedbolts_brigadieropen').AsInteger = -1 then
    Text := ''
  else
    Text := Sender.AsString;
end;

procedure Tdm_Bolts.dset_MainCalcFields(DataSet: TDataSet);
var
  _IsCanEdit, _IsCanDel: boolean;
begin
  if dset_Main.FieldByName( 'fk_closedbolts_officialpost_ins' ).AsInteger <> F_OfficialPostID then
  begin
    _IsCanEdit := false;
    _IsCanDel := false;
  end else
  begin
    _IsCanEdit := true;
    _IsCanDel := true;
  end;

  DataSet.FieldByName( 'CALC_IsCanEditRec' ).AsBoolean := _IsCanEdit;
  DataSet.FieldByName( 'CALC_IsCanDelRec' ).AsBoolean := _IsCanDel;
end;

end.
