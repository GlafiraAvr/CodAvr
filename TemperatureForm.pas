unit TemperatureForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls,  Mask, Spin, RXSpin,
  ToolEdit, DB, IBCustomDataSet, IBSQL;

type
  Tfrm_Temperature = class(TForm)
    btn_Apply: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ed_WaterTemp: TRxSpinEdit;
    ded_Shift: TDateEdit;
    dset_Temper: TIBDataSet;
    sql_Temper: TIBSQL;
    procedure FormShow(Sender: TObject);
    procedure btn_ApplyClick(Sender: TObject);
  private
    { Private declarations }
  public
  end;

  function IsNeedToInputTemper: boolean;

implementation

uses DModule, GlobalData, RightsManagerDModule, StringConsts;

{$R *.dfm}

function IsNeedToInputTemper: boolean;
begin
  if DM_RightsManager.IsCurrentUserDisp then
  begin
    Result:=DM_Main.IsNeedToInputTemper;
    if Result then
      Application.MessageBox(gc_strTempRequest, gc_strDispAVR, MB_OK+MB_ICONWARNING);
  end else Result:=false;
end;

procedure Tfrm_Temperature.FormShow(Sender: TObject);
var
  PrevDate:TDate;
  strWTEmp:string;
begin
  dset_Temper.Transaction.StartTransaction;
  try
    MyOpenSQL(dset_Temper, 'select shiftdate from servanttable');
    PrevDate := dset_Temper.FieldByName('shiftdate').AsDateTime;
    dset_Temper.Close;

    MyOpenSQL(dset_Temper, 'select Temperature from Temperatures where TempDate = ''' + DateToStr(PrevDate) + '''');

    if dset_Temper.Eof and dset_Temper.Bof then
      strWTEmp := '0,00'
    else
      strWTEmp := FloatToStr(dset_Temper.FieldByName('Temperature').AsFloat);
  finally
    dset_Temper.Transaction.Commit;
  end;

  ded_Shift.Date := PrevDate;
  ed_WaterTemp.Text := strWTEmp ;
  FocusControl(btn_Apply);
end;


procedure Tfrm_Temperature.btn_ApplyClick(Sender: TObject);
var
  strWTemp:AnsiString;
  strDate:AnsiString;
  nPos: integer;
begin
  if ded_Shift.Date = 0 then
  begin
    FocusControl(ded_Shift);
    Exit;
  end;
  strDate := ded_Shift.Text;
  strWTemp := ed_WaterTemp.Text;

  nPos := Pos(',', strWTemp);
  if nPos <> 0 then
    strWTemp[nPos] := '.';
  if strWTemp[2] = ',' then
    strWTemp[2] := '.'
  else   if strWTemp[3] = ',' then
    strWTemp[3] := '.';

    
  sql_Temper.Transaction.StartTransaction;
  try
    MyExecSQL(sql_Temper, 'DELETE FROM Temperatures WHERE Tempdate = ''' + strDate + '''');
    MyExecSQL(sql_Temper,'INSERT INTO Temperatures(Tempdate, Temperature) VALUES('''
                        + strDate + ''', '+ strWTEmp + ')');
  except
    sql_Temper.Transaction.Rollback;
    Raise;
  end;
  sql_Temper.Transaction.Commit;
  Close;
end;

end.
