unit ExcelWorksForm;

interface

uses DBGrids, DB, windows, ComObj, Grids, Messages, Variants, sysUtils,
      DBGridEh;

  type TMargins = record
    nTop:integer;
    nLeft:integer;
    nBottom:integer;
    nRight:integer;
  end;


type TExcelWorks = class(TObject)
private
  xlApp:Variant;
  m_strWBTitle:AnsiSTring;
  m_strWSName:AnsiSTring;
  m_strTitle:AnsiSTring;
  m_margins:TMargins;
  m_colormargins:TMargins;

  procedure InitMembers();
public
  constructor Create();
  destructor Destroy();override;

  procedure MapStringGrid(grid:TSTringGrid);
  //А вот не сходятся они к одному дб-шному предку и все тут..
  procedure MapDBGrid(grid:TDBGRid); overload;
  procedure MapDBGrid(grid:TDBGRidEh); overload;

  procedure MapDBGrid2(grid: TDBGrid); 

  procedure Close();

  procedure SetWBTitle(str:AnsiSTring);
  procedure  SetWSName(str:AnsiSTring);
  procedure  SetTitle(str:AnsiSTring);
  procedure SetMargins(top, left, bottom, right:integer);
  procedure SetColorMargins(top, left, bottom, right:integer);
end;

implementation

uses XLConst, HelpFunctions;

constructor TExcelWorks.Create();
begin
  InitMembers();
  xlApp := UnAssigned;
  inherited Create();
end;

destructor TExcelWorks.Destroy();
begin
//  close();
  inherited Destroy();
end;

procedure TExcelWorks.MapStringGrid(grid:TSTringGrid);
var xlSheet, xlRange:Variant;
    rows, cols, skippedcols:integer;
    nTopRow:integer;
    i,j:integer;
    let, let1:AnsiString;
begin
  Close();
  xlApp := CreateOleObject('Excel.Application');

  xlApp.Visible := true;
  xlApp.Workbooks.Add(xlWBatWorkSheet);
  xlApp.Workbooks[1].Title := m_strWBTitle;
  xlApp.Workbooks[1].Worksheets[1].name := m_strWSName;
  xlSheet := xlApp.Workbooks[1].Worksheets[m_strWSName];

  rows := grid.RowCount;
  cols := grid.ColCount;
  nToprow := 2;

  skippedcols := 0;
  for j:= 0 to cols - 1 do
  begin
    if (grid.ColWidths[j] < 3) then
    begin
      skippedcols := skippedcols + 1;
      continue;
    end;

    for i:= 0 to rows - 1 do
    begin
      XLSheet.Cells[i + 1 + nToprow, j + 1 - skippedcols] := Multiline2ClearSTring(grid.Cells[j, i]);
    end;
  end;

  cols := cols - skippedcols;

  let := chr(ord('A') + cols - 1);
  if let > 'Z' then
  begin
    let := 'A' + chr(ord('A') + cols mod 27);
  end;


  xlSheet.Range['A1:' + let + '1'].Merge;
  xlSheet.Cells[1,1] :=m_strTitle;
  xlSheet.Cells[1,1].HorizontalAlignment := xlCenter;


  xlRange := xlSheet.Range['A' + IntToStr(nTopRow + 1) + ':' + let + IntToStr(rows + nTopRow )];
  xlRange.Borders[xlEdgeTop].LineStyle := xlContinious;
  xlRange.Borders[xlEdgeTop].Weight := xlThick;
  xlRange.Borders[xlEdgeBottom].LineStyle := xlContinious;
  xlRange.Borders[xlEdgeBottom].Weight := xlThick;
  xlRange.Borders[xlEdgeLeft].LineStyle := xlContinious;
  xlRange.Borders[xlEdgeLeft].Weight := xlThick;
  xlRange.Borders[xlEdgeRight].LineStyle := xlContinious;
  xlRange.Borders[xlEdgeRight].Weight := xlThick;
  xlRange.Columns.Autofit;


  let1 := chr(ord('A') + cols - m_margins.nRight);
  if let1 > 'Z' then
  begin
    let1 := 'A' + chr(ord('A') + cols mod 27);
  end;


  if (m_margins.nTop <> 0) then
    xlSheet.Range['A' +IntToStr(nTopRow + 1 )+ ':'+ let +
                                    IntToStr(nTopRow + 1 + (m_margins.nTop - 1))].Borders[xlEdgeBottom].LineStyle := xlDouble;

  if (m_margins.nBottom <> 0) then
  begin
    xlRange := xlSheet.Range['A' + IntToStr(rows + nTopRow - (m_margins.nBottom - 1)) + ':' + let +
                                                        IntToStr(rows + nTopRow )];
    xlRange.Borders[xlEdgeRight].LineStyle := xlContinious;
    xlRange.Borders[xlEdgeTop].Weight := xlThin;
  end;

  if (m_margins.nLeft <> 0) then
  begin
    xlRange :=xlSheet.Range['A' +IntToStr(nTopRow  + 1)+ ':'+ chr(ord('A') + (m_margins.nLeft - 1)) +
                                    IntToStr(rows + nTopRow)];
    xlRange.Borders[xlEdgeRight].LineStyle := xlContinious;
    xlRange.Borders[xlEdgeRight].LineStyle := xlContinious;
  end;

  if (m_margins.nRight <> 0) then
  begin
    xlRange := xlSheet.Range[let1 + IntToStr(nTopRow  + 1)+ ':'+ let +
                                    IntToStr(rows + nTopRow)];
    xlRange.Borders[xlEdgeLeft].LineStyle := xlContinious;
    xlRange.Borders[xlEdgeLEft].LineStyle := xlContinious;
  end;

  let1 := chr(ord('A') + cols - m_colormargins.nRight);
  if let1 > 'Z' then
  begin
    let1 := 'A' + chr(ord('A') + cols mod 27);
  end;



  if (m_colormargins.nTop <> 0) then
    xlSheet.Range['A' +IntToStr(nTopRow + 1 + m_colormargins.nTop - 1)+ ':'+ let +
                                    IntToStr(nTopRow + 1)].Interior.color := $0000FFFF;

  if (m_colormargins.nBottom <> 0) then
    xlSheet.Range['A' + IntToStr(rows + nTopRow - m_colormargins.nBottom + 1) + ':' + let +
                                                        IntToStr(rows + nTopRow )].Interior.color := $0000FFFF;

  if (m_colormargins.nLeft <> 0) then
    xlSheet.Range['A' +IntToStr(nTopRow  + 1)+ ':'+ chr(ord('A') + (m_colormargins.nLeft - 1)) +
                                    IntToStr(rows + nTopRow)].Interior.color := $0000FFFF;

  if (m_colormargins.nRight <> 0) then
    xlSheet.Range[ let1 +IntToStr(nTopRow  + 1)+ ':'+ let +
                                    IntToStr(rows + nTopRow)].Interior.color := $0000FFFF;

  InitMembers();
