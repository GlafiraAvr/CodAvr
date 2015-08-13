unit PeriodRegSelCBForm_vds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OptRepDiscon_vds, StdCtrls, SelRegionFrame, Buttons, Mask,
  ToolEdit, ExtCtrls;

type
  Tfrm_PeriodRegSelCB_vds = class(Tfrm_OptRepDiscon_vds)
    CB: TCheckBox;
    btn_Streets: TBitBtn;
    procedure btn_StreetsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
  private
    { Private declarations }
    F_StreetsID, F_StreetsName:string;
  public
    { Public declarations }
    property StreetsID :string read F_StreetsID;
    property StreetsName:string read F_StreetsName;
  end;

var
  frm_PeriodRegSelCB_vds: Tfrm_PeriodRegSelCB_vds;

implementation

{$R *.dfm}
uses SelectItemForm;

procedure Tfrm_PeriodRegSelCB_vds.btn_StreetsClick(Sender: TObject);
var SQL:string;
begin
  inherited;
    SQL:= ' select id ItemID, (select name from Get_FullStreetName(id)) as  ItemName'+
        ' from s_streets'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Улица', F_StreetsID, F_StreetsName, wcName);
end;

procedure Tfrm_PeriodRegSelCB_vds.FormShow(Sender: TObject);
begin
  inherited;
  F_StreetsName:='Все';
  F_StreetsID:='';
 
end;

procedure Tfrm_PeriodRegSelCB_vds.btn_exitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
