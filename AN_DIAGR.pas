unit AN_DIAGR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, Grids, DBGrids, Spin, Buttons, Mask, Diagram,
  ExtCtrls, RxLookup, IBCustomDataSet, DModule;

const nRange=20;
      nYear=20;
type
  TQueryForm = class(TForm)
    lbSreet: TLabel;
    gbNum: TGroupBox;
    seNum1: TSpinEdit;
    seNum2: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    gbYear: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    seYear1: TSpinEdit;
    seYear2: TSpinEdit;
    btDiagram: TBitBtn;
    Label5: TLabel;
    gbGraph: TGroupBox;
    rbMatrix: TRadioButton;
    rbAdd: TRadioButton;
    gbCrash: TGroupBox;
    rbDinam: TRadioButton;
    cbTypeCrash1: TCheckBox;
    cbTypeCrash2: TCheckBox;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    DBL_ul1: TRxDBLookupCombo;
    DiamCB: TRxDBLookupCombo;
    DS_ul1: TDataSource;
    ds_diam: TDataSource;
    dset_ul1: TIBDataSet;
    dset_orders: TIBDataSet;
    dset_diam: TIBDataSet;
    RB_Chet: TRadioButton;
    RB_Nech: TRadioButton;
    RB_All: TRadioButton;
    procedure dblStreetChoiceExit(Sender: TObject);
    procedure edDiamKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btDiagramClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Changing(Sender: TObject);
    procedure rbGraphClick(Sender: TObject);
    procedure dblStreetExit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure dblStreetEnter(Sender: TObject);
    procedure seYear1Enter(Sender: TObject);
    procedure seYear1Exit(Sender: TObject);
    procedure seYear2Exit(Sender: TObject);
    procedure seYear2Enter(Sender: TObject);
    procedure seNum1Enter(Sender: TObject);
    procedure seNum1Exit(Sender: TObject);
    procedure seNum2Exit(Sender: TObject);
    procedure seNum2Enter(Sender: TObject);
    procedure cbTypeCrash1Enter(Sender: TObject);
    procedure cbTypeCrash1Exit(Sender: TObject);
    procedure cbTypeCrash2Enter(Sender: TObject);
    procedure cbTypeCrash2Exit(Sender: TObject);
    procedure rbDinamExit(Sender: TObject);
    procedure rbDinamEnter(Sender: TObject);
    procedure rbMatrixEnter(Sender: TObject);
    procedure rbMatrixExit(Sender: TObject);
    procedure rbAddEnter(Sender: TObject);
    procedure rbAddExit(Sender: TObject);
    procedure edDiamEnter(Sender: TObject);
    procedure edDiamExit(Sender: TObject);
    procedure edDiamchange(Sender: TObject);
    procedure DBL_ul1Change(Sender: TObject);
    procedure DBL_ul1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBL_ul1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DiamCBChange(Sender: TObject);
  private
    { Private declarations }
    Changed:boolean;
    m_nEscKeyState:integer;
    procedure EnableBtn;
  public
    Count:PDoubleArr;
    sRange:Double;
    _MinValue,_MaxValue:double;
    Year1,Year2:TDateTime;
    nYear1,nYear2:Word;
    Num1,Num2:word;
  end;


var
  Streetcode:Longint;

implementation

{$R *.DFM}

uses DgrForm, GlobalData, HelpFunctions;


procedure TQueryForm.dblStreetChoiceExit(Sender: TObject);
begin
   StreetCode:=dset_ul1.FieldByName('id').AsInteger;
//  StreetCode:=tbEnumsNum_Val.asInteger;
  Changed:=True
end;

procedure TQueryForm.EnableBtn;
begin
  btDiagram.Enabled:=(Trim(DBL_ul1.Text)<>'')  and
                     (cbTypeCrash1.Checked or cbTypeCrash2.Checked);
end;

procedure TQueryForm.edDiamKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Return
    then begin
      EnableBtn;
      Key:=0
    end
end;

procedure TQueryForm.btDiagramClick(Sender: TObject);
var j,i:integer;
    p:^Double;
    s:string;
    k:longint;
    sn,diam:integer;
    kpovr:set of byte;
    CodeStr:string;
    strDate1, strDate2:AnsiString;
    strQueryDate: string;
