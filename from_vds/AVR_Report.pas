unit AVR_Report;

interface

uses Windows, SysUtils, DB, IBCustomDataSet, FR_Class, FR_DSet, BaseResultForm,
      BaseOptionForm, Forms, GridViewBuilder, Controls, aligrid, ProgressForm,
      Graphics, Classes, CustomReport;

type

  TBaseReport=class(TCustomReport)
  protected
    F_RecordCount: integer;
    F_GridViewBuilder: TGridViewBuilder;

   

    function GetRecordCount: integer;
    procedure ChangeProgreccIndicator(LoadRecCount: integer);
    procedure OrderBtnClick(Sender: TObject); virtual;
    procedure PrintBtnClick(Sender: TObject); virtual;
    procedure ExcelBtnClick(Sender: TObject);
    procedure GraphBtnClick(Sender: TObject); virtual;
    function GetResultFormGrid: TStringAlignGrid;
    procedure ClearDsets;
  protected
    function LoadData: boolean; override;
  protected
    procedure PrepareDsets; virtual;
  public
    destructor Destroy; override;
  public
    function Execute: boolean; override;
  end;

  TOpenOrderSearch=class(TBaseReport)
  private
    function DateCaption(dt1, dt2: string): string;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;

  TCloseOrderSearch=class(TBaseReport)
  private
    function DateCaption(dt1, dt2: string): string;
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;

  TAllOrderSearch=class(TBaseReport)
  private
    procedure BoltStatusCellShow(ShowValue: variant; var Res: string);
    function DateCaption(dt1, dt2: string): string;
    procedure IsClosedGroupHeaderCaption(DataSet: TDataSet;
                AggregateValueArr: array of double; var OutRow: TStringList);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareResultFormHeader; override;
    procedure PrepareResultFormGrid; override;
    procedure PrepareResultFormBtns; override;
    procedure PrepareFastReport; override;
  end;


implementation

uses HelpFunctions, AnalysisViewForm, PeriodRegDmgSelForm,
    OrderForm, ExcelWorksForm, StringConsts;

{ TBaseReport }

function TBaseReport.Execute: boolean;
begin
  Result:=false;

  if not ShowOptionForm then exit;

  ClearDsets;
  PrepareDsets;
  F_RecordCount:=GetRecordCount;

  if F_RecordCount=0 then
  begin
    Application.MessageBox('Записей удовлетворяющих условию запроса не найдено.',
                            gc_strDispAVR, MB_OK+MB_ICONWARNING);
  end else
  begin
    if F_RecordCount>0 then
      if Application.MessageBox(PChar(Format('Найдено %d записей. Показать?', [F_RecordCount])),
                            gc_strDispAVR, MB_YESNO+MB_ICONQUESTION)<>IDYES then exit;

    PrepareResultFormHeader;
    PrepareResultFormGrid;
    PrepareResultFormBtns;

    LoadData;

    F_ResultForm.ShowModal;
  end;

  Result:=true;
end;


function TBaseReport.GetRecordCount: integer;
begin
  Result:=-1;

  if not Assigned(F_RecordCountDset) then exit;
  if trim(F_RecordCountDset.SelectSQL.Text)='' then exit;

  try
    F_RecordCountDset.Open;
    Result:=F_RecordCountDset.Fields[0].AsInteger;
  except
    F_RecordCountDset.Close;
  end;
end;

procedure TBaseReport.PrepareDsets;
begin
end;

function TBaseReport.LoadData: boolean;
begin
  F_ProgressIndic.Show;

  if F_RecordCount>0 then
  begin
    F_ProgressIndic.Max:=F_RecordCount;
    F_GridViewBuilder.OnLoadRecordCount:=ChangeProgreccIndicator;
  end;
  F_GridViewBuilder.BuildGridView;

  F_ProgressIndic.Hide;
end;

destructor TBaseReport.Destroy;
begin
  F_GridViewBuilder.Free;
  inherited Destroy;
end;



procedure TBaseReport.ChangeProgreccIndicator(LoadRecCount: integer);
begin
  F_ProgressIndic.Position:=LoadRecCount;
end;

procedure TBaseReport.GraphBtnClick(Sender: TObject);
begin
//
end;

