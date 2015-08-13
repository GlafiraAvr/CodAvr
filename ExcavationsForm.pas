unit ExcavationsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseGridForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, Mask, DBCtrls, RxLookup, ExtCtrls, DBCtrlsEh,
  ToolEdit, RXDBCtrl, ComCtrls, DModule, IBSQL;

const
  ID_RASKOPANO=9;
  ID_PRISIP=2;
  ID_NERASKOP=4;
  TO_ADD_DatePlan='Введите дату плана окончания работ и "Благоустроитель"!';

type
  TFixAction = (faInsert, faUpdate, faDelete);

  Tfrm_Excavations = class(Tfrm_BaseGrid)
    dp_Start: TDBDateEdit;
    dbl_brigadiers: TRxDBLookupCombo;
    dbl_brigadiersend: TRxDBLookupCombo;
    dbl_Officials: TRxDBLookupCombo;
    dbl_Equipment: TRxDBLookupCombo;
    dbl_WorkType: TRxDBLookupCombo;
    tp_Start: TDBDateTimeEditEh;
    dset_Officials: TIBDataSet;
    dset_Brigadiers: TIBDataSet;
    dset_Brigadiersend: TIBDataSet;
    dset_WorkType: TIBDataSet;
    dset_Equipment: TIBDataSet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ed_Square: TDBNumberEditEh;
    ds_officials: TDataSource;
    ds_Brigadiers: TDataSource;
    ds_Brigadiersend: TDataSource;
    ds_WorkType: TDataSource;
    ds_Equipment: TDataSource;
    dset_mainID: TIntegerField;
    dset_mainDTIME: TDateTimeField;
    dset_mainFK_EXCAVATIONS_ORDERS: TIntegerField;
    dset_mainFK_EXCAVATIONS_OFFICIALS: TIntegerField;
    dset_mainFK_EXCAVATIONS_BRIGADIERS: TIntegerField;
    dset_mainFK_EXCAVATIONS_BRIGADIERSEND: TIntegerField;
    dset_mainFK_EXCAVATIONS_EXCWT: TIntegerField;
    dset_mainFK_EXCAVATIONS_EQUIPMENT: TIntegerField;
    dset_mainSQUARE: TFloatField;
    dset_mainFK_EXCAVATIONS_HOUSETYPE: TIntegerField;
    dset_mainFK_EXCAVATIONS_STREETS: TIntegerField;
    dset_mainHOUSENUM: TIBStringField;
    dset_mainADRES: TIBStringField;
    pnl_Additional: TPanel;
    mem_AdditionalInfo: TMemo;
    lbl_AddInfo: TLabel;
    Label9: TLabel;
    Bevel1: TBevel;
    dset_mainOFFICIALS: TIBStringField;
    dset_mainBRIG: TIBStringField;
    dset_mainBRIGSEND: TIBStringField;
    dset_mainEXCWT: TIBStringField;
    dset_mainEQUIP: TIBStringField;
    dset_mainOFFICIALPOST: TIntegerField;
    DBL_AsfCompany: TRxDBLookupCombo;
    Label10: TLabel;
    dset_AsfCompany: TIBDataSet;
    ds_AsfCompany: TDataSource;
    dset_mainAsfcompany: TStringField;
    dset_mainFK_EXCAVATIONS_ASFCOMPANY: TIntegerField;
    dset_mainEXCNUMBER: TIntegerField;
    dset_mainEXCORDER: TIBStringField;
    dset_mainDTTM_EXCORD: TDateTimeField;
    L_DTTM_Exord: TLabel;
    l_Exnum: TLabel;
    L_Exorder: TLabel;
    L_Planendwork: TLabel;
    DBE_Exnumber: TDBEdit;
    GroupBox1: TGroupBox;
    Label11: TLabel;
    de_Form7: TDateEdit;
    GroupBox2: TGroupBox;
    Label12: TLabel;
    de_form3: TDateEdit;
    de_Confirm: TDateEdit;
    DE_DTTM_Exord: TDateEdit;
    DBE_Exorder: TEdit;
    de_DTTM_PLANENDWORK: TDateEdit;
    GroupBox3: TGroupBox;
    de_Date_readability: TDateEdit;
    GroupBox4: TGroupBox;
    Label13: TLabel;
    GroupBox5: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    GroupBox6: TGroupBox;
    Label14: TLabel;
    de_OrderClosed: TDateEdit;
    Shape1: TShape;
    cb_withexcav: TCheckBox;
    Label17: TLabel;
    dbl_banceKeeper: TRxDBLookupCombo;
    dset_balanceKeeper: TIBDataSet;
    ds_BalanceKeeper: TDataSource;
    procedure btn_InsertClick(Sender: TObject);override;
    procedure btn_PostClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure CtrlsChange(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure mem_AdditionalInfoChange(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure mem_AdditionalInfoEnter(Sender: TObject);
    procedure mem_AdditionalInfoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dset_OfficialsFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure de_Form7Enter(Sender: TObject);
    procedure de_Form7Exit(Sender: TObject);
    procedure de_DTTM_PLANENDWORKChange(Sender: TObject);
    procedure DBE_ExorderKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DE_DTTM_ExordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DE_DTTM_ExordClick(Sender: TObject);
  protected
    class function GetGUID: string; override;
  protected
    procedure InitVocDsetList; override;
    procedure EnableCtrls(value: boolean);override;
    function IsDateCorrect: boolean; override;
    function IsDataFieldsCorrect: boolean; override;
    function IsCanEditCurrentRec: boolean; override;
  private
    F_IsAddInfoChange: boolean;
    F_IsAddInfoEnter: boolean;
    F_IsCanAddNewRec: boolean;
    F_IDOfficial: integer;
    F_IDOfficialPost: integer;
    F_IDEquip: integer;
    F_DamageLoc:integer;
    FCurrentBrigCloseFromOrder: integer;
    F_ListNumsorders:string;        //список заявок которые нужно забрать из кап ремонта закрытые или отказаные в закрытом наряде 1562
    F_Change:boolean;
    F_WasChanged:boolean;
    procedure  SetNextExcnumber;
    function IsAddInfoInserted: boolean;
    function AddInfoQuery(FixAction: TFixAction): string;
    function GetAddInfo: string;
    procedure EnableSmartCtrls(value: boolean);
    procedure EnableAdditionalInfo;
    function SaveAdditionalInfo: boolean;
    function isDopFieldsDataCorrect():boolean;
    procedure enabledGroupbox3();// разрешение на разрытие разрешать если есть Дата пллан. оконч. работ
    procedure enebledGoupbox(  box:TGroupBox; enebled:boolean);
    procedure cleareAddInfor;//после удаления раскопок
  public
    property DamageLoc:integer  read F_DamageLoc write F_DamageLoc;
    property ListNumsorders:string read F_ListNumsorders write F_ListNumsorders ;
    property WasChanged:boolean read F_wasChanged;

    property IsCanAddNewRec: boolean read F_IsCanAddNewRec write F_IsCanAddNewRec;
    property IDOfficial: integer read F_IDOfficial write F_IDOfficial;
    property IDOfficialPost: integer read F_IDOfficialPost write F_IDOfficialPost;
    property IDEquip: integer read F_IDEquip write F_IDEquip;

    property CurrentBrigCloseFromOrder: integer read FCurrentBrigCloseFromOrder write FCurrentBrigCloseFromOrder;
  end;

implementation

{$R *.dfm}

uses HelpFunctions, HelpClasses, AppGUIDS, RightsManagerDModule, StringConsts;

{ Tfrm_Excavations }

procedure Tfrm_Excavations.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);

  dp_Start.Enabled:=value;
  tp_Start.Enabled:=value;
  dbl_Officials.Enabled:=value;
  dbl_Brigadiers.Enabled:=value;
  dbl_Brigadiersend.Enabled:=value;
  dbl_WorkType.Enabled:=value;
  dbl_Equipment.Enabled:=value;
  ed_Square.Enabled:=value;
  DBL_AsfCompany.Enabled:=value;
end;

function Tfrm_Excavations.IsDataFieldsCorrect: boolean;
begin
  Result:=false;

  {Не удалять}
  {
  if IsDBLEmpty(dbl_Street) then
  begin
    ActiveControl:=dbl_Street;
    ProcessStatus:='Введите наименование улицы';
    exit;
  end;

  if (dset_HouseType.FieldByName('ID').AsInteger=0) and
      (trim(ed_HouseNum.Text)='') then
  begin
    ActiveControl:=ed_HouseNum;
    ProcessStatus:='Введите номер дома';
    exit;
  end;

  if (dset_HouseType.FieldByName('ID').AsInteger=1) and
      (IsDBLEmpty(dbl_Street2)) then
  begin
    ActiveControl:=dbl_Street2;
    ProcessStatus:='Введите наименование 2-ой улицы';
    exit;
  end;
  }
  {/Не удалять}

  if IsDBLEmpty(dbl_officials) then
  begin
    ActiveControl:=dbl_officials;
    ProcessStatus:='Введите диспетчера';
    exit;
  end;

  if ( dbl_WorkType.LookupSource.DataSet.FieldByName('ID').AsInteger <> 12 ) then
  begin
      if IsDBLEmpty(dbl_brigadiers) then
      begin
        ActiveControl:=dbl_brigadiers;
        ProcessStatus:='Введите бригадира';
        exit;
      end;

      if IsDBLEmpty(dbl_brigadiersend) then
      begin
        ActiveControl:=dbl_brigadiersend;
        ProcessStatus:='Укажите кто передал раскопку';
        exit;
      end;
  end;

  if IsDBLEmpty(dbl_WorkType) then
  begin
    ActiveControl:=dbl_WorkType;
    ProcessStatus:='Введите наименование работ';
    exit;
  end;

  {
  if IsDBLEmpty(dbl_Equipment) then
  begin
    ActiveControl:=dbl_Equipment;
    ProcessStatus:='Введите механизм';
    exit;
  end;

  if trim(ed_Square.Text)='' then
  begin
    ActiveControl:=ed_Square;
    ProcessStatus:='Введите площадь';
    exit;
  end;
  }
  case F_DamageLoc  of
   3,5: //место поавреждения зелзона, груновая дорога
   if  dbl_WorkType.LookupSource.DataSet.FieldByName('ID').AsInteger =5 then //асфальт оплата
     begin
      ActiveControl :=dbl_WorkType;
      ProcessStatus:='Нельзя асфальтировать зеленую зану. Поменяйте место повреждения в наряде!!';
      exit;
     end
   end;
  Result:=true;
end;

function Tfrm_Excavations.IsDateCorrect: boolean;
var
  StartDate: string;
begin
  Result:=false;

  //StartDate:=DateTimeToStr(trunc(dp_Start.Date)+StrToTime(tp_Start.Text));
  StartDate:=dp_Start.Field.AsString;

  if not HelpFunctions.IsDateCorrect(StartDate) then
  begin
    Application.MessageBox('Проверте правильность ввода даты и времени',
                            gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;
  end;

  if ( dset_WorkType.FieldByName( 'id' ).AsInteger <> 10 ) and
      IsDateLess(DateTimeToStr(Now), StartDate) then
  begin
    Application.MessageBox('Дата раскопки не может быть больше текущей',
                            gc_strDispAVR, MB_OK+MB_ICONERROR);
    exit;
  end;

  Result:=true;
end;

procedure Tfrm_Excavations.btn_InsertClick(Sender: TObject);
begin
  inherited btn_InsertClick(Sender);
  dset_Main.FieldByName('fk_excavations_orders').AsInteger:=F_OrderID;
  dset_Main.FieldByName('DTIME').AsDateTime:=CrazyNow;

  {Не удалять}
  //dset_Main.FieldByName('fk_excavations_housetype').AsInteger:=0;
  //dset_Main.FieldByName('fk_excavations_streets').AsInteger:=-1;
  {/не удалять}

  dset_Main.FieldByName('fk_excavations_officials').AsInteger:=F_IDOfficial;

  dset_Main.FieldByName('fk_excavations_brigadiers').AsInteger := CurrentBrigCloseFromOrder {-1};
  dset_Brigadiers.Locate( 'ID', CurrentBrigCloseFromOrder, [] );

  dset_Main.FieldByName('fk_excavations_brigadiersend').AsInteger:=-1;
  dset_Main.FieldByName('fk_excavations_equipment').AsInteger:=F_IDEquip;
  dset_Main.FieldByName('square').AsFloat:=0;

  //if dset_Main.RecordCount>0 then
  if F_IsCanAddNewRec then
  begin
    dset_Main.FieldByName('fk_excavations_excwt').AsInteger:=-1; //<пусто>
    EnableSmartCtrls(true);
  end else
  begin
    dset_Main.FieldByName('fk_excavations_excwt').AsInteger:=ID_RASKOPANO; //раскопано
    EnableSmartCtrls(false);
  end;
  EnableAdditionalInfo;

  dp_Start.SetFocus;
end;

function Tfrm_Excavations.IsAddInfoInserted: boolean;
var
  dset: TIBDataSet;
begin
  dset:=TIBDataSet.Create(nil);
  try
    dset.Transaction:=Tr_main;

    MyOpenSQL(dset, Format('select count(*) kol from excavationsinfo where fk_excinfo_orders=%d',[F_OrderID]));
    if dset.FieldByName('kol').AsInteger>0 then
      Result:=true
    else
      Result:=false;
    dset.Close;
  finally
    dset.Free;
  end;
end;

function Tfrm_Excavations.AddInfoQuery(FixAction: TFixAction): string;
begin
  with TQueryGenerator.Create do
  begin
    try
      ValueByFieldName['AdditionalInfo']:=QuotedStr(copy(trim(mem_AdditionalInfo.Text), 0, 195));
      if QuotedStr(copy(trim(mem_AdditionalInfo.Text), 0, 195))='' then
        ValueByFieldName['AdditionalInfo']:='null';

      {Dop Pola}
      if de_Form7.Date>0 then
        ValueByFieldName['dat_form7']:=''''+de_Form7.Text+''''
      else
        ValueByFieldName['dat_form7']:='null';
      if de_Form3.Date>0 then
        ValueByFieldName['dat_form3']:=''''+de_Form3.Text+''''
       else
         ValueByFieldName['dat_form3']:='null';
    {  if trim(ed_form3_num.Text)<>'' then
       ValueByFieldName['num_form3']:=''''+ed_form3_num.Text+''''
      else
       ValueByFieldName['num_form3']:='null';}


      if de_Confirm.Date>0 then
       ValueByFieldName['comfirmblag']:=''''+de_Confirm.Text+''''
       else
        ValueByFieldName['comfirmblag']:='null';

       if DE_DTTM_Exord.Date>0 then
        ValueByFieldName['DTTM_EXCORD']:=''''+DateToStr(DE_DTTM_Exord.Date)+''''
       else
        ValueByFieldName['DTTM_EXCORD']:='null';


       if DBE_Exorder.Text<>'' then
        ValueByFieldName['EXORDER']:=''''+DBE_Exorder.Text+''''
       else
         ValueByFieldName['EXORDER']:='null';

       if de_DTTM_PLANENDWORK.Date>0 then
        ValueByFieldName['DTTM_PLANENDWORK']:=''''+DE_DTTM_PLANENDWORK.Text+''''
       else
         ValueByFieldName['DTTM_PLANENDWORK']:='null';

       if  de_Date_readability.Date>0 then
        ValueByFieldName['DATE_READABILITY_DOCS']:=''''+de_Date_readability.Text+''''
       else
        ValueByFieldName['DATE_READABILITY_DOCS']:='null';

       if de_OrderClosed.Date>0 then
        ValueByFieldName['Dat_ClosedOrder']:=''''+ de_OrderClosed.Text+''''
       else
         ValueByFieldName['Dat_ClosedOrder']:='null';

       if cb_withexcav.Checked then
          ValueByFieldName['WITH_EXCAV']:='1'
        else
          ValueByFieldName['WITH_EXCAV']:='null';

       if dset_balanceKeeper.FieldByName('id').AsInteger>0 then
           ValueByFieldName['FK_EXCINFO_BalanceKeeper']:=dset_balanceKeeper.FieldByName('id').AsString
       else
           ValueByFieldName['FK_EXCINFO_BalanceKeeper']:='null';

      {/]}
       ValueByFieldName['fk_ExcInfo_orders']:=IntToStr(F_OrderID);

      TableName:='ExcavationsInfo';
      Condition:='fk_ExcInfo_orders='+IntToStr(F_OrderID);

      case FixAction of
        faInsert: Result:=GenInsertQuery;
        faUpdate: Result:=GenUpdateQuery;
        faDelete: Result:=GenDeleteQuery;
      end;
    finally
      Free;
    end;
  end;
end;

procedure Tfrm_Excavations.btn_PostClick(Sender: TObject);
begin
 if ( dset_Main.RecordCount>0) or (dset_Main.State<>dsBrowse) then
  if SaveAdditionalInfo then
  begin
    EnableCtrls(false);
    EnableChngBtns;

  end;

 if ( dset_Main.RecordCount>0) or (dset_Main.State<>dsBrowse) then
  inherited btn_PostClick(Sender);
 if not F_IsAddInfoChange then
 begin
   if not F_WasChanged then F_WasChanged:=F_Change;
      F_Change:=false;
 end;
 EnableAdditionalInfo;     


end;

function Tfrm_Excavations.GetAddInfo: string;
var
  dset: TIBDataset;

begin
  dset:=TIBDataset.Create(self);
  try
    dset.Transaction:=Tr_main;
    MyOpenSQL(dset, 'select AdditionalInfo,e.dat_form7, e.dat_form3,  e.comfirmblag, '+
                    ' EXORDER, DTTM_EXCORD,DTTM_PLANENDWORK ,'+
                    ' DATE_READABILITY_DOCS, ' + {дата подачи документов}
                    ' Dat_ClosedOrder, '+ {дата закрытия ордера}
                    ' WITH_EXCAV, '+{без раскопки}
                    ' FK_EXCINFO_BalanceKeeper '+{Балансодержатель}
                    ' from ExcavationsInfo e where fk_excinfo_orders='+IntToStr(F_OrderID));
    //Добавим дополн поля
    if not dset.FieldByName('dat_form3').IsNull then
       de_Form3.Date:=dset.FieldByName('dat_form3').AsDateTime;
    if not dset.FieldByName('dat_form7').IsNull then
       de_Form7.Date:=dset.FieldByName('dat_form7').AsDateTime;
   // ed_form3_num.Text:=dset.fieldbyname('num_form3').AsString;
    if not dset.FieldByName('comfirmblag').IsNull then
      de_Confirm.Date:=dset.FieldByName('comfirmblag').AsDateTime;
    Result:=dset.FieldByName('AdditionalInfo').AsString;
    if  not dset.FieldByName('exorder').IsNull     then
     dbe_exorder.Text:=dset.FieldByName('exorder').asstring;
    if not dset.FieldByName('DTTM_EXCOrd').IsNull  then
      DE_DTTM_Exord.Date:=dset.FieldByName('DTTM_EXCOrd').AsDateTime;
    if not dset.FieldByName('DTTM_PLANENDWORK').IsNull  then
      de_DTTM_PLANENDWORK.Date:=dset.FieldByName('DTTM_PLANENDWORK').AsDateTime;
    if not dset.FieldByName('DATE_READABILITY_DOCS').IsNull then
      de_Date_readability.Date:=dset.FieldByName('DATE_READABILITY_DOCS').AsDateTime;
    if not dset.FieldByName('Dat_ClosedOrder').IsNull then
      de_OrderClosed.Date:=dset.FieldByName('Dat_ClosedOrder').AsDateTime;
    if not dset.FieldByName('WITH_EXCAV').IsNull then
     if dset.FieldByName('WITH_EXCAV').AsInteger=1 then
         cb_withexcav.Checked:=true;
    if  not dset.FieldByName('FK_EXCINFO_BalanceKeeper').IsNull then
    begin

      FixDBLValue(dset.FieldByName('FK_EXCINFO_BalanceKeeper').AsInteger,dbl_banceKeeper);
    end
    else
     FixDBLValue(-1,dbl_banceKeeper);

     dbl_banceKeeper.onChange:=de_DTTM_PLANENDWORKChange;
     enabledGroupbox3();

  finally
    dset.Free;
  end;
end;

procedure Tfrm_Excavations.FormShow(Sender: TObject);
begin
  inherited FormShow(Sender);
  mem_AdditionalInfo.Text:=GetAddInfo;
  EnableAdditionalInfo;

  if F_IsCanAddNewRec then
  begin
    btn_Insert.Visible:=true;
  end else
  begin
    btn_Insert.Visible:=false;
    if (dset_Main.RecordCount<1) and (not F_ReadOnly) then
      btn_InsertClick(nil);
  end;
{
  btn_Insert.Visible:=F_IsCanAddNewRec;
  if (dset_Main.RecordCount<1) and (not F_ReadOnly) then
    btn_InsertClick(nil);
}
end;

procedure Tfrm_Excavations.EnableSmartCtrls(value: boolean);
begin
  dbl_WorkType.Enabled:=value;
 // DBL_AsfCompany.Enabled:=value;
  //dbl_Equipment.Enabled:=value;
  //ed_Square.Enabled:=value;
end;

procedure Tfrm_Excavations.btn_EditClick(Sender: TObject);
begin
  inherited btn_EditClick(Sender); 
  if dset_Main.RecNo>1 then
    EnableSmartCtrls(true)
  else
    EnableSmartCtrls(false);
  EnableAdditionalInfo;

  dp_Start.SetFocus;
end;

procedure Tfrm_Excavations.CtrlsChange(Sender: TObject);
var _tag: integer;
begin
  inherited CtrlsChange(Sender);

  if (Sender is TRxDBLookupcombo) then
  begin
    _tag := (Sender as TRxDBLookupcombo).Tag;
    case _tag of
     111 : //dbl_WorkType
          if (dset_Main.State=dsInsert) or (dset_Main.State=dsEdit) then
             SetNextExcnumber;
     333 : //dbl_Brigadiers
          if (dset_Main.State=dsInsert) or (dset_Main.State=dsEdit) then
              dset_Main.FieldByName('fk_excavations_brigadiersend').AsInteger:=
              dset_Brigadiers.FieldByName('ID').AsInteger;
    end; //case
  end;
    F_Change:=true;
end;

procedure Tfrm_Excavations.EnableAdditionalInfo;
var
  val: boolean;
  //BMark: string;
  //i: integer;
begin
  with dset_Main do
  begin
    if dset_Main.State in [dsInsert, dsEdit] then
    begin
      val:=false;
    end else
    begin
    {
      DisableControls;
      BMark:=Bookmark;
      val:=true;
      First;
      while not Eof do
      begin
        i:=FieldByName('fk_excavations_excwt').AsInteger;
        if not(FieldByName('fk_excavations_excwt').AsInteger in [ID_RASKOPANO, ID_PRISIP, ID_NERASKOP]) then
        begin
          val:=false;
          break;
        end;
        Next;
      end;
      Bookmark:=BMark;
      EnableControls;
      }

      val:=(dset_Main.RecordCount>0);
    end;
  end;

  if (F_ReadOnly) {or not(DM_RightsManager.IsCurrentUserDisp)}  then
  begin
    mem_AdditionalInfo.Enabled:=false;

    lbl_AddInfo.Visible:=false;
     DBE_Exnumber.Enabled:=false;
    de_DTTM_PLANENDWORK.Enabled:=false;
    GroupBox3.Enabled:=false;
    GroupBox4.Enabled:=false;
    GroupBox5.Enabled:=false;
    GroupBox1.Enabled:=false;
    GroupBox2.Enabled:=false;
    GroupBox6.Enabled:=false;
    dbl_banceKeeper.Enabled:=false;

  end else
  begin
    mem_AdditionalInfo.Enabled:=val;
    lbl_AddInfo.Visible:=val;
//    mem_AdditionalInfo.Enabled:=true;
//    lbl_AddInfo.Visible:=true;
    DBE_Exnumber.Enabled:=val;
    de_DTTM_PLANENDWORK.Enabled:=val;
    GroupBox3.Enabled:=val;
    GroupBox4.Enabled:=val;
    GroupBox5.Enabled:=val;
    GroupBox1.Enabled:=val;
    GroupBox2.Enabled:=val;
    GroupBox6.Enabled:=val;
    dbl_banceKeeper.Enabled:=val;
  end;
end;

procedure Tfrm_Excavations.btn_DeleteClick(Sender: TObject);
begin
  inherited btn_DeleteClick(Sender);
  EnableAdditionalInfo;
  F_WasChanged:=true;
  cleareAddInfor();
end;


function Tfrm_Excavations.isDopFieldsDataCorrect():boolean;
begin
  if de_form3.Date>Now() then
   begin
    Application.MessageBox('Дата формы3 не может бать больше текущей!',gc_strDispAVR, MB_OK+MB_ICONERROR);
    de_form3.SetFocus;
    Result:=false;
    exit;
   end;
   if de_form7.Date>Now() then
   begin
    Application.MessageBox('Дата формы7 не может бать больше текущей!', gc_strDispAVR, MB_OK+MB_ICONERROR);
    de_form7.SetFocus;
    Result:=false;
    exit;
   end;
   if DE_DTTM_EXORD.Date>NOW() then
   begin
    Application.MessageBox('Дата ордера не может бать больше текущей!', gc_strDispAVR, MB_OK+MB_ICONERROR);
    DE_DTTM_EXORD.SetFocus;
    Result:=false;
    exit;
   end;
   if de_Date_readability.Date>Now() then
    begin
     Application.MessageBox('Дата подачи документов не может быть больше текущей!',gc_strDispAVR, MB_OK+MB_ICONERROR);
     de_Date_readability.SetFocus;
     REsult:=false;
     exit;
    end;
   if de_OrderClosed.Date>Now() then
   begin
      Application.MessageBox('Дата закрытия отдера не может быть больше текущей!',gc_strDispAVR, MB_OK+MB_ICONERROR);
     de_OrderClosed.SetFocus;
     REsult:=false;
     exit;
   end;
    Result:=true;
end;

function Tfrm_Excavations.SaveAdditionalInfo: boolean;
var
  is_inserted: boolean;
  add_info: string;
  sql_tmp: TIBSQL;
  num_form3,exorder:string;
  dat_form3, dat_from7, confirm,DTTM_EXCORD:TDate;
  dat_PlanEnd:TDate;
  dat_REadability:TDate;
  dat_closedOrder:TDate;
  with_excav:boolean;
  fk_balancakeeper:integer;
begin
  Result:=false;

  if not F_IsAddInfoChange then exit;

  is_inserted:=IsAddInfoInserted;
  add_info:=trim(mem_AdditionalInfo.Text);
 // num_form3:=ed_form3_num.Text;
  dat_form3:=de_Form3.Date;
  dat_from7:=de_Form7.Date;
  confirm:=de_Confirm.date;
  DTTM_EXCORD:=DE_DTTM_EXORD.date;
  exorder:=DBE_Exorder.Text;
  dat_PlanEnd:=De_DTTM_Planendwork.Date;
  dat_REadability:= de_Date_readability.Date;
  dat_closedOrder:=de_OrderClosed.Date;
  with_excav:=cb_withexcav.Checked;
  if (dset_balanceKeeper.FindField('id')<>nil) then
   fk_balancakeeper:=dset_balanceKeeper.fieldbyname('id').AsInteger;
  if  isDopFieldsDataCorrect then
 begin
  try
    sql_tmp:=TIBSQL.Create(self);
    try
      sql_tmp.Transaction:=Tr_main;

      if (not is_inserted) and( (add_info<>'')   or
         (dat_form3>0)or (dat_from7>0) or ( confirm>0) or
        (DTTM_EXCORD>0) or (exorder<>'')or (dat_PlanEnd>0) or (dat_REadability>0)
        or (dat_closedOrder>0) or (with_excav) or(fk_balancakeeper>0))
        then
        MyExecSQL(sql_tmp, AddInfoQuery(faInsert)) else
      if is_inserted and ((add_info<>'')or   (dat_form3>0)or (dat_from7>0) or ( confirm>0)
       or (DTTM_EXCORD>0) or (exorder<>'') or (dat_PlanEnd>0) or (dat_REadability>0)
       or (dat_closedOrder>0) or (with_excav) or (fk_balancakeeper>0)) then
        MyExecSQL(sql_tmp, AddInfoQuery(faUpdate)) else
      if is_inserted and (add_info='')and  (dat_form3=0)and (dat_from7=0) and ( confirm=0)
    and  (DTTM_EXCORD=0) and (exorder='')and (dat_PlanEnd=0) and  (dat_REadability=0)
    and (dat_closedOrder=0)and (not with_excav) and (fk_balancakeeper=-1) then
        MyExecSQL(sql_tmp, AddInfoQuery(faDelete)) ;
    finally
      sql_tmp.Free;
    end;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar(E.Message), gc_strDispAVR, MB_OK+MB_ICONERROR);
      Tr_main.RollbackRetaining;
      exit;
    end;
  end;
  Tr_main.CommitRetaining;

  F_IsAddInfoChange:=false;

  Result:=true;
  end
  else
   Result:=false;
