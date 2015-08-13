unit OptRSvodVed_ns;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OptRSvodVed, Buttons, StdCtrls, ExtCtrls, SelRegionFrame,
  SelDateTimePeriodFrame,SelectItemForm;

type
  Tfrm_OptRSvod_ns = class(Tfrm_OptRSvod)
    btn_DamagePlace: TButton;
    procedure btn_DamagePlaceClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_OptRSvod_ns: Tfrm_OptRSvod_ns;

implementation

{$R *.dfm}

procedure Tfrm_OptRSvod_ns.btn_DamagePlaceClick(Sender: TObject);
var sql:string;
begin
  inherited;
   SQL:=' select id ItemID, name ItemName, activity from S_damagePlace  '+
  'where id>0 and  activity is  null and name is not null order by name  ';
  ShowSelectItemsDlg(SQL, 'Места повреждения', F_DamagePlace_ID, F_DamagePlace_Name);


end;

end.
