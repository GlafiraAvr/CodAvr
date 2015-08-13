unit OptRSvodVed;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, ExtCtrls, SelRegionFrame,
  SelDateTimePeriodFrame, Buttons;

type
  
  Tfrm_OptRSvod = class(Tfrm_BaseOption)
    frame_SelDateTimePeriod1: Tframe_SelDateTimePeriod;
    frame_SelRegion1: Tframe_SelRegion;
    rg_typ: TRadioGroup;
    Butt_onControl: TButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure frame_SelRegion1btn_RegionClick(Sender: TObject);
    procedure Butt_onControlClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
  F_RegionsID:string;
  F_strRegions:string;
  BeginDateTime,EndDateTime:TDateTime;
  F_Typ:integer;
  F_organs_ID:string;
  F_organs_name:string;

  F_DamagePlace_ID:string;
  F_DamagePlace_Name:string;
    { Public declarations }
  end;

const count_days=121;

var
  frm_OptRSvod: Tfrm_OptRSvod;


implementation

uses SelectItemForm;
{$R *.dfm}

procedure Tfrm_OptRSvod.frame_SelRegion1btn_RegionClick(Sender: TObject);
begin
  inherited;
  frame_SelRegion1.btn_RegionClick(Sender);

end;

procedure Tfrm_OptRSvod.Butt_onControlClick(Sender: TObject);
var sQL:string;
begin
  inherited;
  SQL:=' select id ItemID, name ItemName, activity from S_ORGANISATIONS  '+
  'where id>0 and  activity is  null and name is not null order by name  ';
  ShowSelectItemsDlg(SQL, 'На контроле', F_Organs_id, F_organs_name);

end;

procedure Tfrm_OptRSvod.BitBtn2Click(Sender: TObject);
begin
  inherited;
  if   frame_SelDateTimePeriod1.IsDateTimeCorrect
  then
  begin
   if (rg_typ.ItemIndex=0)
   or(frame_SelDateTimePeriod1.de_End.Date- frame_SelDateTimePeriod1.de_Begin.Date<count_days) then
   begin
   frame_SelRegion1.SetRegions(F_RegionsID, F_strRegions);
   BeginDateTime:=frame_SelDateTimePeriod1.BeginDateTime;
   EndDateTime:=frame_SelDateTimePeriod1.EndDateTime;
   F_typ:=rg_typ.ItemIndex+1;

   ModalResult:=mrOk;
   end
   else
   begin
     Application.MessageBox( PChar('Интервал может быть не больше '+ IntToStr(count_days-1)+ 'дней.'),
      'Внимание', MB_OK + MB_ICONWARNING );

         ModalResult:=mrNone;
   end
 end
end;

procedure Tfrm_OptRSvod.FormShow(Sender: TObject);
begin
  inherited;
  frame_SelDateTimePeriod1.de_Begin.Date:=date()-1;
  frame_SelDateTimePeriod1.tp_Begin.Time:=0;
  frame_SelDateTimePeriod1.de_End.Date:=date();
  frame_SelDateTimePeriod1.tp_End.Time:=1;


end;

end.
