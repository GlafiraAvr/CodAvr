unit EquipsVADModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocAttacher, DB, kbmMemTable, GlobalVocCacheDModule;

type
  Tdm_EquipsVA = class(Tdm_BaseVocAttacher)
    mt_Equips: TkbmMemTable;
    mt_EquipsFULL_NAME: TStringField;
  private
  public
   procedure SetFilterTyp(id_typ:integer);
  end;


implementation

{$R *.dfm}
procedure Tdm_EquipsVA.SetFilterTyp(id_typ:integer);
begin
 mt_equips.Filter:='id_typ='+IntTostr(id_typ);
 mt_Equips.Filtered:=false;
 mt_Equips.Filtered:=true;

end;

end.