end;


procedure TExcelWorks.MapDBGrid(grid:TDBGRid);
var xlSheet, xlRange:Variant;
    rows, cols, skippedcols:integer;
    nTopRow:integer;
    i,j, n:integer;
    ds:TDataSet;
    let, let1:AnsiString;
begin
  Close();
  xlApp := CreateOleObject('Excel.Application');

  xlApp.Visible := true;
  xlApp.Workbooks.Add(xlWBatWorkSheet);
  xlApp.Workbooks[1].Title := m_strWBTitle;
  xlApp.Workbooks[1].Worksheets[1].name := m_strWSName;
  xlSheet := xlApp.Workbooks[1].Worksheets[m_strWSName];


  ds := grid.DataSource.DataSet;
  rows := ds.RecordCount;
  cols := ds.FieldCount;
  nToprow := 3;

  ds.First();
  n:= 0;
  for i := 0 to cols - 1 do
  begin
      if (grid.Columns[i].Width > 3) and (grid.Columns[i].Visible) then
      begin
        XLSheet.Cells[ nTopRow , n + 1] := grid.Columns[i].Title.Caption;
        n:= n + 1;
      end;
  end;

  skippedcols := cols - n;

  for i:= 0 to rows - 1 do
  begin
    n := 0;
    for j:= 0 to cols - 1 do
    begin
      if (grid.Columns[j].Width > 3) and (grid.Columns[j].Visible) then
      begin
        XLSheet.Cells[i + 1 + nTopRow, n + 1] := ds.Fields[j].AsString;
        n := n + 1;
      end;
    end;
    ds.Next();
  end;

  let :=   chr(ord('A') + cols - skippedcols - 1);
  if let > 'Z' then
  begin
    let := 'A' + chr(ord('A') + ((cols - skippedcols) mod 27));
  end;


  xlSheet.Range['A1:' + let + '1'].Merge;
  xlSheet.Cells[1,1] :=m_strTitle;
  xlSheet.Cells[1,1].HorizontalAlignment := xlCenter;
  xlSheet.Cells[1,1].Interior.Color := $0000FFFF;



  xlRange := xlSheet.Range['A' + IntToStr(nTopRow) + ':' +
          let + IntTostr(rows + nTopRow)];

