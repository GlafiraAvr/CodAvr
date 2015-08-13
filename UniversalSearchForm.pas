unit UniversalSearchForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RxLookup, Buttons, Mask, ToolEdit, Spin, DB,
  IBCustomDataSet, IBDatabase, DModule, BaseOptionForm, ComCtrls, ExtCtrls;

type
  Tfrm_UniversalSearch = class(Tfrm_BaseOption)
    sp_NumOrder: TSpinEdit;
    Label1: TLabel;
    lbl_DateComing1: TLabel;
    dp_Coming1: TDateEdit;
    dp_Coming2: TDateEdit;
    lbl_DateComing2: TLabel;
    btn_Officials: TBitBtn;
    btn_Regions: TBitBtn;
    btn_MessageType: TBitBtn;
    GroupBox1: TGroupBox;
    dbl_Street: TRxDBLookupCombo;
    dbl_HouseType: TRxDBLookupCombo;
    dbl_Street2: TRxDBLookupCombo;
    ed_HouseNum1: TEdit;
    ed_HouseNum2: TEdit;
    Label4: TLabel;
    lbl_vid: TLabel;
    lbl_withstreet: TLabel;
    btn_DamageLocality: TBitBtn;
    btn_DamagePlace: TBitBtn;
    cb_OrderType: TComboBox;
    cb_IsPayed: TComboBox;
    cb_AreClosures: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    GroupBox2: TGroupBox;
    btn_OfficialsClosed: TBitBtn;
    btn_DamageType: TBitBtn;
    btn_TubeDiameter: TBitBtn;
    btn_TubeMaterial: TBitBtn;
    btn_excworktype: TBitBtn;
    Label11: TLabel;
    dp_Closed1: TDateEdit;
    dp_Closed2: TDateEdit;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    btn_Brigadiers: TButton;
    Tr_Voc: TIBTransaction;
    dset_Street: TIBDataSet;
    dset_Street2: TIBDataSet;
    dset_Housetype: TIBDataSet;
    ds_Street: TDataSource;
    ds_Street2: TDataSource;
    ds_HouseType: TDataSource;
    lbl_po: TLabel;
    Label5: TLabel;
    chk_IsCalcLeak: TCheckBox;
    btnNaControle: TBitBtn;
    btn_BrigDep1: TBitBtn;
    sp_NumSO: TSpinEdit;
    lbl_SONum: TLabel;
    tp_Closed1: TMaskEdit;
    tp_Closed2: TMaskEdit;
    tp_Coming1: TMaskEdit;
    tp_Coming2: TMaskEdit;
    IBTransaction1: TIBTransaction;
    dset_street_vds: TIBDataSet;
    DataSource1: TDataSource;
    lbl_ecavpermis: TLabel;
    me_Exorder: TMaskEdit;
    procedure btn_OfficialsClick(Sender: TObject);
    procedure btn_RegionsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_MessageTypeClick(Sender: TObject);
    procedure btn_DamageLocalityClick(Sender: TObject);
    procedure btn_DamagePlaceClick(Sender: TObject);
    procedure btn_OfficialsClosedClick(Sender: TObject);
    procedure btn_BrigadiersClick(Sender: TObject);
    procedure btn_DamageTypeClick(Sender: TObject);
    procedure btn_TubeDiameterClick(Sender: TObject);
    procedure btn_TubeMaterialClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbl_HouseTypeChange(Sender: TObject);
    procedure btn_excworktypeClick(Sender: TObject);
    procedure dp_Coming2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure dp_Coming1Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EntryEnter(Sender: TObject);
    procedure EntryExit(Sender: TObject);
    procedure btnNaControleClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_BrigDep1Click(Sender: TObject);
    procedure btn_MessageType_vdsClick(Sender: TObject);
    procedure btn_DamageType_vdsClick(Sender: TObject);
  protected
    F_Officials: string;
    F_Regions: string;
    F_MessageType: string;
    F_DamageLocality: string;
    F_DamagePlace: string;
    F_OfficialsClosed: string;
    F_Brigadiers: string;
    F_DamageType: string;
    F_TubeDiameter: string;
    F_TubeMaterial: string;
    F_ExcWorkType: string;
    F_ResultCondition: string;
    F_BrigDep1: string;

    F_strRegions: string;
    F_strDamagePlace: string;
    F_strDamageLocality: string;
    F_strDamageType: string;
    F_strTubeMaterial: string;
    F_strExcWorkType: string;
    F_strTubeDiameter: string;
    F_strStartDate: string;
    F_strFinishedDate: string;

    F_ShortTableName: string;
    F_IsCalcLeak: boolean;

    F_Controls:string;
    F_strControls:string;

    procedure AddSubConstraint(var Res: string; Constraint:string);
    procedure EnableAdresCtrls(value: boolean);

    procedure OpenDataSets; virtual;
  public
    property ResultCondition: string read F_ResultCondition;
    property strRegions: string read F_strRegions;
    property strDamagePlace: string read F_strDamagePlace;
    property strDamageLocality: string read F_strDamageLocality;
    property strDamageType: string read F_strDamageType;
    property strTubeMaterial: string read F_strTubeMaterial;
    property strExcWorkType: string read F_strExcWorkType;
    property strTubeDiameter: string read F_strTubeDiameter;
    property strStartDate: string read F_strStartDate;
    property strFinishedDate: string read F_strFinishedDate;
    property ShortTableName: string write F_ShortTableName;
    property IsCalcLeak: boolean read F_IsCalcLeak;
  end;

