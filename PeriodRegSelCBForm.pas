unit PeriodRegSelCBForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PeriodRegSelForm, StdCtrls, Mask, ToolEdit, Buttons, ExtCtrls;

type
  Tfrm_PeriodRegSelCB = class(Tfrm_PeriodRegSel)
    CB: TCheckBox;
    CB_ALL: TCheckBox;
    btn_street: TBitBtn;
    procedure CBClick(Sender: TObject);
    procedure CB_ALLClick(Sender: TObject);
    procedure btn_RegionsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_streetClick(Sender: TObject);
  private
    { Private declarations }
    F_StreetsID:string;
    F_StreetsName:string;
  public
    { Public declarations }
    property StreetsID:string read F_StreetsID;
    property StreeetsName:string read F_StreetsName;
  end;

var
  frm_PeriodRegSelCB: Tfrm_PeriodRegSelCB;

implementation

{$R *.dfm}
uses SelectItemForm;

procedure Tfrm_PeriodRegSelCB.CBClick(Sender: TObject);
begin
  inherited;
if CB.Checked then
   Cb_all.Checked:=false;
   
end;

procedure Tfrm_PeriodRegSelCB.CB_ALLClick(Sender: TObject);
begin
  inherited;
if CB_all.Checked then
   Cb.Checked:=false;
end;

procedure Tfrm_PeriodRegSelCB.btn_RegionsClick(Sender: TObject);
var SQL:string;
begin
  inherited;

end;

procedure Tfrm_PeriodRegSelCB.FormShow(Sender: TObject);
begin
  inherited;
  F_StreetsName:='Все';
  F_StreetsID:='';
end;

procedure Tfrm_PeriodRegSelCB.btn_streetClick(Sender: TObject);
var SQL:string;
begin
  inherited;
     SQL:= ' select id ItemID, (select name from Get_FullStreetName(id)) as  ItemName'+
        ' from s_streets'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Улица', F_StreetsID, F_StreetsName, wcName);
end;

end.
