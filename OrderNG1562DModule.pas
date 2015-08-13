unit OrderNG1562DModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OrderNGDModule, IBSQL, IBDatabase, DB, IBCustomDataSet, DModule
  , RxMemDS;

type
  TSortType=(stOrderNumberAndDatecoming, stRegions, stAdres);

  ROrder1562Data = record// class
    IsLinked: boolean;
    IsClosed: boolean;
    InWork: boolean;

   //private
    F_IsLinked: boolean;
    F_IsClosed: boolean;
    F_InWork: boolean;
   //public
    // spisok1562
    ID: integer;
    NUM1562: integer;
    Datatime: TDateTime;
    phone: String;
    street_name: String;
    house: String;
    appartment: String;
    nfloor: String;
    podesd: String;
    kodpodesd: String;
    PLACE: String;
    ABONENT: String;
    Region: String;
    kodclass: String;
    ABOUT: String;
    WORKS: String;
    STATUS: String;
    AVAR : String;
    REGL : TDateTime;
    //cardwork
    id_order_att: integer;
    is_closed: Integer;
    dttm_in_work: TDateTime;
    dttm_in: TDateTime;

    ID_ISP: integer;
    ISPA: string;
    ID_JOB: integer;
    JOBA: string;
    ID_OPERATOR1562: integer;
    dttm_close, dttm_regl: TDatetime;

    // messagehistory
    fk_id_stat: Integer;
    checked: Integer;
    dttm_out: TDateTime;
    ordernumber_att: String;
    mhid: Integer;

  {  property IsLinked: boolean read F_IsLinked write F_IsLinked;
    property IsClosed: boolean read F_IsClosed write F_IsClosed;
    property InWork: boolean read F_InWork write F_InWork;
   }
  end;

 Tdm_OrderNG1562  = class(TDataModule)
    dset: TIBDataSet;
    tran: TIBTransaction;
    IBSQL1562: TIBSQL;
    tran1562: TIBTransaction;
    dset1562: TIBDataSet;
    ResultDset: TRxMemoryData;
    ResultDsetid: TIntegerField;
    ResultDsetNum1562: TIntegerField;
    ResultDsetDatatime: TDateTimeField;
    ResultDsetphone: TStringField;
    ResultDsetadres: TStringField;
    ResultDsethouse: TStringField;
    ResultDsetappartment: TStringField;
    ResultDsetnfloor: TStringField;
    ResultDsetpodesd: TStringField;
    ResultDsetkodpodesd: TStringField;
    ResultDsetPLACE: TStringField;
    ResultDsetABONENT: TStringField;
    ResultDsetRegions: TStringField;
    ResultDsetkodclass: TStringField;
    ResultDsetABOUT: TStringField;
    ResultDsetWORKS: TStringField;
    ResultDsetSTATUS: TStringField;
    ResultDsetAVAR: TStringField;
    ResultDsetREGL: TDateTimeField;
    ResultDsetid_order: TIntegerField;
    ResultDsetis_closed: TIntegerField;
    ResultDsetdttm_in_work: TDateTimeField;
    ResultDsetdttm_in: TDateTimeField;
    ResultDsetfk_id_stat: TIntegerField;
    ResultDsetchecked: TIntegerField;
    ResultDsetdttm_out: TDateTimeField;
    ResultDsetordernumber: TIntegerField;
    ResultDsetmhid: TIntegerField;
    IBSQL: TIBSQL;
    dset_Officials1562: TIBDataSet;
    dset_Job1562: TIBDataSet;
    dset_DispClose: TIBDataSet;
    AVROrdersDset: TRxMemoryData;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    ResultDsetDateComing: TDateField;
    ResultDsetFlowSpeed: TFloatField;
    StringField1: TStringField;
    ResultDsetDamagePlace: TStringField;
    ResultDsetDamageType: TStringField;
    ResultDsetDiameter: TIntegerField;
    StringField2: TStringField;
    ResultDsetid_region: TIntegerField;
    ResultDsetptr_add_info: TIntegerField;
    ResultDsetwhatisdone: TStringField;
    ResultDsetDateClosed: TDateField;
    ResultDsetHouseType: TIntegerField;
    ResultDsetHouseNum: TStringField;
    ResultDsetStreetID: TIntegerField;
    ResultDsetAddAddr: TStringField;
    ResultDsetAomTypeOfAvar: TIntegerField;
    ResultDsetisclosed: TIntegerField;
    ResultDsetsDateClosed: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
