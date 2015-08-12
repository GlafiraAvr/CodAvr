unit DataSetTree;

interface

uses SysUtils, Classes, DB, Variants;

type
  TTreeNode=class;
  TDataSetTree=class;

  TLevel=class
  private
    F_DataSetTree: TDataSetTree;
    F_PreviousValue: variant;
    F_CurrentNode: TTreeNode;
    F_NodeList: TList;
    F_CheckFieldName: string;
    F_LevelNumber: integer;
    F_IsEmpty: boolean; //true - если нет узлов
    function AddNode: TTreeNode;
  public
    property LevelNumber: integer read F_LevelNumber;
    constructor Create(ADataSetTree: TDataSetTree);
    destructor Destroy; override;
  end;

  TNodeKind=(nkGroup, nkData);

  TTreeNode=class
  private
    F_Level: TLevel;
    F_FatherNode: TTreeNode;
    F_ChildNodeList: TList;
    F_RecNoList: TList;
    F_NodeKind: TNodeKind;
    function GetChildNode(Index: integer): TTreeNode;
    function GetCheckFieldName: string;
    function GetRecord(Index: integer): TDataSet;
    function GetLevelNumber: integer;
    function GetCheckFieldValue: variant;
    function GetDataSet: TDataSet;
    function GetRecNoByIndex(Index: integer): integer;
  public
    property CheckFieldName: string read GetCheckFieldName;
    property LevelNumber: integer read GetLevelNumber;
    property CheckFieldValue: variant read GetCheckFieldValue;
    property NodeKind: TNodeKind read F_NodeKind;
    property FatherNode: TTreeNode read F_FatherNode;
    property RecordList[Index: integer]: TDataSet read GetRecord;
    property ChildNodeList[Index: integer]: TTreeNode read GetChildNode;
    function RecordCount: integer;
    function ChildNodeCount: integer;
    constructor Create(ALevel: TLevel);
    destructor Destroy; override;
  end;

  TDataSetTree=class
  private
    F_DataSet: TDataSet;
    F_LevelList: TList;
    F_NodeList: TList;
    function GetNode(Index: integer): TTreeNode;
  private
    procedure AddAllRecordsToNodeAndSubnode(node: TTreeNode);
  public
    property NodeList[index: integer]: TTreeNode read GetNode;
    function NodeCount: integer;
    constructor Create(dset: TDataSet);
    destructor Destroy; override;
    procedure BuildTree;
    procedure AddCheckFieldName(CheckFieldName: string);
    procedure SaveTreeInfoToFile(FileName: string);
  end;


implementation

procedure ClearObjectList(list: TList);
var
  i: integer;
begin
  for i:=0 to list.Count-1 do
    TObject(list.Items[i]).Free;
  list.Clear;  
end;

{ TLevel }

function TLevel.AddNode: TTreeNode;
begin
  Result:=TTreeNode.Create(self);
  F_NodeList.Add(Result);
  F_CurrentNode:=Result;
  F_IsEmpty:=false;
end;

constructor TLevel.Create(ADataSetTree: TDataSetTree);
begin
  inherited Create;
  F_IsEmpty:=true;
  F_DataSetTree:=ADataSetTree;
  F_NodeList:=TList.Create;
  F_PreviousValue:=Null;
end;


destructor TLevel.Destroy;
begin
  F_NodeList.Free;
  inherited Destroy;
end;

{ TTreeNode }

function TTreeNode.ChildNodeCount: integer;
begin
  Result:=F_ChildNodeList.Count;
end;

constructor TTreeNode.Create(ALevel: TLevel);
begin
  inherited Create;
  F_Level:=ALevel;
  F_ChildNodeList:=TList.Create;
  F_RecNoList:=TList.Create;
  F_NodeKind:=nkGroup;
end;

destructor TTreeNode.Destroy;
begin
  F_ChildNodeList.Free;
  F_RecNoList.Free;
  inherited Destroy;
end;

function TTreeNode.GetCheckFieldName: string;
begin
  Result:=F_Level.F_CheckFieldName;
end;

function TTreeNode.GetCheckFieldValue: variant;
begin
  RecordList[0].FieldByName(GetCheckFieldName).Value;
end;

function TTreeNode.GetChildNode(Index: integer): TTreeNode;
begin
  Result:=TTreeNode(F_ChildNodeList.Items[Index]);
end;

function TTreeNode.GetDataSet: TDataSet;
begin
  Result:=F_Level.F_DataSetTree.F_DataSet;
end;

function TTreeNode.GetLevelNumber: integer;
begin
  Result:=F_Level.F_LevelNumber;
end;

function TTreeNode.GetRecNoByIndex(Index: integer): integer;
begin
  Result:=integer(F_RecNoList.Items[Index]);
end;

function TTreeNode.GetRecord(Index: integer): TDataSet;
begin
  Result:=GetDataSet;
  Result.RecNo:=GetRecNoByIndex(Index);