end;

procedure Tfrm_Excavations.mem_AdditionalInfoChange(Sender: TObject);
begin
  inherited;
  if F_IsAddInfoEnter then
  begin
    F_IsAddInfoChange:=true;
        btn_Post.Enabled:=true;
    btn_Cancel.Enabled:=true;
  end;
   F_Change:=true;
end;

procedure Tfrm_Excavations.btn_CancelClick(Sender: TObject);
begin
  inherited btn_CancelClick(Sender);
  mem_AdditionalInfo.Text:=GetAddInfo;
  F_IsAddInfoChange:=false;
  EnableAdditionalInfo;
  F_Change:=false;
  
end;

procedure Tfrm_Excavations.mem_AdditionalInfoEnter(Sender: TObject);
begin
  inherited;
  F_IsAddInfoEnter:=true;
end;

procedure Tfrm_Excavations.mem_AdditionalInfoExit(Sender: TObject);
begin
  inherited;
  F_IsAddInfoEnter:=false;
end;

procedure Tfrm_Excavations.FormCreate(Sender: TObject);
begin
  inherited;
  F_IsAddInfoChange:=false;
  F_IsAddInfoEnter:=false;
  F_IsCanAddNewRec:=true;
  F_IDOfficial:=-1;
  FCurrentBrigCloseFromOrder := -1;
  if DM_RightsManager.IsCurrentUserCanEditForm(Excav_withexcavedit) then
    cb_withexcav.Enabled:=true
  else
    cb_withexcav.Enabled:=false;
  F_Change:=false;  
  F_WasChanged:=false;  

