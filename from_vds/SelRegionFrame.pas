unit SelRegionFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Buttons, IBDatabase, DB, IBCustomDataSet, DModule;

type
  Tframe_SelRegion = class(TFrame)
    btn_Region: TBitBtn;
    dset: TIBDataSet;
    tran: TIBTransaction;
    procedure btn_RegionClick(Sender: TObject);
  private
    F_RegionsID: string;
    F_RegionsName: string;
    procedure SetAllRegionsByDistrict(var ARegionsID: string; var ARegionsName: string);
  public
    procedure SetRegions(var ARegionsID: string; var ARegionsName: string);
  end;

implementation

{$R *.dfm}

uses SelectItemForm, HelpFunctions, RightsManagerDModule;


procedure Tframe_SelRegion.btn_RegionClick(Sender: TObject);
var
  SQL: string;
begin
{  SQL:=
      ' select dd.id_region ItemID, sr.name ItemName'+
      ' from db_districtregion dd'+
      '  join s_regions sr on ( dd.id_region = sr.id )'+
      ' where id_district= '+ inttostr(DM_RightsManager.CurrentDistrictID) ;
      }
  SQL:=' select id ItemID, name ItemName, activity from s_regions where id>0 '; // будут видеть все наряды, но работать только со своими
  ShowSelectItemsDlg(SQL, 'Район', F_RegionsID, F_RegionsName);
  if trim(F_RegionsID)='' then
    SetAllRegionsByDistrict(F_RegionsID, F_RegionsName);
end;

procedure Tframe_SelRegion.SetAllRegionsByDistrict(var ARegionsID,
  ARegionsName: string);
var
  SQL: string;
begin
  ARegionsID:=''; ARegionsName:='';

{  SQL:=
      ' select dd.id_region id , sr.name, sr.activity'+
      ' from db_districtregion dd'+
      '  join s_regions sr on ( dd.id_region = sr.id )'+
      ' where id_district = '+ inttostr(DM_RightsManager.CurrentDistrictID) ;
 }
  SQL:=' select id, name, activity from s_regions '; // будут видеть все наряды, но работать только со своими
  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
    MyOpenIBDS(dset, SQL );

    dset.First;
    while not dset.Eof do
    begin
      ARegionsID:=ARegionsID+', '+dset.FieldByName('id').AsString;
      ARegionsName:=ARegionsName+', '+dset.FieldByName('name').AsString;
      dset.Next;
    end;

    Delete(ARegionsID, 1, 2);
    Delete(ARegionsName, 1, 2);

    ARegionsID:=trim(ARegionsID);
    ARegionsName:=trim(ARegionsID);

    if ARegionsID<>'' then ARegionsID:='('+ARegionsID+')';
    if ARegionsName<>'' then ARegionsName:='('+AregionsName+')';

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(Tframe_SelRegion.SetAllRegionsByDistrict)');
    end;
  end;
end;

procedure Tframe_SelRegion.SetRegions(var ARegionsID,
  ARegionsName: string);
begin
  if trim(F_RegionsID)<>'' then
  begin
    ARegionsID:=F_RegionsID;
    ARegionsName:=F_RegionsName;
  end else SetAllRegionsByDistrict(ARegionsID, ARegionsName);
end;

end.
