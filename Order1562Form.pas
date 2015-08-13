unit Order1562Form;
{$define Sentto1562}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OrderNGForm, StdCtrls, Buttons, ExtCtrls, Grids, ValEdit,
  OrderSearchFrameUnit, Aligrid, IBSQL, DB, IBCustomDataSet, DModule,
  IBDatabase, RxLookup, Mask, ToolEdit, ADODB,StringConsts,workSQL, DBCtrls,GlobalVocCacheDModule,
  kbmMemTable, DBCtrlsEh, RXDBCtrl, DBLookupEh;

type
 TSearchEvent=procedure (is_closed:boolean; StartDate,EndDate:TDate) of object ;

  Tfrm_Order1562 = class(Tfrm_OrderNG)
    Splitter1: TSplitter;
    Splitter3: TSplitter;
    vle_Order1562: TValueListEditor;
    Grid: TStringAlignGrid;
    btn_Exit: TBitBtn;
    dset: TIBDataSet;
    ib_exec: TIBSQL;
    tran1562: TIBTransaction;
    btn_NewOrder: TBitBtn;
    btn_CloseOrder: TBitBtn;
    btn_Order: TBitBtn;
    tran: TIBTransaction;
    Pnl_Vocs: TPanel;
    Splitter4: TSplitter;
    DBL_Job1562: TRxDBLookupCombo;
    dset_Job1562: TIBDataSet;
    ds_Job1562: TDataSource;
    DBL_Officials1562: TRxDBLookupCombo;
    dset_Officials1562: TIBDataSet;
    ds_Officials1562: TDataSource;
    dp_End: TDateEdit;
    l_closedtime: TLabel;
    me_End: TMaskEdit;
    mem_officials: TMemo;
    mem_job: TMemo;
    L_Isp1562: TLabel;
    L_Job1562: TLabel;
    lbl_DispClose: TLabel;
    DBL_DispClose: TRxDBLookupCombo;
    dset_DispClose: TIBDataSet;
    ds_DispClose: TDataSource;
    dset_cardwork: TIBDataSet;
    l_Regl: TLabel;
    de_Regl: TDateEdit;
    te_Regl: TMaskEdit;
    btn_Previos: TBitBtn;
    btnnext: TBitBtn;
    ADOQuery1562: TADOQuery;
    Canseled: TButton;
    Memo1: TMemo;
    About: TLabel;
    btn_Region: TButton;
    btn_Prepare: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    Prin_why: TBitBtn;
    PrinMaster: TBitBtn;
    ds_brig: TDataSource;
    dset_work: TIBDataSet;
    tran_prin: TIBTransaction;
    ds_work: TDataSource;
    dp_brig: TDateEdit;
    dp_why_not: TDateEdit;
    dbl_brig: TRxDBLookupCombo;
    me_brig: TMaskEdit;
    me_why_not: TMaskEdit;
    m_why_not: TMemo;
    IBS_prin: TIBSQL;
    m_brig: TkbmMemTable;
    m_brigid: TIntegerField;
    m_brigname: TStringField;
    m_brigactivity: TStringField;
    m_brigfk_brigadiers_regions: TIntegerField;
    dset_brig: TIBDataSet;
    cb_AddExcav: TCheckBox;
    pnl_OptExxcav: TPanel;
    cb_close: TCheckBox;
    de_StartOrder: TDateEdit;
    de_endOrder: TDateEdit;
    Label2: TLabel;
    Label3: TLabel;
    btn_Seach: TBitBtn;
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
//    procedure btn_PrepareClick(Sender: TObject);
    procedure btn_NewOrderClick(Sender: TObject);
    procedure btn_CloseOrderClick(Sender: TObject);
    procedure btn_OrderClick(Sender: TObject);
    procedure OnChangeControls(Sender: TObject);
    procedure btnnextClick(Sender: TObject);
    procedure CanseledClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridEnter(Sender: TObject);
    procedure GridExit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PrinMasterClick(Sender: TObject);
    procedure Prin_whyClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbl_brigChange(Sender: TObject);
    procedure m_why_notChange(Sender: TObject);
    procedure cb_AddExcavClick(Sender: TObject);
    procedure cb_closeClick(Sender: TObject);
    procedure btn_SeachClick(Sender: TObject);
    procedure de_StartOrderChange(Sender: TObject);

  private
    { Private declarations }
    F_ID1562: integer;
    F_Count: integer;

    F_ORDERNUMBER,F_ORDERNUMBER_new: string;
    F_IsCtrlChange: boolean; // если что-то сохраняли, для внешних вызовов
    F_IsClosed: boolean;
    F_IsDisp: boolean;
    F_IsNeedToClose: boolean;
    F_IsLinked, F_IsLinkedChange, F_InWork: boolean;
    F_SetInWork: boolean;
    F_IsInicialization: boolean;
    F_Official1562:integer;
    F_Job1562:integer;
    F_Official1562Add: string;
    F_Job1562Add: string;
    F_ID_MessHist, F_SPIS_ID: integer;
    F_UpdControls: array[1..9] of boolean;
    ///08.12.2011
    F_ID_Region:integer;
    F_ID_STREEt:integer;

    //15.12.2011
    F_OurNumber:integer;
    F_RecivedNumber:integer;
    F_Date_Rec:tdatetime;
    F_Date_Our:tdatetime;
    F_Cansel:boolean;

    F_app:integer;

    F_floor:string;
    F_porch:string;
    F_phone:string;
    F_abonent:string;
    F_about:string;
    F_avar:string;
    F_from:string;

     //05.03.2013
     F_Street_name:string;

     //27.11.2013
     F_Add_Excav:integer;
    //3.12.2013
    F_Searchev:TSearchEvent;
    //4.12.2013
    F_ChangeOpt:boolean;
    //10.09.2014
    F_newDateComingOrder:TDateTime;
    procedure OnChangeManualy(_tag: byte);
    function Get_ORDERNUMBER(_id: integer): string;
    function Get_REGION_ID(_id: integer): integer;
    function Get_OpenDate(id:integer):TDateTime;
    procedure CheckForLinks;
    procedure SaveUpdControls;
    procedure MyEnableControls(_Enable: boolean);
    procedure LinkControls(_isLinked: boolean);
    procedure OpenVocs;
    procedure UpdControlsChangeClear;
    procedure setClosed(is_anable:boolean );
    procedure setOrderNumber(number:string );


    function Get_ORDERCLOSED(_id: integer): integer;// 19.01.2012 Glasha
    procedure Set_LINKED(_Link:boolean);
    procedure set_id_1562(_id_1562:integer);

    function  set_sql_insert(fk_brig:integer=0;dt_master:string='';why_not:string='';dt_why_not:string=''):string; //28.08.2012

    function get_adres(street,HOUSE, APPARTMENT,Podesd,NumberFloor:string):string;

    procedure SettApp(v:integer);{установим  если для ВДС не доступно с раскопкой}
    procedure changeOPt(val:boolean);
  public
    { Public declarations }
     F_ID_ORDER, New_id_order: integer;
     F_Closed:boolean;
   procedure setAddExcav(add:integer );
    constructor Create(AOwner: TComponent; Title: string='');
    property ID1562: integer read F_ID1562 write set_id_1562;
    property ID_ORDER: integer read F_ID_ORDER write F_ID_ORDER;
    property ORDERNUMBER: string read F_ORDERNUMBER write setOrderNumber;
    property IsCtrlChange: boolean read F_IsCtrlChange;
    property IsLinked: boolean read F_IsLinked write Set_LINKED;
    property IsClosed: boolean read F_IsClosed write setClosed;
    property InWork: boolean read F_InWork write F_InWork;
    property ID_MessHist: integer read F_ID_MessHist write F_ID_MessHist;
    property SPIS_ID: integer read F_SPIS_ID write F_SPIS_ID;
    //08.12.2011  для фотмирования вновь созданного наряда
    property id_Region:integer read F_ID_Region write F_ID_Region;
    property id_Street:integer read F_ID_STREEt write F_ID_STREEt;
       //15.12.2011
  property   OurNumber:integer read F_OurNumber write F_OurNumber;
  property  RecivedNumber:integer read F_RecivedNumber write F_RecivedNumber;
  property  Date_Rec:tdatetime read F_Date_Rec write F_Date_Rec;
  property  Date_Our:tdatetime read F_Date_Our write F_Date_Our;
    property floor:string read F_floor write F_floor;
    property porch:string read F_porch write F_porch;
    property phone:string read F_phone write F_phone;
    property abonent:string read F_abonent write F_abonent;
    property _about:string read F_about write F_about;

    property _avar:string read F_avar write F_avar;

   property _app:integer read F_app write SettApp;
   property _from:string read F_from write F_from;

   property IsLinkedChange: boolean read F_IsLinkedChange write F_IsLinkedChange;
    procedure InitValues;
   property Street_name:string  read F_Street_name write F_Street_name;
   property Add_Ezxcav:integer read F_Add_Excav write setAddExcav;
   //3.12.2013
   property SearchEv:TSearchEvent write F_SearchEv;
   procedure ClosePanel;
   procedure OpenPanel;
   //4.12.2013

   property change_Opt:boolean read F_ChangeOpt write  changeOPt;


  end;