end;

class function Tfrm_Excavations.GetGUID: string;
begin
  Result:=EXCAVATIONSFORMGUID;
end;

procedure Tfrm_Excavations.InitVocDsetList;
begin
  inherited;
  F_VocDsetList.Add(dset_Officials);
  F_VocDsetList.Add(dset_Brigadiers);
  F_VocDsetList.Add(dset_brigadiersend);
  F_VocDsetList.Add(dset_WorkType);
  F_VocDsetList.Add(dset_Equipment);
  F_VocDsetList.Add(dset_AsfCompany);
  F_VocDsetList.Add(dset_balanceKeeper);
end;

function Tfrm_Excavations.IsCanEditCurrentRec: boolean;
begin
  Result:=(dset_Main.FieldByName('OfficialPost').AsInteger=F_IDOfficialPost);
end;

procedure Tfrm_Excavations.dset_OfficialsFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if (DataSet.FieldByName('fk_offic_officpost').AsInteger=F_IDOfficialPost)
    and (DataSet.FieldByName('Activity').IsNull) then
    Accept:=true
  else
    Accept:=false;
end;

procedure Tfrm_Excavations.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  SaveAdditionalInfo;
end;

procedure Tfrm_Excavations.SetNextExcnumber;
var _sql: string;
    _dset: TIBDataSet;
    _res: integer;
