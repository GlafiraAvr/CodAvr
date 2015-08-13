unit GreenSpringGetDate;

interface

uses
  SysUtils, Classes,DModule, DB, IBCustomDataSet,Variants;

type
  Tdm_GreenSpringGetDate = class(TDataModule)
    dset_date: TIBDataSet;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetDate(year:integer):TDateTime;
  end;

var
  dm_GreenSpringGetDate: Tdm_GreenSpringGetDate;

implementation

{$R *.dfm}
function Tdm_GreenSpringGetDate.GetDate(year:integer):TDateTime;
var V:variant;
begin
if  not dset_date.Active then
 dset_date.Open;
 V:=dset_date.Lookup('Curyear',VarArrayOf([year]),'curdate');
 if not (VarType(V) in [varNull]) then
  result:=V
 else
   result:=StrToDate('01.03.'+IntToStr(year));
end;

procedure Tdm_GreenSpringGetDate.DataModuleDestroy(Sender: TObject);
begin
if dset_date.Active then
   dset_date.Close;
end;

end.
