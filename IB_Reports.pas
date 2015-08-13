unit IB_Reports;

interface

uses Windows, SysUtils, DB, IBCustomDataSet, FR_Class, FR_DSet, BaseResultForm,
     BaseOptionForm, Forms, GridViewBuilder, Controls, aligrid, ProgressForm,
     Graphics, Classes, CustomReport, Chart, TeenGine, WaitProcessForm, frOLEExl,
     DateUtils, IBDataBase, Series, RxMemDS;

const
  AVR_COLORS: array[0..9] of TColor=(
    clOlive,clGreen,clNavy,clPurple,clTeal,
    clRed,clLime,clAqua,clBlue,clFuchsia);

type

  TMemReport=class(TCustomReport)
  private
    F_MemTable: TRxMemoryData;
    procedure Print;
  protected
    function AddFieldToMemTable(const AFieldName:string;AFieldClass:TFieldClass;
                                   ASize:Word; ACalculated:boolean; ADispLabel: string=''):TField;
    procedure DeleteAllFieldsFromMemTable;
  protected
    procedure PrintBtnClick(Sender: TObject);
    procedure PrepareDsets; virtual;
  public
    property MemTable: TRxMemoryData write F_MemTable;
    function Execute: boolean; override;
    destructor Destroy; override;
  end;


  TKolvoOtkazov=class(TMemReport)
  private
    F_frUDSet: TfrUserDataset;
    procedure CreateMemTable;
    procedure frGetValue(const ParName: String; var ParValue: Variant);
    function GetRegionsName: string;
    function GetDamagePlaceName: string;
    procedure OnFrShowGraph(Sender: TObject);
    procedure AddSeries(chart: TChart; field_name: string; id_dmg: integer;
        _title: string; _color: TColor; group_number: integer);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareDsets; override;
    procedure PrepareFastReport; override;
  public
    property frUDset: TfrUserDataset read F_frUDSet write F_frUDSet;
  end;



implementation

uses HelpFunctions, KolvoOtkazForm, FrPreviewForm, KolvoOtkazGraphForm,
      MNKUnit, ApUnit, HLSRGBUnit, Variants;

{ TMemReport }

function TMemReport.AddFieldToMemTable(const AFieldName: string;
  AFieldClass: TFieldClass; ASize: Word; ACalculated: boolean; ADispLabel: string=''): TField;
begin
  Result:=F_MemTable.FindField(AFieldName); // Field may already exists!
  if Result<>nil then Exit;

  Result:=AFieldClass.Create(nil);
  with Result do
  try
    FieldName:=AFieldName;
    if (Result is TStringField) or (Result is TBCDField) or (Result is TBlobField) or
      (Result is TBytesField) or (Result is TVarBytesField) then
    begin
      Size:=ASize;
    end;
    Calculated:=ACalculated;
    DataSet:=F_MemTable;
    DisplayLabel:=ADispLabel;
    Name:=F_MemTable.Name+AFieldName;
  except
    Free; // We must release allocated memory on error!
    raise;
  end;
end;

procedure TMemReport.DeleteAllFieldsFromMemTable;
begin
  F_MemTable.Close;
  while F_MemTable.FieldCount>0 do
  begin
    F_MemTable.Fields[0].Free;
  end;
end;

destructor TMemReport.Destroy;
begin
  DeleteAllFieldsFromMemTable;
  inherited Destroy;
end;

function TMemReport.Execute: boolean;
var
  WaitForm: Tfrm_WaitProcess;
begin
  Result:=false;

  if not ShowOptionForm then exit;

  WaitForm:=Tfrm_WaitProcess.Create(nil);
  try
    WaitForm.Show;
    PrepareDsets;
    PrepareResultFormGrid;
    PrepareResultFormHeader;
    PrepareResultFormBtns;
    WaitForm.Close;
  finally
    WaitForm.Free;
  end;

  if Assigned(F_ResultForm) then
    F_ResultForm.ShowModal
  else
    Print;

  Result:=true;
