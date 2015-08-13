unit UniversalSearchForm_vds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RxLookup, Buttons, Mask, ToolEdit, Spin, DB,
  IBCustomDataSet, IBDatabase, DModule, BaseOptionForm, ExtCtrls,
  SelRegionFrame;

type
  Tfrm_UniversalSearch_vds = class(Tfrm_BaseOption)
    sp_NumOrder: TSpinEdit;
    Label1: TLabel;
    lbl_DateComing1: TLabel;
    dp_Coming1: TDateEdit;
    dp_Coming2: TDateEdit;
    lbl_DateComing2: TLabel;
    btn_Officials: TBitBtn;
    btn_MessageType: TBitBtn;
    GroupBox1: TGroupBox;
    dbl_Street: TRxDBLookupCombo;
    Label4: TLabel;
    cb_OrderType: TComboBox;
    Label8: TLabel;
    GroupBox2: TGroupBox;
    btn_DamageType: TBitBtn;
    Label11: TLabel;
    dp_Closed1: TDateEdit;
    dp_Closed2: TDateEdit;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    btn_Brigadiers: TButton;
    Tr_Voc: TIBTransaction;
    dset_Street: TIBDataSet;
    ds_Street: TDataSource;
    Label5: TLabel;
    ed_HouseNum: TEdit;
    ed_PorchNum: TEdit;
    ed_FloorNum: TEdit;
    ed_ApartmentNum: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Bevel1: TBevel;
    ed_HousingNum: TEdit;
    tp_Coming1: TMaskEdit;
    tp_Coming2: TMaskEdit;
    tp_Closed1: TMaskEdit;
    tp_Closed2: TMaskEdit;
    Button1: TButton;
    btn_Region: TBitBtn;
    lbl_SONum: TLabel;
    sp_NumSO: TSpinEdit;
    GroupBox3: TGroupBox;
    cb_workRegion: TComboBox;
    btn_brig: TBitBtn;
    btn_DispCLose: TButton;
    Button2: TButton;
    procedure btn_OfficialsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_MessageTypeClick(Sender: TObject);
    procedure btn_BrigadiersClick(Sender: TObject);
    procedure btn_DamageTypeClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dp_Coming2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure dp_Coming1Change(Sender: TObject);
//    procedure frame_SelRegionbtn_RegionClick(Sender: TObject);
    procedure btn_RegionClick(Sender: TObject);
    procedure btn_brigClick(Sender: TObject);
    procedure cb_workRegionChange(Sender: TObject);
    procedure btn_DispCLoseClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  protected
    F_Officials: string;
    F_Regions: string;
    F_OfficialsClosed: string;
    F_Brigadiers: string;
    F_DamageType: string;
    F_ResultCondition: string;
    F_MessageType: string;

    F_strMessageType: string;
    F_strRegions: string;
    F_strDamageType: string;
    F_strStartDate: string;
    F_strFinishedDate: string;

    F_ShortTableName: string;

    F_Organisation:string;

    F_Brigs:string;
    F_regWork:string;

    F_BrigClose:string;

    procedure AddSubConstraint(var Res: string; Constraint:string);
    procedure EnableAdresCtrls(value: boolean);
    procedure SetRegions;

    procedure OpenDataSets; virtual;
  public
    property ResultCondition: string read F_ResultCondition;
    property strRegions: string read F_strRegions;
    property strDamageType: string read F_strDamageType;
    property strStartDate: string read F_strStartDate;
    property strFinishedDate: string read F_strFinishedDate;
    property strMessageType: string read F_strMessageType;
    property ShortTableName: string write F_ShortTableName;
  end;

var
  frm_UniversalSearch_vds: Tfrm_UniversalSearch_vds;

implementation

{$R *.dfm}

uses SelectItemForm, HelpFunctions;

procedure Tfrm_UniversalSearch_vds.btn_OfficialsClick(Sender: TObject);
var
  SQL, ItemsID, ItemsName: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_officials'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Диспетчер', ItemsID, ItemsName);
  if ItemsID<>'' then
    F_Officials:=Format('%sFK_ORDERS_OFFICIALS in %s',[F_ShortTableName, ItemsID]);
end;

