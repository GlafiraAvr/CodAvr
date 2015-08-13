unit ResSvodVedForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseResultForm, ExtCtrls, Grids, DBGrids, RXDBCtrl,
  RepSvodVedDModule, DB, StdCtrls, Buttons, DBGridEh, Menus, SecurityBaseForm;

type
  Tfrm_ResSvodVed = class(Tfrm_BaseResult)
    pnl_btns: TPanel;
    ds_CountByReg: TDataSource;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBGridEh: TDBGridEh;
    btn_SnapShot: TBitBtn;
    btn_LoadSnapshot: TBitBtn;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    BitBtn3: TBitBtn;
    CB_D: TCheckBox;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
  protected
    class function GetGUID: string; override;
  private
    procedure CalcVsego;
  public
    CalcVsegoZaSmenu: procedure of object;
    function CanEdit: boolean;
  end;


implementation

uses AppGUIDS;

{$R *.dfm}
//   if not IsCurrentUserCanEdit then
class function Tfrm_ResSvodVed.GetGUID: string;
begin
  Result:=ORDERFORMGUID; // права на изменение такие-же, как и у формы Orders
end;

procedure Tfrm_ResSvodVed.BitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure Tfrm_ResSvodVed.BitBtn1Click(Sender: TObject);
begin
  inherited;
  CalcVsego;
  ModalResult:=mrOk;
end;

procedure Tfrm_ResSvodVed.N1Click(Sender: TObject);
begin
  inherited;
  CalcVsego;  
end;

procedure Tfrm_ResSvodVed.CalcVsego;
begin
  if Assigned(CalcVsegoZaSmenu) then
    CalcVsegoZaSmenu;
end;

function Tfrm_ResSvodVed.CanEdit: boolean ;
begin
   //
   result:= IsCurrentUserCanEdit;
end;

end.
