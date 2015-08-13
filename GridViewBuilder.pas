unit GridViewBuilder;

interface

uses SysUtils, Classes, DB, Grids, Aligrid, Graphics,
      DataSetTree, Variants, Controls, Types;


const
  ID_FIELD_COL_NUMBER = 0;
  HELP_ID_FIELD_COL_NUMBER = 1;
  ROWINFORMER_COL_NUMBER = 2;
  CHECKBOX_FIELD_VALUE = 'ch';
  CHECKBOX_COLOR: TColor = clBlack;

type
  TGBColumn=class;
  TGroup=class;

  TGBColumnTitle=class
  private
    F_Caption: string;
    F_Font: TFont;
    F_Column: TGBColumn;
    F_Alignment: TMyAlign;
    function DefaultFont: TFont;
  public
    property Caption: string read F_Caption write F_Caption;
    property Font: TFont read F_Font write F_Font;
    property Alignment: TMyAlign read F_Alignment write F_Alignment;
    constructor Create(AColumn: TGBColumn);
    destructor Destroy; override;
  end;

  TShowColumnCellEvent=procedure(ShowValue: variant; var Res: string) of object;
  TColumnType=(ctMaster, ctDetail);

  TGBColumn=class
  private
    F_Grid: TStringAlignGrid;
    F_FieldName: string;
    F_ColumnTitle: TGBColumnTitle;
    F_OnShowColumnCell: TShowColumnCellEvent;
    F_Alignment: TMyAlign;
    F_DisplayWidth: integer;
    F_ColumnType: TColumnType;
    function GetGrid: TStringAlignGrid;
  public
    property Alignment: TMyAlign read F_Alignment write F_Alignment;
    property FieldName: string read F_FieldName write F_FieldName;
    property ColumnTitle: TGBColumnTitle read F_ColumnTitle write F_ColumnTitle;
    property OnShowColumnCell: TShowColumnCellEvent
              read F_OnShowColumnCell write F_OnShowColumnCell;
    property DisplayWidth: integer read F_DisplayWidth write F_DisplayWidth;
    property ColumnType: TColumnType read F_ColumnType write F_ColumnType;
    constructor Create(AGrid: TStringAlignGrid);
    destructor Destroy; override;
  end;

//////////////////////////////////////////////////////////
  TShowGroupBorderCaptionEvent=procedure(DataSet: TDataSet;
        AggregateValueArr: array of double; var OutRow: TStringList) of object;

  TGroupBorder=class
  protected
    F_Grid: TStringAlignGrid;
    F_Color: TColor;
    F_Font: TFont;
    F_Alignment: TMyAlign;
    F_Visible: boolean;
    F_OnShowCaption: TShowGroupBorderCaptionEvent;
  public
    property Font: TFont read F_Font write F_Font;
    property Alignment: TMyAlign read F_Alignment write F_Alignment;
    property Color: TColor read F_Color write F_Color;
    property Visible: boolean read F_Visible write F_Visible;
    property OnShowCaption: TShowGroupBorderCaptionEvent read F_OnShowCaption
                                    write F_OnShowCaption;
    constructor Create(AGrid: TStringAlignGrid);
    destructor Destroy; override;
  end;

  TGroupHeader=class(TGroupBorder);
  TGroupFooter=class(TGroupBorder);


  TAggrigateType=(atSum, atAvg, atCount, atMin, atMax);

  TAggregateField=class
  private
    F_Node: TTreeNode;
    F_AggrigateType: TAggrigateType;
    F_AggFieldName: string;
  private
    function Sum: double;
    function Count: integer;
    function Avg: double;
    function Min: double;
    function Max: double;
  public
    property AggrigateType: TAggrigateType read F_AggrigateType;
    property AggFieldName: string read F_AggFieldName;
    function CalcAggValueForNode(node: TTreeNode): double;
    constructor Create(AAggType: TAggrigateType; AAggFieldName: string);
  end;


  TGroup=class
  private
    F_Grid: TStringAlignGrid;
    F_GroupField: string;
    F_GroupHeader: TGroupHeader;
    F_GroupFooter: TGroupFooter;
    F_IsNumberRecordInGroup: boolean;  //нумеровать или нет строки в группе
    F_RowNumberInGroup: integer; //номер строки в группе, используется при нумерации строк в группе
    F_AggregateFieldList: TList;
    function GetGrid: TStringAlignGrid;
  public
    property GroupHeader: TGroupHeader read F_GroupHeader;
    property GroupFooter: TGroupFooter read F_GroupFooter;
    property IsNumberRecordInGroup: boolean read F_IsNumberRecordInGroup
                                  write F_IsNumberRecordInGroup;
    procedure AddAggregateField(AAggType: TAggrigateType; AAggFieldName: string);
    constructor Create(AGrid: TStringAlignGrid; AGroupField: string);
    destructor Destroy; override;
  end;

  TLoadRecordCountEvent=procedure(LoadRecCount: integer) of object;

  TRowInformer=class
  protected
    F_IsRowChecked: boolean;
    F_RecNumInDataSet: integer;
  public
    property IsRowChecked: boolean read F_IsRowChecked write F_IsRowChecked;
    property RecNumInDataSet: integer read F_RecNumInDataSet write F_RecNumInDataSet;
    constructor Create;
  end;

  TRowInformerClass=class of TRowInformer;

  TRowInformerList=class(TList)
  public
    procedure Clear; override;
  end;

  TFillRowInformerEvent=procedure ( DataSet: TDataSet; var RowInformer: TRowInformer ) of object;

  TGridViewBuilder=class
  private
    F_Dset: TDataSet;
    F_DetailDset: TDataSet;
    F_Grid: TStringAlignGrid;
    F_ColumnList: TList;
    F_GroupList: TList;
    F_OnLoadRecordCount: TLoadRecordCountEvent;
    F_OnFillRowInformer: TFillRowInformerEvent;
    F_RowInformerList: TRowInformerList;
    F_RowInformerClass: TRowInformerClass;

    F_RowSelect: boolean;
    F_SelFieldNum: integer;
    F_SelFieldVal: string;
    F_SelFieldIsBold: boolean;
    F_SelFieldColor: TColor;

    function GetColumn(Index: integer): TGBColumn;
    function GetGroup(Index: integer): TGroup;
  private
    OldAfterScroll: TDataSetNotifyEvent;
    OldGridDrawCell: TDrawCellEvent;
    OldGridMouseDown: TMouseEvent;
    procedure NewAfterScroll(DataSet: TDataSet);
    procedure NewGridDrawCell(Sender: TObject; ACol, ARow: Longint;
      Rect: TRect; State: TGridDrawState);
    procedure NewGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    F_NotDataColCount: integer;
    F_IsNumberRecord: boolean;
    F_IsGridEmpty: boolean;
    F_IsShowCheckBoxes: boolean;
    F_IDFieldName: string;
    F_HelpIDFieldName: string;
