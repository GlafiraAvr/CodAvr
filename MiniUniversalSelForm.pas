unit MiniUniversalSelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UniversalSearchForm, DB, IBCustomDataSet, IBDatabase, StdCtrls,
  RxLookup, Buttons, Mask, ToolEdit, Spin;

type
  Tfrm_MiniUniversalSel = class(Tfrm_UniversalSearch)
    dp_Date1: TDateEdit;
    dp_Date2: TDateEdit;
    chb_WithTemper: TCheckBox;
    procedure btn_okClick(Sender: TObject);
  protected
    procedure OpenDataSets; override;
  public
    constructor Create(AOwner: TComponent; Title: string='');
  end;

var
  frm_MiniUniversalSel: Tfrm_MiniUniversalSel;

implementation

{$R *.dfm}

uses StringConsts;

{ Tfrm_MiniUniversalSel }

constructor Tfrm_MiniUniversalSel.Create(AOwner: TComponent; Title: string='');
begin
  inherited Create(AOwner);
  Caption:=Title;
  tp_Closed2.Visible:=false;
  tp_Closed1.Visible:=false;
  tp_Coming1.Visible:=false;
  tp_Coming2.Visible:=false;
end;

procedure Tfrm_MiniUniversalSel.OpenDataSets;
begin
//
end;

procedure Tfrm_MiniUniversalSel.btn_okClick(Sender: TObject);
begin
  if dp_Date1.Date=0 then
    Application.MessageBox('Необходимо ввести дату начала поиска', gc_strDispAVR, MB_OK+MB_ICONWARNING)
  else
    begin
      if dp_Date2.Date=0 then
        dp_Date2.Date:=Date;
      inherited btn_okClick(Sender);
    end;
end;

end.
