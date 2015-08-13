unit RootReportDModule;

interface

{$I !TEST_DEFINE.inc}

uses
  SysUtils, Classes, DB, IBCustomDataSet;

type
{$ifdef test}
  TTESTBeforeOpen=class
  private
    F_DsetName: string;
    F_BeforeOpen: TDataSetNotifyEvent;
  public
    constructor Create(dset: TDataSet);
    property DsetName: string read F_DsetName;
    property BeforeOpen: TDataSetNotifyEvent read F_BeforeOpen;
  end;
{$endif}

  Tdm_RootReport = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    {$ifdef test}
    F_TBOList: TList;
    procedure CreateAndInitDsetList;
    procedure ClearAndFreeDsetList;
    procedure OnTestBeforeOpen(DataSet: TDataSet);
    {$endif}
  public
  end;


implementation

{$R *.dfm}

{$ifdef test}

uses TestUnit;

constructor TTESTBeforeOpen.Create(dset: TDataSet);
begin
  inherited Create;
  F_DsetName:=dset.Name;
  F_BeforeOpen:=dset.BeforeOpen;
end;


procedure Tdm_RootReport.OnTestBeforeOpen(DataSet: TDataSet);
var
  i: integer;
  tbo: TTESTBeforeOpen;
  is_find: boolean;
begin
  TEST_SaveStrings2File((DataSet as TIBDataSet).SelectSQL, ClassName+'.'+DataSet.Name);

  is_find:=false;
  for i:=0 to F_TBOList.Count-1 do
  begin
    tbo:=TTESTBeforeOpen(F_TBOList.Items[i]);
    if AnsiCompareText(DataSet.Name, tbo.DsetName)=0 then
    begin
      if Assigned(tbo.BeforeOpen) then
        tbo.BeforeOpen(DataSet);
      is_find:=true;
      break;
    end;
  end;

  if not is_find then
    raise Exception.Create('Не сработал родной обработчик '+ClassName+'.'+DataSet.Name+
        '.BeforeOpen(Tdm_RootReport.OnTestBeforeOpen)');
end;

procedure Tdm_RootReport.CreateAndInitDsetList;
var
  i: integer;
  tbo: TTESTBeforeOpen;
  _dset: TIBDataSet;
begin
  F_TBOList:=TList.Create;

  for i:=0 to ComponentCount-1 do
    if (Components[i] is TIBDataSet) then
    begin
      _dset:=(Components[i] as TIBDataSet);
      tbo:=TTESTBeforeOpen.Create(_dset);
      F_TBOList.Add(tbo);
      _dset.BeforeOpen:=OnTestBeforeOpen;
    end;
end;

procedure Tdm_RootReport.ClearAndFreeDsetList;
var
  i: integer;
begin
  for i:=0 to F_TBOList.Count-1 do
    TTESTBeforeOpen(F_TBOList.Items[i]).Free;
  F_TBOList.Free;
end;

{$endif}


procedure Tdm_RootReport.DataModuleCreate(Sender: TObject);
begin
  {$ifdef test}
   CreateAndInitDsetList;
  {$endif}
end;



procedure Tdm_RootReport.DataModuleDestroy(Sender: TObject);
begin
  {$ifdef test}
  ClearAndFreeDsetList;
  {$endif}
end;

end.