begin
  ShortDateFormat := 'dd.mm.yy';
  longDateFormat := 'dd.mm.yy';
  diam:=-1;
  strDate1 := '01.01.'+seYear1.Text;
  strDate2 := '01.01.'+seYear2.Text;
  strQueryDate := '01.01.'+IntToStr(seYear2.Value+1);
  Year1:=StrToDate(strDAte2);
  Year2:=StrToDate(strDate2);
  nYear1:=StrToInt(seYear1.Text);
  nYear2:=StrToInt(seYear2.Text);
  Num1:=StrToInt(seNum1.Text);
  Num2:=StrToInt(seNum2.Text);
  kPovr:=[];
  if cbTypeCrash1.Checked then
    kpovr:=kpovr+[1];
  if cbTypeCrash2.Checked then
    kpovr:=kpovr+[2];
  sRange:=(Num2-Num1+1)/nRange;
  if sRange<1.0
    then exit;
  If trim(DiamCB.Text)<>'' Then diam:= dset_Diam.FieldByName('id').AsInteger;
  If trim(DBL_ul1.Text)<>'' Then CodeStr := dset_ul1.FieldByName('id').AsString;

  MyOpenSQL(dset_orders,
    ' select * from orders where datecoming>='''+strDate1+''''+
    ' and datecoming<='''+strQueryDate+''''+
    ' and FK_ORDERS_STREETS='+CodeStr+
    ' and FK_ORDERS_HOUSETYPES=0');

  if Changed
    then with dset_orders do
      begin
        for i:=0 to nYear-1 do
          for j:=0 to nRange-1 do
            Count^[i*nRange+j]:=0.0;
        _MinValue:=0; _MaxValue:=0;
        //SetRange([IntToStr(StreetCode),'1'],[IntToStr(StreetCode),'1']);
        First;
        while not Eof do
          try
            if ((diam=-1) or (FieldByName('FK_ORDERS_DIAMETERS').asInteger=diam)) and
               (FieldByName('FK_ORDERS_DAMAGEPLACE').asInteger in kpovr)
              then begin
                s:=Trim(FieldByName('HOUSENUM').AsString);
                if s<>''
                  then begin
                    i:=1;
                    while (i<Length(s)) and (s[i] in ['0'..'9']) do inc(i);
                    if not (s[i] in ['0'..'9'])
                      then SetLength(s,i-1);
                    if Trim(s)='' then
                     sn:=0
                    else
                     sn:=StrToInt(Trim(s));
                    if  (((sn mod 2)=0) and (RB_Chet.Checked))
                        or (((sn mod 2)>0) and (RB_Nech.Checked)) or (RB_All.Checked) then
                    begin   //чёт - нечет
                    j:=trunc((sn-Num1)/sRange);
                    if (j<nRange) and (j>=0)
                      then begin

                        {
                        s:=DateToStr(FieldByName('DateComing').asDateTime-Year1);
                        i:=pos('.',s);
                        while i<>0 do
                          begin
                            System.Delete(s,1,i);
                            i:=pos('.',s);
                          end;
                        i:=StrToInt(Trim(s));
                        }

                        i:=GetYear(FieldByName('DateComing').AsDateTime)-seYear1.Value;
                        if (i<nYear) and (i>=0)
                          then begin
                            k:=(i*nRange+j)*sizeof(double);
                            p:=Pointer(Longint(Count)+k);
                            p^:=p^+1.0;
                            if p^>_MaxValue
                              then _MaxValue:=p^;
                          end
                        end //чёт - нечет
                      end
                  end;
              end;
            Next
          except
            Next;
            Continue
          end
      end;

    dset_orders.Close();
   //создание формы с диаграммой
   Graph:=TGraph.Create(Self);
   Graph.Caption:=DBL_ul1.Text;
   Graph.ShowModal;
   Changed:=False;
end;

procedure TQueryForm.FormCreate(Sender: TObject);
var Year, Month, Day : Word;
begin
  inherited;
  dset_diam.Active:=True;
  dset_ul1.Active:=True;
  Dbl_ul1.DisplayValue := '';
  DiamCB.DisplayValue := '';
  GetMem(Count,nRange*nYear*sizeof(Double));
  DecodeDate(Date, Year, Month, Day);
  seYear2.Value:=Year;
  If (seYear2.Value-seYear1.Value)>(nYear-1) Then seYear1.Value:=seYear2.Value-(nYear-1);
end;

procedure TQueryForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dset_diam.Active:=FAlse;
  dset_ul1.Active:=False;
  if dset_orders.Transaction.InTransaction then
    dset_orders.Transaction.Commit;
  FreeMem(Count,nRange*nYear*sizeof(Double));
  ShortDateFormat := 'dd.mm.yyyy';
  longDateFormat := 'dd.mm.yyyy';
  Action:=caFree;
end;

procedure TQueryForm.Changing(Sender: TObject);
begin
  Changed:=True;
  EnableBtn
end;

procedure TQueryForm.rbGraphClick(Sender: TObject);
begin
  gbGraph.Tag:=TRadioButton(Sender).Tag;
  EnableBtn
end;

procedure TQueryForm.dblStreetExit(Sender: TObject);
begin
  DBL_ul1.Color:=Old_Col;
  EnableBtn;
end;

procedure TQueryForm.BitBtn1Click(Sender: TObject);
begin
 Close;
end;

procedure TQueryForm.dblStreetEnter(Sender: TObject);
begin
  inherited;
  DBL_ul1.Color:=New_Col;
end;

procedure TQueryForm.seYear1Enter(Sender: TObject);
begin
  inherited;
  seYear1.Color:=New_Col;
end;

procedure TQueryForm.seYear1Exit(Sender: TObject);
begin
  inherited;
  seYear1.Color:=Old_Col;
  If (seYear2.Value-seYear1.Value)>9 Then seYear1.Value:=seYear2.Value-9;
end;

procedure TQueryForm.seYear2Exit(Sender: TObject);
begin
  inherited;
  seYear2.Color:=OLD_Col;
  If (seYear2.Value-seYear1.Value)>9 Then seYear1.Value:=seYear2.Value-9;
end;

procedure TQueryForm.seYear2Enter(Sender: TObject);
begin
  inherited;
  seYear2.Color:=New_Col;
end;

procedure TQueryForm.seNum1Enter(Sender: TObject);
begin
  inherited;
  seNum1.Color:=New_Col;
end;

procedure TQueryForm.seNum1Exit(Sender: TObject);
begin
  inherited;
  seNum1.Color:=OLD_Col;
end;

procedure TQueryForm.seNum2Exit(Sender: TObject);
begin
  inherited;
  seNum2.Color:=OLD_Col;
end;

procedure TQueryForm.seNum2Enter(Sender: TObject);
begin
  inherited;
  seNum2.Color:=New_Col;
end;

procedure TQueryForm.cbTypeCrash1Enter(Sender: TObject);
begin
  inherited;
  cbTypeCrash1.Color:=New_Col;
end;

procedure TQueryForm.cbTypeCrash1Exit(Sender: TObject);
begin
  inherited;
  cbTypeCrash1.Color:=OLD_Col;
end;

procedure TQueryForm.cbTypeCrash2Enter(Sender: TObject);
begin
  inherited;
  cbTypeCrash2.Color:=New_Col;
end;

procedure TQueryForm.cbTypeCrash2Exit(Sender: TObject);
begin
  inherited;
  cbTypeCrash2.Color:=OLD_Col;
end;

procedure TQueryForm.rbDinamExit(Sender: TObject);
begin
  inherited;
  rbDinam.Color:=OLD_Col;
end;

procedure TQueryForm.rbDinamEnter(Sender: TObject);
begin
  inherited;
  rbDinam.Color:=New_Col;
end;

procedure TQueryForm.rbMatrixEnter(Sender: TObject);
begin
  inherited;
  rbMatrix.Color:=New_Col;
end;

procedure TQueryForm.rbMatrixExit(Sender: TObject);
begin
  inherited;
  rbMatrix.Color:=OLD_Col;
end;

procedure TQueryForm.rbAddEnter(Sender: TObject);
begin
  inherited;
  rbAdd.Color:=New_Col;
end;

procedure TQueryForm.rbAddExit(Sender: TObject);
begin
  inherited;
  rbAdd.Color:=Old_Col;
end;

procedure TQueryForm.edDiamEnter(Sender: TObject);
begin
  inherited;
  DiamCB.Color:=New_Col;
end;

procedure TQueryForm.edDiamExit(Sender: TObject);
begin
  inherited;
  DiamCB.Color:=OLD_Col;
end;

procedure TQueryForm.edDiamchange(Sender: TObject);
begin
  inherited;
  Changed:=True;
end;

procedure TQueryForm.DBL_ul1Change(Sender: TObject);
begin
  EnableBtn();
end;

procedure TQueryForm.DBL_ul1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var str:AnsiSTring;
begin
  str := Sender.ClassName;
  if (Key = 27) and (str = 'TRxDBLookupCombo') then
  begin
    if (sender as TRxDBLookupCombo).DisplayEmpty <> '' then
      Exit;
    if (m_nEscKeyState = 1) then
    begin
      (sender as TRxDBLookupCombo).Value := '';
    end;
    m_nEscKeyState := 0;
  end;
end;

procedure TQueryForm.DBL_ul1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var str:AnsiSTring;
  begin
  str := Sender.ClassName;
  if (Key = 27) and (str = 'TRxDBLookupCombo') then
  begin
    m_nEscKeyState := 2;
    if (sender as TRxDBLookupCombo).Listvisible = false then
    begin
      m_nEscKeyState := 1;
    end;
  end;

end;

procedure TQueryForm.DiamCBChange(Sender: TObject);
begin
  Changed:=True;
end;

end.
