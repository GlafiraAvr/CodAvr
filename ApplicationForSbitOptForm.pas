unit ApplicationForSbitOptForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, SelDateTimePeriodFrame, StdCtrls, Buttons;

type
  Tfrm_OptApplicationForSbit = class(Tfrm_BaseOption)
    frame_SelDateTimePeriod1: Tframe_SelDateTimePeriod;
    bitbtn_Ok: TBitBtn;
    BitBtn2: TBitBtn;
    procedure bitbtn_OkClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    function getStartDateTime:TDateTime;
    function getEndDateTime:TDateTime;
  public
    { Public declarations }
    property StartDate:TDateTime read getStartDateTime;
    property EndDate:TDateTime read getEndDateTime;
    procedure setInterval(begindate:TDateTime; endDateTDateTime:TDateTime);
    procedure setDefault(begindate:TDateTime; endDateTDateTime:TDateTime);
  end;



var
  frm_OptApplicationForSbit: Tfrm_OptApplicationForSbit;

implementation

{$R *.dfm}

function Tfrm_OptApplicationForSbit.getStartDateTime:TDateTime;
begin
  result:=frame_SelDateTimePeriod1.BeginDateTime;
end;

function Tfrm_OptApplicationForSbit.getEndDateTime:TDateTime;
begin
 result:=frame_SelDateTimePeriod1.EndDateTime;
end;


procedure Tfrm_OptApplicationForSbit.bitbtn_OkClick(Sender: TObject);
begin
  inherited;
  if  not frame_SelDateTimePeriod1.IsDateTimeCorrect then
   exit;
   ModalResult:=mrOk;
end;



procedure Tfrm_OptApplicationForSbit.BitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure Tfrm_OptApplicationForSbit.setInterval(begindate:TDateTime; endDateTDateTime:TDateTime);
begin
 frame_SelDateTimePeriod1.BeginDateTime:=begindate;
 frame_SelDateTimePeriod1.EndDateTime:=endDateTDateTime;
end;

procedure Tfrm_OptApplicationForSbit.setDefault(begindate:TDateTime; endDateTDateTime:TDateTime);
begin
 if frame_SelDateTimePeriod1.BeginDateTime=0 then
  frame_SelDateTimePeriod1.BeginDateTime:=begindate;
 if frame_SelDateTimePeriod1.EndDateTime=0 then
  frame_SelDateTimePeriod1.EndDateTime:=endDateTDateTime;


end;
end.
