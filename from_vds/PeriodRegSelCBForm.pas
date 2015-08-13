unit PeriodRegSelCBForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  StdCtrls, Mask, ToolEdit, Buttons, ExtCtrls,
  OptRepDiscon, SelRegionFrame;

type
  Tfrm_PeriodRegSelCB = class(Tfrm_OptRepDiscon)
    CB: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_PeriodRegSelCB: Tfrm_PeriodRegSelCB;

implementation

{$R *.dfm}

end.