//    F_DataRec: ROrder1562Data;
    F_NeedLink, F_NeedInWork: boolean;
    F_NewIDOrderAtt: integer;
    F_UpdControls: array[1..9] of boolean;

    F_Condition: string;
    F_SortType: TSortType;
    F_IsAscSort: boolean;

   procedure OpenVocs;
   procedure CommitTransaction;
   procedure RollbackTransaction;
   function SaveUpdControls: boolean;
   function Get_ORDERNUMBER(_id: integer): integer;
   function Get_REGION_ID(_id: integer): integer;
   procedure UpdControlsChangeClear;
   function CheckControlChanges: boolean;


   procedure SetSortType(Value: TSortType);

  public
    { Public declarations }
//    property DataRec: ROrder1562Data read F_DataRec write F_DataRec;

    property Condition: string read F_Condition write F_Condition;
    property SortType: TSortType read F_SortType write SetSortType;
    property IsAscSort: boolean read F_IsAscSort write F_IsAscSort;

    procedure InitDataRec(_OrderID: integer);
    procedure CancelAll;
    procedure LinkOrder;
    procedure InWorkOrder;
    procedure InitValues;
    procedure SetChangesToSave(_t: byte);
    function SaveAll: boolean;
    procedure OnChangeManualy(_tag: byte);
    procedure FillAVROrders;
  end;


var
  dm_OrderNG1562: Tdm_OrderNG1562;
  F_DataRec: ROrder1562Data;

implementation

uses HelpFunctions;

{$R *.dfm}

procedure Tdm_OrderNG1562.DataModuleCreate(Sender: TObject);
begin

  //InitValues;

end;

procedure Tdm_OrderNG1562.InitValues;
begin
   F_NeedLink := false;
   F_NeedInWork:=false;
   OpenVocs;
   UpdControlsChangeClear;
   FillAVROrders;

end;