procedure Tfrm_UniversalSearch_vds.FormShow(Sender: TObject);
begin
  F_Officials:='';
  F_Regions:='';
  F_OfficialsClosed:='';
  F_Brigadiers:='';
  F_DamageType:='';
  F_MessageType:='';

  F_strMessageType:='Все';
  F_strRegions:='Все';
  F_strDamageType:='Все';
  F_strStartDate:='';
  F_strFinishedDate:='';
  F_brigs:='';

  F_BrigClose:='';

  if (F_ShortTableName<>'') and (pos('.',F_ShortTableName)=0)  then
    F_ShortTableName:=F_ShortTableName+'.'
  else F_ShortTableName:='o.';


  OpenDataSets;
end;

procedure Tfrm_UniversalSearch_vds.btn_MessageTypeClick(Sender: TObject);
var
  SQL, ItemsID, ItemsName: string;
begin
  SQL:= ' select id ItemID, messagename ItemName'+
        ' from s_messagetypes_vds'+
        ' where id<>-1 and activity is null'+
        ' order by messagename';

  ShowSelectItemsDlg(SQL, 'О чем заявлено', ItemsID, ItemsName);
  if ItemsID<>'' then
    F_MessageType:=Format('%sFK_ORDERS_MESSAGETYPES in %s', [F_ShortTableName, ItemsID]);
end;

procedure Tfrm_UniversalSearch_vds.btn_BrigadiersClick(Sender: TObject);
var
  SQL, ItemsID, ItemsName,s: string;
  p:integer;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_organisations '+
        ' where  activity is null and name  is not null'+
        ' order by name';
  p:=-1;
  ShowSelectItemsDlg(SQL, 'Организация', ItemsID, ItemsName);

  if ItemsID<>'' then begin
   if pos(' 1,',ItemsID)>0 then
    p:=pos(' 1,',ItemsID);
   if ItemsID[length(ItemsID)-1]='1' then
    p:=length(ItemsID)-2;
   if p>=0 then begin
    s:='-';
    insert(s,ItemsID,p+1);
   end;
   F_Organisation:=Format('%sFK_ORDERS_ORGANISATIONS in %s', [F_ShortTableName, ItemsID]);
  end;
end;

procedure Tfrm_UniversalSearch_vds.btn_DamageTypeClick(Sender: TObject);
var
  SQL, ItemsID, ItemsName: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_damagetype_vds'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Тип повреждения', ItemsID, ItemsName);
  if ItemsID<>'' then
  begin
    F_DamageType:=Format('%sFK_ORDERS_DAMAGETYPE in %s', [F_ShortTableName, ItemsID]);
    F_strDamageType:=ItemsName;
  end;
end;