begin
  if dset_Main.FieldByName('FK_EXCAVATIONS_EXCWT').AsInteger = 12 then
  begin
    _sql := 'select max(excnumber)+1 new_excnumber from excavations where excnumber is not null';
    _dset := TIBDataSet.Create(self);
    _dset.Database := DM_Main.IBDatabase;
    _dset.Transaction := DM_Main.Tr_tmp;
    MyOpenIBDS(_dset, _sql);
    _res := _dset.FieldByName('new_excnumber').AsInteger;
    _dset.Close;
    dset_main.FieldByName('EXCNUMBER').AsInteger := _res;
  end;

end;

procedure Tfrm_Excavations.de_Form7Enter(Sender: TObject);
begin
  inherited;
  F_IsAddInfoEnter:=true;
  EntryEnter(Sender);
end;

procedure Tfrm_Excavations.de_Form7Exit(Sender: TObject);
begin
  inherited;
 F_IsAddInfoEnter:=false;
 EntryExit(sender);
 SetProcessStatus('');
end;

procedure Tfrm_Excavations.enabledGroupbox3();
begin
  if (de_DTTM_PLANENDWORK.Date>0) and(dset_balanceKeeper.FieldByName('id').AsInteger>0) then
  enebledGoupbox( Groupbox3,true)
  else
  begin
   enebledGoupbox( Groupbox3,false);
   //DBE_Exorder.Text:='';
  // DE_DTTM_Exord.Clear;
  end;