//  xlRange := xlSheet.Range['A' + IntToStr(nTopRow + 1) + ':' + chr(ord('A') + cols - 1) + IntToStr(rows + nTopRow )];
  xlRange.Borders[xlEdgeTop].LineStyle := xlContinious;
  xlRange.Borders[xlEdgeTop].Weight := xlThick;
  xlRange.Borders[xlEdgeBottom].LineStyle := xlContinious;
  xlRange.Borders[xlEdgeBottom].Weight := xlThick;
  xlRange.Borders[xlEdgeLeft].LineStyle := xlContinious;
  xlRange.Borders[xlEdgeLeft].Weight := xlThick;
  xlRange.Borders[xlEdgeRight].LineStyle := xlContinious;
  xlRange.Borders[xlEdgeRight].Weight := xlThick;
  xlRange.Columns.Autofit;

  let1 := chr(ord('A') + cols - m_margins.nRight);
  if let1 > 'Z' then
  begin
    let1 := 'A' + chr(ord('A') + cols mod 27);
  end;


  if (m_margins.nTop <> 0) then
    xlSheet.Range['A' +IntToStr(nTopRow )+ ':'+ let +
                                    IntToStr(nTopRow + (m_margins.nTop - 1))].Borders[xlEdgeBottom].LineStyle := xlDouble;

  if (m_margins.nBottom <> 0) then
  begin
    xlRange := xlSheet.Range['A' + IntToStr(rows + nTopRow - (m_margins.nBottom - 1)) + ':' + let +
                                                        IntToStr(rows + nTopRow )];
    xlRange.Borders[xlEdgeRight].LineStyle := xlContinious;
    xlRange.Borders[xlEdgeTop].Weight := xlThin;
  end;

  if (m_margins.nLeft <> 0) then
  begin
    xlRange :=xlSheet.Range['A' +IntToStr(nTopRow  )+ ':'+ chr(ord('A') + (m_margins.nLeft - 1)) +
                                    IntToStr(rows + nTopRow)];
    xlRange.Borders[xlEdgeRight].LineStyle := xlContinious;
    xlRange.Borders[xlEdgeRight].LineStyle := xlContinious;
  end;

  if (m_margins.nRight <> 0) then
  begin
    xlRange := xlSheet.Range[let1 + IntToStr(nTopRow  + 1)+ ':'+ let +
                                    IntToStr(rows + nTopRow)];
    xlRange.Borders[xlEdgeLeft].LineStyle := xlContinious;
    xlRange.Borders[xlEdgeLEft].LineStyle := xlContinious;
  end;

  let1 := chr(ord('A') + cols - m_colormargins.nRight);
  if let1 > 'Z' then
  begin
    let1 := 'A' + chr(ord('A') + cols mod 27);
  end;



  if (m_colormargins.nTop <> 0) then
    xlSheet.Range['A' +IntToStr(nTopRow + 1 + m_colormargins.nTop - 1)+ ':'+ let +
                                    IntToStr(nTopRow + 1)].Interior.color := $0000FFFF;

  if (m_colormargins.nBottom <> 0) then
    xlSheet.Range['A' + IntToStr(rows + nTopRow - m_colormargins.nBottom + 1) + ':' + let +
                                                        IntToStr(rows + nTopRow )].Interior.color := $0000FFFF;

  if (m_colormargins.nLeft <> 0) then
    xlSheet.Range['A' +IntToStr(nTopRow  + 1)+ ':'+ chr(ord('A') + (m_colormargins.nLeft - 1)) +
                                    IntToStr(rows + nTopRow)].Interior.color := $0000FFFF;

  if (m_colormargins.nRight <> 0) then
    xlSheet.Range[ let1 +IntToStr(nTopRow  + 1)+ ':'+ let +
                                    IntToStr(rows + nTopRow)].Interior.color := $0000FFFF;

  InitMembers();
end;


procedure TExcelWorks.MapDBGrid(grid:TDBGRidEh);
var xlSheet, xlRange:Variant;
    rows, cols, skippedcols:integer;
    nTopRow:integer;
    i,j, n:integer;
    ds:TDataSet;
    let, let1:AnsiString;
