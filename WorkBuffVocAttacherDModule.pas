unit WorkBuffVocAttacherDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocAttacher, DB, kbmMemTable, GlobalVocCacheDModule;

type
  Tdm_WorkBuffVocAttacher = class(Tdm_BaseVocAttacher)
    mt_s_work: TkbmMemTable;
    mt_s_diam: TkbmMemTable;
  private
  public
  end;

implementation

{$R *.dfm}

end.