end;

procedure TMemReport.PrepareDsets;
begin
//
end;


procedure TMemReport.Print;
begin
  if not LoadReportFile then exit;
  PrepareFastReport;

  ShowReport;
end;

procedure TMemReport.PrintBtnClick(Sender: TObject);
begin
  Print;
end;

{ TKolvoOtkazov }

procedure TKolvoOtkazov.AddSeries(chart: TChart; field_name: string; id_dmg: integer;
    _title: string; _color: TColor; group_number: integer);
var
  ser, ser_mnk: TFastLineSeries;
  mnk: TMNK;
  last_x, first_x: TDate;
  k: integer;
begin
  ser:=TFastLineSeries.Create(chart);
  with ser do
  begin
    XValues.DateTime:=true;
    Marks.Visible:=false;
    Marks.Style:=smsValue;
    Tag:=group_number;
    Marks.Visible:=false;
    Title:=_title;
    SeriesColor:=_color;

    if AnsiCompareText(field_name, 'REG_ALL')=0 then
      LinePen.Width:=5
    else if id_dmg=-1 then
      LinePen.Width:=3
    else LinePen.Width:=2;
  end;

  ser_mnk:=TFastLineSeries.Create(chart);
  with ser_mnk do
  begin
    XValues.DateTime:=true;
    Marks.Visible:=false;
    Marks.Style:=smsValue;
    Tag:=group_number;
    Marks.Visible:=false;
    Title:='~'+_title;
    SeriesColor:=clBlack;

    if AnsiCompareText(field_name, 'REG_ALL')=0 then
      LinePen.Width:=2
    else
      LinePen.Width:=1;
  end;

  mnk:=TMNK.Create;
  try
    last_x:=0; first_x:=0; k:=1;
    F_MemTable.First;
    while not F_MemTable.Eof do
    begin
      if F_MemTable.FieldByName('ID_DMG_PLACE').AsInteger=id_dmg then
      begin
        if first_x=0 then first_x:=F_MemTable.FieldByName('DT').AsDateTime;
        ser.AddXY(F_MemTable.FieldByName('DT').AsDateTime, F_MemTable.FieldByName(field_name).AsFloat);
        mnk.AddXY(k, F_MemTable.FieldByName(field_name).AsFloat);
        inc(k);
        last_x:=F_MemTable.FieldByName('DT').AsDateTime;
      end;
      F_MemTable.Next;
    end;
    mnk.Execute;

    ser_mnk.AddXY(first_x, mnk.OutY1);
    ser_mnk.AddXY(last_x, mnk.OutY2);
  finally
    mnk.Free;
  end;

  chart.AddSeries(ser);
  chart.AddSeries(ser_mnk);
end;

procedure TKolvoOtkazov.CreateForms;
begin
  F_OptionForm:=Tfrm_KolvoOtkazOpt.Create(nil, F_Name);
end;

procedure TKolvoOtkazov.CreateMemTable;
var
  i: integer;
begin
  F_MemTable.Close;
  DeleteAllFieldsFromMemTable;
  AddFieldToMemTable('DT', TDateField, 10, false, 'Дата');
  AddFieldToMemTable('DMG_PLACE', TStringField, 32, false);
  AddFieldToMemTable('ID_DMG_PLACE', TIntegerField, 10, false);

  with (F_OptionForm as Tfrm_KolvoOtkazOpt) do
    for i:=0 to Arr_RegionsCount-1 do
      AddFieldToMemTable('REG_'+Arr_RegionsID[i], TIntegerField, 10, false, Arr_strRegions[i]);

  AddFieldToMemTable('REG_ALL', TIntegerField, 10, false, 'Всего');
end;

procedure TKolvoOtkazov.frGetValue(const ParName: String;
  var ParValue: Variant);