var
  frm_UniversalSearch: Tfrm_UniversalSearch;

implementation

{$R *.dfm}

uses SelectItemForm, HelpFunctions;


var
  OldColor: TColor;

procedure Tfrm_UniversalSearch.btn_OfficialsClick(Sender: TObject);
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

procedure Tfrm_UniversalSearch.btn_RegionsClick(Sender: TObject);
var
  SQL, ItemsID, ItemsName: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_regions'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Район', ItemsID, ItemsName);
  if ItemsID<>'' then
  begin
    F_Regions:=Format('%sFK_ORDERS_REGIONS in %s', [F_ShortTableName, ItemsID]);
    F_strRegions:=ItemsName;
  end;
end;

procedure Tfrm_UniversalSearch.FormShow(Sender: TObject);
begin
  F_Officials:='';
  F_Regions:='';
  F_MessageType:='';
  F_DamageLocality:='';
  F_DamagePlace:='';
  F_OfficialsClosed:='';
  F_Brigadiers:='';
  F_DamageType:='';
  F_TubeDiameter:='';
  F_TubeMaterial:='';
  F_ExcWorkType:='';
  F_BrigDep1 := '';

  F_strRegions:='Все';
  F_strDamagePlace:='Все';
  F_strDamageLocality:='Все';
  F_strDamageType:='Все';
  F_strTubeMaterial:='Все';
  F_strExcWorkType:='Все';
  F_strTubeDiameter:='Все';
  F_strStartDate:='';
  F_strFinishedDate:='';
  F_Controls:='';

  if (F_ShortTableName<>'') and (pos('.',F_ShortTableName)=0)  then
    F_ShortTableName:=F_ShortTableName+'.'
  else
    F_ShortTableName:='o.';


  OpenDataSets;
end;

procedure Tfrm_UniversalSearch.btn_MessageTypeClick(Sender: TObject);
var
  SQL, ItemsID, ItemsName: string;
begin
  SQL:= ' select id ItemID, messagename ItemName'+
        ' from s_messagetypes'+
//        ' where (id<>-1) and (activity is null) and (S_MT_CATEGORY_ID in (1,4))'+
        ' where (id<>-1) and (S_MT_CATEGORY_ID in (1,4))'+
        ' order by messagename';

  ShowSelectItemsDlg(SQL, 'О чем заявлено', ItemsID, ItemsName);
  if ItemsID<>'' then
    F_MessageType:=Format('%sFK_ORDERS_MESSAGETYPES in %s', [F_ShortTableName, ItemsID]);
end;

procedure Tfrm_UniversalSearch.btn_DamageLocalityClick(Sender: TObject);
var
  SQL, ItemsID, ItemsName: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_damagelocality'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Местность повреждения', ItemsID, ItemsName);
  if ItemsID<>'' then
  begin
    F_DamageLocality:=Format('%sFK_ORDERS_DAMAGELOCALITY in %s', [F_ShortTableName, ItemsID]);
    F_strDamageLocality:=ItemsName;
  end;
end;

procedure Tfrm_UniversalSearch.btn_DamagePlaceClick(Sender: TObject);
var
  SQL, ItemsID, ItemsName: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_damageplace'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Место повреждения', ItemsID, ItemsName);
  if ItemsID<>'' then
  begin
    F_DamagePlace:=Format('%sFK_ORDERS_DAMAGEPLACE in %s', [F_ShortTableName, ItemsID]);
    F_strDamagePlace:=ItemsName;
  end;
