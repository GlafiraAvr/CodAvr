unit DepEquipsDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseDepChargeDModule, IBDatabase, DB, IBCustomDataSet;

type
  Tdm_DepEquips = class(Tdm_BaseDepCharge)
    dset_MainEQUIP: TIBStringField;
    dset_MainID: TIntegerField;
    dset_MainFK_DEPEQUIPS_ORDER: TIntegerField;
    dset_MainFK_DEPEQUIPS_DEPARTURE: TIntegerField;
    dset_MainFK_DEPEQUIPS_EQUIP: TIntegerField;
    dset_MainFK_DEPEQUIPS_OFFICPOST_INS: TIntegerField;
    dset_Mainclc_IsCanDel: TBooleanField;
    dset_Mainclc_IsCanEdit: TBooleanField;
    procedure dset_MainAfterInsert(DataSet: TDataSet);
    procedure OnFieldChange(Sender: TField);
    procedure DataModuleCreate(Sender: TObject);
    procedure dset_MainCalcFields(DataSet: TDataSet);
  private
    F_DefaultOfficPostID: integer;
  public
  end;


implementation

{$R *.dfm}

uses GlobalData, DModule;

procedure Tdm_DepEquips.dset_MainAfterInsert(DataSet: TDataSet);
begin
  inherited;
  dset_Main.FieldByName( 'fk_depequips_order' ).AsInteger := F_OrderID;
  dset_Main.FieldByName( 'fk_depequips_departure' ).AsInteger := F_DepID;
  dset_Main.FieldByName( 'fk_depequips_officpost_ins' ).AsInteger := F_DefaultOfficPostID;
end;

procedure Tdm_DepEquips.OnFieldChange(Sender: TField);
begin
  if Assigned( F_OnMyFieldChange ) then
    F_OnMyFieldChange( Sender );
end;

procedure Tdm_DepEquips.DataModuleCreate(Sender: TObject);
begin
  inherited;
  F_DefaultOfficPostID := DM_Main.GetIDOfficialPost( GlobalData.g_IDOfficial );
end;

procedure Tdm_DepEquips.dset_MainCalcFields(DataSet: TDataSet);
var
  _IsCanEdit, _IsCanDel: boolean;
  _OfficPostInsID: integer;
begin
  _OfficPostInsID := dset_Main.FieldByName( 'fk_depequips_officpost_ins' ).AsInteger;
  _IsCanDel := ( F_DefaultOfficPostID = _OfficPostInsID );
  _IsCanEdit := ( F_DefaultOfficPostID = _OfficPostInsID );

  dset_Main.FieldByName( 'clc_IsCanEdit' ).AsBoolean := _IsCanEdit;
  dset_Main.FieldByName( 'clc_IsCanDel' ).AsBoolean := _IsCanDel;
end;

end.
