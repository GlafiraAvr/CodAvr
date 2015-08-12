unit BaseBefor;

interface
uses Classes, Controls, Variants,  SvodkaGikDModule, FR_Class,
     FR_DSet, SysUtils, ProgressForm, FrPreviewForm,
     Aligrid, DB, Graphics, DataExchInterfacesUnit,
     ObjListUnit, ExcelWorksForm, Grids,RXDBCtrl,RxMemDS, UniDataExchUnit,  NGReportBaseDModule;

type

tBasePrepared_Time=class
private

protected
  procedure OnStopProgress(Sender: TObject);
  procedure InitFields; virtual;
  procedure CreateForms; virtual;
public
  F_Pind: TProgressIndicator;
  F_DT:tDate;
  F_DM:Tdm_NGReportBase;
  procedure OnChangeProgressStatus(ProgLength, ProgPos: integer);
  constructor Create ;
  destructor Destroy;
  function Excute:boolean; virtual;
end;

implementation


constructor tBasePrepared_Time.Create();
begin
  inherited Create;


  {Создаем и ининциализируем pind}
  F_Pind:=TProgressIndicator.Create(nil);
  F_Pind.OnCancel:=OnStopProgress;
  F_Pind.Caption:='Идет подготовка данных';
  F_Pind.CancelCaption:='Отмена';
  {/Создаем и ининциализируем pind}

  InitFields;
  CreateForms;


  if Assigned(F_DM) then
    F_DM.OnChangeProgressStatus:=OnChangeProgressStatus;
end;

procedure tBasePrepared_Time.OnChangeProgressStatus(ProgLength,
  ProgPos: integer);
begin
  F_Pind.Max:=ProgLength;
  F_Pind.Position:=ProgPos;
end;

procedure tBasePrepared_Time.OnStopProgress(Sender: TObject);
begin

  F_DM.IsStopProgress:=true;
end;


destructor  tBasePrepared_Time.Destroy;
begin
 inherited;
  F_Pind.Free;
  F_DM.Free;
  inherited Destroy;
end;

function  tBasePrepared_Time.Excute:boolean;
begin
//
end;

procedure tBasePrepared_Time.InitFields;
begin
//
end;

procedure tBasePrepared_Time.CreateForms; 
begin
//
end;

end.
 