end;

procedure Tfrm_UniversalSearch.btn_OfficialsClosedClick(Sender: TObject);
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

procedure Tfrm_UniversalSearch.btn_BrigadiersClick(Sender: TObject);
var
  SQL, ItemsID, ItemsName: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from brigadiers'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Бригадир', ItemsID, ItemsName);
  if ItemsID<>'' then
    F_Brigadiers := Format( ' %sID in '+
                            ' (select fk_departures_orders'+
                            ' from departures'+
                            ' where depnumber<>1 and'+
                            ' fk_departures_brigadiers in %s)', [F_ShortTableName, ItemsID]);
end;

procedure Tfrm_UniversalSearch.btn_DamageTypeClick(Sender: TObject);
var
  SQL, ItemsID, ItemsName: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_damagetype'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Тип повреждения', ItemsID, ItemsName);
  if ItemsID<>'' then
  begin
    F_DamageType:=Format('%sFK_ORDERS_DAMAGETYPE in %s', [F_ShortTableName, ItemsID]);
    F_strDamageType:=ItemsName;
  end;
end;

procedure Tfrm_UniversalSearch.btn_TubeDiameterClick(Sender: TObject);
var
  SQL, ItemsID, ItemsName: string;
begin
  SQL:= ' select id ItemID, diameter ItemName'+
        ' from s_tubediameter'+
        ' where id<>-1 and activity is null'+
        ' order by diameter';

  ShowSelectItemsDlg(SQL, 'Диаметер', ItemsID, ItemsName);
  if ItemsID<>'' then
  begin
    F_TubeDiameter:=Format('%sFK_ORDERS_DIAMETERS in %s', [F_ShortTableName, ItemsID]);
    F_strTubeDiameter:=ItemsName;
  end;
end;

procedure Tfrm_UniversalSearch.btn_TubeMaterialClick(Sender: TObject);
var
  SQL, ItemsID, ItemsName: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_tubematerial'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Материал трубы', ItemsID, ItemsName);
  if ItemsID<>'' then
  begin
    F_TubeMaterial:=Format('%sFK_ORDERS_TUBEMATERIAL in %s', [F_ShortTableName, ItemsID]);
    F_strTubeMaterial:=ItemsName;
  end;
end;

