unit AddWorkForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, Mask, DBCtrlsEh, ExtCtrls, RxLookup,
  DB, DepPlanWorMatDModule;

type
  Tfrm_AddWork = class(TForm)
    ds_main: TDataSource;
    ds_work: TDataSource;
    ds_diam: TDataSource;
    dbl_work: TRxDBLookupCombo;
    dbL_diam: TRxDBLookupCombo;
    pn_Exc: TPanel;
    pn_Other: TPanel;
    db_Quntity: TDBNumberEditEh;
    db_Lengt: TDBEdit;
    dbe_Width: TDBEdit;
    dbe_Depth: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    dbe_additionalInfo: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    dbe_asf: TDBEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbl_workChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbl_workContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure dbl_workCloseUp(Sender: TObject);
    procedure dbl_workDropDown(Sender: TObject);
    
      
  private
    { Private declarations }
   procedure AddPnlVisibleBuild;
  function IsFiledCorrect():boolean;
  public
    { Public declarations }
  end;

var
  frm_AddWork: Tfrm_AddWork;



implementation
uses HelpFunctions,GlobalData;

{$R *.dfm}

function   Tfrm_AddWork.IsFiledCorrect :boolean;
procedure Showmassage(Comp:TWinControl;mess:string);
begin
  Application.MessageBox(PAnsiChar(mess),'¬нимание', MB_OK + MB_ICONWARNING);
  Comp.SetFocus;
end;
begin
 Result:=false;
 if IsDBLEmpty(dbl_work) then
 begin
  Showmassage(dbl_work,'¬ведите работу');
  exit;
 end ;
 if  pn_Exc.Visible then
 begin
  if IsDBLEmpty(dbl_work)or(dbl_work.Value='0') then begin

      Showmassage(dbl_work,'¬ведите диаметр');
       exit;
   end;
   if db_Quntity.Text='' then
    begin
       Showmassage(db_Quntity,'¬ведите кол-во');
       exit;
    end;

 end;
 if pn_Other.Visible then
 begin
    if dbe_Depth.Text=''  then begin
     Showmassage(dbe_Depth,'¬ведите глубину');
     exit;
   end;
   if db_Lengt.Text=''  then begin
     Showmassage(db_Lengt,'¬ведите длинну');
     exit;
   end;
   if dbe_Width.Text=''  then begin
     Showmassage(dbe_Width,'¬ведите ширину');
     exit;
   end;
 end;
 Result:=true;

end;

procedure Tfrm_AddWork.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  procedure _Next;
  begin
    SelectNext( ActiveControl, true, true );
  end;
begin
  if ( Key=VK_RETURN ) and not( ssCtrl in Shift ) then
  begin
    if (Sender is TRxDBLookupCombo) then
    begin
      if not (Sender as TRxDBLookupCombo).IsDropDown then
        _Next;
    end else _Next;
  end;
end;

procedure  Tfrm_AddWork.AddPnlVisibleBuild;
begin
 if ds_work.DataSet.FieldByName('id_workkind').AsInteger=WORKKIND_RASKOP_ID then
 begin
  pn_Other.Visible:=true;
  pn_Exc.Visible:=false;
 end
 else
 begin
  pn_Other.Visible:=false;
  pn_Exc.Visible:=true;
 end;

end;

procedure Tfrm_AddWork.dbl_workChange(Sender: TObject);
begin
 AddPnlVisibleBuild;
end;

procedure Tfrm_AddWork.BitBtn1Click(Sender: TObject);
begin
if   isFiledCorrect then
 MOdalResult:=mrOk ;
//else MOdalResult:=mrCancel;
end;

procedure Tfrm_AddWork.BitBtn2Click(Sender: TObject);
begin
Close;
end;

procedure Tfrm_AddWork.FormShow(Sender: TObject);
begin
  AddPnlVisibleBuild;
  //db_Quntity.Text:='';
  //db_Lengt.Text:='';
  //dbe_Width.Text:='';

end;

procedure Tfrm_AddWork.dbl_workContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var a:integer;
begin
  a:= MousePos.Y;
end;

procedure Tfrm_AddWork.dbl_workCloseUp(Sender: TObject);
begin
BitBtn1.Enabled:=true;
end;

procedure Tfrm_AddWork.dbl_workDropDown(Sender: TObject);
begin
BitBtn1.Enabled:=false;
end;

end.