procedure Tfrm_UniversalSearch_vds.btn_okClick(Sender: TObject);
begin
  F_ResultCondition:=' where 1=1';

  if (trim(sp_NumOrder.Text)<>'') and (trim(sp_NumOrder.Text)<>'0') then
    F_ResultCondition:=F_ResultCondition+Format(' and %sOrderNumber=%s', [F_ShortTableName ,sp_NumOrder.Text]);

  if dp_Coming1.Date<>0 then
    F_ResultCondition:=F_ResultCondition+Format(' and %sDatecoming>=''%s %s'' ', [F_ShortTableName, DateToStr(dp_Coming1.Date), tp_Coming1.Text]);

  if dp_Coming2.Date<>0 then
    F_ResultCondition:=F_ResultCondition+Format(' and %sDatecoming<=''%s %s'' ', [F_ShortTableName, DateToStr(dp_Coming2.Date), tp_Coming2.Text ]);

  if dp_Closed1.Date<>0 then
    F_ResultCondition:=F_ResultCondition+Format(' and %sDateClosed>=''%s %s'' ', [F_ShortTableName, DateToStr(dp_Closed1.Date),   tp_Closed1.Text ]);

  if dp_Closed2.Date<>0 then
    F_ResultCondition:=F_ResultCondition+Format(' and %sDateClosed<=''%s %s'' ', [F_ShortTableName, DateToStr(dp_Closed2.Date),   tp_Closed2.Text ]);

  if Tr_Voc.InTransaction then
  begin
    if dset_Street.FieldByName('ID').AsInteger<>-1 then
      F_ResultCondition:=F_ResultCondition+Format(' and %sFK_ORDERS_STREETS=%s',[F_ShortTableName, dset_Street.FieldByName('ID').AsString]);
  end;

  if trim(ed_HouseNum.Text)<>'' then
    F_ResultCondition:=F_ResultCondition+Format(' and %sHouseNum=%s',[F_ShortTableName, QuotedStr(trim(ed_HouseNum.Text))]);

  if trim(ed_HousingNum.Text)<>'' then
    F_ResultCondition:=F_ResultCondition+Format(' and %sHousingNum=%s',[F_ShortTableName, QuotedStr(trim(ed_HousingNum.Text))]);

  if trim(ed_PorchNum.Text)<>'' then
    F_ResultCondition:=F_ResultCondition+Format(' and %sPorchNum=%s',[F_ShortTableName, QuotedStr(trim(ed_PorchNum.Text))]);

  if trim(ed_FloorNum.Text)<>'' then
    F_ResultCondition:=F_ResultCondition+Format(' and %sFloorNum=%s',[F_ShortTableName, QuotedStr(trim(ed_FloorNum.Text))]);

  if trim(ed_ApartmentNum.Text)<>'' then
    F_ResultCondition:=F_ResultCondition+Format(' and %sApartmentNum=%s',[F_ShortTableName, QuotedStr(trim(ed_ApartmentNum.Text))]);

  if cb_OrderType.ItemIndex=1 then       // незакрытые
    F_ResultCondition:=F_ResultCondition+Format(' and %sIsClosed=0', [F_ShortTableName]);

  if cb_OrderType.ItemIndex=2 then    //закрытые
    F_ResultCondition:=F_ResultCondition+Format(' and %sIsClosed=1', [F_ShortTableName]);
 if cb_OrderType.ItemIndex=3 then //отключения
    F_ResultCondition:=' join  disconnections_vds dv on dv.fk_discon_order=o.id '+ F_ResultCondition+
                        ' and dv.dttm_con is null ';

  if ( trim( sp_NumSO.Text ) <> '' ) and ( trim( sp_NumSO.Text ) <> '0' ) then
    F_ResultCondition := F_ResultCondition +
      Format( ' and (%sid in (select id_order from numsorders_vds where number = %s) )',
        [F_ShortTableName, sp_NumSO.Text ] );

   //Работа районов
  case cb_workRegion.ItemIndex of
   0:F_ResultCondition := 'left join regions_works_vds rv on rv.fk_id_order=o.id '+F_ResultCondition; //все
   1:F_ResultCondition := 'left join regions_works_vds rv on rv.fk_id_order=o.id '+F_ResultCondition+
       ' and rv.fk_id_user is null ';//не в работе
   2:F_ResultCondition := ' join regions_works_vds rv on rv.fk_id_order=o.id '+F_ResultCondition+ //в работе
        'and rv.fk_id_user is not  null and  rv.FK_ID_CLOSEDUSED is null';
   3:F_ResultCondition := ' join regions_works_vds rv on rv.fk_id_order=o.id '+F_ResultCondition+ //Выполненно
        ' and rv.fk_id_user is not  null and  rv.fk_id_closedused is not null';
  end;
  AddSubConstraint(F_ResultCondition, F_Officials);

//  SetRegions;
  AddSubConstraint(F_ResultCondition, F_Regions);

  AddSubConstraint(F_ResultCondition, F_MessageType);
  AddSubConstraint(F_ResultCondition, F_OfficialsClosed);
  AddSubConstraint(F_ResultCondition, F_Brigadiers);
  AddSubConstraint(F_ResultCondition, F_DamageType);

  AddSubConstraint(F_ResultCondition, F_Organisation);
  AddSubConstraint(F_ResultCondition, F_brigs);

 AddSubConstraint(F_ResultCondition, F_BrigClose); // бригадир при закрытии наряда
/////////////////////////////////////////////////////
  if dp_Coming1.Date<>0 then
    F_strStartDate:=DateToStr(dp_Coming1.Date)+' '+ tp_Coming1.Text;

  if dp_Coming2.Date<>0 then
    F_strFinishedDate:=DateToStr(dp_Coming2.Date)+' '+tp_Coming2.Text;

  ModalResult:=mrOk;
end;

procedure Tfrm_UniversalSearch_vds.AddSubConstraint(var Res: string;
  Constraint: string);
