unit OptSvodVedForm_vds_2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, ExtCtrls, SelDateTimePeriodFrame, StdCtrls,
  Mask, ToolEdit, Buttons;

type
  Tfrm_svod_ved_vds_2 = class(Tfrm_BaseOption)
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    frame_SelDT: Tframe_SelDateTimePeriod;
    Panel2: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
  private
    { Private declarations }
     F_RegionsID: string;
     F_BegDate,F_EndDate:TDateTime;
     F_Dt: TDate;
     F_tip:integer;
     F_IsShowPreview: boolean;
     F_Regions:string;

  public
    { Public declarations }
    property BegDate:TDateTime read F_BegDate;
    property EndDate:TDateTime read F_EndDate;
    property Dt:TDate read F_Dt;
    property tip:integer read F_tip;
    property IsShowPreview: boolean read F_IsShowPreview;
    property Regions:string read F_Regions;


  end;

var
  frm_svod_ved_vds_2: Tfrm_svod_ved_vds_2;

implementation
uses HelpFunctions;

{$R *.dfm}

procedure Tfrm_svod_ved_vds_2.FormCreate(Sender: TObject);
begin
  inherited;


  frame_SelDT.BeginDateTime:=Now()-0.417;
  frame_SelDT.endDateTime:=Now();
end;

procedure Tfrm_svod_ved_vds_2.btn_okClick(Sender: TObject);
begin
  inherited;


    F_tip:=2;
    if  not frame_SelDT.IsDateTimeCorrect then exit;
    F_begDate:=frame_SelDT.BeginDateTime;
    F_EndDate:=frame_SelDT.EndDateTime;

  ModalResult:=mrOk;

end;



procedure Tfrm_svod_ved_vds_2.btn_exitClick(Sender: TObject);
begin
  inherited;
  ModalResult:=mrCancel;
end;

end.
