unit WorkVocAttcherDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocAttacher, DB, kbmMemTable, GlobalVocCacheDModule;

type
  Tdm_WorkVocAttacher = class(Tdm_BaseVocAttacher)
    mt_BWork: TkbmMemTable;
    mt_Works: TkbmMemTable;
    mt_Diam: TkbmMemTable;
    mt_Maters: TkbmMemTable;
  private
  public
  end;

implementation

{$R *.dfm}

end.