procedure TBaseReport.OrderBtnClick(Sender: TObject);
var
  OrderID: integer;
  frm_Order: Tfrm_Order;
  Grid: TStringAlignGrid;
begin
  Grid:=GetResultFormGrid;
  if not Assigned(Grid) then exit;

  if Assigned(Grid.Objects[0, Grid.Row]) then
  begin
    OrderID:=integer(Grid.Objects[0, Grid.Row]);
    frm_Order:=Tfrm_Order.Create(nil, OrderID);
    frm_Order.ShowModal;
  end;
end;

procedure TBaseReport.PrintBtnClick(Sender: TObject);
begin
  if not LoadReportFile then exit;
  PrepareFastReport;

  ShowReport;

end;

procedure TBaseReport.ExcelBtnClick(Sender: TObject);
var
  Grid: TStringAlignGrid;
  Title: string;
  CentrLbl, LeftLbl: string;
begin
  Grid:=GetResultFormGrid;
  if not Assigned(Grid) then exit;

  //Только для случая, когда ResultForm - это Tfrm_AnalysiView
  if (F_ResultForm is Tfrm_AnalysisView) then
  begin
    CentrLbl:=(F_ResultForm as Tfrm_AnalysisView).CenterLabel;
    LeftLbl:=(F_ResultForm as Tfrm_AnalysisView).LeftLabel;
  end else exit;

  with TExcelWorks.Create do
  begin
    try
      Title:=ReplaceChar(CentrLbl, #13, ' ');
      if trim(Title)<>'' then Title:=Title+';';
      Title:=Title+ReplaceChar(LeftLbl, #13, ';');

      Close;
      SetWSName('Результаты поиска');
      SetTitle(Title);
      SetMargins(1, 1,0, 0);
      MapStringGrid(Grid);
    finally
      Free;
    end;
  end;
end;

function TBaseReport.GetResultFormGrid: TStringAlignGrid;
var
  i: integer;
begin
  for i:=0 to F_ResultForm.ComponentCount-1 do
    if (F_ResultForm.Components[i] is TStringAlignGrid) then
    begin
      Result:=(F_ResultForm.Components[i] as TStringAlignGrid);
      break;
    end;
end;

procedure TBaseReport.ClearDsets;
  procedure ClearDS(ds: TIBDataSet);
  begin
    if Assigned(ds) then
    begin
      ds.Close;
      ds.SelectSQL.Clear;
    end;
  end;
var
  i: integer;
begin
  ClearDS(F_RecordCountDset);

  for i:=low(F_Dset) to High(F_Dset) do
    ClearDS(F_Dset[i]);
end;

{ TOpenOrderSearch }

procedure TOpenOrderSearch.CreateForms;
begin
  F_OptionForm:=Tfrm_PeriodRegDmgSel.Create(nil, 'Поиск незакрытых нарядов');
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, 'Просмотр незакрытых нарядов');
end;

function TOpenOrderSearch.DateCaption(dt1, dt2: string): string;
begin
  if dt1<>''then   dt1:=  DateToStr(StrToDateTime(dt1));
   if dt2<>'' then  dt2:=  DateToStr(StrToDateTime(dt2));
  Result:='Поиск незакрытых нарядов'+#13+'за';
  if (dt1='') and (dt2='') then
  begin
    Result:=Result+' весь период'
  end else
  begin
    Result:=Result+' период';
    if dt1<>'' then Result:=Result+' c '+dt1;
    if dt2<>'' then Result:=Result+' по '+dt2;
  end;
end;

procedure TOpenOrderSearch.InitFields;
begin
  F_Name:='Поиск незакрытых нарядов за период';
  F_ReportFileName:='OpenOrderSearch.frf';
end;

procedure TOpenOrderSearch.PrepareDsets;
var
  SelSQL, CountSQL: string;
begin
 //(F_OptionForm as Tfrm_PeriodRegDmgSel).btn_okClick(nil);
  SelSQL :=' select id, DateComing,'+
           ' (select FullOrderNum from get_fullordernum(o.OrderNumber, o.fk_orders_district)) FullOrderNum,'+
           ' (select name from s_district where id=o.fk_orders_district) district,'+
           ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
           ' (select adres from get_adres(o.fk_orders_streets, o.housenum,'+
           '     o.housingnum, o.PorchNum, o.floornum, o.apartmentnum, o.porchkod)) adres'+
           ' from orders o '+
           (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
           ' and IsClosed=0 order by DateComing';

  CountSQL:='select count(id) RecordCount from orders '+
            (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
            ' and IsClosed=0';

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TOpenOrderSearch.PrepareFastReport;
var i,j:integer;
begin
  with F_OptionForm as Tfrm_PeriodRegDmgSel do
  begin
    frVariables['Caption']:=DateCaption(strStartDate, strFinishedDate);
    frVariables['Regions']:='Районы: '+StrRegions;
    //frVariables['DamagePlace']:='Места повреждения: '+strDamagePlace;
  end;
  TRmem.Close;
  TRmem.Open;
    if not F_Dset[0].Active then F_Dset[0].Open;
    F_Dset[0].First;

    while  not F_Dset[0].Eof do begin
     TRmem.Append;
     for j:=0 to  F_Dset[0].FieldCount-1 do
       TRmem.FieldByName( F_Dset[0].Fields[j].FieldName).Value:=F_Dset[0].Fields[j].AsString;
     TRmem.Post;
     F_Dset[0].Next;
    end;
end;

procedure TOpenOrderSearch.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Order.OnClick:=OrderBtnClick;
    btn_Print.OnClick:=PrintBtnClick;
  end;
end;

procedure TOpenOrderSearch.PrepareResultFormGrid;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                  (F_ResultForm as Tfrm_AnalysisView).Grid);

  with F_GridViewBuilder do
  begin
    IDFieldName:='ID';

    AddColToGVB(F_GridViewBuilder, 'DateComing', 'Дата и время'+#13+'поступления', alCenter);
    AddColToGVB(F_GridViewBuilder, 'FullOrderNum', '№'+#13+'наряда', alCenter);
    AddColToGVB(F_GridViewBuilder, 'Regions', 'Район', alLeft);
    AddColToGVB(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);

    IsNumberRecord:=true;
  end;
end;

procedure TOpenOrderSearch.PrepareResultFormHeader;
begin
  with (F_ResultForm as Tfrm_AnalysisView),
        (F_OptionForm as Tfrm_PeriodRegDmgSel) do
  begin

    CenterLabel:=DateCaption(strStartDate, strFinishedDate);
//    LeftLabel:='Районы: '+StrRegions+#13+
//                'Места повреждения: '+strDamagePlace;
  end;
end;

{ TCloseOrderSearch }

procedure TCloseOrderSearch.CreateForms;
begin
  F_OptionForm:=Tfrm_PeriodRegDmgSel.Create(nil, 'Поиск закрытых нарядов');
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, 'Просмотр закрытых нарядов');
end;

function TCloseOrderSearch.DateCaption(dt1, dt2: string): string;
begin
   if dt1<>'' then dt1:=  DateToStr(StrToDateTime(dt1));
   if dt2<>'' then dt2:=  DateToStr(StrToDateTime(dt2));
  Result:='Поиск закрытых нарядов'+#13+'за';
  if (dt1='') and (dt2='') then
  begin
    Result:=Result+' весь период'
  end else
  begin
    Result:=Result+' период';
    if dt1<>'' then Result:=Result+' c '+dt1;
    if dt2<>'' then Result:=Result+' по '+dt2;
  end;
end;

procedure TCloseOrderSearch.InitFields;
begin
  F_Name:='Поиск закрытых нарядов за период';
  F_ReportFileName:='RepClosedOrders.frf';
end;

procedure TCloseOrderSearch.PrepareDsets;
var
  SelSQL, CountSQL: string;
begin

  SelSQL :=
    ' select id, DateComing, DateClosed, '+
    ' (select FullOrderNum from get_fullordernum(o.OrderNumber, o.fk_orders_district)) FullOrderNum,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
    ' (select adres from get_adres(o.fk_orders_streets, o.housenum,'+
    '     o.housingnum, o.PorchNum, o.floornum, o.apartmentnum, o.porchkod)) adres'+
    ' from orders o '+
    (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
    ' and IsClosed=1 order by DateComing';

  CountSQL:='select count(id) RecordCount from orders '+
            (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
            ' and IsClosed=1';

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TCloseOrderSearch.PrepareFastReport;
var i,j:integer;
begin
  with (F_OptionForm as Tfrm_PeriodRegDmgSel) do
  begin
    frVariables['Caption']:=DateCaption(strStartDate, strFinishedDate);
    frVariables['Regions']:='Районы: '+StrRegions;
//    frVariables['DamagePlace']:='Места повреждения: '+strDamagePlace;

  end;

 TRmem.Close;
  TRmem.Open;
    if not F_Dset[0].Active then F_Dset[0].Open;
    F_Dset[0].First;

    while  not F_Dset[0].Eof do begin
     TRmem.Append;
     for j:=0 to  F_Dset[0].FieldCount-1 do
       TRmem.FieldByName( F_Dset[0].Fields[j].FieldName).Value:=F_Dset[0].Fields[j].AsString;
     TRmem.Post;
     F_Dset[0].Next;
    end;


end;

procedure TCloseOrderSearch.PrepareResultFormBtns;
begin
  with F_ResultForm as Tfrm_AnalysisView do
  begin
    btn_Order.OnClick:=OrderBtnClick;
    btn_Print.OnClick:=PrintBtnClick;
    //btn_Excel.OnClick:=ExcelBtnClick;
  end;
end;

procedure TCloseOrderSearch.PrepareResultFormGrid;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                  (F_ResultForm as Tfrm_AnalysisView).Grid);

  with F_GridViewBuilder do
  begin
    IDFieldName:='ID';

    AddColToGVB(F_GridViewBuilder, 'DateComing', 'Дата и время'+#13+'поступления', alCenter);
    AddColToGVB(F_GridViewBuilder, 'DateClosed', 'Дата и время'+#13+'закрытия', alCenter);
    AddColToGVB(F_GridViewBuilder, 'FullOrderNum', '№'+#13+'наряда', alCenter);
    AddColToGVB(F_GridViewBuilder, 'Regions', 'Район', alLeft);
    AddColToGVB(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);

    IsNumberRecord:=true;
  end;
end;

procedure TCloseOrderSearch.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodRegDmgSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:=DateCaption(strStartDate, strFinishedDate);
//    LeftLabel:='Районы: '+StrRegions+#13+
//              'Места повреждения: '+strDamagePlace;
  end;
end;

{ TAllOrderSearch }

procedure TAllOrderSearch.BoltStatusCellShow(ShowValue: variant;
  var Res: string);
var
  val:integer;
begin
  val:=VarToInteger(ShowValue);

  if val=0 then
    Res:=''
  else
    Res:='Пер: '+IntToStr(val);
end;

procedure TAllOrderSearch.CreateForms;
begin
  F_OptionForm:=Tfrm_PeriodRegDmgSel.Create(nil, 'Поиск всех нарядов');
  F_ResultForm:=Tfrm_AnalysisView.Create(nil, 'Поиск всех нарядов');
end;

function TAllOrderSearch.DateCaption(dt1, dt2: string): string;
begin
  if dt1<>''then dt1:=  DateToStr(StrToDateTime(dt1));
 if dt2<>''then  dt2:=  DateToStr(StrToDateTime(dt2));
  Result:='Поиск всех нарядов'+#13+'за';
  if (dt1='') and (dt2='') then
  begin
    Result:=Result+' весь период'
  end else
  begin
    Result:=Result+' период ';
    if dt1<>'' then Result:=Result+' c '+dt1;
    if dt2<>'' then Result:=Result+' по '+dt2;
  end;
end;

procedure TAllOrderSearch.InitFields;
begin
  F_Name:='Поиск всех нарядов за период';
  F_ReportFileName:='RepAllOrders.frf';
end;

procedure TAllOrderSearch.IsClosedGroupHeaderCaption(DataSet: TDataSet;
  AggregateValueArr: array of double; var OutRow: TStringList);
begin
  with OutRow do
  begin
    Add('');
    Add('');
    Add('');
    Add('');
    Add('');
    if DataSet.FieldByName('IsClosed').AsInteger=0 then
      Add('ОТКРЫТЫЕ ЗАЯВКИ')
    else
      Add('ЗАКРЫТЕ ЗАЯВКИ');
  end;
end;

procedure TAllOrderSearch.PrepareDsets;
var
  SelSQL, CountSQL: string;
begin
  SelSQL :=
    ' select id, DateComing, IsClosed, '+
    ' (select FullOrderNum from get_fullordernum(o.OrderNumber, o.fk_orders_district)) FullOrderNum,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
    ' (select adres from get_adres2(o.fk_orders_streets, o.housenum,'+
    '     o.housingnum, o.PorchNum, o.floornum, o.apartmentnum)) adres, 1 MainGr'+
    ' from orders o '+
    (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition+
    ' order by IsClosed, DateComing';

  CountSQL:='select count(id) RecordCount from orders '+
            (F_OptionForm as Tfrm_PeriodRegDmgSel).ResultCondition;

  AddSelSQLToDset(F_Dset[0], SelSQL);
  AddSelSQLToDset(F_RecordCountDset, CountSQL);
end;

procedure TAllOrderSearch.PrepareFastReport;
var i,j:integer; 
begin
  with (F_OptionForm as Tfrm_PeriodRegDmgSel) do
  begin
    frVariables['Caption']:=DateCaption(strStartDate, strFinishedDate);
    frVariables['Regions']:='Районы: '+StrRegions;
//    frVariables['DamagePlace']:='Места повреждения: '+strDamagePlace;
  end;
   TRmem.Close;
  TRmem.Open;
    if not F_Dset[0].Active then F_Dset[0].Open;
    F_Dset[0].First;

    while  not F_Dset[0].Eof do begin
     TRmem.Append;
     for j:=0 to  F_Dset[0].FieldCount-1 do
        TRmem.FieldByName( F_Dset[0].Fields[j].FieldName).Value:=F_Dset[0].Fields[j].AsString;
     TRmem.Post;
     F_Dset[0].Next;
    end;
end;

procedure TAllOrderSearch.PrepareResultFormBtns;
begin
  with (F_ResultForm as Tfrm_AnalysisView) do
  begin
    btn_Order.OnClick:=OrderBtnClick;
    btn_Print.OnClick:=PrintBtnClick;
    //btn_Excel.OnClick:=ExcelBtnClick;
  end;
end;

procedure TAllOrderSearch.PrepareResultFormGrid;
var
  group: TGroup;
begin
  F_GridViewBuilder.Free;
  F_GridViewBuilder:=TGridViewBuilder.Create(F_Dset[0],
                (F_ResultForm as Tfrm_AnalysisView).Grid);

  F_GridViewBuilder.IDFieldName:='ID';

  AddColToGVB(F_GridViewBuilder, 'DateComing', 'Дата и время'+#13+'поступления', alCenter);
  AddColToGVB(F_GridViewBuilder, 'FullOrderNum', '№'+#13+'наряда', alCenter);
  AddColToGVB(F_GridViewBuilder, 'Regions', 'Район', alLeft);
  AddColToGVB(F_GridViewBuilder, 'Adres', 'Адрес', alLeft);

  group:=F_GridViewBuilder.AddGroup('MainGr');
  group.GroupHeader.Visible:=false;
  group.GroupFooter.Visible:=false;
  group.IsNumberRecordInGroup:=true;

  group:=F_GridViewBuilder.AddGroup('IsClosed');
  group.GroupHeader.Visible:=true;
  group.GroupHeader.OnShowCaption:=IsClosedGroupHeaderCaption;
  group.GroupHeader.Font.Style:=[fsBold];
  group.GroupHeader.Alignment:=alCenter;
  group.GroupFooter.Visible:=false;
  group.GroupHeader.Color:=clAqua;
  group.IsNumberRecordInGroup:=true;
end;

procedure TAllOrderSearch.PrepareResultFormHeader;
begin
  with (F_OptionForm as Tfrm_PeriodRegDmgSel),
        (F_ResultForm as Tfrm_AnalysisView) do
  begin
    CenterLabel:=DateCaption(strStartDate, strFinishedDate);
//    LeftLabel:='Районы: '+StrRegions+#13+
//                'Места повреждения: '+strDamagePlace;
  end;
end;

end.