begin
  if AnsiCompareText(ParName, 'HeaderCell')=0 then
    ParValue:=F_MemTable.Fields[F_frUDSet.RecNo+3].DisplayLabel
  else
  if AnsiCompareText(ParName, 'DataCell')=0 then
    ParValue:=F_MemTable.FieldByName('DMG_PLACE').AsString
  else
  if AnsiCompareText(ParName, 'DataCellValue')=0 then
  begin
    ParValue:=F_MemTable.Fields[F_frUDSet.RecNo+3].Value;
    if VarType(ParValue) = varNull then ParValue := 0;
  end;
end;

function TKolvoOtkazov.GetDamagePlaceName: string;
var
  i: integer;
begin
  Result:='';
  with (F_OptionForm as Tfrm_KolvoOtkazOpt) do
    for i:=0 to Arr_DamagePlaceCount-1 do
      Result:=Result+', '+Arr_strDamagePlace[i];
  Delete(Result, 1, 2);
end;

function TKolvoOtkazov.GetRegionsName: string;
var
  i: integer;
begin
  Result:='';
  with (F_OptionForm as Tfrm_KolvoOtkazOpt) do
    for i:=0 to Arr_RegionsCount-1 do
      Result:=Result+', '+Arr_strRegions[i];
  Delete(Result, 1, 2);
end;


procedure TKolvoOtkazov.InitFields;
begin
  F_Name:='Сводка "Количество отказов"';
  F_ReportFileName:='KolvoOtkazov.frf';
end;

procedure TKolvoOtkazov.OnFrShowGraph(Sender: TObject);
var
  frm_Graph: Tfrm_KolvoOtkazGraph;
  HLSRGB:THLSRGB;
  ser: TFastLineSeries;
  i, j, color_index, step_bright: integer;
  sub_color: TColor;
begin
  frm_Graph:=Tfrm_KolvoOtkazGraph.Create(nil);
  HLSRGB:=THLSRGB.Create;
  try
    with (F_OptionForm as Tfrm_KolvoOtkazOpt) do
    begin
      color_index:=-1;
      step_bright:=(180-30) div Arr_DamagePlaceCount;

      for i:=3 to F_MemTable.Fields.Count-1 do
      begin
        inc(color_index);
        AddSeries(frm_Graph.Chart1, F_MemTable.Fields[i].FieldName, -1, NameCase(F_MemTable.Fields[i].DisplayLabel),
                     AVR_COLORS[color_index],1{Основная});

        for j:=0 to Arr_DamagePlaceCount-1 do
        begin
          try
            sub_color:=HLSRGB.ChangeBrightnesOfColor(AVR_COLORS[color_index],30+j*step_bright);
          except
            sub_color:=clBlack;
          end;

          AddSeries(frm_Graph.Chart1, F_MemTable.Fields[i].FieldName, StrToInt(Arr_DamagePlaceID[j]),
            '*'+NameCase(copy(F_MemTable.Fields[i].DisplayLabel,1,3))+'-'+NameCase(copy(Arr_strDamagePlace[j],1,5)),
            sub_color, 2 {По местам повреждений});
        end; //end for j

      end;  //end for i
    end; //end with
    frm_Graph.ShowModal;
  finally
    frm_Graph.Free;
    HLSRGB.Free;
  end;
end;

procedure TKolvoOtkazov.PrepareDsets;
  procedure Add_dt_dmg_Fields(dt: TDate; dmg_place: string; id_dmg_place: integer);
  begin
    F_MemTable.FieldByName('DT').AsDateTime:=dt;
    F_MemTable.FieldByName('DMG_PLACE').AsString:=dmg_place;
    F_MemTable.FieldByName('ID_DMG_PLACE').AsInteger:=id_dmg_place;
  end;
var
  i, j, k: integer;
  reg_cond: string;
  arr_sum, arr_total_sum: array of integer;