var
  frm_Order1562: Tfrm_Order1562;

   OldColorRow: TColor;

implementation

{$R *.dfm}
uses RightsManagerDModule,HelpFunctions,HelpClasses,GlobalData;

constructor Tfrm_Order1562.Create(AOwner: TComponent; Title: string='');
begin
  inherited Create(AOwner);
  Caption:=Title;

end;

procedure Tfrm_Order1562.InitValues;
var _SQL : string;
    _dt: TDateTime;
begin
  F_IsInicialization:= true;
  F_IsDisp:=DM_RightsManager.IsCurrentUserDisp;
  btn_NewOrder.Enabled := F_IsDisp;
  btn_Prepare.Enabled := (not F_IsClosed);
  btn_region.Enabled:=  (not F_IsClosed);
  F_IsCtrlChange:= false;

  UpdControlsChangeClear;

  OpenVocs;

  _SQL := ' select * from cardwork '+
          ' where fk_id_spisok1562 = ' + inttostr( F_SPIS_ID );


   MyOpenIBDS(dset_cardwork, _SQL);

  F_IsLinkedChange := false;
  F_IsNeedToClose := false;
  F_SetInWork := false;

  if not dset_cardwork.eof then
   begin
     InWork := (not dset_cardwork.FieldByName('dttm_in_work').IsNull);
     IsClosed := ((not dset_cardwork.FieldByName('is_closed').IsNull) and (dset_cardwork.FieldByName('is_closed').AsInteger = 1));

     IsLinked := (not dset_cardwork.FieldByName('FK_ID_AVR_ORDER').IsNull);
     if IsLinked then ID_ORDER := dset_cardwork.FieldByName('FK_ID_AVR_ORDER').AsInteger else
            ID_ORDER := 0;

   

     mem_officials.Text := dset_cardwork.FieldByName('ISPA').AsString;
     mem_job.Text := dset_cardwork.FieldByName('JOBA').AsString;

     _dt := dset_cardwork.FieldByName('dttm_regl').AsDateTime;
     de_regl.Text := DateToStr( int( _dt ));
     te_regl.Text := TimeToStr( frac( _dt ));

     if (not dset_cardwork.FieldByName('ID_ISP').IsNull) then
       begin
         dset_Officials1562.Locate('id', dset_cardwork.FieldByName('ID_ISP').AsInteger, []);
         DBL_Officials1562.DisplayValue:=dset_Officials1562.FieldByName('name').AsString;
       end;

     if (not dset_cardwork.FieldByName('ID_JOB').IsNull) then
       begin
         dset_job1562.Locate('id', dset_cardwork.FieldByName('ID_JOB').AsInteger, []);
         DBL_job1562.DisplayValue:=dset_job1562.FieldByName('name').AsString;
       end;


   {  if ( F_ID_ORDER > 0 ) then
       begin
         dset_Officials1562.Locate('id_region', Get_REGION_ID(F_ID_ORDER), []);
         DBL_Officials1562.DisplayValue:=dset_Officials1562.FieldByName('name').AsString;
       end;
   }



   end;

  MyEnableControls(InWork);
  LinkControls( IsLinked );
  F_IsInicialization:= false; // флаг того, что это еще только была инициализация
  btn_Save.Enabled := false;
{DTTM_CLOSE, DTTM_IN_WORK, FK_ID_AVR_ORDER, FK_ID_SPISOK1562,
, ID_ISP, ID_JOB, ID_OPERATOR1562,  ISPA, JOBA, NUM1562 }

end;

