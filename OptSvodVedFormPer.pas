unit OptSvodVedFormPer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OptSvodVedForm, SelRegionFrame, StdCtrls, Mask, ToolEdit,
  Buttons, ExtCtrls;

type
  Tfrm_OptSvodVedPer = class(Tfrm_OptSvodVed)
    de_End: TDateEdit;
    Label2: TLabel;
    cb_o62: TCheckBox;
    cb_Peoples: TCheckBox;
    cb_ODS: TCheckBox;
    procedure btn_okClick(Sender: TObject); override;
  private
    { Private declarations }
    F_DtEnd: TDate;
    F_Dt: TDate;
    F_strRegions: string;
    F_RegionsID: string;
  public
    { Public declarations }
    property DtEnd: TDate read F_DtEnd;
    property Dt: TDate read F_Dt;
    property strRegions: string read F_strRegions;
    property RegionsID: string read F_RegionsID;    
  end;

var
  frm_OptSvodVedPer: Tfrm_OptSvodVedPer;

implementation

{$R *.dfm}
uses SelectItemForm, HelpFunctions;

procedure Tfrm_OptSvodVedPer.btn_okClick(Sender: TObject);
begin
  inherited;
  //if (not IsDateCorrect(de_Date.Text)) or ((not IsDateCorrect(de_End.Text)) and (de_End.Date>1)) then
  if (not IsDateCorrect(de_Date.Text)) then
  begin
    Application.MessageBox('Дата введена неправильно', 'Внимание', MB_OK+MB_ICONWARNING);
    exit;
  end;

  if (de_Date.Date>Date) or (de_End.Date>Date) then
  begin
    Application.MessageBox('Дата не может быть больше текущей', 'Внимание', MB_OK+MB_ICONWARNING);
    exit;
  end;

  frame_SelRegion.SetRegions(F_RegionsID, F_strRegions);

  F_Dt:=de_Date.Date;
  if de_End.Date< F_Dt then F_DtEnd := Date
   else
   F_DtEnd:= de_End.Date;
//  F_IsShowPreview:=chb_IsShowPreview.Checked;

  ModalResult:=mrOk;

end;

end.
