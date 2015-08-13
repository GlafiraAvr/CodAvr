unit SuborderVADModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocAttacher, DB, kbmMemTable, GlobalVocCacheDModule;

type
  Tdm_SuborderVA = class(Tdm_BaseVocAttacher)
    mt_Streets: TkbmMemTable;
    mt_Brig: TkbmMemTable;
    mt_Offic: TkbmMemTable;
    mt_Abon: TkbmMemTable;
    mt_Msg: TkbmMemTable;
    mt_Region: TkbmMemTable;
  private
  public
  end;


implementation

{$R *.dfm}

end.
