unit DisconForm_vds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseGridForm, DB, IBCustomDataSet, IBDatabase, ComCtrls, Grids,
  DBGrids, StdCtrls, Buttons, Mask, DBCtrls, RxLookup, ExtCtrls, DModule,
  ToolEdit, RXDBCtrl, DBCtrlsEh;


type
  Tfrm_Discon = class(Tfrm_BaseGrid)
    TabC: TTabControl;
    dset_DisconType: TIBDataSet;
    dset_street_: TIBDataSet;
    dset_mainID: TIntegerField;
    dset_mainFK_DISCON_STREET: TIntegerField;
    dset_mainHOUSENUM: TIBStringField;
    dset_mainHOUSINGNUM: TIBStringField;
    dset_mainPORCHNUM: TIBStringField;
    dset_mainFLOORNUM: TIBStringField;
    dset_mainAPARTMENTNUM: TIBStringField;
    dset_mainFK_DISCON_ORDER: TIntegerField;
    dset_mainFK_DISCON_DISCONTYPE: TIntegerField;
    dset_mainDTTM_DISCON: TDateTimeField;
    dset_mainDTTM_CON: TDateTimeField;
    ds_Street_: TDataSource;
    ds_DisconType: TDataSource;
    dbl_DisconType: TRxDBLookupCombo;
    de_Discon: TDBDateEdit;
    de_Con: TDBDateEdit;
    dset_mainADRES: TIBStringField;
    gb_Adres: TGroupBox;
    Label1: TLabel;
    dbl_street_: TRxDBLookupCombo;
    Label2: TLabel;
    dbe_HouseNum: TDBEdit;
    Label3: TLabel;
    dbe_HousingNum: TDBEdit;
    Label4: TLabel;
    dbe_PorchNum: TDBEdit;
    dbe_FloorNum: TDBEdit;
    dbe_ApartmentNum: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    te_Discon: TDBDateTimeEditEh;
    te_Con: TDBDateTimeEditEh;
    Label10: TLabel;
    Label11: TLabel;
    dset_mainDISCONTYPE: TIBStringField;
    dbl_DisconReason: TRxDBLookupCombo;
    dset_mainFK_DISCON_DISCONREASON: TIntegerField;
    dset_mainFK_DISCON_EXECUTOR: TIntegerField;
    dset_mainDISCONREASON: TIBStringField;
    dset_mainEXECUTOR: TIBStringField;
    dset_DisconReason: TIBDataSet;
    dset_Executor: TIBDataSet;
    ds_DisconReason: TDataSource;
    ds_Executor: TDataSource;
    Label12: TLabel;
    dbl_Executor: TRxDBLookupCombo;
    Label13: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label14: TLabel;
    dset_BrigConnect: TIBDataSet;
    ds_BrigConnect: TDataSource;
    dbl_BrigConnect: TRxDBLookupCombo;
    dset_mainFK_DISCON_BRIG_CONNECT: TIntegerField;
    dset_mainBRIG_CONNECT: TIBStringField;
    l_addinfo: TLabel;
    DBE_Addinfo: TDBEdit;
    dset_mainADDITIONALINFO: TStringField;
    Label15: TLabel;
    de_plan: TDBDateEdit;
    Label16: TLabel;
    te_plan: TDBDateTimeEditEh;
    dset_mainDTTM_PLAN: TDateTimeField;
    dset_mainG_KV: TIntegerField;
    dset_mainG_POD: TIntegerField;
    dset_mainG_ZHD: TIntegerField;
    dset_mainG_STOJ: TIntegerField;
    Label17: TLabel;
    DBE_ATG: TDBEdit;
    Label18: TLabel;
    dset_mainG_ST_SP: TIntegerField;
    GroupBox1: TGroupBox;
    Label19: TLabel;
    DB_G_KV: TDBEdit;
    Label20: TLabel;
    DB_G_ZHD: TDBEdit;
    Label21: TLabel;
    dbe_g_stoj: TDBEdit;
    Label22: TLabel;
    DBE_st_sp: TDBEdit;
    dset_mainG_ATG: TSmallintField;
    DBE_gv: TDBEdit;
    ComboBox1: TComboBox;
    dset_mainG_GV: TIBStringField;
    Label23: TLabel;
    DBE_g_pod: TDBEdit;
    procedure btn_InsertClick(Sender: TObject);
    procedure dset_mainAfterOpen(DataSet: TDataSet);
    procedure dset_mainAfterDelete(DataSet: TDataSet);
    procedure dset_mainAfterScroll(DataSet: TDataSet);
    procedure btn_CancelClick(Sender: TObject);
    procedure dbg_MainDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure TabCChanging(Sender: TObject; var AllowChange: Boolean);
    procedure TabCChange(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure dbl_DisconTypeChange(Sender: TObject);
  protected
    class function GetGUID: string; override;
  protected
    procedure InitVocDsetList; override;
    procedure EnableCtrls(value: boolean); override;
    function IsDateCorrect: boolean; override;
    function IsDataFieldsCorrect: boolean; override;
  private
    F_RecordCount: integer;
    procedure SetRecordCount(value: integer);
  private
    F_IDStreet: integer;
    F_HouseNum: string;
    F_HousingNum: string;
    F_PorchNum: string;
    F_FloorNum: string;
    F_ApartmentNum: string;
   function StrSearch(all_str:string; inpstr:string):integer;   //01.12.2011.
  public
    property IDStreet: integer read F_IDStreet write F_IDStreet;
    property HouseNum: string read F_HouseNum write F_HouseNum;
    property HousingNum: string read F_HousingNum write F_HousingNum;
    property PorchNum: string read F_PorchNum write F_PorchNum;
    property FloorNum: string read F_FloorNum write F_FloorNum;
    property ApartmentNum: string read F_ApartmentNum write F_ApartmentNum;
  end;


implementation

{$R *.dfm}

uses HelpFunctions, AppGUIDS;

{ Tfrm_Discon }

procedure Tfrm_Discon.EnableCtrls(value: boolean);
begin
  inherited;
  dbl_street_.Enabled:=value;
  dbe_HouseNum.Enabled:=value;
  dbe_HousingNum.Enabled:=value;
  dbe_PorchNum.Enabled:=value;
  dbe_FloorNum.Enabled:=value;
  dbe_ApartmentNum.Enabled:=value;
  dbl_DisconType.Enabled:=value;
  dbl_DisconReason.Enabled:=value;
  dbl_Executor.Enabled:=value;
  dbl_BrigConnect.Enabled:=value;
  de_Discon.Enabled:=value;
  de_Con.Enabled:=value;
  de_plan.Enabled:=value;
  te_plan.Enabled:=value;
  te_discon.Enabled:=value;
  te_con.Enabled:=value;
  DBE_Addinfo.Enabled := value;

   //glasha 08.05.12
  dbe_gv.Enabled:=value;
  dbe_ATG.Enabled:=value;
  db_G_KV.Enabled:=value;
  db_G_ZHD.Enabled:=value;
  dbe_g_stoj.Enabled:=value;
  DBE_st_sp.Enabled:=value;


end;

procedure Tfrm_Discon.btn_InsertClick(Sender: TObject);
begin
  inherited btn_InsertClick(Sender);
  dset_Main.FieldByName('fk_discon_order').AsInteger:=F_OrderID;
  dset_Main.FieldByName('fk_discon_street').AsInteger:=F_IDStreet;
  dset_Main.FieldByName('HouseNum').AsString:=F_HouseNum;
  dset_Main.FieldByName('HousingNum').AsString:=F_HousingNum;
  dset_Main.FieldByName('PorchNum').AsString:=F_PorchNum;
  dset_Main.FieldByName('FloorNum').AsString:=F_FloorNum;
  dset_Main.FieldByName('ApartmentNum').AsString:=F_ApartmentNum;

  TabC.Tabs.Add('Новый');
  TabC.TabIndex:=TabC.Tabs.Count-1;

  ActiveControl:=dbl_street_;
end;

procedure Tfrm_Discon.SetRecordCount(value: integer);
var
  i: integer;
begin
  F_RecordCount:=value;

  TabC.Tabs.Clear;
  for i:=1 to F_RecordCount do
    TabC.Tabs.Add('N'+IntToStr(i));
  TabC.TabIndex:=dset_Main.RecNo-1;

  Caption:='Отключения - Всего отключений: '+IntToStr(F_RecordCount);
end;

procedure Tfrm_Discon.dset_mainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  dset_Main.Last;
  SetRecordCount(dset_main.RecordCount);
  dset_Main.First;
  //Cb_gv.Text:=dset_Main.FieldValues['g_gv'].asstring;
end;

procedure Tfrm_Discon.dset_mainAfterDelete(DataSet: TDataSet);
begin
  inherited;
  SetRecordCount(dset_main.RecordCount);
end;

procedure Tfrm_Discon.dset_mainAfterScroll(DataSet: TDataSet);
begin
  inherited;
  TabC.TabIndex:=dset_Main.RecNo-1;
  
end;

procedure Tfrm_Discon.btn_CancelClick(Sender: TObject);
begin
  if (dset_Main.State=dsInsert) and (TabC.Tabs.Count>0) then
    TabC.Tabs.Delete(TabC.Tabs.Count-1);

  inherited btn_CancelClick(Sender);
end;

procedure Tfrm_Discon.dbg_MainDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  with (Sender as TDBGrid) do
  begin
    if dset_Main.FieldByName('DTTM_CON').IsNull then
      Canvas.Brush.Color:=clWindow
    else
      Canvas.Brush.Color:=clGrayText;
    Canvas.Font.Color:=clWindowText;
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

function Tfrm_Discon.IsDateCorrect: boolean;
begin
  Result:=false;

  if dset_Main.FieldByName('DTTM_DISCON').IsNull then
  begin
    ProcessStatus:='Введите дату и время отключения';
    ActiveControl:=de_discon;
    exit;
  end;

  if dset_Main.FieldByName('DTTM_DISCON').AsDateTime>Now then
  begin
    ProcessStatus:='Дата и время отключения не могут быть больше текущих';
    ActiveControl:=te_Discon;
    exit;
  end;

  if (not dset_Main.FieldByName('DTTM_CON').IsNull)
    and (dset_Main.FieldByName('DTTM_CON').AsDateTime>Now) then
  begin
    ProcessStatus:='Дата и время включения не могут быть больше текущих';
    ActiveControl:=te_Con;
    exit;
  end;

  if (not dset_Main.FieldByName('DTTM_CON').IsNull)
  and (dset_Main.FieldByName('DTTM_CON').AsDateTime<dset_Main.FieldByName('DTTM_DISCON').AsDateTime) then
  begin
    ProcessStatus:='Включение не может быть раньше отключения';
    ActiveControl:=te_Con;
    exit;
  end;

  Result:=true;
end;

function Tfrm_Discon.IsDataFieldsCorrect: boolean;
begin
  Result:=false;

  {
  if IsDBLEmpty(dbl_DisconType) then
  begin
    ActiveControl:=dbl_DisconType;
    SetProcessStatus('Введите тип отключения');
    exit;
  end;
  }

  if IsDBLEmpty(dbl_street_) then
  begin
    ActiveControl:=dbl_street_;
    SetProcessStatus('Введите улицу');
    exit;
  end;


  if trim(dbe_Housenum.Text)='' then
  begin
    ActiveControl:=dbe_Housenum;
    SetProcessStatus('Введите номер дома');
    exit;
  end;

  if (not dset_Main.FieldByName('dttm_discon').IsNull)
      and (IsDBLEmpty(dbl_Executor)) then
  begin
    ActiveControl:=dbl_Executor;
    SetProcessStatus('Введите исполнителя откл.');
    exit;
  end;


  if (not dset_Main.FieldByName('dttm_con').IsNull)
      and (IsDBLEmpty(dbl_BrigConnect)) then
  begin
    ActiveControl:=dbl_BrigConnect;
    SetProcessStatus('Введите ответственного за включение');
    exit;
  end;


  Result:=true;
end;

procedure Tfrm_Discon.TabCChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  if dset_Main.State in [dsInsert, dsEdit] then
  begin
    AllowChange:=false;
    SetProcessStatus('Отмените или сохраните изменения');
  end else
  begin
    AllowChange:=true;
  end;
end;

procedure Tfrm_Discon.TabCChange(Sender: TObject);
begin
  inherited;
  dset_Main.RecNo:=TabC.TabIndex+1;
end;

class function Tfrm_Discon.GetGUID: string;
begin
  Result:=DISCONFORMGUID_vds;
end;

procedure Tfrm_Discon.InitVocDsetList;
begin
  inherited;
  F_VocDsetList.Add(dset_street_);
  F_VocDsetList.Add(dset_DisconType);
  F_VocDsetList.Add(dset_DisconReason);
  F_VocDsetList.Add(dset_Executor);
  F_VocDsetList.Add(dset_BrigConnect);
end;

procedure Tfrm_Discon.btn_PostClick(Sender: TObject);
var s,sv:string;
p,val:integer;
begin

  { dset_mainG_STOJ.Value:=2;}
  inherited;

end;

function Tfrm_Discon.StrSearch(all_str:string; inpstr:string):integer; //01.12.2011.
 var sv:string;
 p,val:integer;
begin
  p:=pos(PChar(inpstr),PCHar(all_str))-1;
  if p<0 then Result:=0
  else
   begin
    while all_str[p]=' ' do p:=p-1;
    sv:='';
    while (all_str[p]>='0') and (all_str[p]<='9')  and (p>0) do
    begin
     sv:=all_str[p]+sv;
     p:=p-1;
    end ;
    if sv='' then Result:=1
             else Result:=StrToInt(sv);
   end;
end;
procedure Tfrm_Discon.ComboBox1Select(Sender: TObject);
begin
  inherited;
dbe_gv.Text:=ComboBox1.Text;
end;

procedure Tfrm_Discon.dbl_DisconTypeChange(Sender: TObject);
begin
  inherited;
  CtrlsChange(Sender);
   if (dset_main.State=dsInsert)or (dset_main.State=dsEdit) then
if  dbl_DisconType.Text<>'' then  begin
  dset_mainG_KV.Value:=StrSearch(dbl_DisconType.Text,'кв');
  dset_mainG_Pod.Value:=StrSearch(dbl_DisconType.Text,'под');
  dset_mainG_ZHD.Value:=StrSearch(dbl_DisconType.Text,'дом');
  dset_mainG_STOJ.Value:=StrSearch(dbl_DisconType.Text,'стоя');
end;
end;

end.
