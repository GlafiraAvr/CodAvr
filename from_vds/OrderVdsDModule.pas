unit OrderVdsDModule;

interface

uses
  SysUtils, Classes,GlobalVocCacheDModule, DB, kbmMemTable;

type
  Tdm_order_vds = class(TDataModule)
    mt_brigadiers: TkbmMemTable;
    mt_Applicant_vds: TkbmMemTable;
    mt_officials_open: TkbmMemTable;
    mt_regions: TkbmMemTable;
    mt_street: TkbmMemTable;
    mt_Message: TkbmMemTable;
    mt_tubediametr: TkbmMemTable;
    mt_organisation: TkbmMemTable;
    mt_official_closed: TkbmMemTable;
    mt_damagetype: TkbmMemTable;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OpenVocs();
  end;

var
  dm_order_vds: Tdm_order_vds;

implementation

{$R *.dfm}

procedure Tdm_order_vds.OpenVocs();
var
 _List:TList;
 i:integer;
begin
 _List:=TList.Create;
 _list.Add(mt_brigadiers);
 _list.Add(mt_Applicant_vds);
 _list.Add(mt_officials_open);
 _list.Add(mt_regions);
 _list.Add(mt_street);
 _list.Add(mt_Message);
 _list.Add(mt_tubediametr);
 _list.Add(mt_organisation);
 _list.Add(mt_official_closed);
 _list.Add(mt_damagetype);


 dm_GlobalVocCache.CheckVocs(_List);
 mt_brigadiers.Filter:='activity is null';
 mt_brigadiers.Filtered:=true;
 mt_street.Filter:='activity is null';
  mt_street.Filtered:=true;
 for i:=0 to _List.Count-1 do
 begin
 {   if TDataSet( _List.Items[ i ] ).findField('activity')<>nil then
    begin
      TDataSet( _List.Items[ i ] ).Filter:='activity is null';
      TDataSet( _List.Items[ i ] ).Filtered:=true;
    end;}
    TDataSet( _List.Items[ i ] ).Open;
 end;
 mt_officials_open.First;
 mt_officials_open.Next;
 i:=mt_officials_open.fieldbyname('id').AsInteger;
  _list.Free;
end;

procedure Tdm_order_vds.DataModuleDestroy(Sender: TObject);
begin
mt_brigadiers.Filtered:=false;
 mt_brigadiers.Close;
 mt_Applicant_vds.Close;
 mt_official_closed.Close;
 mt_officials_open.Close;
 mt_regions.Close;
 mt_street.Close;
 mt_Message.Close;
 mt_tubediametr.Close;

 mt_organisation.Close;
 mt_damagetype.Close


end;

end.