procedure Tfrm_Order1562.OpenVocs;
begin
 if (dset_Officials1562.Active) then dset_Officials1562.Close; dset_Officials1562.Open;
 if (dset_Job1562.Active) then dset_Job1562.Close; dset_Job1562.Open;
 if (dset_DispClose.Active) then dset_DispClose.Close; dset_DispClose.Open;
end;

procedure Tfrm_Order1562.LinkControls(_isLinked: boolean);
begin
// if _isLinked then btn_Prepare.Font.Color := clBlack
//    else btn_Prepare.Font.Color := clRed;
 btn_CloseOrder.Enabled := _isLinked;
end;

procedure Tfrm_Order1562.CheckForLinks;
begin
  if dset.Active then dset.Close;
  dset.SelectSQL.Text := 'select id, num1562, fk_spisok1562_order from spisok1562 where num1562=' + inttostr(F_ID1562);
  if not dset.Eof then F_Count := dset.FieldByName('kol').AsInteger;
end;

procedure Tfrm_Order1562.btn_SaveClick(Sender: TObject);

  procedure UpdateInWorkDset;
   var _SQL : string;
   begin
    //
     if not tran1562.Active then tran1562.StartTransaction;
     try
      _SQL := ' update message_history set checked = 1'+
              ' , dttm_out = '''+ datetimetostr(now)+
              ''' where id = '+ inttostr(F_ID_MessHist);
      ib_exec.SQL.Text := _SQL;
      ib_exec.ExecQuery;

      _SQL := ' insert into cardwork '+
              ' (fk_id_spisok1562 , dttm_in_work, id_base) values '+
              '( '+ inttostr( F_SPIS_ID ) +
              ', '''+ datetimetostr(now)+ ''', 1)';
      ib_exec.SQL.Text := _SQL;
      ib_exec.ExecQuery;

      _SQL := ' insert into message_history '+
              ' (fk_id_spisok1562 , dttm_in, fk_id_sender, fk_id_s_stat, checked) values '+
              '( '+ inttostr( F_SPIS_ID ) +
              ', '''+ datetimetostr(now)+ ''', 2, 3, 0)';

      ib_exec.SQL.Text := _SQL;
      ib_exec.ExecQuery;



      tran1562.Commit;
      F_IsCtrlChange:= true;
      tran1562.StartTransaction;

     except
      on E:Exception do
      begin
        tran1562.Rollback;
        raise Exception.Create(E.Message+'( -- procedure Tfrm_Order1562.btn_SaveClick(Sender: TObject)), UpdateInWorkDset');
      end;
     end;

   end;


  procedure UpdateLinkDset(_id: integer);
   var _SQL : string;
   begin
    if not tran1562.Active then tran1562.StartTransaction;
    try
      _SQL := ' update cardwork set ' +
              ' id_base = 1'+
              ' , FK_ID_AVR_ORDER = '+ inttostr(_id)+
              ' where FK_ID_SPISOK1562 = '+ inttostr(F_SPIS_ID);
      ib_exec.SQL.Text := _SQL;
      ib_exec.ExecQuery;
      tran1562.Commit;
      F_IsCtrlChange:= true;
      tran1562.StartTransaction;
    except
      on E:Exception do
      begin
        tran1562.Rollback;
        raise Exception.Create(E.Message+'( -- procedure Tfrm_Order1562.btn_SaveClick(Sender: TObject)), UpdateLinkDset');
      end;
    end;
   end;

   procedure UpdateLinkDset1(_id: integer;order_number:string);

   function set_avar():string;
   begin
     if trim(F_avar)='' then Result:='null'
     else result:=' ''A'' ';

   end;
   var table:string;

       number, order, v_addexcav:string; //15.08.2012
   begin
    case F_App of
      2:table:='numsorders';
      3:table:='numsorders_vds';
    end;
    if F_Add_Excav=1 then
     v_addexcav:='1'
    else
     v_addexcav:='null';
    if  not tran.Active  then
     tran.StartTransaction;

    try
     if F_ID_ORDER>0 then

             ib_exec.SQL.Text:=Format('update %s set id_order= %s,add_excav=%s where id_1562=%s',
                               [table,IntToStr(_id),intToStr(F_ID1562),v_addExcav])


     else
      begin
      MyOpenIBDS(dset,Format('select res,ORDERNUMBER,DISTRICT,DATECOMING from PROCISCANADD1562(%d)',
                                  [F_ID1562]));
      if dset.FieldByName('res').AsInteger=0 then //заявка есть в базе
         begin
          Application.MessageBox(PChar(' Заявка уже принята, наряд №'+dset.FieldByName('ordernumber').AsString+dset.FieldByName('district').AsString),'Ошибка',Mb_ICONERROR+MB_OK);
          exit;
         end;
      case F_App of
       2:MyOpenIBDS(dset,Format('select o.ordernumber, o.isclosed from orders o where o.id=%d',[_id]));
       3:MyOpenIBDS(dset,Format('select  '+
                                ' (select fullordernum from  '+
                                ' get_fullordernum(o.ordernumber, o.fk_orders_district)) ordernumber, '+
                                '  o.isclosed from orders_vds  o where id=%d',[_id]));
      end;
      if (dset.FieldByName('isclosed').AsInteger=1) and (  F_Add_Excav=0) then
      begin
        Application.MessageBox(PChar('Наряд  №'+dset.FieldByName('ordernumber').AsString+ ' закрыт !'),'Ошибка!',MB_OK+MB_ICONERROR);
        exit;
      end;
      ib_exec.SQL.Text:=Format('update or insert into %s (id_order, number,ID_1562,'+
                                               'Number_Our_Request,Date_Our_Request,'+
                                               ' Date_Recive_Request,Recived_From,state_inner,state_avar,id_officials, '+
                                               ' abonent,phone,adress,about,ID_REGION, add_excav ) '+
                        ' values (%s,%s,%s,%s,''%s'',''%s'',''%s'',1,%s,%d,''%s'',''%s'',''%s'',''%s'',%d,%s)'+
                        ' matching (ID_1562)',
                        [table,IntTOStr(_id),IntTOStr(F_RecivedNumber),intToStr(F_ID1562),
                        IntToStr(OurNumber),DateTimeToStr(Date_Our),
                        DateTimeToStr(Date_Rec), vle_Order1562.Values['откуда'],set_avar(),g_IDOfficial,
                        F_abonent,F_phone,get_adres(f_street_name,
                                                    vle_Order1562.Values['Дом'],
                                                    vle_Order1562.Values['Кватира'],
                                                    f_porch,F_floor)   ,F_about, F_ID_Region, v_addExcav ]);

      end;
  {   str:= Format('select * from insert_into%s '+
                               ' (%d,%d,''%s'',%d,%d,''%s'',''%s'',1,%d,%s)',
                        [table,_id,F_RecivedNumber,DateTimeToStr(Date_Our),
                        F_ID1562,OurNumber,DateTimeToStr(Date_Our),
                        vle_Order1562.Values['откуда'],g_IDOfficial,set_avar()]) ;
     MyOpenIBDS(dset, str
                       );

     todo:= dset.Fields[0].Value;}
     ib_exec.ExecQuery;
     F_newDateComingOrder:=Get_OpenDate(New_id_order);
     dm_workSQL.Resived1562(id1562,id_order,_id,order_number,F_newDateComingOrder);
     tran.Commit;
    except
      on E:exception do
       begin
        tran.Rollback;
        Raise Exception.Create(E.Message+'');
       end;
    end;


    {if ID_order<=0 then
     try
        ADOQuery1562.SQL.Clear;
        ADOQuery1562.SQL.Add('declare @error_number int');
        ADOQuery1562.SQL.Add('declare @error_mesage varchar(200)');
        ADOQuery1562.SQL.Add('exec spRead_Kh_New '+IntToStr(ID1562)+' ,@error_number,@error_mesage');
        ADOQuery1562.SQL.Add('select @error_number,@error_mesage');
        ADOQuery1562.ExecSQL;
        ADOQuery1562.Active:=true;
        if         ADOQuery1562.Connection.InTransaction
        then      ADOQuery1562.Connection.CommitTrans;
        if not ADOQuery1562.Fields[0].IsNull  then
         Raise Exception.Create('Ошибка №' + ADOQuery1562.Fields[1].Asstring+ ' ' +ADOQuery1562.Fields[2].Asstring);
        ADOQuery1562.Close;

     except
     on E:exception do
      begin
          Raise Exception.Create(E.Message+'-1562-');
      end;
     end;}


   end;





  procedure UpdateCloseDset;
   var _sql, _val : string;
   begin
    if not tran1562.Active then tran1562.StartTransaction;
   try

     _val :=', dateclosed = ''' + dp_end.Text+ ' ' + me_End.Text + ''''+
      ', ID_ISP = '+ dset_Officials1562.fieldbyname('id1562').AsString +
      ', ISPA = '''+ mem_officials.Text + ''''+
      ', ID_JOB = '+ dset_Job1562.fieldbyname('id_job1562').AsString +
      ', JOBA = '''+ mem_job.Text + ''''+
      ', ID_OPERATOR1562 = '+ dset_DispClose.fieldbyname('id').AsString +
      ', DTTM_CLOSE = ''' + datetimetostr(now)+ '''';

      _SQL := ' update cardwork set is_closed = 1 '+
               _val + ' where num1562 = '+ inttostr(F_ID1562);

      ib_exec.SQL.Text := _sql;
      ib_exec.ExecQuery;

      _SQL := ' insert into message_history '+
              ' (fk_id_spisok1562 , dttm_in, fk_id_sender, fk_id_s_stat, checked) values '+
              '( '+ inttostr( F_SPIS_ID ) +
              ', '''+ datetimetostr(now)+ ''', 2, 8, 0)';

      ib_exec.SQL.Text := _sql;
      ib_exec.ExecQuery;

      tran1562.Commit;
      F_IsCtrlChange:= true;
      tran1562.StartTransaction;
    except
      on E:Exception do
      begin
        tran1562.Rollback;
        raise Exception.Create(E.Message+'( -- procedure Tfrm_Order1562.btn_SaveClick(Sender: TObject)), UpdateCloseDset');
      end;
    end;
   end;

  function CheckControlChanges: boolean;
  var b:byte;
      _res: boolean;
  begin
      //
    _res := false;
    for b:= 1 to 9 do
        if F_UpdControls[b] then _res := true;

    Result := _res;
  end;

 {procedure Cansel();
 begin
  //
   if  not tran.Active  then tran.StartTransaction;
    try
     if F_ID_ORDER>0 then
      ib_exec.SQL.Text:=Format('update numsorders set id_order=null where id_1562=%s',
                               [intToStr(F_ID1562)])
     else
      ib_exec.SQL.Text:=Format('insert into numsorders ( number,ID_1562,'+
                                               'Number_Our_Request,Date_Our_Request,'+
                                               ' Date_Recive_Request,Recived_From,state_inner,state_outer ) '+
                        'values (%s,%s,%s,''%s'',''%s'',''%s'',3,1)',
                        [IntTOStr(F_RecivedNumber),intToStr(F_ID1562),
                        OurNumber,DateToStr(Date_Our),
                        DateToStr(Date_Rec), vle_Order1562.Values['откуда']]);

     ib_exec.ExecQuery;
     tran.Commit;
    except
      on E:exception do
       begin
        Raise Exception.Create(E.Message+'-- insert in ourbase---');
       end;
    end;
   {$ifdef Sentto1562}
    {if ID_order<=0 then
     try
        ADOQuery1562.SQL.Clear;
        ADOQuery1562.SQL.Add('declare @error_number int');
        ADOQuery1562.SQL.Add('declare @error_mesage varchar(200)');
        ADOQuery1562.SQL.Add('exec spRead_Kh_New '+IntToStr(ID1562)+' ,@error_number,@error_mesage');
        ADOQuery1562.SQL.Add('select @error_number,@error_mesage');
        ADOQuery1562.ExecSQL;
        ADOQuery1562.Active:=true;
        if         ADOQuery1562.Connection.InTransaction
        then      ADOQuery1562.Connection.CommitTrans;
        if not ADOQuery1562.Fields[0].IsNull  then
         Raise Exception.Create('Ошибка №' + ADOQuery1562.Fields[1].Asstring+ ' ' +ADOQuery1562.Fields[2].Asstring);
        ADOQuery1562.Close;

     except
     on E:exception do
      begin
          Raise Exception.Create(E.Message+'-1562-');
      end;
     end; }
   // {$endif}
{ end;}

begin
  inherited;
  if cb_AddExcav.Checked then
    F_Add_Excav:=1
  else
    F_Add_Excav:=0;

  if  F_IsLinkedChange then
    btn_Prepare.enabled:=false;
  btn_Save.Enabled := false;

 // InitValues;


  if CheckControlChanges then
    if (Application.MessageBox(PChar('Сохранить изменения?'),
                              'Внимание!', MB_YESNO+MB_ICONQUESTION)=ID_YES)
      then SaveUpdControls;

  if F_SetInWork then
    if (Application.MessageBox(PChar('ПРИНЯТЬ ТЕКУЩУЮ ЗАЯВКУ?'),
                              'Внимание!', MB_YESNO+MB_ICONQUESTION)=ID_YES)
      then UpdateInWorkDset;


   if F_IsLinkedChange then
      if ( F_ID_ORDER <= 0 ) or
       (Application.MessageBox(PChar('Эта заявка уже связана с нарядом №'+ F_ORDERNUMBER +'. Изменить связь на №'+ F_ORDERNUMBER_new +' ?'),
                                'Внимание!', MB_YESNO+MB_ICONQUESTION)=ID_YES)
        then UpdateLinkDset1(New_id_order,F_ORDERNUMBER_new);


   if F_IsNeedToClose then
    if (Application.MessageBox(PChar('ЗАКРЫТЬ ТЕКУЩУЮ ЗАЯВКУ?'),
                              'Внимание!', MB_YESNO+MB_ICONQUESTION)=ID_YES)
      then UpdateCloseDset;

    if F_Cansel then
      if (Application.MessageBox(PChar('ОТКАЗ ОТ ВІПОЛНЕНИЯ ТЕКУЩЕЙ ЗАЯВКИ!'),
                              'Внимание!', MB_YESNO+MB_ICONQUESTION)=ID_YES)  then

        begin
     //   Cansel();
        end;
   F_IsLinkedChange:=false;

   GroupBox1.Enabled:=true;
   GroupBox2.Enabled:=true;

end;

function Tfrm_Order1562.Get_ORDERNUMBER(_id: integer): string;
   begin
    case F_App of
     2:MyOpenSQL(dset, 'select ordernumber,datecoming  from orders where id = '+ inttostr(_id));
     3:MyOpenSQL(dset, 'select (select FULLORDERNUM from GET_FULLORDERNUM(ordernumber,fk_orders_district)) ordernumber, datecoming from orders_vds where id = '+ inttostr(_id));
    end;

     F_newDateComingOrder:= dset.fieldbyname('datecoming').asDateTime;
     result := dset.FieldByName('ordernumber').asstring;

   end;

function Tfrm_Order1562.Get_ORDERCLOSED(_id: integer): integer;
   begin
    case  F_App of
      2:  MyOpenSQL(dset, 'select isclosed from orders where id = '+ inttostr(_id));
      3:  MyOpenSQL(dset, 'select isclosed from orders_vds where id = '+ inttostr(_id));
    end;
      result := dset.FieldByName('isclosed').AsInteger;
   end;


function Tfrm_Order1562.Get_REGION_ID(_id: integer): integer;
   begin
     case F_App of
      2:   MyOpenSQL(dset, 'select FK_ORDERS_REGIONS from orders where id = '+ inttostr(_id));
      3:    MyOpenSQL(dset, 'select FK_ORDERS_REGIONS from orders_vds where id = '+ inttostr(_id));
     end;
     result := dset.FieldByName('FK_ORDERS_REGIONS').AsInteger;
   end;

procedure Tfrm_Order1562.btn_ExitClick(Sender: TObject);
begin
  inherited;
  if IsLinkedChange then
 if Application.MessageBox(' Сохранить изменеия?',
        gc_strDispAVR,MB_YESNO+MB_ICONQUESTION)=IDYES then
     begin
         ActiveControl:=btn_Save;
        exit;
     end;
 Close;
end;

{procedure Tfrm_Order1562.btn_PrepareClick(Sender: TObject);
var _row, i, _gridrow: integer;
begin
  inherited;
//
  _gridrow := Grid.Row;
  if _gridrow>0 then
  begin
  if Assigned( Grid.Objects[0, Grid.Row] ) then
              begin
              New_id_order := integer(Grid.Objects[0, Grid.Row]);
              F_ORDERNUMBER_new :=  Get_ORDERNUMBER(New_id_order); //установим номе наряда и дату поступления наряда
              end;
  btn_Save.Enabled := true;
   for i := 1 to Grid.RowCount do grid.ColorRow[i] := clWhite;
   grid.ColorRow[Grid.Row] := clskyBlue	;
//   vle_Order1562.DeleteRow(vle_Order1562.RowCount-1);
//2011-2012 by Glasha
   vle_Order1562.FindRow('№наряда', _row);
   vle_Order1562.DeleteRow(_row);
   vle_Order1562.InsertRow( '№наряда' , Get_ORDERNUMBER(New_id_order) ,true);

   vle_Order1562.FindRow('наряд', _row);
   vle_Order1562.DeleteRow(_row);
   if   Get_ORDERCLOSED(New_id_order)=1  then
    vle_Order1562.InsertRow( 'наряд' , 'закрыт' ,true)
   else
    vle_Order1562.InsertRow( 'наряд' , 'открыт' ,true);


  {if ( F_ID_ORDER > 0 ) then
   begin
     dset_Officials1562.Locate('id_region', Get_REGION_ID(F_ID_ORDER), []);
     DBL_Officials1562.DisplayValue:=dset_Officials1562.FieldByName('name').AsString;
   end;}


{   F_IsLinkedChange := true;
   btn_CloseOrder.Enabled := true;

   btn_Prepare.Enabled:=false;
   //\Otvaz.Enabled:=true;
   btn_neworder.Enabled:=false;
   btn_region.Enabled:=false;
   groupbox1.Enabled:=false;
   GroupBox2.Enabled:=false;

 end;

end;
}

procedure Tfrm_Order1562.btn_NewOrderClick(Sender: TObject);
begin
//

end;

procedure Tfrm_Order1562.btn_CloseOrderClick(Sender: TObject);
var _sql, _val: string;
begin
  inherited;
//

 dp_end.Date := Now;

 me_End.Text := formatdatetime( 'hh:mm' ,Now);


 if not(dset_Officials1562.Active) then dset_Officials1562.Open;
 if not(dset_Job1562.Active) then dset_Job1562.Open;
 if not(dset_DispClose.Active) then dset_DispClose.Open;

  if ( F_ID_ORDER > 0 ) then
   begin
     dset_Officials1562.Locate('id_region', Get_REGION_ID(F_ID_ORDER), []);
     DBL_Officials1562.DisplayValue:=dset_Officials1562.FieldByName('name').AsString;
   end;

 F_IsNeedToClose := true;
 btn_Save.Enabled := true;
end;

procedure Tfrm_Order1562.MyEnableControls(_Enable: boolean);
 begin
    //
    l_closedtime.Enabled := _Enable;
    L_Isp1562.Enabled := _Enable;
    L_Job1562.Enabled := _Enable;
    DBL_Job1562.Enabled := _Enable;
    DBL_Officials1562.Enabled := _Enable;
    mem_officials.Enabled := _Enable;
    mem_job.Enabled := _Enable;
    dp_End.Enabled := _Enable;
    me_End.Enabled := _Enable;
    lbl_DispClose.Enabled := _Enable;
    DBL_DispClose.Enabled := _Enable;
 end;

procedure Tfrm_Order1562.btn_OrderClick(Sender: TObject);
begin

//
end;

procedure Tfrm_Order1562.SaveUpdControls;
var _set, _sql, _sep: string;
begin
    //
 _sql := ' update cardwork set ';
 _set := '';
 _sep := '';


    if F_UpdControls[1] or F_UpdControls[2] then
        begin
               _set := ' dttm_regl = '''+ de_Regl.Text+ ' ' + te_Regl.Text+'''';
               _sep:= ', ';
        end;
    if F_UpdControls[3] then
        begin
             _set := _set + _sep + 'ID_ISP = '+ dset_Officials1562.fieldbyname('id').AsString;
             _sep:= ', ';
          end;
    if F_UpdControls[4] then
        begin
             _set := _set +_sep + 'ISPA = '''+ mem_officials.Text + ''''; _sep:= ', ';
          end;
    if F_UpdControls[5] then
        begin
             _set := _set +_sep + 'ID_JOB = '+ dset_Job1562.fieldbyname('id').AsString;
             _sep:= ', ';
        end;
    if F_UpdControls[6] then
        begin
             _set := _set +_sep + 'JOBA = '''+ mem_job.Text + ''''; _sep:= ', ';
        end;
    if F_UpdControls[7] then _set :=_set + _sep + 'ID_OPERATOR1562 = '+ dset_DispClose.fieldbyname('id').AsString;

  _sql := _sql + _set;

  _sql := _sql + ' where FK_ID_SPISOK1562 = '+ inttostr(F_SPIS_ID);

  if not tran1562.Active then tran1562.StartTransaction;
    try
      ib_exec.SQL.Text := _sql;
      ib_exec.ExecQuery;
      tran1562.Commit;
      F_IsCtrlChange:= true;
      UpdControlsChangeClear;
      tran1562.StartTransaction;
    except
      on E:Exception do
      begin
        tran1562.Rollback;
        raise Exception.Create(E.Message+'( -- procedure Tfrm_Order1562.SaveUpdControls)');
      end;
    end;


end;

procedure Tfrm_Order1562.UpdControlsChangeClear;
var b:byte;
begin
   for b := 1 to 9 do
      F_UpdControls[b] := false;
end;

procedure Tfrm_Order1562.OnChangeControls(Sender: TObject);
begin
  if not F_IsInicialization then
      OnChangeManualy((Sender as TControl).Tag);

end;


procedure Tfrm_Order1562.OnChangeManualy(_tag: byte);
begin
  F_UpdControls[_tag] := true ;
  if (not btn_Save.Enabled) then btn_Save.Enabled := true;

end;

procedure Tfrm_Order1562.btnnextClick(Sender: TObject);
begin
  inherited;
//
end;

procedure Tfrm_Order1562.setClosed(is_anable:boolean );
begin
 //  btn_Prepare.Enabled:=not is_anable;
  // btn_NewOrder.Enabled:= not is_anable;
   btn_region.Enabled:= not is_anable;
   btn_Save.Enabled:=false;
   Canseled.Enabled:= not is_anable;
   F_IsClosed:=is_anable;

GroupBox1.Enabled:=(not is_anable){* and (F_ID_ORDER<=0)};
GroupBox2.Enabled:=(not is_anable) {and (F_ID_ORDER<=0)};



end;

procedure Tfrm_Order1562.CanseledClick(Sender: TObject);
begin
  inherited;
F_Cansel:=true;
btn_Save.Enabled:=true;

end;

procedure Tfrm_Order1562.FormShow(Sender: TObject);
begin
  inherited;
if F_IsLinked then
  grid.ColorRow[1] := clskyBlue;

end;

procedure Tfrm_Order1562.GridDblClick(Sender: TObject);
begin
  inherited;
  btn_Order.Click;
end;

procedure Tfrm_Order1562.GridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
 { with Sender as TStringAlignGrid do
  begin
   if Row <> ARow then
   begin
    ColorRow[Row]:=OldColorRow;
    OldColorRow:=ColorRow[ARow];
    ColorRow[ARow]:=ClLime;
   end
  end}
end;

procedure Tfrm_Order1562.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
{  if (Key=VK_F5) or (Key=VK_RETURN) then
    GridDblClick(Sender);}
end;

procedure Tfrm_Order1562.GridEnter(Sender: TObject);
begin
  inherited;
{ with Sender as TStringAlignGrid do
  begin
    OldColorRow:=ColorRow[Row];
  end;                         }
end;

procedure Tfrm_Order1562.GridExit(Sender: TObject);
begin
  inherited;
with Sender as TStringAlignGrid do
  begin
  //  ColorRow[Row]:=OldColorRow;
  end;
end;

procedure  Tfrm_Order1562.setOrderNumber(number:string );
var f:boolean;
begin
f:=(number='');
F_ORDERNUMBER:=number;
btn_newOrder.Enabled:=f;
btn_Region.Enabled:=f;
btn_prepare.Enabled:=f;
btn_Seach.Enabled:=f;

end;

procedure Tfrm_Order1562.BitBtn1Click(Sender: TObject);
var _row, i, _gridrow: integer;
begin
  inherited;
_gridrow := Grid.Row;
  if _gridrow>0 then
  begin
  if Assigned( Grid.Objects[0, Grid.Row] ) then
              begin
              New_id_order := integer(Grid.Objects[0, Grid.Row]);

              end;
  F_ORDERNUMBER_new := Get_ORDERNUMBER(New_id_order);
  btn_Save.Enabled := true;
   for i := 1 to Grid.RowCount do grid.ColorRow[i] := clWhite;
   grid.ColorRow[Grid.Row] := clskyBlue	;
//   vle_Order1562.DeleteRow(vle_Order1562.RowCount-1);
//2011-2012 by Glasha
   vle_Order1562.FindRow('№наряда', _row);
   vle_Order1562.DeleteRow(_row);
   vle_Order1562.InsertRow( '№наряда' , F_ORDERNUMBER_new ,true);

   vle_Order1562.FindRow('наряд', _row);
   vle_Order1562.DeleteRow(_row);
   if   Get_ORDERCLOSED(New_id_order)=1  then
    vle_Order1562.InsertRow( 'наряд' , 'закрыт' ,true)
   else
    vle_Order1562.InsertRow( 'наряд' , 'открыт' ,true);


  {if ( F_ID_ORDER > 0 ) then
   begin
     dset_Officials1562.Locate('id_region', Get_REGION_ID(F_ID_ORDER), []);
     DBL_Officials1562.DisplayValue:=dset_Officials1562.FieldByName('name').AsString;
   end;}


   F_IsLinkedChange := true;
   btn_CloseOrder.Enabled := true;

   btn_Prepare.Enabled:=false;
   //\Otvaz.Enabled:=true;
   btn_neworder.Enabled:=false;
   btn_region.Enabled:=false;

   GroupBox1.Enabled:=false;
   GroupBox2.Enabled:=false;

 end;

end;

procedure Tfrm_Order1562.Set_LINKED(_Link:boolean);
 begin
   btn_Prepare.Enabled:=not _Link;
   F_islinked:=_Link;
   cb_AddExcav.Enabled:=(F_app=2) and(not _Link);
 end;
procedure Tfrm_Order1562.FormCreate(Sender: TObject);
begin
  inherited;
dset_brig.Open;
F_Add_Excav:=0;
de_StartOrder.Date:=Now()-30;
de_endOrder.Date:=NOW();
end;


procedure Tfrm_Order1562.set_id_1562(_id_1562:integer);
const SEL_SQL='select FK_BRIG, DATE_BRIG, WHY_NOT, DATE_WHY_NOT '+
              ' from %s where id_1562=%d';
      SEL_UPDATE='update or insert into %s (id_1562)';
 var table:string;
begin

case F_APP of
 2:table:='numsorders';
 3:table:='numsorders_vds';
end;
F_ID1562:=_id_1562;
MyOpenIBDS(dset_work,Format(SEL_SQL,[table,_id_1562]));
dset_work.First;
FixDBLValue(dset_work.FieldByName('fk_brig').asinteger,dbl_brig);
if  dset_work.FieldByName('why_not').IsNull then
 m_why_not.Text:=''
else
 m_why_not.Text:= dset_work.FieldByName('why_not').AsString;
if dset_work.FieldByName('date_brig').IsNull then
  begin
   dp_brig.Date:=Now();
   me_brig.Text:=FormatDateTime('hh:mm',NOW());
   PrinMaster.Enabled:=true;
  end
else
begin
  dp_brig.Date:=dset_work.FieldByName('date_brig').AsDateTime;
  me_brig.Text:=FormatDateTime('hh:mm',dset_work.FieldByName('date_brig').AsDateTime);
end;


if dset_work.FieldByName('date_why_not').IsNull then
begin
 dp_why_not.Date:=NOW();
 me_why_not.Text:=FormatDateTime('hh:mm',NOW());
end

else
begin
 dp_why_not.Date:=dset_work.FieldByName('date_why_not').AsDateTime;
 me_why_not.Text:=FormatDateTime('hh:mm',dset_work.FieldByName('date_why_not').AsDateTime);
end;

PrinMaster.Enabled:=false;
Prin_why.Enabled:=false;


end;

function Tfrm_Order1562.set_sql_insert(fk_brig:integer=0;dt_master:string='';why_not:string='';dt_why_not:string=''):string;

 function set_avar():string;
   begin
     if trim(F_avar)='' then Result:='null'
     else result:=' ''A'' ';

   end;
 function is_set(par:string;value:string):string;
 begin
 Result:='';
  if ((value<>'') and (value<>'0')) then
   Result:=', '+par;
 end;
 function set_val(value:string):string ;
 begin
 Result:='';

  if (value<>'') and (value<>'0') then
   Result:=','''+value+'''';
 end;
 function set_int_val(value:integer):string ;
 begin
 Result:='';

  if  (value<>0) then
   Result:=', '+IntToStr(value)

  else
   Result:='';

 end;


 var table:string;
 var s:string;
     QGen:TQueryGenerator;

begin
 case F_App of
    2:table:='numsorders';
    3:table:='numsorders_vds';
  end;

   QGen:=TQueryGenerator.Create;
   QGen.TableName:=table;
   QGen.ValueByFieldName['number']:=IntToStr(F_RecivedNumber);
   QGen.ValueByFieldName['id_1562']:=intToStr(F_ID1562);
   QGen.ValueByFieldName['Number_Our_Request']:=IntToStr(OurNumber);
   QGen.ValueByFieldName['Date_Our_Request']:=''''+DateTimeToStr(Date_Our)+'''';
   QGen.ValueByFieldName['Date_Recive_Request']:=''''+DateTimeToStr(Date_Rec)+'''';
   QGen.ValueByFieldName['Recived_From']:=''''+vle_Order1562.Values['откуда']+'''';
   QGen.ValueByFieldName['state_avar']:=set_avar;
   QGen.ValueByFieldName['abonent']:=''''+F_abonent+'''';
   QGen.ValueByFieldName['phone']:=''''+F_phone+'''';
   QGen.ValueByFieldName['adress']:=''''+get_adres(F_street_name,vle_Order1562.Values['Дом'],
                                                    vle_Order1562.Values['Кватира'],
                                                    f_porch,F_floor)+'''';

   QGen.ValueByFieldName['id_Region']:=IntTOStr(F_ID_Region);
   QGen.ValueByFieldName['about']:=''''+F_about+'''';
    if set_int_val(fk_brig)<>'' then
     QGen.ValueByFieldName['fk_brig']:=IntToStr(fk_brig);
    if is_set('dt_master', dt_master)<>'' then
      QGen.ValueByFieldName['date_brig']:=''''+dt_master+'''';
    if is_set('why_not',why_not)<>'' then
     QGen.ValueByFieldName['why_not']:=''''+why_not+'''';
    if is_set('dt_why_not', dt_why_not)<>'' then
      QGen.ValueByFieldName['date_why_not']:=''''+dt_why_not+'''';
   QGen.Condition:=' matching (ID_1562) ';

   Result:=QGen.GenUpdateOrInsertQuery;
   QGen.Free;

end;


procedure Tfrm_Order1562.PrinMasterClick(Sender: TObject);

var fk_brig:integer;
   dt_brig:string;
begin
  inherited;
 try
  fk_brig:=dset_brig.fieldbyname('id').asinteger;
  if  (fk_brig>0)and(not dset_brig.FieldByName('name').IsNull)  then
  begin
   dp_brig.Date:=Date();
   me_brig.Text:=DateTimeFormat('hh:mm',Now());
   dt_brig:=dp_brig.Text+' '+me_brig.Text;
   if tran.Active then tran.Rollback;
   tran.StartTransaction;
   IBS_prin.SQL.clear;
   IBS_prin.SQL.Text:=set_sql_insert(fk_brig,dt_brig);
   IBS_prin.ExecQuery;
   tran.Commit;
   PrinMaster.Enabled:=false;
  end
  else
  begin
   Application.MessageBox('Введите фамилию мастера','Внимание!',MB_OK+MB_ICONWARNING);
  end;
 except
   PrinMaster.Enabled:=true;
   tran.Rollback;
   exit;
 end;

end;

procedure Tfrm_Order1562.Prin_whyClick(Sender: TObject);
var why_not:string;
    dt_why_not:string;
begin
  inherited;
  try
  why_not:=m_why_not.text;
  if trim(why_not)<>'' then
  begin
  dp_why_not.Date:=Date();
  me_why_not.Text:=FormatDateTime('hh:mm',Now());
  dt_why_not:=dp_why_not.text+' '+me_why_not.text;
  if tran.Active then tran.Rollback;
   tran.StartTransaction;
   IBS_prin.SQL.clear;
   IBS_prin.SQL.Text:=set_sql_insert(0,'',why_not,dt_why_not);
   IBS_prin.ExecQuery;
   tran.Commit;
   Prin_why.Enabled:=false;
  end

  else
    Application.MessageBox('Введите почему не выполненнно!','Внимание!',MB_OK+MB_ICONWARNING);

  except
   tran.Rollback;
  end;



end;

procedure Tfrm_Order1562.FormDestroy(Sender: TObject);
begin
  inherited;
dset_brig.Close;
end;

procedure Tfrm_Order1562.dbl_brigChange(Sender: TObject);
begin
  inherited;
PrinMaster.Enabled:=true;

end;

procedure Tfrm_Order1562.m_why_notChange(Sender: TObject);
begin
  inherited;
Prin_why.Enabled:=true;
end;


function Tfrm_Order1562.get_adres(street,HOUSE, APPARTMENT,Podesd,NumberFloor:string):string;
     function forAdress(val:string;add_str:string=''):string;
      begin
       Result:='';
       if (trim(val)<>'')and (trim(val)<>'.')and(trim(val)<>'-')and(trim(val)<>',') then
         Result:=Result+add_str+trim(val)+' ';
      end;
    begin
     Result:='';
     Result:=Result+street+forAdress(house,' д.') +' '+forAdress(APPARTMENT,' кв.')+
              forAdress(Podesd,' п.')+
             ' ' +forAdress(NumberFloor,' эт.');

end;



procedure Tfrm_Order1562.setAddExcav(add:integer );
begin
 if add>0 then
 begin
  F_Add_Excav:=1;
  cb_AddExcav.Checked:=true;
  pnl_OptExxcav.Height:=41;
 end
 else
 begin
  F_Add_Excav:=0;

  pnl_OptExxcav.Height:=0;
 end


end;

procedure Tfrm_Order1562.SettApp(v:integer);
begin
 F_app:=v;
 case f_app of
 2:cb_AddExcav.Enabled:= true;//not F_isLinked; {с раскопкой доступно для НС}
 3:cb_AddExcav.Enabled:=false; {с раскопкой  не доступно для ВДС}
  end;
end;

procedure Tfrm_Order1562.cb_AddExcavClick(Sender: TObject);
begin
  inherited;
  change_Opt:=false;
  if (cb_AddExcav.Checked)and (F_ID_ORDER<=0) then
  begin
    F_Add_Excav:=1;
    pnl_OptExxcav.Height:=41;

  end
  else
  begin
   F_Add_Excav:=0;
   pnl_OptExxcav.Height:=0;
   if F_IsClosed then
    begin
     F_IsClosed:=false;
     F_Searchev(false,0,0);
    end;
    cb_close.Checked:=false;
  end;
end;



procedure Tfrm_Order1562.cb_closeClick(Sender: TObject);
begin
  inherited;

de_StartOrder.Enabled:=cb_close.Checked;
de_endOrder.Enabled:=cb_close.Checked;
Change_opt:=true;
end;

procedure Tfrm_Order1562.ClosePanel;
begin
  F_closed:=false;
  pnl_OptExxcav.Height:=1;
end;

procedure Tfrm_Order1562.OpenPanel;
begin

  pnl_OptExxcav.Height:=41;
end;



procedure Tfrm_Order1562.btn_SeachClick(Sender: TObject);
begin
  inherited;
F_closed:=cb_close.Checked;
if f_Closed then
 if de_StartOrder.Date>de_endorder.Date then
 begin
  Application.MessageBox('Неправильный интервал!',PChar(gc_strDispAVR),MB_ICONERROR+MB_OK);
  de_StartOrder.SetFocus;
  exit;
 end
 else
  F_SearchEv(f_Closed,de_StartOrder.Date,de_endorder.Date)
else
 F_SearchEv(f_Closed,0,0);
Change_opt:=false;
end;

procedure Tfrm_Order1562.changeOPt(val:boolean);
begin
F_ChangeOpt:=val;
  if val then
    btn_Seach.Font.Color:=clBlue
  else
    btn_Seach.Font.Color:=clBlack;


end;


procedure Tfrm_Order1562.de_StartOrderChange(Sender: TObject);
begin
  inherited;
Change_OPt:=true;
end;


//при связывании наряда неправильно отдаем дату
function Tfrm_Order1562.Get_OpenDate(id:integer):TDateTime;
begin
  case F_app of
  2: MyOpenSQL(dset, 'select datecoming  from orders where id = '+ inttostr(id));
  3: MyOpenSQL(dset, 'select datecoming  from orders_vds where id = '+ inttostr(id));
  end;
  result:=dset.fieldbyname('datecoming').AsDateTime;
end;


end.