begin
  Close();
  xlApp := CreateOleObject('Excel.Application');

  xlApp.Visible := true;
  xlApp.Workbooks.Add(xlWBatWorkSheet);
  xlApp.Workbooks[1].Title := m_strWBTitle;
  xlApp.Workbooks[1].Worksheets[1].name := m_strWSName;
  xlSheet := xlApp.Workbooks[1].Worksheets[m_strWSName];


  ds := grid.DataSource.DataSet;
  rows := ds.RecordCount;
  cols := ds.FieldCount;
  nToprow := 3;

  ds.First();
  n:= 0;
  for i := 0 to cols - 1 do
  begin
      if (grid.Columns[i].Width > 3) and (grid.Columns[i].Visible) then
      begin
        XLSheet.Cells[ nTopRow , n + 1] := grid.Columns[i].Title.Caption;
        n:= n + 1;
      end;
  end;

  skippedcols := cols - n;

  for i:= 0 to rows - 1 do
  begin
    n := 0;
    for j:= 0 to cols - 1 do
    begin
      if (grid.Columns[j].Width > 3) and (grid.Columns[j].Visible) then
      begin
        XLSheet.Cells[i + 1 + nTopRow, n + 1] := ds.Fields[j].AsString;
        n := n + 1;
      end;
    end;
    ds.Next();
  end;

  let := chr(ord('A') + cols - skippedcols - 1);
  if let > 'Z' then
  begin
    let := 'A' + chr(ord('A') + ((cols - skippedcols) mod 27));
  end;


  xlSheet.Range['A1:' + let + '1'].Merge;
  xlSheet.Cells[1,1] :=m_strTitle;
  xlSheet.Cells[1,1].HorizontalAlignment := xlCenter;
  xlSheet.Cells[1,1].Interior.Color := $0000FFFF;



  xlRange := xlSheet.Range['A' + IntToStr(nTopRow) + ':' +
          let + IntTostr(rows + nTopRow)];

//  xlRange := xlSheet.Range['A' + IntToStr(nTopRow + 1) + ':' + chr(ord('A') + cols - 1) + IntToStr(rows + nTopRow )];
  xlRange.Borders[xlEdgeTop].LineStyle := xlContinious;
  xlRange.Borders[xlEdgeTop].Weight := xlThick;
  xlRange.Borders[xlEdgeBottom].LineStyle := xlContinious;
  xlRange.Borders[xlEdgeBottom].Weight := xlThick;
  xlRange.Borders[xlEdgeLeft].LineStyle := xlContinious;
  xlRange.Borders[xlEdgeLeft].Weight := xlThick;
  xlRange.Borders[xlEdgeRight].LineStyle := xlContinious;
  xlRange.Borders[xlEdgeRight].Weight := xlThick;
  xlRange.Columns.Autofit;

  let1 := chr(ord('A') + cols - m_margins.nRight);
  if let1 > 'Z' then
  begin
    let1 := 'A' + chr(ord('A') + cols mod 27);
  end;


  if (m_margins.nTop <> 0) then
    xlSheet.Range['A' +IntToStr(nTopRow )+ ':'+ let +
                                    IntToStr(nTopRow + (m_margins.nTop - 1))].Borders[xlEdgeBottom].LineStyle := xlDouble;

  if (m_margins.nBottom <> 0) then
  begin
    xlRange := xlSheet.Range['A' + IntToStr(rows + nTopRow - (m_margins.nBottom - 1)) + ':' + let +
                                                        IntToStr(rows + nTopRow )];
    xlRange.Borders[xlEdgeRight].LineStyle := xlContinious;
    xlRange.Borders[xlEdgeTop].Weight := xlThin;
  end;

  if (m_margins.nLeft <> 0) then
  begin
    xlRange :=xlSheet.Range['A' +IntToStr(nTopRow  )+ ':'+ chr(ord('A') + (m_margins.nLeft - 1)) +
                                    IntToStr(rows + nTopRow)];
    xlRange.Borders[xlEdgeRight].LineStyle := xlContinious;
    xlRange.Borders[xlEdgeRight].LineStyle := xlContinious;
  end;

  if (m_margins.nRight <> 0) then
  begin
    xlRange := xlSheet.Range[let1 + IntToStr(nTopRow  + 1)+ ':'+ let +
                                    IntToStr(rows + nTopRow)];
    xlRange.Borders[xlEdgeLeft].LineStyle := xlContinious;
    xlRange.Borders[xlEdgeLEft].LineStyle := xlContinious;
  end;

  let1 := chr(ord('A') + cols - m_colormargins.nRight);
  if let1 > 'Z' then
  begin
    let1 := 'A' + chr(ord('A') + cols mod 27);
  end;



  if (m_colormargins.nTop <> 0) then
    xlSheet.Range['A' +IntToStr(nTopRow + 1 + m_colormargins.nTop - 1)+ ':'+ let +
                                    IntToStr(nTopRow + 1)].Interior.color := $0000FFFF;

  if (m_colormargins.nBottom <> 0) then
    xlSheet.Range['A' + IntToStr(rows + nTopRow - m_colormargins.nBottom + 1) + ':' + let +
                                                        IntToStr(rows + nTopRow )].Interior.color := $0000FFFF;

  if (m_colormargins.nLeft <> 0) then
    xlSheet.Range['A' +IntToStr(nTopRow  + 1)+ ':'+ chr(ord('A') + (m_colormargins.nLeft - 1)) +
                                    IntToStr(rows + nTopRow)].Interior.color := $0000FFFF;

  if (m_colormargins.nRight <> 0) then
    xlSheet.Range[ let1 +IntToStr(nTopRow  + 1)+ ':'+ let +
                                    IntToStr(rows + nTopRow)].Interior.color := $0000FFFF;

  InitMembers();