end;

function TTreeNode.RecordCount: integer;
begin
  Result:=F_RecNoList.Count;
end;

{ TDataSetTree }

procedure TDataSetTree.AddAllRecordsToNodeAndSubnode(node: TTreeNode);
var
  i, j: integer;
  ChildNode: TTreeNode;
begin
  if node.F_NodeKind<>nkData then
  begin
    for i:=0 to node.ChildNodeCount-1 do
    begin
      ChildNode:=TTreeNode(node.F_ChildNodeList.Items[i]);
      AddAllRecordsToNodeAndSubnode(ChildNode);
      for j:=0 to ChildNode.RecordCount-1 do
        node.F_RecNoList.Add(ChildNode.F_RecNoList.Items[j])
    end;
  end;
end;

procedure TDataSetTree.AddCheckFieldName(CheckFieldName: string);
var
  level: TLevel;
  LNum: integer;
begin
  level:=TLevel.Create(self);
  level.F_CheckFieldName:=CheckFieldName;
  LNum:=F_LevelList.Add(level);
  level.F_LevelNumber:=LNum;
end;

procedure TDataSetTree.BuildTree;
var
  i, j: integer;
  level, prev_level: TLevel;
  node: TTreeNode;
begin
  //надо сделать очистку всех списков
  //пока за ненадобностью не реализовано
  if not F_DataSet.Active then F_DataSet.Open;

  F_DataSet.First;
  while not F_DataSet.Eof do
  begin
    {Выстраиваем ветку}
    for i:=0 to F_LevelList.Count-1 do
    begin
      {Узлы}
      level:=TLevel(F_LevelList.Items[i]);
      if (level.F_IsEmpty) or
      (F_DataSet.FieldValues[level.F_CheckFieldName]<>level.F_PreviousValue) then
      begin
        level.F_PreviousValue:=F_DataSet.FieldValues[level.F_CheckFieldName];

        node:=level.AddNode;
        F_NodeList.Add(node);

        for j:=level.LevelNumber+1 to F_LevelList.Count-1 do
          TLevel(F_LevelList.Items[j]).F_PreviousValue:=Null;

        if i>0 then
        begin
          prev_level:=TLevel(F_LevelList.Items[i-1]);
          node.F_FatherNode:=prev_level.F_CurrentNode;
          prev_level.F_CurrentNode.F_ChildNodeList.Add(node);
        end;
      end else
      begin
        node:=level.F_CurrentNode;
      end;
      {/Узлы}
    end; //end for i;

    {Добавляем номер записи}
    node.F_NodeKind:=nkData;
    node.F_RecNoList.Add(ptr(F_DataSet.RecNo));
    {/Добавляем номер записи}

    F_DataSet.Next;
    {/Выстраиваем ветку}
  end; //end while

  {К каждому узлу добавляем все записи подчененных узлов}
  for i:=0 to F_NodeList.Count-1 do
    if not Assigned(TTreeNode(F_NodeList.Items[i]).F_FatherNode) then
      AddAllRecordsToNodeAndSubnode(TTreeNode(F_NodeList.Items[i]));
  {/К каждому узлу добавляем все записи подчененных узлов}
end;

constructor TDataSetTree.Create(dset: TDataSet);
begin
  inherited Create;
  F_DataSet:=dset;
  F_LevelList:=TList.Create;
  F_NodeList:=TList.Create;
end;

destructor TDataSetTree.Destroy;
begin
  ClearObjectList(F_LevelList);
  ClearObjectList(F_NodeList);
  F_LevelList.Free;
  F_NodeList.Free;

  inherited Destroy;
end;

function TDataSetTree.GetNode(Index: integer): TTreeNode;
begin
  Result:=TTreeNode(F_NodeList.Items[Index]);
end;

function TDataSetTree.NodeCount: integer;
begin
  Result:=F_NodeList.Count;
end;

procedure TDataSetTree.SaveTreeInfoToFile(FileName: string);
var
  sl: TStringList;
  i, j: integer;
  level: TLevel;
  node: TTreeNode;
begin
  sl:=TStringList.Create;
  try
    sl.Add('---===LEVELS===---');
    for i:=0 to F_LevelList.Count-1 do
    begin
      level:=TLevel(F_LevelList.Items[i]);
      sl.Add('LevelNumber='+IntToStr(level.F_LevelNumber));
      sl.Add('LevelCheckFieldName='+level.F_CheckFieldName);

      sl.Add('  ---===NODE===---');
      for j:=0 to level.F_NodeList.Count-1 do
      begin
        node:=TTreeNode(level.F_NodeList.Items[j]);
        sl.Add(' NodeKind='+ IntToStr(ord(node.F_NodeKind)));
      end;
    end;


    sl.SaveToFile(FileName);
  finally
    sl.Clear
  end;
end;

end.
