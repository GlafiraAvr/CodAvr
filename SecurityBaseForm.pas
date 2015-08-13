unit SecurityBaseForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  Tfrm_SecurityBase = class(TForm)
  protected
    class function IsCurrentUserCanEdit: boolean; virtual;
    class function IsCurrentDistrictCanAccessRegion(RegionID: integer): boolean; virtual;

     class function GetDistrictID: integer;//2012.02
  public
    class function GetGUID: string; virtual; abstract;
  end;


implementation

{$R *.dfm}

uses RightsManagerDModule;


{ Tfrm_SecurityBase }

class function Tfrm_SecurityBase.IsCurrentUserCanEdit: boolean;
begin
  Result:=DM_RightsManager.IsCurrentUserCanEditForm(GetGUID);
end;

class function Tfrm_SecurityBase.IsCurrentDistrictCanAccessRegion(RegionID: integer): boolean;
begin
  Result:=DM_RightsManager.IsCurrentDistrictHasAccesToRegion(RegionID);
end;


class function Tfrm_SecurityBase.GetDistrictID: integer; //2012.02
begin
  Result := DM_RightsManager.CurrentDistrictID;
end;
end.
