unit DBTextFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OutputFrame, StdCtrls, DBCtrls;

type
  Tframe_DBText = class(Tframe_Output)
    lbl_FieldCaption: TLabel;
    DBText: TDBText;
  private
  public
  end;


implementation

{$R *.dfm}

end.
