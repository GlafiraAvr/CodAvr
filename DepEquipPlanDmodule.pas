unit DepEquipPlanDmodule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseDepChargeDModule, IBDatabase, DB, IBCustomDataSet;

type
  Tdm_DepPlanEqChange = class(Tdm_BaseDepCharge)
    dset_eqip_type: TIBDataSet;
    dset_eqip_typeID: TIntegerField;
    dset_eqip_typeNAME: TIBStringField;
    dset_MainEQUIP: TIBStringField;
    dset_MainID: TIntegerField;
    dset_MainFK_ID_ORDER: TIntegerField;
    dset_MainFK_ID_DEPARTURES: TIntegerField;
    dset_MainFK_ID_EQUIPMENT: TIntegerField;
    dset_MainFK_ID_EQUIPTYP: TIntegerField;
    dset_MainTYPNAME: TIBStringField;

    procedure dset_MainAfterInsert(DataSet: TDataSet);
    procedure OnFieldChange(Sender: TField);
    procedure dset_MainFK_EQUIP_TYPChange(Sender: TField);
    procedure dset_MainAfterEdit(DataSet: TDataSet);
    procedure InitTable();

  private
    { Private declarations }
     F_OnMyTypChange:  TFieldNotifyEvent;
     F_Table:string;

  public
    { Public declarations }
      property Table:string write F_Table;
      procedure OpenDset; override  ;
      property OnMyTypChange: TFieldNotifyEvent read F_OnMyTypChange write F_OnMyTypChange;

  end;

const Sql_Select ='select '+
                  ' (select  full_name from GET_EQUIP_FULL_NAME(e.id)) equip, '+
                  ' de.id, de.fk_id_order, de.fk_id_departures, de.fk_id_equipment ,' +
                  ' de.fk_id_equiptyp, '+
                  ' (select se.name from s_equipment_typ se where se.id=de.fk_id_equiptyp) typname '+
                  ' from %s de , EQUIPMENT e '+
                  ' where de.fk_id_departures=:pDepID and  de.fk_id_equipment=e.id '+
                  ' order by 1';
      SQL_Update=' update  %s set '+
                 '  FK_ID_EQUIPMENT=:FK_ID_EQUIPMENT,'+
                 ' fk_id_equiptyp=:fk_id_equiptyp '+
                 ' where id=:id';
      SQL_Insert=' insert into %s (Fk_id_order,FK_ID_DEPARTURES,FK_ID_EQUIPMENT,fk_id_equiptyp)'+
                 '  values (:FK_ID_ORDER,:FK_ID_DEPARTURES,:FK_ID_EQUIPMENT,:fk_id_equiptyp)';

      SQL_del=' delete from %s where id=:old_id';


      Gen_Ns= 'GEN_EQUIP_PALN_DEPARTURE';
      Gen_Vds='GEN_EQUIP_PALN_DEPARTURE_VDS_ID';



var
   dm_DepPlanEqChange: Tdm_DepPlanEqChange;

implementation


{$R *.dfm}
procedure Tdm_DepPlanEqChange.OpenDset;
begin
 InitTable();
 inherited;

 dset_eqip_type.Open;
end;


procedure Tdm_DepPlanEqChange.dset_MainAfterInsert(DataSet: TDataSet);
begin
  inherited;
  //dset_Main.Edit;
  dset_Main.FieldByName( 'FK_ID_ORDER' ).AsInteger := F_OrderID;
  dset_Main.FieldByName( 'FK_ID_DEPARTURES' ).AsInteger := F_DepID;

end;

procedure  Tdm_DepPlanEqChange.OnFieldChange(Sender: TField);
begin
  if Assigned( F_OnMyFieldChange ) then
    F_OnMyFieldChange( Sender );
end;


procedure Tdm_DepPlanEqChange.dset_MainFK_EQUIP_TYPChange(Sender: TField);
begin
  inherited;
if Assigned( F_OnMyTypChange) then
   F_OnMyTypChange(Sender);
end;

procedure Tdm_DepPlanEqChange.dset_MainAfterEdit(DataSet: TDataSet);
begin
  inherited;
//  F_OnMyTypChange(DataSet.Fields[0]);
end;


procedure Tdm_DepPlanEqChange.InitTable();
begin
 dset_main.SelectSQL.Text:=Format(SQL_Select,[F_table]);
 dset_main.ModifySQL.Text:=Format(SQL_Update,[F_table]);
 dset_main.InsertSQL.Text:=Format(SQL_Insert,[F_table]);
 dset_main.DeleteSQL.Text:=Format(Sql_Del,[F_table]);
 if F_table =
     'EQUIP_PALN_DEPARTURE' then dset_main.GeneratorField.Generator:= Gen_ns;

 if F_Table='EQUIP_PALN_DEPARTURE_vds'  then dset_main.GeneratorField.Generator:= Gen_vds;

// dset_main.GeneratorField.Field:='id';
// dset_main.GeneratorField.IncrementBy:=1;


end;


end.
