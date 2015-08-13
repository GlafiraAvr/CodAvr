unit DepPlanWorksDmodule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseDepChargeDModule, IBDatabase, DB, IBCustomDataSet;

type
  Tdm_DepPlanWorks = class(Tdm_BaseDepCharge)
  private
    { Private declarations }
  public
    { Public declarations }
     procedure OpenDset
  end;

var
  dm_DepPlanWorks: Tdm_DepPlanWorks;

implementation

{$R *.dfm}

end.