procedure Tfrm_UniversalSearch.btn_okClick(Sender: TObject);
  function GetHouseNumCond: string;
  var
    hn1, hn2: string;
  begin
    Result := '';
    hn1 :=  FormatHouseNum( ed_HouseNum1.Text);
    hn2 :=  FormatHouseNum( ed_HouseNum2.Text);

    if (hn1<>'') and (hn2='') then
    begin
      //Result := Format( ' and Is_HouseNum_Equal(%sHouseNum, ''%s'')=1', [F_ShortTableName, hn1] )
      Result := Format( ' and (upper(%sHouseNum) = ''%s'')', [F_ShortTableName, hn1] )
    end else
    begin
      if hn1<>'' then
        //Result := Format( ' and str_to_int(%sHouseNum)>=%d', [F_ShortTableName, Str_To_Int( hn1 )] );
        Result := Format( ' and trim(o.housenum) <> '''' and (select INTVAL from TOINT(%sHouseNum))>=%d', [F_ShortTableName, Str_To_Int( hn1 )] );
      if hn2<>'' then
        //Result := Result+Format( ' and str_to_int(%sHouseNum)<=%d',[F_ShortTableName, Str_To_Int( hn2 )]);
        Result := Result+Format( ' and (select INTVAL from TOINT(%sHouseNum))<=%d',[F_ShortTableName, Str_To_Int( hn2 )]);
    end;
  end;
begin
  F_ResultCondition:=' where 1=1';

  if (trim(sp_NumOrder.Text)<>'') and (trim(sp_NumOrder.Text)<>'0') then
    F_ResultCondition:=F_ResultCondition+Format(' and %sOrderNumber=%s', [F_ShortTableName ,sp_NumOrder.Text]);

  if ( trim( sp_NumSO.Text ) <> '' ) and ( trim( sp_NumSO.Text ) <> '0' ) then
    F_ResultCondition := F_ResultCondition +
      Format( ' and (%sid in (select id_order from numsorders where number = %s) )',
        [F_ShortTableName, sp_NumSO.Text ] );
  if ( trim( me_Exorder.Text ) <> '' ) and ( trim( me_Exorder.Text ) <> '0' ) then
    F_ResultCondition := F_ResultCondition +
      Format( ' and (%sid in (select FK_EXCINFO_ORDERS from EXCAVATIONSINFO where EXORDER = ''%s'') )',
        [F_ShortTableName, me_Exorder.Text ] );


  if dp_Coming1.Date<>0 then
    F_ResultCondition:=F_ResultCondition+Format(' and %sDatecoming>=''%s '+ tp_Coming1.text + ''' ', [F_ShortTableName, DateToStr(dp_Coming1.Date)]);

  if dp_Coming2.Date<>0 then
    F_ResultCondition:=F_ResultCondition+Format(' and %sDatecoming<=''%s '+ tp_Coming2.text + ''' ', [F_ShortTableName, DateToStr(dp_Coming2.Date)]);

  if dp_Closed1.Date<>0 then
    F_ResultCondition:=F_ResultCondition+Format(' and %sDateClosed>=''%s '+ tp_Closed1.Text + ''' ', [F_ShortTableName, DateToStr(dp_Closed1.Date)]);

  if dp_Closed2.Date<>0 then
    F_ResultCondition:=F_ResultCondition+Format(' and %sDateClosed<=''%s '+ tp_Closed2.Text + ''' ', [F_ShortTableName, DateToStr(dp_Closed2.Date)]);

  if Tr_Voc.InTransaction then
  begin
    if dset_Street.FieldByName('ID').AsInteger<>-1 then
      F_ResultCondition:=F_ResultCondition+Format(' and %sFK_ORDERS_STREETS=%s',[F_ShortTableName, dset_Street.FieldByName('ID').AsString]);

    if dset_HouseType.FieldByName('ID').AsInteger=0 then
    begin
      F_ResultCondition := F_ResultCondition + GetHouseNumCond;
      {
      if trim(ed_HouseNum1.Text)<>'' then
        F_ResultCondition:=F_ResultCondition+Format(' and str_to_int(%sHouseNum)>=%s',[F_ShortTableName, ed_HouseNum1.Text]);
      if trim(ed_HouseNum2.Text)<>'' then
        F_ResultCondition:=F_ResultCondition+Format(' and str_to_int(%sHouseNum)<=%s',[F_ShortTableName, ed_HouseNum2.Text]);
      }
    end;

    if (dset_HouseType.FieldByName('ID').AsInteger=1) and
      (dset_Street2.FieldByName('ID').AsInteger<>-1) then
      F_ResultCondition:=F_ResultCondition+Format(' and %sHouseNum=''%s''', [F_ShortTableName, dset_Street2.FieldByName('ID').AsString]);
  end;

  if cb_OrderType.ItemIndex=1 then       // незакрытые
    F_ResultCondition:=F_ResultCondition+Format(' and %sIsClosed=0', [F_ShortTableName]);

  if cb_OrderType.ItemIndex=2 then    //закрытые
    F_ResultCondition:=F_ResultCondition+Format(' and %sIsClosed=1', [F_ShortTableName]);
  //отключения связь c disconnections
  if cb_OrderType.ItemIndex=3 then //отключения
   f_ResultCondition:=' join disconnections d on d.fk_id_order=o.id '+F_ResultCondition +
                       ' and d.dttm_con is null ';

  if cb_IsPayed.ItemIndex=1 then
    F_ResultCondition:=F_ResultCondition+Format(' and %sIsPayed=0', [F_ShortTableName]);

  if cb_IsPayed.ItemIndex=2 then
    F_ResultCondition:=F_ResultCondition+Format(' and %sIsPayed=1', [F_ShortTableName]);

  AddSubConstraint(F_ResultCondition, F_Officials);
  AddSubConstraint(F_ResultCondition, F_Regions);
  AddSubConstraint(F_ResultCondition, F_MessageType);
  AddSubConstraint(F_ResultCondition, F_DamageLocality);
  AddSubConstraint(F_ResultCondition, F_DamagePlace);
  AddSubConstraint(F_ResultCondition, F_OfficialsClosed);
  AddSubConstraint(F_ResultCondition, F_Brigadiers);
  AddSubConstraint(F_ResultCondition, F_DamageType);
  AddSubConstraint(F_ResultCondition, F_TubeDiameter);
  AddSubConstraint(F_ResultCondition, F_TubeMaterial);
  AddSubConstraint(F_ResultCondition, F_ExcWorkType);
  AddSubConstraint(F_ResultCondition, F_BrigDep1);
/////////////////////////////////////////////////////
  AddSubConstraint(F_ResultCondition,F_Controls);
//
  if dp_Coming1.Date<>0 then
    F_strStartDate:=DateToStr(dp_Coming1.Date);

  if dp_Coming2.Date<>0 then
    F_strFinishedDate:=DateToStr(dp_Coming2.Date);

  F_IsCalcLeak:=chk_IsCalcLeak.Checked;  

  ModalResult:=mrOk;
end;

procedure Tfrm_UniversalSearch.AddSubConstraint(var Res: string;
  Constraint: string);
begin
  if trim(Constraint)<>'' then
    Res:=Res+' and '+Constraint;
end;

procedure Tfrm_UniversalSearch.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  if Tr_Voc.InTransaction then
//    Tr_Voc.Commit;
//  Action:=caFree;
end;

procedure Tfrm_UniversalSearch.EnableAdresCtrls(value: boolean);
begin
  dbl_Street.Enabled:=value;
  dbl_Housetype.Enabled:=value;
  dbl_Street2.Enabled:=value;
  ed_HouseNum1.Enabled:=value;
  ed_HouseNum2.Enabled:=value;
end;

procedure Tfrm_UniversalSearch.dbl_HouseTypeChange(Sender: TObject);
begin
  case dset_HouseType.FieldByName('ID').AsInteger of
    0: //Улица, № дома
      begin
        dbl_Street2.Visible:=false;
        ed_HouseNum1.Visible:=true;
        ed_HouseNum2.Visible:=true;

        lbl_vid.Visible:=true;
        lbl_po.Visible:=true;
        lbl_withstreet.Visible:=false;
      end;
    1: //Пересение улиц
      begin
        dbl_Street2.Visible:=true;
        ed_HouseNum1.Visible:=false;
        ed_HouseNum2.Visible:=false;

        lbl_vid.Visible:=false;
        lbl_po.Visible:=false;
        lbl_withstreet.Visible:=true;
      end;
    2: //Местность
      begin
        dbl_Street2.Visible:=false;
        ed_HouseNum1.Visible:=false;
        ed_HouseNum2.Visible:=false;

        lbl_vid.Visible:=false;
        lbl_po.Visible:=false;
        lbl_withstreet.Visible:=false;
      end;
  end; //end case
end;

procedure Tfrm_UniversalSearch.btn_excworktypeClick(Sender: TObject);
var
  SQL, ItemsID, ItemsName: string;
begin
  SQL:= ' select id ItemID, workname ItemName'+
        ' from s_excavationworktypes'+
        ' where id<>-1 and activity is null'+
        ' order by workname';

  ShowSelectItemsDlg(SQL, 'Засыпано(раскопано)', ItemsID, ItemsName);
  if ItemsID<>'' then
  begin
    F_ExcWorkType:=Format('%sLastExcWrkType in %s', [F_ShortTableName, ItemsID]);
    F_strExcWorkType:=ItemsName;
  end;
end;

procedure Tfrm_UniversalSearch.dp_Coming2Change(Sender: TObject);
begin
  if dp_Coming2.Date<>0 then
    F_strFinishedDate:=DateToStr(dp_Coming2.Date);
end;

procedure Tfrm_UniversalSearch.OpenDataSets;
begin
  if not Tr_Voc.InTransaction then
  begin
    Tr_Voc.StartTransaction;
    dset_Street.Open;
    dset_Street2.Open;
    dset_HouseType.Open;
  end;
  dset_HouseType.First;
  dbl_HouseType.DisplayValue:=dset_HouseType.FieldByName('name').AsString;
  ResetDBL(dbl_Street);
  ResetDBL(dbl_Street2);
end;

procedure Tfrm_UniversalSearch.FormCreate(Sender: TObject);
begin
  F_ShortTableName:='';

  tp_Coming1.Text := '00:00';
  tp_Closed1.Text := '00:00';
  tp_Coming2.Text := '23:59';
  tp_Closed2.Text := '23:59';

end;

procedure Tfrm_UniversalSearch.btn_cancelClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_UniversalSearch.dp_Coming1Change(Sender: TObject);
begin
  inherited;
  if dp_Coming1.Date<>0 then
    F_strStartDate:=DateToStr(dp_Coming1.Date);
end;

procedure Tfrm_UniversalSearch.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_RETURN then
  begin
    if (Sender is TRxDBLookupCombo) then
    begin
      if not (Sender as TRxDBLookupCombo).IsDropDown then
        SelectNext(ActiveControl, true, true);
    end else SelectNext(ActiveControl, true, true);
  end;
end;

procedure Tfrm_UniversalSearch.EntryEnter(Sender: TObject);
begin
  if Sender is TRXDBLookupCombo then
  begin
    OldColor:=(Sender as TRXDBLookupCombo).color;
    (Sender as TRXDBLookupCombo).color := clLime;
  end else
  if Sender is TEdit then
  begin
     OldColor:=(Sender as TEdit).Color;
     (Sender as TEdit).Color :=  clLime;
  end else
  if Sender is TSpinEdit then
  begin
     OldColor:=(Sender as TSpinEdit).Color;
     (Sender as TSpinEdit).Color :=clLime;
  end else
  if Sender is TComboBox then
  begin
     OldColor:=(Sender as TComboBox).Color;
     (Sender as TComboBox).Color :=  clLime;
  end else
  if Sender is TDateEdit then
  begin
    OldColor:=(sender as TDateEdit).Color;
    (sender as TDateEdit).Color := clLime;
  end;
end;

procedure Tfrm_UniversalSearch.EntryExit(Sender: TObject);
begin
  if Sender is TRXDBLookupCombo then
  begin
    (Sender as TRXDBLookupCombo).color :=OldColor;
  end else
  if Sender is TEdit then
  begin
     (Sender as TEdit).Color :=OldColor;
  end else
  if Sender is TSpinEdit then
  begin
     (Sender as TSpinEdit).Color :=OldColor;
  end else
  if Sender is TComboBox then
  begin
     (Sender as TComboBox).Color :=OldColor;
  end else
  if Sender is TDateEdit then
  begin
    (sender as TDateEdit).Color :=OldColor;
  end;
end;

procedure Tfrm_UniversalSearch.btnNaControleClick(Sender: TObject);

var
  SQL, ItemsID, ItemsName: string;
  
begin
  inherited;

  // заявка на котроле

  SQL:= ' select id ItemID, name ItemName'+
        ' from S_ORGANISATIONS'+
        ' where ( id<>-1 ) and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Заявка на контроле', ItemsID, ItemsName);
  
  if ItemsID<>'' then
  begin
    F_Controls:=Format('%sFK_ORDERS_ORGANISATIONS in %s', [F_ShortTableName, ItemsID]);
    F_strControls:=ItemsName;
  end;

end;

procedure Tfrm_UniversalSearch.FormDestroy(Sender: TObject);
begin
  inherited;
  if Tr_Voc.InTransaction then Tr_Voc.Commit;
end;

procedure Tfrm_UniversalSearch.btn_BrigDep1Click(Sender: TObject);
var
  SQL, ItemsID, ItemsName: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from brigadiers'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Бригадир', ItemsID, ItemsName);
  if ItemsID<>'' then
    F_BrigDep1 := Format( ' %sID in '+
                          ' (select fk_departures_orders'+
                          ' from departures'+
                          ' where depnumber=1 and'+
                          ' fk_departures_brigadiers in %s)', [F_ShortTableName, ItemsID]);
end;

procedure Tfrm_UniversalSearch.btn_MessageType_vdsClick(Sender: TObject);
 var
  SQL, ItemsID, ItemsName: string;
begin
  inherited;
SQL:= ' select id ItemID, messagename ItemName'+
        ' from s_messagetypes_vds'+
//        ' where (id<>-1) and (activity is null) and (S_MT_CATEGORY_ID in (1,4))'+
        ' where (id<>-1) and (S_MT_CATEGORY_ID in (1,4))'+
        ' order by messagename';

  ShowSelectItemsDlg(SQL, 'О чем заявлено', ItemsID, ItemsName);
  if ItemsID<>'' then
    F_MessageType:=Format('%sFK_ORDERS_MESSAGETYPES in %s', [F_ShortTableName, ItemsID]);
end;

procedure Tfrm_UniversalSearch.btn_DamageType_vdsClick(Sender: TObject);
var
  SQL, ItemsID, ItemsName: string;
begin
  inherited;

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

end.
