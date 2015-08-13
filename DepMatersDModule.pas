unit DepMatersDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseDepChargeDModule, IBDatabase, DB, IBCustomDataSet;

type
  Tdm_DepMaters = class(Tdm_BaseDepCharge)
    dset_MainMATER: TIBStringField;
    dset_MainDIAM: TIntegerField;
    dset_MainID: TIntegerField;
    dset_MainFK_DEPMATERS_DEPARTURE: TIntegerField;
    dset_MainFK_DEPMATERS_ORDER: TIntegerField;
    dset_MainFK_DEPMATERS_MATER: TIntegerField;
    dset_MainFK_DEPMATERS_DIAMETER: TIntegerField;
    dset_MainQUANTITY: TIBBCDField;
    procedure dset_MainAfterInsert(DataSet: TDataSet);
    procedure OnFieldChange(Sender: TField);
  private
  public
  end;


implementation

{$R *.dfm}

procedure Tdm_DepMaters.dset_MainAfterInsert(DataSet: TDataSet);
begin
  inherited;
  dset_Main.FieldByName( 'fk_depmaters_order' ).AsInteger := F_OrderID;
  dset_Main.FieldByName( 'fk_depmaters_departure' ).AsInteger := F_DepID;
end;

procedure Tdm_DepMaters.OnFieldChange(Sender: TField);
begin
  if Assigned( F_OnMyFieldChange ) then
    F_OnMyFieldChange( Sender );
end;

end.
