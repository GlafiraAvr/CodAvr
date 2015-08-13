unit shiftnumform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, Spin, Mask, ToolEdit, DB,
  IBCustomDataSet, IBSQL;

type
  Tfrm_ShiftNum = class(TForm)
    btn_Apply: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ed_ShiftNum: TSpinEdit;
    ded_Shift: TDateEdit;
    dset_Shift: TIBDataSet;
    sql_Shift: TIBSQL;
    procedure btn_ApplyClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    F_ShiftDate: TDate;
    F_ShiftNum: integer;
  public
    property ShiftDate: TDate read F_ShiftDate;
    property ShiftNum: integer read F_ShiftNum;
  end;

  //  Функция возращает номер и дату смены
  procedure GetShiftsNumAndDate(var NumShift: integer; var DateShift: TDate);

  function IsNeedToChangeShift: boolean;

implementation

uses DModule, GlobalData, RightsManagerDModule, StringConsts, HelpFunctions;

{$R *.dfm}

function IsNeedToChangeShift: boolean;
begin
  if DM_RightsManager.IsCurrentUserDisp then
  begin
    Result:=DM_Main.IsNeedToChangeShift;
    if Result then
      Application.MessageBox(gc_strShiftRequest, gc_strDispAVR, MB_OK+MB_ICONWARNING);
  end else Result:=false;
end;


// Функция возращает номер и дату смены
procedure GetShiftsNumAndDate(var NumShift: integer; var DateShift: TDate);
var
  dset_Shift:TIBDataSet;
begin
  dset_Shift:=TIBDataSet.Create(nil);
  try
    dset_Shift.Database:=DM_Main.IBDatabase;
    dset_Shift.Transaction:=DM_Main.Tr_RCommited;
    if (not dset_Shift.Transaction.InTransaction) then  dset_Shift.Transaction.StartTransaction;
    try
      MyOpenSQL(dset_Shift, 'select shiftnumber, shiftdate from servanttable');
      if dset_Shift.Eof and dset_Shift.Bof then
      begin
        NumShift:=-1;
        DateShift:=0;
      end else
      begin
        NumShift:=dset_Shift.FieldByName('shiftnumber').AsInteger;
        DateShift:=dset_Shift.FieldByName('shiftdate').AsDateTime;
      end;
    finally
      dset_Shift.Transaction.Commit;
    end;
  finally
    dset_Shift.Free;
  end;
end;

procedure Tfrm_ShiftNum.btn_ApplyClick(Sender: TObject);
var
  nNum:integer;
  dtTemp:TDate;
  PrevShiftNum:integer;
begin
  nNum := StrToInt(ed_ShiftNum.Text);
  if nNum <= 0 then
  begin
    Close;
    exit;
  end;

  if ded_Shift.Date = 0 then
  begin
    ded_Shift.Date := Date();
    Exit;
  end;

  GetShiftsNumAndDate(PrevShiftNum, dtTemp);

  if sql_Shift.Transaction.InTransaction then
    sql_Shift.Transaction.Rollback;
  sql_Shift.Transaction.StartTransaction;
  try
    MyExecSQL(sql_Shift,' update servanttable SET shiftnumber = ' + IntToStr(nNum)+
                        ' , shiftdate = ''' + ded_Shift.Text + '''');
    if PrevShiftNum <> nNum then
      MyExecSQL(sql_Shift, 'DELETE FROM Temperatures WHERE Tempdate = ''' + ded_Shift.Text + '''');
  except
    sql_Shift.Transaction.Rollback;
    Raise;
  end;
  sql_Shift.Transaction.Commit;

  F_ShiftDate := StrToDate(ded_Shift.Text);
  F_ShiftNum := nNum;
  Close;
end;

procedure Tfrm_ShiftNum.FormShow(Sender: TObject);
var
  PrevDate:TDate;
  nShiftNum:integer;
begin
  ded_Shift.Date := Date();
  dset_Shift.Transaction.StartTransaction;
  try
    dset_Shift.Open;
    if not(dset_Shift.Eof and dset_Shift.Bof) then
    begin
      PrevDate := dset_Shift.FieldByName('shiftdate').AsDateTime;
      nShiftNum := dset_Shift.FieldByName('shiftnumber').AsInteger;

      if (Date() - PrevDate >= 2) or
      ((Date() - PrevDate = 1) and (Time() > StrToTime(g_ShiftStartTime) ))then
      begin
        nShiftNum := nShiftNum + 1; //nshiftnum mod 4 + 1
        if(nShiftNum > 4) then
          nShiftNum := 1;
      end;
      ed_ShiftNum.Text := IntToStr(nShiftNum);
    end;
  finally
    dset_Shift.Transaction.Commit;
  end;  
end;

end.
