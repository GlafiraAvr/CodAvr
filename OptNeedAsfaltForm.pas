unit OptNeedAsfaltForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, ExtCtrls, SelDatePeriodFrame, Mask,
  ToolEdit, Buttons, RepNeedAsfaltDModule;

type
  Tfrm_OptNeedAsfalt = class(Tfrm_BaseOption)
    Label1: TLabel;
    de_NeedRestore: TDateEdit;
    frame_Dates: Tframe_SelDatePeriod;
    Bevel1: TBevel;
    Bevel2: TBevel;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    rg_ExcType: TRadioGroup;
    de_StartDate: TDateEdit;
    Label2: TLabel;
    Bevel3: TBevel;
    procedure btn_exitClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function GetStartDate: TDateTime;
    function GetNeedRestoreDate: TDateTime;
    function GetBegDate: TDateTime;
    function GetEndDate: TDateTime;
    function GetExcType: TExcType;
  public
    property StartDate: TDateTime read GetStartDate;
    property NeedRestoreDate: TDateTime read GetNeedRestoreDate;
    property BegDate: TDateTime read GetBegDate;
    property EndDate: TDateTime read GetEndDate;
    property ExcType: TExcType read GetExcType;
  end;

implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tfrm_OptNeedAsfalt.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_OptNeedAsfalt.btn_okClick(Sender: TObject);
begin
  if not IsDateCorrect( de_NeedRestore.Text ) then
    Application.MessageBox( 'Поле "Необходимо восстановить по состоянию на" не задано или задано неверно',
      'Внимание', MB_OK + MB_ICONWARNING )
  else
  if not IsDateCorrect( de_StartDate.Text ) then
    Application.MessageBox( 'Поле "Учитывать заявки дата поступления которых больше чем" не задано или задано неверно',
      'Внимание', MB_OK + MB_ICONWARNING )
  else
    if frame_Dates.IsDatesCorrect then
      ModalResult := mrOk;
end;

function Tfrm_OptNeedAsfalt.GetBegDate: TDateTime;
begin
  Result := frame_Dates.BeginDate;
end;

function Tfrm_OptNeedAsfalt.GetEndDate: TDateTime;
begin
  Result := frame_Dates.EndDate;
end;

function Tfrm_OptNeedAsfalt.GetNeedRestoreDate: TDateTime;
begin
  Result := de_NeedRestore.Date;
end;

procedure Tfrm_OptNeedAsfalt.FormCreate(Sender: TObject);
var
  _Year, _Month, _Day: word;
begin
  inherited;
  DecodeDate( Date, _Year, _Month, _Day );
  de_StartDate.Date := Date - 365;
  de_NeedRestore.Date := EncodeDate( _Year, 1, 1 );
  frame_Dates.BeginDate := EncodeDate( _Year, _Month, 1 );
  frame_Dates.EndDate := Date;
end;

function Tfrm_OptNeedAsfalt.GetExcType: TExcType;
begin
  if rg_ExcType.ItemIndex = 0 then Result := etAsfalt
  else Result := etZelen;
end;

function Tfrm_OptNeedAsfalt.GetStartDate: TDateTime;
begin
  Result := de_StartDate.Date;
end;

end.