end;

procedure TExcelWorks.Close();
begin
  if not VarIsEmpty(xlAPP) then
  begin
    xlApp.DisplayAlerts := false;
    xlApp.Quit;
    xlApp := UnAssigned;
  end;
end;

procedure TExcelWorks.InitMembers();
begin
  m_strWBTitle := '';
  m_strWSName  := '';
  m_strTitle  := '';
  m_margins.nTop := 0;
  m_margins.nRight := 0;
  m_margins.nLeft := 0;
  m_margins.nBottom := 0;
  m_colormargins.nTop := 0;
  m_colormargins.nRight := 0;
  m_colormargins.nLeft := 0;
  m_colormargins.nBottom := 0;

end;

procedure TExcelWorks.SetWBTitle(str:AnsiSTring);
begin
  m_strWBTitle := str;
end;
procedure  TExcelWorks.SetWSName(str:AnsiSTring);
begin
  m_strWSName := str;
end;

procedure  TExcelWorks.SetTitle(str:AnsiSTring);
begin
  m_strTitle := str;
end;

procedure TExcelWorks.SetMargins(top, left, bottom, right:integer);
begin
  m_margins.nTop := top;
  m_margins.nleft := left;
  m_margins.nBottom := bottom;
  m_margins.nRight := right;
end;

procedure TExcelWorks.SetColorMargins(top, left, bottom, right:integer);
begin
  m_colormargins.nTop := top;
  m_colormargins.nleft := left;
  m_colormargins.nBottom := bottom;
  m_colormargins.nRight := right;
end;

procedure TExcelWorks.MapDBGrid2(grid: TDBGrid);
var xlSheet, xlRange:Variant;
    rows, cols:integer;
    nTopRow:integer;
    i,j, n:integer;
    ds:TDataSet;
    let, let1:AnsiString;
    Bookmark: string;
begin
  Close();
  xlApp := CreateOleObject('Excel.Application');

  xlApp.Visible := true;
  xlApp.Workbooks.Add(xlWBatWorkSheet);
  xlApp.Workbooks[1].Title := m_strWBTitle;
  xlApp.Workbooks[1].Worksheets[1].name := m_strWSName;
  xlSheet := xlApp.Workbooks[1].Worksheets[m_strWSName];


  ds := grid.DataSource.DataSet;
  cols := grid.Columns.Count;
  nToprow := 3;

  for i := 0 to cols - 1 do
    XLSheet.Cells[ nTopRow , i + 1] := grid.Columns[i].Title.Caption;

  ds.DisableControls;
  Bookmark:=ds.Bookmark;
  ds.First;
  rows:=0;
  while not ds.Eof do
  begin
    for j:=0 to cols-1 do
      XLSheet.Cells[rows+1+nTopRow, j+1]:=grid.Fields[j].AsString;
    inc(rows);
    ds.Next;
  end;
  ds.Bookmark:=Bookmark;
  ds.EnableControls;

  if trim(AnsiUpperCase(grid.Fields[0].FieldName))='ROWNUM' then
    for i:=1 to rows do
      XLSheet.Cells[i+nTopRow, 1]:=i;

  let :=   chr(ord('A') + cols  - 1);
  if let > 'Z' then
  begin
    let := 'A' + chr(ord('A') + (cols mod 27));
  end;


  xlSheet.Range['A1:' + let + '1'].Merge;
  xlSheet.Cells[1,1] :=m_strTitle;
  xlSheet.Cells[1,1].HorizontalAlignment := xlCenter;
  xlSheet.Cells[1,1].Interior.Color := $0000FFFF;



  xlRange := xlSheet.Range['A' + IntToStr(nTopRow) + ':' +
          let + IntTostr(rows + nTopRow)];