//    F_IsAdjustColWidths: boolean;
    procedure ResetGrid;
    procedure DefineGridHeader;
    procedure BuildViewWithGroup;
    procedure BuildViewWithoutGroup;
  private
    function GetMaxRowInGridHeader: integer;
    procedure InsertAddInfoInGrid(Col: integer; MemoryAdres: Pointer);
    procedure InsertIDFieldValue(IDValue: integer); //вставляет в 1-ую ячейку последней (на текущий момент) строки
    procedure InsertHelpIDFieldValue(HelpIDValue: integer);
    function GroupIndex(node: TTreeNode): integer;
    procedure InsertGroupAndSubgroup(node: TTreeNode);
    procedure InsertGroupHeader(node: TTreeNode);
    procedure InsertGroupFooter(node: TTreeNode);
    procedure InsertGroupRows(node: TTreeNode);
    procedure InsertNumbersInRow(FatherNode: TTreeNode; SrcRow: TStringList);
    procedure IssueRowCells; //оформляет ячейки в последней стороке
    function GetCellValue(column:TGBColumn; value: variant): string;
    procedure InsertAndFillNewRowInformer(DataSet: TDataSet);
  public
  { это для выделения нужных строк красивостями}
    property SelFieldNum: integer write F_SelFieldNum;
    property SelFieldVal: string write F_SelFieldVal;
    property SelFieldIsBold: boolean write F_SelFieldIsBold;
    property SelFieldColor: TColor write F_SelFieldColor;
    property RowSelect:boolean write F_RowSelect;
  {// это для выделения нужных строк красивостями}
    property IsNumberRecord: boolean read F_IsNumberRecord
                                      write F_IsNumberRecord;
    property IsShowCheckBoxes: boolean read F_IsShowCheckBoxes
                                       write F_IsShowCheckBoxes;
    property ColumnList[Index: integer]: TGBColumn read GetColumn;
    function ColumnCount: integer;
    function AddColumn: TGBColumn;

    property GroupList[index: integer]: TGroup read GetGroup;
    function GroupCount: integer;
    function AddGroup(AGroupField: string): TGroup;

    property OnLoadRecordCount: TLoadRecordCountEvent read F_OnLoadRecordCount
                                write F_OnLoadRecordCount;
    property OnFillRowInformer: TFillRowInformerEvent read F_OnFillRowInformer
                                write F_OnFillRowInformer;
    property IDFieldName: string read F_IDFieldName write F_IDFIeldName;
    property HelpIDFieldName: string read F_HelpIDFieldName write F_HelpIDFieldName;
    procedure SetRowInformerList( ARowInformerList: TRowInformerList;
      AClassRef: TRowInformerClass);
    procedure BuildGridView;
    constructor Create(ADset: TDataSet; AGrid: TStringAlignGrid); overload;
    constructor Create(ADset, ADetailDset: TDataSet; AGrid: TStringAlignGrid); overload;
    constructor Create(ADset: TDataSet; AGrid: TStringAlignGrid;
                       AFieldNum: integer; AFieldValue: string;
                        AIsBold: boolean; AFontColor: TColor); overload;
    destructor Destroy; override;
  end;


implementation

uses strtool;

function LineToMultiLine(const line: string; max_subline_width: integer): string;
var
  s: string;
  i: integer;
begin
  i:=0;
  Result:='';
  repeat
    inc(i);
    s:=ExtractLineFix(i, max_subline_width, line);
    if s<>'' then
      Result:=Result+#13#10+s;
  until s='';
  Delete(Result, 1, 2);
end;


{ TGridViewBuilder }

function TGridViewBuilder.AddColumn: TGBColumn;
begin
  Result:=TGBColumn.Create(F_Grid);
  F_ColumnList.Add(Result);
end;

function TGridViewBuilder.AddGroup(AGroupField: string): TGroup;
begin
  Result:=TGroup.Create(F_Grid, AGroupField);
  F_GroupList.Add(Result);
end;

procedure TGridViewBuilder.BuildGridView;
begin
  ResetGrid;
  DefineGridHeader;

  if F_GroupList.Count>0 then
    BuildViewWithGroup
  else
    BuildViewWithoutGroup;

  F_Grid.AdjustColWidths;
end;

procedure TGridViewBuilder.BuildViewWithGroup;
var
  group: TGroup;
  i: integer;
  DSTree: TDataSetTree;
begin
  DSTree:=TDataSetTree.Create(F_Dset);
  try
    {Строим дерево}
    for i:=0 to F_GroupList.Count-1 do
    begin
      group:=TGroup(F_GroupList.Items[i]);
      DSTree.AddCheckFieldName(group.F_GroupField);
    end;
    DSTree.BuildTree;
    {/Строим дерево}

    {Заносим данный в Grid}
    for i:=0 to DSTree.NodeCount-1 do
      if not Assigned(DStree.NodeList[i].FatherNode) then
        InsertGroupAndSubgroup(DStree.NodeList[i]);
    {/Заносим данный в Grid}
  finally
    DSTree.Free;
  end;
end;

procedure TGridViewBuilder.BuildViewWithoutGroup;
var
  i, NumColForRowNumber: integer;
  column: TGBColumn;
  CellValue: string;
begin
  with F_Grid do
  begin
    RowCount:=2;
    if not F_Dset.Active then F_Dset.Open;
    F_Dset.First;
    while not F_Dset.Eof do
    begin
      IssueRowCells;

      {Заполняем строку в рез. таблице}
      for i:=0 to F_ColumnList.Count-1 do
      begin
        column:=TGBColumn(F_ColumnList.Items[i]);
        if (column.ColumnType=ctDetail) and Assigned(F_DetailDset) then
        begin
          if not F_DetailDset.Active then F_DetailDset.Open;
          F_DetailDset.First;
          CellValue:=GetCellValue(column, F_DetailDset.FieldByName(column.FieldName).Value);
          F_DetailDset.Next;
        end else
          CellValue:=GetCellValue(column, F_Dset.FieldByName(column.FieldName).Value);

        Cells[F_NotDataColCount+i, RowCount-1]:=CellValue;
       {  здесь добавим выделение нужной нам строки}
         if F_RowSelect then
         begin
           if (i = F_SelFieldNum) and (trim(CellValue) = trim(F_SelFieldVal)) then
           begin
              //RowFont[RowCount-1].Color := F_SelFieldColor;
              ColorRow[RowCount-1] := F_SelFieldColor;
              if F_SelFieldIsBold then
                  RowFont[RowCount-1].Style := [fsBold];
           end;
         end;
        {/ здесь добавим выделение нужной нам строки}
      end;
      F_Grid.AdjustRowHeight(F_Grid.RowCount-1);
      {/Заполняем строку в рез. таблице}

      if trim(F_IDFieldName)<>'' then
        InsertIDFieldValue(F_Dset.FieldByName(F_IDFieldName).AsInteger);
      if trim(F_HelpIDFieldName)<>'' then
        InsertHelpIDFieldValue(F_Dset.FieldByName(F_HelpIDFieldName).AsInteger);

      InsertAndFillNewRowInformer( F_Dset );

      {Если нужно ставим номер строки}
      if F_IsNumberRecord then
      begin
        if F_IsShowCheckBoxes then
          NumColForRowNumber := 1
        else
          NumColForRowNumber := 0;

        Cells[NumColForRowNumber, RowCount-1]:=IntToStr(RowCount-1);
      end;
      {/Если нужно ставим номер строки}

      {Если нужно показывать чекбоксы, то вставляем еще один столбец в котором будем их рисовать}
      if F_IsShowCheckBoxes then
        Cells[0, RowCount-1] := CHECKBOX_FIELD_VALUE;
      {/Если нужно показывать чекбоксы, то вставляем еще один столбец в котором будем их рисовать}

      {Если нужно вставляем подстроки}
      if Assigned(F_DetailDset) then
      begin
        while not F_DetailDset.Eof do
        begin
          RowCount:=RowCount+1;
          for i:=0 to F_ColumnList.Count-1 do
          begin
            column:=TGBColumn(F_ColumnList.Items[i]);
            if column.ColumnType=ctDetail then
              CellValue:=GetCellValue(column, F_DetailDset.FieldByName(column.FieldName).Value)
            else
              CellValue:='';
            Cells[F_NotDataColCount+i, RowCount-1]:=CellValue;
          end;
          F_DetailDset.Next;
          F_Grid.AdjustRowHeight(F_Grid.RowCount-1);
        end;
      end;
      {/Если нужно вставляем подстроки}

      F_Dset.Next;
      RowCount:=RowCount+1;
    end; //end while
    RowCount:=RowCount-1;
  end; //end with
end;

function TGridViewBuilder.ColumnCount: integer;
begin
  Result:=F_ColumnList.Count
end;

constructor TGridViewBuilder.Create(ADset: TDataSet; AGrid: TStringAlignGrid);
begin
  inherited Create;
  F_Dset := ADset;
  F_Grid := AGrid;
  F_IsNumberRecord := false;
  F_IsShowCheckBoxes := false;
  F_ColumnList := TList.Create;
  F_GroupList := TList.Create;

  OldAfterScroll := F_Dset.AfterScroll;
  F_Dset.AfterScroll := NewAfterScroll;
  OldGridDrawCell := F_Grid.OnDrawCell;
  F_Grid.OnDrawCell := NewGridDrawCell;
  OldGridMouseDown := F_Grid.OnMouseDown;
  F_Grid.OnMouseDown := NewGridMouseDown;
  F_RowSelect := false;
end;

constructor TGridViewBuilder.Create(ADset, ADetailDset: TDataSet;
  AGrid: TStringAlignGrid);
begin
  Create(ADset, AGrid);
  F_DetailDset:=ADetailDset;
end;

constructor TGridViewBuilder.Create(ADset: TDataSet; AGrid: TStringAlignGrid;
        AFieldNum: integer; AFieldValue: string; AIsBold: boolean; AFontColor: TColor);
begin
// этот конструктор сделан специально для возможности выделять красивостями
// строки на этапе построения грида  
  Create(ADset, AGrid);
  F_RowSelect := true;
  F_SelFieldNum:= AFieldNum;
  F_SelFieldVal:= AFieldValue;
  F_SelFieldIsBold:= AIsBold;
  F_SelFieldColor:= AFontColor;

end;


procedure TGridViewBuilder.DefineGridHeader;
var
  i: integer;
  column: TGBColumn;
begin
  {Дополнительные поля для нумерации в пределах группы, а также поля для чекбоксов}
  F_NotDataColCount:=0;

  if F_GroupList.Count>0 then
  begin
    for i:=0 to F_GroupList.Count-1 do
      if TGroup(F_GroupList.Items[i]).F_IsNumberRecordInGroup then
        inc(F_NotDataColCount);
  end else
  begin
    if F_IsNumberRecord then F_NotDataColCount:=1;
  end;

  if F_IsShowCheckBoxes then inc(F_NotDataColCount);
  {/Дополнительные поля для нумерации в пределах группы, а также поля для чекбоксов}

  {Задаем кол-во столбцов}
  F_Grid.RowCount:=2;
  F_Grid.FixedRows:=1;
  F_Grid.ColCount:=F_NotDataColCount+F_ColumnList.Count;
  F_Grid.FixedCols:=0;
  {/Задаем кол-во столбцов}

  {Раскраска загаловка таблицы}
  for i:=0 to F_ColumnList.Count-1 do
  begin
    column:=TGBColumn(F_ColumnList.Items[i]);
    F_Grid.Cells[F_NotDataColCount+i, 0]:=column.F_ColumnTitle.F_Caption;
    F_Grid.CellFont[F_NotDataColCount+i, 0].Assign(column.F_ColumnTitle.F_Font);
    F_Grid.AlignCell[F_NotDataColCount+i, 0]:=column.F_ColumnTitle.F_Alignment;
  end;
  {/Раскраска загаловка таблицы}

  {Задаем высоту заголовка таблицы}
  F_Grid.RowHeights[0]:=GetMaxRowInGridHeader*F_Grid.RowHeights[0];
  {/Задаем высоту заголовка таблицы}
end;

destructor TGridViewBuilder.Destroy;
var
  i: integer;
begin
  for i:=0 to F_ColumnList.Count-1 do
    TGBColumn(F_ColumnList.Items[i]).Free;
  F_ColumnList.Clear;
  F_ColumnList.Free;

  for i:=0 to F_GroupList.Count-1 do
    TGroup(F_GroupList.Items[i]).Free;
  F_GroupList.Clear;
  F_GroupList.Free;

  F_Dset.AfterScroll:=OldAfterScroll;
  F_Grid.OnDrawCell := OldGridDrawCell;
  F_Grid.OnMouseDown := OldGridMouseDown;
  inherited Destroy;
end;


procedure TGridViewBuilder.InsertAndFillNewRowInformer(DataSet: TDataSet);
var
  RowInformer: TRowInformer;
begin
  {Проверяем был ли задан список. Если был, то заполняем}
  if Assigned( F_RowInformerList ) then
  begin
    {Add}
    RowInformer := F_RowInformerClass.Create;
    F_RowInformerList.Add( RowInformer );
    InsertAddInfoInGrid( ROWINFORMER_COL_NUMBER, RowInformer );
    {/Add}

    {Fill}
    RowInformer.RecNumInDataSet := DataSet.RecNo;
    if Assigned( F_OnFillRowInformer ) then
      F_OnFillRowInformer( DataSet, RowInformer );
    {/Fill}
  end;
end;

function TGridViewBuilder.GetCellValue(column:TGBColumn; value: variant): string;
begin
  try
    if VarType(value)=varNull then
      Result:=''
    else
      Result:=trim(string(value));
  except
    Result:='';
  end;

  if Assigned(column.F_OnShowColumnCell) then
    column.F_OnShowColumnCell(value, Result);


 if column.F_DisplayWidth<>-1 then
    Result:=LineToMultiLine(Result, column.F_DisplayWidth);
end;

function TGridViewBuilder.GetColumn(Index: integer): TGBColumn;
begin
    Result:=TGBColumn(F_ColumnList.Items[Index]);
end;

function TGridViewBuilder.GetGroup(Index: integer): TGroup;
begin
  Result:=TGroup(F_GroupList.Items[Index]);
end;

function TGridViewBuilder.GetMaxRowInGridHeader: integer;
  function CountFixCharInStr(FixChar: char; str: string): integer;
  var
    i: integer;
  begin
    Result:=0;
    for i:=0 to length(str)-1 do
      if str[i]=FixChar then
        inc(Result);
  end;
var
  i: integer;
  column: TGBColumn;
  EnCount, MaxEnCount: integer;
begin
  {Находим макс. кол-во ентеров}
  MaxEnCount:=0;
  for i:=0 to F_ColumnList.Count-1 do
  begin
    column:=TGBColumn(F_ColumnList.Items[i]);
    EnCount:=CountFixCharInStr(#13, column.F_ColumnTitle.F_Caption);
    if EnCount>MaxEnCount then
      MaxEnCount:=EnCount;
  end;
  {/Находим макс. кол-во ентеров}

  Result:=MaxEnCount+1;
end;

function TGridViewBuilder.GroupCount: integer;
begin
  Result:=F_GroupList.Count;
end;

function TGridViewBuilder.GroupIndex(node: TTreeNode): integer;
begin
  Result:=node.LevelNumber;
end;

procedure TGridViewBuilder.InsertGroupAndSubgroup(node: TTreeNode);
var
  i: integer;
begin
  TGroup(F_GroupList.Items[GroupIndex(node)]).F_RowNumberInGroup:=0;
  if node.NodeKind=nkData then
  begin
    InsertGroupHeader(node);
    InsertGroupRows(node);
    InsertGroupFooter(node);
  end else
  begin
    InsertGroupHeader(node);
    for i:=0 to node.ChildNodeCount-1 do
      InsertGroupAndSubgroup(node.ChildNodeList[i]);
    InsertGroupFooter(node);
  end;
end;

procedure TGridViewBuilder.InsertGroupFooter(node: TTreeNode);
var
  group: TGroup;
  rec: TStringList;
  i: integer;
  AggField: TAggregateField;
  AggValueArr: array of double;
begin
  group:=TGroup(F_GroupList.Items[GroupIndex(node)]);

  if not group.F_GroupFooter.F_Visible then exit;   //Проверяем видимости Footer'а

  {Добавляем пустые строки}
  F_Grid.RowCount:=F_Grid.RowCount+1;
  if node.NodeKind<>nkData then
    F_Grid.RowCount:=F_Grid.RowCount+1;
  {/Добавляем пустые строки}

  {Вставляем footer}
  rec:=TStringList.Create;
  try
    if Assigned(group.F_GroupFooter.F_OnShowCaption) then
    begin
      SetLength(AggValueArr,group.F_AggregateFieldList.Count);
      for i:=0 to group.F_AggregateFieldList.Count-1 do
      begin
        AggField:=TAggregateField(group.F_AggregateFieldList.Items[i]);
        AggValueArr[i]:=AggField.CalcAggValueForNode(node);
      end;
      group.F_GroupFooter.F_OnShowCaption(node.RecordList[0], AggValueArr, rec);
    end;
    F_Grid.Rows[F_Grid.RowCount-1].AddStrings(rec);
  finally
    rec.Free;
  end;
  {/Вставляем footer}

  {Раскрашиваем footer}
  F_Grid.ColorRow[F_Grid.RowCount-1]:=group.F_GroupFooter.F_Color;
  F_Grid.RowFont[F_Grid.RowCount-1].Assign(group.F_GroupFooter.F_Font);
  F_Grid.AlignRow[F_Grid.RowCount-1]:=group.F_GroupFooter.F_Alignment;
  {Раскрашиваем footer}
end;

procedure TGridViewBuilder.InsertGroupHeader(node: TTreeNode);
var
  group: TGroup;
  rec: TStringList;
  AggField: TAggregateField;
  AggValueArr: array of double;
  i: integer;
begin
  {Добавление пустых строк между группами}
  if not F_IsGridEmpty then
    F_Grid.RowCount:=F_Grid.RowCount+2;
  {/Добавление пустых строк между группами}

  group:=TGroup(F_GroupList.Items[GroupIndex(node)]);

  if not group.F_GroupHeader.F_Visible then exit; //Проверяем видимость Header'а

  {Создаем и добавляем стороку заголовка в таблицу}
  rec:=TStringList.Create;
  try
    if Assigned(group.F_GroupHeader.F_OnShowCaption) then
    begin
      SetLength(AggValueArr,group.F_AggregateFieldList.Count);
      for i:=0 to group.F_AggregateFieldList.Count-1 do
      begin
        AggField:=TAggregateField(group.F_AggregateFieldList.Items[i]);
        AggValueArr[i]:=AggField.CalcAggValueForNode(node);
      end;
      if node.RecordCount>0 then
        group.F_GroupHeader.F_OnShowCaption(node.RecordList[0], AggValueArr, rec);
    end;
    F_Grid.Rows[F_Grid.RowCount-1].AddStrings(rec);
  finally
    rec.Free;
  end;
  {/Создаем и добавляем стороку заголовка в таблицу}

  {Оформляем сторку заголовка}
  F_Grid.ColorRow[F_Grid.RowCount-1]:=group.F_GroupHeader.F_Color;
  F_Grid.RowFont[F_Grid.RowCount-1].Assign(group.F_GroupHeader.F_Font);
  F_Grid.AlignRow[F_Grid.RowCount-1]:=group.F_GroupHeader.F_Alignment;
  {Оформляем сторку заголовка}

  F_IsGridEmpty:=false; //Если занесли хотя бы один заголовок гр., то таблица уже не пуста
end;

procedure TGridViewBuilder.InsertGroupRows(node: TTreeNode);
var
  i,j: integer;
  GRRow: TStringList;
  column: TGBColumn;
  CellValue: string;
begin
  GRRow:=TStringList.Create;
  try
    for i:=0 to node.RecordCount-1 do
    begin
      F_Grid.RowCount:=F_Grid.RowCount+1;

      IssueRowCells;  //оформляем главную строку

      {Формируем и вставляем главную строку}
      GRRow.Clear;
      InsertNumbersInRow(node, GRRow); //добавляет нумерацию строки в пределах группы, подгруппы и т.д.
      for j:=0 to F_ColumnList.Count-1 do
      begin
        column:=TGBColumn(F_ColumnList.Items[j]);
        if (column.F_ColumnType=ctDetail) and (Assigned(F_DetailDset)) then
        begin
          if not F_DetailDset.Active then F_DetailDset.Open;
          F_DetailDset.First;
          CellValue:=GetCellValue(column, F_DetailDset.FieldByName(column.F_FieldName).Value);
          F_DetailDset.Next;
        end else CellValue:=GetCellValue(column, node.RecordList[i].FieldByName(column.F_FieldName).Value);

        GRRow.Add(CellValue);
      end;

      {Если нужно показывать чекбоксы, то вставляем еще один столбец в котором будем их рисовать}
      if F_IsShowCheckBoxes then
        GRRow.Insert(0, CHECKBOX_FIELD_VALUE);
      {Если нужно показывать чекбоксы, то вставляем еще один столбец в котором будем их рисовать}

      F_Grid.Rows[F_Grid.RowCount-1].AddStrings(GRRow);
      F_Grid.AdjustRowHeight(F_Grid.RowCount-1);
      {/Формируем и вставляем главную строку}

      if trim(F_IDFieldName)<>'' then
        InsertIDFieldValue(node.RecordList[i].FieldByName(F_IDFieldName).AsInteger);
      if trim(F_HelpIDFieldName)<>'' then
        InsertHelpIDFieldValue(node.RecordList[i].FieldByName(F_HelpIDFieldName).AsInteger);

      InsertAndFillNewRowInformer( node.RecordList[i] );

      {Если необходимо, то формируем и вставляем подстроки}
      if Assigned(F_DetailDSet) then
      begin
        while not F_DetailDset.Eof do
        begin
          F_Grid.RowCount:=F_Grid.RowCount+1;

          IssueRowCells; //оформляем подстроку

          GRRow.Clear;
          for j:=1 to F_NotDataColCount do GRRow.Add('');
          //InsertNumbersInRow(node, GRRow);
          for j:=0 to F_ColumnList.Count-1 do
          begin
            column:=TGBColumn(F_ColumnList.Items[j]);
            if (column.F_ColumnType=ctDetail) then
              CellValue:=GetCellValue(column, F_DetailDset.FieldByName(column.F_FieldName).Value)
            else
              CellValue:='';
            GRRow.Add(CellValue);
          end;
          F_Grid.Rows[F_Grid.RowCount-1].AddStrings(GRRow);
          F_Grid.AdjustRowHeight(F_Grid.RowCount-1);

          F_DetailDset.Next;
        end;
      end;
      {/Если необходимо, то формируем и вставляем подстроки}

    end; // end for i
  finally
    GRRow.Free;
  end;
end;

procedure TGridViewBuilder.InsertHelpIDFieldValue(HelpIDValue: integer);
begin
  InsertAddInfoInGrid( HELP_ID_FIELD_COL_NUMBER, ptr( HelpIDValue ) );
end;

procedure TGridViewBuilder.InsertIDFieldValue(IDValue: integer);
begin
  InsertAddInfoInGrid(ID_FIELD_COL_NUMBER, ptr( IDValue ));
end;

procedure TGridViewBuilder.InsertAddInfoInGrid(Col: integer; MemoryAdres: Pointer);
begin
  F_Grid.Objects[Col, F_Grid.RowCount-1]:=MemoryAdres;
end;

procedure TGridViewBuilder.InsertNumbersInRow(FatherNode: TTreeNode;
  SrcRow: TStringList);
var
  group: TGroup;
begin
  group:=TGroup(F_GroupList.Items[GroupIndex(FatherNode)]);
  if group.IsNumberRecordInGroup then
  begin
    inc(group.F_RowNumberInGroup);
    SrcRow.Insert(0, IntToStr(group.F_RowNumberInGroup));
  end;

  if Assigned(FatherNode.FatherNode) then
    InsertNumbersInRow(FatherNode.FatherNode, SrcRow);
end;

procedure TGridViewBuilder.IssueRowCells;
var
  i: integer;
  column: TGBColumn;
begin
  for i:=0 to F_ColumnList.Count-1 do
  begin
    column:=TGBColumn(F_ColumnList.Items[i]);
    F_Grid.AlignCell[F_NotDataColCount+i, F_Grid.RowCount-1]:=column.F_Alignment;
  end;
end;

procedure TGridViewBuilder.NewAfterScroll(DataSet: TDataSet);
begin
  if Assigned(F_OnLoadRecordCount) then
    F_OnLoadRecordCount(DataSet.RecNo);
  if Assigned(OldAfterScroll) then
    OldAfterScroll(DataSet);
end;

procedure TGridViewBuilder.NewGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
const
  DELTA = 2;
var
  OldColor: TColor;
  RowInformer: TRowInformer;
begin
  if Assigned( OldGridDrawCell ) then
    OldGridDrawCell( Sender, ACol, ARow, Rect, State);

  if ( F_IsShowCheckBoxes ) and ( Assigned( F_RowInformerList ) ) then
  begin
    if ( ACol = 0 ) and ( ARow > 0 ) and Assigned( F_Grid.Objects[ROWINFORMER_COL_NUMBER, ARow] ) then
    begin
      OldColor := F_Grid.Canvas.Brush.Color;
      F_Grid.Canvas.Rectangle( Rect.left-DELTA, Rect.Top-DELTA, Rect.Right+DELTA, Rect.Bottom+DELTA );
      RowInformer := TRowInformer( F_Grid.Objects[ROWINFORMER_COL_NUMBER, ARow] );
      if RowInformer.IsRowChecked then
      begin
        F_Grid.Canvas.Brush.Color := CHECKBOX_COLOR;
        F_Grid.Canvas.Rectangle( Rect.left+DELTA, Rect.Top+DELTA, Rect.Right-DELTA, Rect.Bottom-DELTA );
      end;
      F_Grid.Canvas.Brush.Color:=OldColor;
    end;
  end;
end;

procedure TGridViewBuilder.NewGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Col, Row: integer;
  RowInformer: TRowInformer;
begin
  if Assigned( OldGridMouseDown ) then
    OldGridMouseDown( Sender, Button, Shift, X, Y );

  if ( F_IsShowCheckBoxes ) and ( Assigned( F_RowInformerList ) ) then
  begin
    F_Grid.MouseToCell(X, Y, Col, Row);
    if ( Col = 0 ) and ( Row > 0 ) and Assigned( F_Grid.Objects[ROWINFORMER_COL_NUMBER, Row] ) then
    begin
      RowInformer := TRowInformer( F_Grid.Objects[ROWINFORMER_COL_NUMBER, Row] );
      RowInformer.IsRowChecked := not RowInformer.IsRowChecked;
    end;
  end;
end;

procedure TGridViewBuilder.ResetGrid;
var
  i, j: integer;
begin
  F_IsGridEmpty:=true;

  F_Grid.RowHeights[0]:=F_Grid.DefaultRowHeight;
  with F_Grid do
  begin
    for j:=0 to RowCount-1 do
      for i:=0 to ColCount-1 do
      begin
        if Assigned(Rows[j].Objects[i]) then
          Rows[j].Objects[i]:=nil;
        Cells[i,j]:='';
      end;

    ResetAllCellAll;
    ResetAllRowAll;
    ResetAllColAll;
    ColCount:=1;
    RowCount:=1;
  end;
end;


procedure TGridViewBuilder.SetRowInformerList(
  ARowInformerList: TRowInformerList; AClassRef: TRowInformerClass);
begin
  F_RowInformerList := ARowInformerList;
  F_RowInformerClass := AClassRef;
  //
  F_RowInformerList.Clear;
end;

{ TGBColumn }

constructor TGBColumn.Create(AGrid: TStringAlignGrid);
begin
  inherited Create;
  F_Grid:=AGrid;
  F_Alignment:=alDefault;
  F_ColumnTitle:=TGBColumnTitle.Create(self);
  F_DisplayWidth:=-1;
  F_ColumnType:=ctMaster; 
end;

destructor TGBColumn.Destroy;
begin
  F_ColumnTitle.Free;
  inherited Destroy;
end;

function TGBColumn.GetGrid: TStringAlignGrid;
begin
  Result:=F_Grid;
end;

{ TGBColumnTitle }

constructor TGBColumnTitle.Create(AColumn: TGBColumn);
begin
  inherited Create;
  F_Column:=AColumn;
  F_Alignment:=alDefault;
  F_Font:=TFont.Create;
  F_Font.Assign(DefaultFont);
end;

function TGBColumnTitle.DefaultFont: TFont;
var
  Grid: TStringAlignGrid;
begin
  Grid:=F_Column.GetGrid;
  Result:=Grid.Font;
end;

destructor TGBColumnTitle.Destroy;
begin
  F_Font.Free;
  inherited Destroy;
end;

{ TGroup }

procedure TGroup.AddAggregateField(AAggType: TAggrigateType;
  AAggFieldName: string);
var
  AggField: TAggregateField;
begin
  AggField:=TAggregateField.Create(AAggType, AAggFieldName);
  F_AggregateFieldList.Add(AggField);
end;

constructor TGroup.Create(AGrid: TStringAlignGrid; AGroupField: string);
begin
  inherited Create;
  F_GroupField:=AGroupField;
  F_Grid:=AGrid;
  F_IsNumberRecordInGroup:=false;
  F_GroupHeader:=TGroupHeader.Create(AGrid);
  F_GroupFooter:=TGroupFooter.Create(AGrid);
  F_AggregateFieldList:=TList.Create;
end;

destructor TGroup.Destroy;
var
  i: integer;
begin
  F_GroupHeader.Free;
  F_GroupFooter.Free;

  for i:=0 to F_AggregateFieldList.Count-1 do
    TAggregateField(F_AggregateFieldList.Items[i]).Free;

  F_AggregateFieldList.Free;
  inherited Destroy;
end;

function TGroup.GetGrid: TStringAlignGrid;
begin
  Result:=F_Grid;
end;


{ TGroupBorder }

constructor TGroupBorder.Create(AGrid: TStringAlignGrid);
begin
  inherited Create;
  F_Grid:=AGrid;
  F_Visible:=true;
  F_Font:=TFont.Create;
  F_Font.Assign(AGrid.Font);
  F_Color:=AGrid.Color;
  F_Alignment:=alDefault;
end;

destructor TGroupBorder.Destroy;
begin
  F_Font.Free;
  inherited Destroy;
end;


{ TAggregateField }

function TAggregateField.Avg: double;
begin
  if Count<>0 then
    Result:=Sum/Count
  else
    Result:=0;  
end;

function TAggregateField.CalcAggValueForNode(node: TTreeNode): double;
begin
  F_Node:=node;
  case F_AggrigateType of
    atSum: Result:=Sum;
    atCount: Result:=Count;
    atAvg: Result:=Avg;
    atMin: Result:=Min;
    atMax: Result:=Max;
  end; //end case
end;

function TAggregateField.Count: integer;
begin
  Result:=F_Node.RecordCount;
end;

constructor TAggregateField.Create(AAggType: TAggrigateType;
            AAggFieldName: string);
begin
  inherited Create;
  F_AggrigateType:=AAggType;
  F_AggFieldName:=AAggFieldName;
end;

function TAggregateField.Max: double;
var
  i: integer;
begin
  if F_Node.RecordCount<1 then exit;

  Result:=F_Node.RecordList[0].FieldByName(F_AggFieldName).AsFloat;
  for i:=1 to F_Node.RecordCount-1 do
    if F_Node.RecordList[i].FieldByName(F_AggFieldName).AsFloat>Result then
      Result:=F_Node.RecordList[i].FieldByName(F_AggFieldName).AsFloat;
end;

function TAggregateField.Min: double;
var
  i: integer;
begin
  if F_Node.RecordCount<1 then exit;

  Result:=F_Node.RecordList[0].FieldByName(F_AggFieldName).AsFloat;
  for i:=1 to F_Node.RecordCount-1 do
    if F_Node.RecordList[i].FieldByName(F_AggFieldName).AsFloat<Result then
      Result:=F_Node.RecordList[i].FieldByName(F_AggFieldName).AsFloat;
end;

function TAggregateField.Sum: double;
var
  i: integer;
begin
  Result:=0;
  for i:=0 to F_Node.RecordCount-1 do
    if not F_Node.RecordList[i].FieldByName(F_AggFieldName).IsNull then
      Result:=Result+F_Node.RecordList[i].FieldByName(F_AggFieldName).AsFloat;
end;

{ TRowInformer }

constructor TRowInformer.Create;
begin
  inherited Create;
  F_IsRowChecked := true;
  F_RecNumInDataSet := -1;
end;

{ TRowInformerList }

procedure TRowInformerList.Clear;
var
  i: integer;
begin
  for i:=0 to Count-1 do
    TRowInformer( Items[i] ).Free;

  inherited;
end;

end.