procedure Tdm_OrderNG1562.InitDataRec(_OrderID: integer);
var i: integer;
begin



  MyOpenIBDS(dset1562,
    ' select sp.id, sp.Num1562, sp.Datatime '+
    ', sp.PHONE, sp.street_name, sp.house, sp.appartment, sp.nfloor, sp.podesd, sp.kodpodesd '+
    ', sp.PLACE, sp.ABONENT, sp.REGION, sp.kodclass, sp.ABOUT, sp.WORKS '+
    ', (select ss.name from s_stat ss where ss.id_stat = mh.fk_id_s_stat) STATUS '+
    ', sp.AVAR, sp.REGL '+
    ', cw.fk_id_avr_order id_order '+
    ', cw.is_closed, cw.dttm_in_work '+
    ', cw.ID_ISP, cw.ISPA, cw.ID_JOB, cw.JOBA, cw.ID_OPERATOR1562 '+
    ', cw.dttm_close, cw.dttm_regl '+
    ', mh.dttm_in , mh.fk_id_s_stat , mh.checked , mh.dttm_out , mh.id mhid '+
    ' from message_history mh '+
    ' join spisok1562 sp on ((sp.id = mh.FK_ID_SPISOK1562) and (mh.FK_ID_SENDER = 1)) '+
    'left join cardwork cw on ( cw.fk_id_spisok1562 = sp.id )'+
    ' where sp.id = '+ IntToStr(F_DataRec.ID) );

  with F_DataRec, dset1562 do
   begin
    //spisok1562  (Read Only)
    ID := _OrderID;
    NUM1562  := FieldByName('NUM1562').AsInteger;
    Datatime := FieldByName('Datatime').AsDateTime;
    phone := FieldByName('phone').AsString;
    street_name := FieldByName('street_name').AsString;
    house := FieldByName('house').AsString;
    appartment:= FieldByName('appartment').AsString;
    nfloor   := FieldByName('nfloor').AsString;
    podesd   := FieldByName('podesd').AsString;
    kodpodesd:= FieldByName('kodpodesd').AsString;
    PLACE    := FieldByName('PLACE').AsString;
    ABONENT  := FieldByName('ABONENT').AsString;
    Region   := FieldByName('Region').AsString;
    kodclass := FieldByName('kodclass').AsString;
    ABOUT    := FieldByName('ABOUT').AsString;
    WORKS    := FieldByName('WORKS').AsString;
    STATUS   := FieldByName('STATUS').AsString;
    AVAR     := FieldByName('AVAR').AsString;
    REGL     := FieldByName('REGL').AsDateTime;
    //cardwork
    id_order_att := FieldByName('id_order').AsInteger;;
    is_closed    := FieldByName('is_closed').AsInteger;
    dttm_in_work := FieldByName('dttm_in_work').AsDateTime;

    ID_ISP := FieldByName('ID_ISP').AsInteger;
    ISPA   := FieldByName('ISPA').AsString;
    ID_JOB := FieldByName('ID_JOB').AsInteger;
    JOBA   := FieldByName('JOBA').AsString;;

    ID_OPERATOR1562 :=FieldByName('ID_OPERATOR1562').AsInteger;;
    dttm_close :=FieldByName('dttm_close').AsDateTime;
    dttm_regl  :=FieldByName('dttm_regl').AsDateTime;

    //messahehistory
    dttm_in    := FieldByName('dttm_in').AsDateTime;
    fk_id_stat := FieldByName('fk_id_s_stat').AsInteger;
    checked    := FieldByName('checked').AsInteger;
    dttm_out   := FieldByName('dttm_out').AsDateTime;
    ordernumber_att :=  inttostr( Get_ORDERNUMBER( FieldByName('id_order').asInteger));
    mhid := FieldByName('mhid').AsInteger;
   end; //with

   with F_DataRec do
   begin
    IsClosed := ( is_closed > 0 );
    IsLinked := ( id_order_att > 0 );
    InWork   := ( dttm_in_work > 0 );
   end;

   F_Condition := ' where 1=1';
   if F_DataRec.IsLinked then
       F_Condition := F_Condition + ' and o.id = '+ IntToStr(F_DataRec.id_order_att)
    else
       F_Condition := F_Condition +
                 // ' and o.fk_orders_regions = ' + IntToStr(Get_REGION_ID(F_DataRec.id_order_att)) +
                  ' and o.DateComing >= ''' + DateToStr( Int(F_DataRec.Datatime) - 1 )+'''' +
                  ' and o.DateComing <= ''' + DateToStr( Int(F_DataRec.Datatime) + 1 )+'''' ;

   InitValues;

end;

procedure Tdm_OrderNG1562.CommitTransaction;
begin
  if tran1562.InTransaction then tran1562.Commit;
end;

procedure Tdm_OrderNG1562.RollBackTransaction;
begin
  if tran1562.InTransaction then tran1562.Rollback;
end;

procedure Tdm_OrderNG1562.CancelAll;
begin
  RollbackTransaction;
  InitDataRec( F_DataRec.ID );
end;

procedure Tdm_OrderNG1562.LinkOrder;
begin
  F_NeedLink :=  not F_DataRec.IsLinked;
end;

procedure Tdm_OrderNG1562.InWorkOrder;
begin
  F_NeedInWork := not F_DataRec.InWork;
end;

procedure Tdm_OrderNG1562.SetChangesToSave(_t: byte);
begin

   F_UpdControls[_t] := true;

  //
end;

function Tdm_OrderNG1562.SaveAll: boolean;
var _res: boolean;


  function UpdateInWorkDset: boolean;
   var _SQL : string;
   begin
    //
     if not tran1562.Active then tran1562.StartTransaction;
     try
      _SQL := ' update message_history set checked = 1'+
              ' , dttm_out = '''+ datetimetostr(now)+
              ''' where id = '+ inttostr(F_DataRec.mhid);
      IBSQL1562.SQL.Text := _SQL;
      IBSQL1562.ExecQuery;

      _SQL := ' insert into cardwork '+
              ' (fk_id_spisok1562 , dttm_in_work, id_base) values '+
              '( '+ inttostr( F_DataRec.ID ) +
              ', '''+ datetimetostr(now)+ ''', 1)';
      IBSQL1562.SQL.Text := _SQL;
      IBSQL1562.ExecQuery;

      _SQL := ' insert into message_history '+
              ' (fk_id_spisok1562 , dttm_in, fk_id_sender, fk_id_s_stat, checked) values '+
              '( '+ inttostr( F_DataRec.ID ) +
              ', '''+ datetimetostr(now)+ ''', 2, 3, 0)';

      IBSQL1562.SQL.Text := _SQL;
      IBSQL1562.ExecQuery;

      tran1562.Commit;
      //F_NeedSaveChanges:= false;
      Result := true;
      tran1562.StartTransaction;

     except
      on E:Exception do
      begin
        tran1562.Rollback;
        raise Exception.Create(E.Message+'( -- procedure Tfrm_OrderNG1562.btn_SaveClick(Sender: TObject)), UpdateInWorkDset');
        Result := false
      end;
     end;

   end;


  function UpdateLinkDset(_id: integer): boolean;
   var _SQL : string;
   begin
    if not tran1562.Active then tran1562.StartTransaction;
    try
      _SQL := ' update cardwork set ' +
              ' id_base = 1'+
              ' , FK_ID_AVR_ORDER = '+ inttostr(_id)+
              ' where FK_ID_SPISOK1562 = '+ inttostr(F_DataRec.ID);
      IBSQL1562.SQL.Text := _SQL;
      IBSQL1562.ExecQuery;
      tran1562.Commit;
    //  F_IsCtrlChange:= true;
      tran1562.StartTransaction;
      result := true;
    except
      on E:Exception do
      begin
        tran1562.Rollback;
        raise Exception.Create(E.Message+'( -- procedure Tfrm_Order1562.btn_SaveClick(Sender: TObject)), UpdateLinkDset');
        result := false;
      end;
    end;
   end;


begin

 _res := true;


  if F_NeedInWork and _res then
    if (Application.MessageBox(PChar('ÏÐÈÍßÒÜ ÒÅÊÓÙÓÞ ÇÀßÂÊÓ?'),
                              'Âíèìàíèå!', MB_YESNO+MB_ICONQUESTION)=ID_YES)
      then _res := _res and UpdateInWorkDset;

   if F_NeedLink and _res then
      if ( F_DataRec.id_order_att = 0 ) or
       (Application.MessageBox(PChar('Ýòà çàÿâêà óæå ñâÿçàíà ñ íàðÿäîì ¹'+ F_DataRec.ordernumber_att +'. Èçìåíèòü ñâÿçü íà ¹'+ IntToStr(Get_ORDERNUMBER(F_NewIDOrderAtt)) +' ?'),
                                'Âíèìàíèå!', MB_YESNO+MB_ICONQUESTION)=ID_YES)
        then _res := _res and UpdateLinkDset(F_NewIDOrderAtt);

  if CheckControlChanges then
    if (Application.MessageBox(PChar('Ñîõðàíèòü èçìåíåíèÿ?'),
                              'Âíèìàíèå!', MB_YESNO+MB_ICONQUESTION)=ID_YES)
      then _res := _res and SaveUpdControls;

    Result := _res;
  { if F_IsNeedToClose then
    if (Application.MessageBox(PChar('ÇÀÊÐÛÒÜ ÒÅÊÓÙÓÞ ÇÀßÂÊÓ?'),
                              'Âíèìàíèå!', MB_YESNO+MB_ICONQUESTION)=ID_YES)
      then UpdateCloseDset;
   }

  InitValues;

end;

function Tdm_OrderNG1562.CheckControlChanges: boolean;
  var b:byte;
      _res: boolean;
begin
    _res := false;
    for b:= 1 to 9 do
        if F_UpdControls[b] then _res := true;

    Result := _res;
end;


procedure Tdm_OrderNG1562.UpdControlsChangeClear;
var b:byte;
begin
   for b := 1 to 9 do
      F_UpdControls[b] := false;
end;


procedure Tdm_OrderNG1562.OnChangeManualy(_tag: byte);
begin
  F_UpdControls[_tag] := true ;
end;


function Tdm_OrderNG1562.SaveUpdControls: boolean;
var _set, _sql, _sep: string;
begin
    //
 _sql := ' update cardwork set ';
 _set := '';
 _sep := '';


    if F_UpdControls[1] or F_UpdControls[2] then
        begin
               _set := ' dttm_regl = '''+ DateTimeToStr(F_DataRec.dttm_regl)+'''';
               _sep:= ', ';
        end;
    if F_UpdControls[3] then
        begin
//             _set := _set + _sep + 'ID_ISP = '+ IntToStr(DataRec.);
             _sep:= ', ';
          end;
    if F_UpdControls[4] then
        begin
             _set := _set +_sep + 'ISPA = '''+ F_DataRec.ISPA + ''''; _sep:= ', ';
          end;
    if F_UpdControls[5] then
        begin
             _set := _set +_sep + 'ID_JOB = '+ IntToStr(F_DataRec.ID_JOB);
             _sep:= ', ';
        end;
    if F_UpdControls[6] then
        begin
             _set := _set +_sep + 'JOBA = '''+ F_DataRec.JOBA + ''''; _sep:= ', ';
        end;
    if F_UpdControls[7] then _set :=_set + _sep + 'ID_OPERATOR1562 = '+ IntToStr(F_DataRec.ID_OPERATOR1562);

  _sql := _sql + _set;

  _sql := _sql + ' where FK_ID_SPISOK1562 = '+ inttostr(F_DataRec.ID);

  if not tran1562.Active then tran1562.StartTransaction;
    try
      IBSQL1562.SQL.Text := _sql;
      IBSQL1562.ExecQuery;
      tran1562.Commit;
//      F_IsCtrlChange:= true;
      UpdControlsChangeClear;
      tran1562.StartTransaction;
    except
      on E:Exception do
      begin
        tran1562.Rollback;
        raise Exception.Create(E.Message+'( -- procedure Tdm_OrderNG1562.SaveUpdControls)');
      end;
    end;


end;

function Tdm_OrderNG1562.Get_ORDERNUMBER(_id: integer): integer;
   begin
      MyOpenSQL(dset, 'select ordernumber from orders where id = '+ inttostr(_id));
      result := dset.FieldByName('ordernumber').AsInteger;
   end;

function Tdm_OrderNG1562.Get_REGION_ID(_id: integer): integer;
   begin
      MyOpenSQL(dset, 'select FK_ORDERS_REGIONS from orders where id = '+ inttostr(_id));
      result := dset.FieldByName('FK_ORDERS_REGIONS').AsInteger;
   end;


procedure Tdm_OrderNG1562.FillAVROrders;
  function GetSortCondition: string;
  var
    s: string;
  begin
    if F_IsAscSort then s:='asc'
    else s:='desc';

    case F_SortType of
      stOrderNumberAndDatecoming:
        Result:=' order by OrderNumber '+s+', DateComing';
      stRegions:
        Result:=' order by 5 '+s;
      stAdres:
        Result:=' order by 10 '+s;
      else Result:='';
    end;
  end;
var
  i: integer;
begin

  if AVROrdersDset.Active then AVROrdersDset.Close;
  AVROrdersDset.Open;

  MyOpenIBDS(dset,
    ' select id, OrderNumber, cast(DateComing as Date) DateComing, FlowSpeed,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
    ' (select name from s_DamagePlace where id=o.fk_orders_damageplace) DamagePlace,'+
    ' (select name from s_DamageType where id=o.fk_orders_damagetype) DamageType,'+
    ' (select diameter from s_TubeDiameter where id=o.fk_orders_diameters) Diameter,'+
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
    '  o.housenum, o.additionaladdress)) adres, fk_orders_regions id_region,' +
    ' (select orderworks from get_orderworks( o.id, 0, 1 )) whatisdone,'+
    '  cast(DateClosed as Date) DateClosed,'+
    ' o.fk_orders_housetypes HouseType, o.fk_orders_streets StreetID, o.HouseNum,'+
    ' o.additionaladdress AddAddr'+
    ' , o.IsClosed '+
    ' from orders o '+
    F_Condition+
    GetSortCondition);


  dset.First;
  while not dset.Eof do
  begin
    AVROrdersDset.Append;
    for i:=0 to dset.FieldCount-1 do
      AVROrdersDset.FieldByName(dset.Fields[i].FieldName).Value:=dset.Fields[i].Value;

    if  (dset.FieldByName('isclosed').AsInteger = 1) then
        AVROrdersDset.FieldByName('sdateclosed').AsString := dset.FieldByName('dateclosed').AsString
        else
        AVROrdersDset.FieldByName('sdateclosed').AsString := '';
    AVROrdersDset.Post;

    dset.Next;
  end;
  dset.Close;
end;

procedure Tdm_OrderNG1562.SetSortType(Value: TSortType);
begin
  if Value<>F_SortType then
  begin
    F_IsAscSort:=true;
    F_SortType:=Value;
  end else F_IsAscSort:=not F_IsAscSort;
end;


procedure Tdm_OrderNG1562.OpenVocs;
begin
 if (dset_Officials1562.Active) then dset_Officials1562.Close; dset_Officials1562.Open;
 if (dset_Job1562.Active) then dset_Job1562.Close; dset_Job1562.Open;
 if (dset_DispClose.Active) then dset_DispClose.Close; dset_DispClose.Open;
end;


procedure Tdm_OrderNG1562.DataModuleDestroy(Sender: TObject);
begin
  //F_DataRec.Destroy;
end;

end.