//  xlRange := xlSheet.Range['A' + IntToStr(nTopRow + 1) + ':' + chr(ord('A') + cols - 1) + IntToStr(rows + nTopRow )];
  xlRange.Borders[xlEdgeTop].LineStyle := xlContinious;
  xlRange.Borders[xlEdgeTop].Weight := xlThick;
  xlRange.Borders[xlEdgeBottom].LineStyle := xlContinious;
  xlRange.Borders[xlEdgeBottom].Weight := xlThick;
  xlRange.Borders[xlEdgeLeft].LineStyle := xlContinious;
  xlRange.Borders[xlEdgeLeft].Weight := xlThick;
  xlRange.Borders[xlEdgeRight].LineStyle := xlContinious;
  xlRange.Borders[xlEdgeRight].Weight := xlThick;
  xlRange.Columns.Autofit;

  let1 := chr(ord('A') + cols - m_margins.nRight);
  if let1 > 'Z' then
  begin
    let1 := 'A' + chr(ord('A') + cols mod 27);
  end;


  if (m_margins.nTop <> 0) then
    xlSheet.Range['A' +IntToStr(nTopRow )+ ':'+ let +
                                    IntToStr(nTopRow + (m_margins.nTop - 1))].Borders[xlEdgeBottom].LineStyle := xlDouble;

  if (m_margins.nBottom <> 0) then
  begin
    xlRange := xlSheet.Range['A' + IntToStr(rows + nTopRow - (m_margins.nBottom - 1)) + ':' + let +
                                                        IntToStr(rows + nTopRow )];
    xlRange.Borders[xlEdgeRight].LineStyle := xlContinious;
    xlRange.Borders[xlEdgeTop].Weight := xlThin;
  end;

  if (m_margins.nLeft <> 0) then
  begin
    xlRange :=xlSheet.Range['A' +IntToStr(nTopRow  )+ ':'+ chr(ord('A') + (m_margins.nLeft - 1)) +
                                    IntToStr(rows + nTopRow)];
    xlRange.Borders[xlEdgeRight].LineStyle := xlContinious;
    xlRange.Borders[xlEdgeRight].LineStyle := xlContinious;
  end;

  if (m_margins.nRight <> 0) then
  begin
    xlRange := xlSheet.Range[let1 + IntToStr(nTopRow  + 1)+ ':'+ let +
                                    IntToStr(rows + nTopRow)];
    xlRange.Borders[xlEdgeLeft].LineStyle := xlContinious;
    xlRange.Borders[xlEdgeLEft].LineStyle := xlContinious;
  end;

  let1 := chr(ord('A') + cols - m_colormargins.nRight);
  if let1 > 'Z' then
  begin
    let1 := 'A' + chr(ord('A') + cols mod 27);
  end;



  if (m_colormargins.nTop <> 0) then
    xlSheet.Range['A' +IntToStr(nTopRow + 1 + m_colormargins.nTop - 1)+ ':'+ let +
                                    IntToStr(nTopRow + 1)].Interior.color := $0000FFFF;

  if (m_colormargins.nBottom <> 0) then
    xlSheet.Range['A' + IntToStr(rows + nTopRow - m_colormargins.nBottom + 1) + ':' + let +
                                                        IntToStr(rows + nTopRow )].Interior.color := $0000FFFF;

  if (m_colormargins.nLeft <> 0) then
    xlSheet.Range['A' +IntToStr(nTopRow  + 1)+ ':'+ chr(ord('A') + (m_colormargins.nLeft - 1)) +
                                    IntToStr(rows + nTopRow)].Interior.color := $0000FFFF;

  if (m_colormargins.nRight <> 0) then
    xlSheet.Range[ let1 +IntToStr(nTopRow  + 1)+ ':'+ let +
                                    IntToStr(rows + nTopRow)].Interior.color := $0000FFFF;

  InitMembers();
end;

end.