begin
  CreateMemTable;
  F_MemTable.Open;
  SetLength(arr_sum, F_MemTable.Fields.Count-3);
  SetLength(arr_total_sum, F_MemTable.Fields.Count-3);

  for k:=0 to High(arr_total_sum) do
    arr_total_sum[k]:=0;

  with (F_OptionForm as Tfrm_KolvoOtkazOpt) do
  begin
    if RegionsID<>'' then reg_cond:=' and fk_regions in'+RegionsID
    else reg_cond:='';

    for i:=0 to trunc(dt_end)-trunc(dt_begin) do
    begin
      for k:=0 to High(arr_sum) do
        arr_sum[k]:=0;

      for j:=0 to Arr_DamagePlaceCount-1 do
      begin
        MyOpenIBDS(F_Dset[0],
            ' select fk_dmgplace id_dmg,'+
            ' fk_regions id_reg, kol_orders kolvo'+
            ' from REP_GIK_DOP'+
            ' where dt='''+DateToStr(dt_begin+i)+''''+
            ' and fk_dmgplace='+Arr_DamagePlaceID[j]+
            reg_cond);

        F_MemTable.Append;
        Add_dt_dmg_Fields(dt_begin+i, Arr_strDamagePlace[j], StrToInt(Arr_DamagePlaceID[j]));
        F_MemTable.FieldByName('REG_ALL').AsInteger:=0;
        while not F_Dset[0].Eof do
        begin
          F_MemTable.FieldByName('REG_'+trim(F_Dset[0].FieldByName('id_reg').AsString)).AsInteger:=
                                      F_Dset[0].FieldByName('kolvo').AsInteger;
          F_MemTable.FieldByName('REG_ALL').AsInteger:=F_MemTable.FieldByName('REG_ALL').AsInteger+
                                      F_Dset[0].FieldByName('kolvo').AsInteger;
          F_Dset[0].Next;
        end;
        F_MemTable.Post;

        for k:=0 to High(arr_sum) do
          arr_sum[k]:=arr_sum[k]+F_MemTable.Fields[k+3].AsInteger;
      end; //end for j

      {Подсчет "Всего" за день}
      F_MemTable.Append;
      Add_dt_dmg_Fields(dt_begin+i, 'Всего', -1);
      for k:=0 to High(arr_sum) do
      begin
        F_MemTable.Fields[k+3].AsInteger:=arr_sum[k];
        arr_total_sum[k]:=arr_total_sum[k]+arr_sum[k];
      end;
      F_MemTable.Post;
      {/Подсчет "Всего" за день}
    end; //end for i

    {общего "Всего"}
      F_MemTable.Append;
      Add_dt_dmg_Fields(-2, 'Всего', -2);
      for k:=0 to High(arr_total_sum) do
        F_MemTable.Fields[k+3].AsInteger:=arr_total_sum[k];
      F_MemTable.Post;
    {/общего "Всего"}
  end; //end with
end;

procedure TKolvoOtkazov.PrepareFastReport;
begin
 F_frUDSet.RangeEnd:=reCount;
 F_frUDSet.RangeEndCount:=F_MemTable.FieldCount-3;
 F_Report.OnGetValue:=frGetValue;
 if Assigned(F_Report.Preview) and (F_Report.Preview.Owner is Tfrm_FrPreview) then
    (F_Report.Preview.Owner as Tfrm_FrPreview).OnShowGraph:=OnFrShowGraph;

 frVariables['Dt_begin']:=DateToStr((F_OptionForm as Tfrm_KolvoOtkazOpt).dp_Date1.Date);
 frVariables['Dt_end']:=DateToStr((F_OptionForm as Tfrm_KolvoOtkazOpt).dp_Date2.Date);
 frVariables['Regions']:=GetRegionsName;
 frVariables['DamagePlace']:=GetDamagePlaceName;
 if (F_OptionForm as Tfrm_KolvoOtkazOpt).Arr_DamagePlaceCount>1 then
    frVariables['IsHideVsegoByDmg']:='0'
 else
    frVariables['IsHideVsegoByDmg']:='1';
end;

end.