begin
  if trim(Constraint)<>'' then
    Res:=Res+' and '+Constraint;
end;

procedure Tfrm_UniversalSearch_vds.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Tr_Voc.InTransaction then
    Tr_Voc.Commit;
  //Action:=caFree;
end;

procedure Tfrm_UniversalSearch_vds.EnableAdresCtrls(value: boolean);
begin
  dbl_Street.Enabled:=value;
end;

procedure Tfrm_UniversalSearch_vds.dp_Coming2Change(Sender: TObject);
begin
  if dp_Coming2.Date<>0 then
    F_strFinishedDate:=DateToStr(dp_Coming2.Date);
end;

procedure Tfrm_UniversalSearch_vds.OpenDataSets;
begin
  Tr_Voc.StartTransaction;
  dset_Street.Open;
  ResetDBL(dbl_Street);
end;

procedure Tfrm_UniversalSearch_vds.FormCreate(Sender: TObject);
begin
  F_ShortTableName:='';
  tp_Coming1.Text := '00:00';
  tp_Coming2.Text := '23:59';
  tp_Closed1.Text := '00:00';
  tp_Closed2.Text := '23:59';
end;

procedure Tfrm_UniversalSearch_vds.btn_cancelClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_UniversalSearch_vds.dp_Coming1Change(Sender: TObject);
begin
  inherited;
  if dp_Coming1.Date<>0 then
    F_strStartDate:=DateToStr(dp_Coming1.Date);
end;

procedure Tfrm_UniversalSearch_vds.SetRegions;
//var
 // RegID, RegName: string;
begin
 { frame_SelRegion.SetRegions(RegID, RegName);

  if RegID<>'' then
  begin
    F_Regions:=Format('%sFK_ORDERS_REGIONS in %s', [F_ShortTableName, RegID]);
    F_strRegions:=RegName;
  end;}
end;

{procedure Tfrm_UniversalSearch_vds.frame_SelRegionbtn_RegionClick(
  Sender: TObject);
begin
  inherited;
  frame_SelRegion.btn_RegionClick(Sender);

end;}

procedure Tfrm_UniversalSearch_vds.btn_RegionClick(Sender: TObject);
var
SQL, ItemsID, ItemsName: string;
begin
  inherited;
 SQL:= ' select id ItemID, name ItemName'+
        ' from s_regions'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Район', ItemsID, ItemsName);
  if ItemsID<>'' then
    F_Regions:=Format('%sFK_ORDERS_Regions in %s',[F_ShortTableName, ItemsID]);
end;

procedure Tfrm_UniversalSearch_vds.btn_brigClick(Sender: TObject);
var SQL, ItemsID, ItemsName: string;
begin
  inherited;
  SQL:= ' select id ItemID, name ItemName'+
        ' from brigadiers'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Мастер', ItemsID, ItemsName);
  if ItemsID<>'' then
  begin
    F_Brigs:=Format('  rv.FK_ID_BRIG  in %s',[ ItemsID]);
    F_regWork:=' join REGIONS_WORKS_VDS on %sid=rw.fk_id_order '
  end;

end;

procedure Tfrm_UniversalSearch_vds.cb_workRegionChange(Sender: TObject);
begin
  inherited;
  case cb_workRegion.ItemIndex of
   1: btn_brig.Enabled:=false;
   0,2,3: btn_brig.Enabled:=true;
  end; 
end;

procedure Tfrm_UniversalSearch_vds.btn_DispCLoseClick(Sender: TObject);
var
  SQL, ItemsID, ItemsName: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_officials'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Диспетчер', ItemsID, ItemsName);
  if ItemsID<>'' then
    F_OfficialsClosed:=Format('%sFK_ORDERS_OFFICIALCLOSED in %s', [F_ShortTableName, ItemsID]);
end;



procedure Tfrm_UniversalSearch_vds.Button2Click(Sender: TObject);
var   SQL, ItemsID, ItemsName:string;
begin
  inherited;
   SQL:= ' select id ItemID, name ItemName'+
        ' from brigadiers'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Бригадир', ItemsID, ItemsName);
  if ItemsID<>'' then
   F_BrigClose:=Format(' %sfk_orders_brigadiers in %s ', [F_ShortTableName, ItemsID]);
end;

end.
