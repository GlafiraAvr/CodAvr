unit VA_PlanWorks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocAttacher, GlobalVocCacheDModule, DB, kbmMemTable;

type
  Tdm_DepPlanWMVA = class(Tdm_BaseVocAttacher)
    mt_works: TkbmMemTable;
    mt_maters: TkbmMemTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm_DepPlanWMVA: Tdm_DepPlanWMVA;

implementation

{$R *.dfm}

end.