end;

procedure Tfrm_Excavations.de_DTTM_PLANENDWORKChange(Sender: TObject);
begin
  inherited;
  mem_AdditionalInfoChange(Sender);
  enabledGroupbox3();
end;

procedure Tfrm_Excavations.enebledGoupbox( box:TGroupBox; enebled:boolean);
var i:integer;
begin

for i:=0 to box.ControlCount-1 do
begin
 if box.Controls[i].ClassType.InheritsFrom(TEdit) then
   (box.Controls[i] as TEdit).ReadOnly:=not enebled;
 if  (box.Controls[i].ClassType.InheritsFrom(TDateEdit)) then
   (box.Controls[i] as TDateEdit).ReadOnly:=not enebled;
end;

end;

procedure Tfrm_Excavations.DBE_ExorderKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
if DBE_Exorder.REadOnly then
   SetProcessStatus(TO_ADD_DatePlan);
end;

procedure Tfrm_Excavations.DE_DTTM_ExordKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
if DE_DTTM_Exord.ReadOnly then
  SetProcessStatus(TO_ADD_DatePlan);
end;

procedure Tfrm_Excavations.DE_DTTM_ExordClick(Sender: TObject);
begin
  inherited;
    if  not DE_DTTM_Exord.ReadOnly then
//  SetProcessStatus(TO_ADD_DatePlan);
end;

procedure Tfrm_Excavations.cleareAddInfor ();
var sql_tmp:TIBSQL;
begin
 if (dset_main.State in [ dsBrowse]) then
   if dset_main.RecordCount=0 then
    begin
     mem_AdditionalInfo.Clear;
     de_DTTM_PLANENDWORK.Clear;
     resetDBL(dbl_banceKeeper);
     DBE_Exorder.Clear;
     DE_DTTM_Exord.Clear;
     de_Date_readability.Clear;
     de_Confirm.Clear;
     de_Form7.Clear;
     de_form3.Clear;
     de_OrderClosed.Clear;
     cb_withexcav.Checked:=false;
     sql_tmp:=TIBSQL.Create(self);
     sql_tmp.Transaction:=tr_main;
     try
     MyExecSQL(sql_tmp,'delete from EXCAVATIONSINFO where FK_EXCINFO_ORDERS ='+IntToStr(F_OrderID));
     finally
      sql_tmp.free;
     end;
    end

end;



end.
