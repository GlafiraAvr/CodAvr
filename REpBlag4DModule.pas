unit REpBlag4DModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, IBCustomDataSet, FR_DSet,
  FR_DBSet, DB, kbmMemTable,DModule, IBDatabase;

const
   zel_sq: array [0..0] of string =('zelen_square');
   zel_count:array [0..0] of string =('zelen_count');
   asf_count: array [0..2] of string=('magistr_count', 'vnutr_count','centrDor_count' );
   asf_sq: array [0..2] of string=('magistr_square', 'vnutr_square','centrDor_square' );
   DAYS_EXTRA = 10;
   STR_MAX_PLAN_DAY = '01.08.2014';
   STR_PLAN_DAY = '31.07.2014';
   PROSROCH = 'Просроч.';                                        
   SROCH = 'Срок';

type
  typDl=(zelen, tasf,cheb);
  Tdm_RepBlag4 = class(Tdm_NGReportBase)
    ResultDset: TkbmMemTable;
    ResultDsetregion: TStringField;
    ResultDsetadres: TStringField;
    ResultDsettotal_count: TIntegerField;
    ResultDsettotal_square: TFloatField;
    ResultDsetmagistr_count: TIntegerField;
    ResultDsetmagistr_square: TFloatField;
    ResultDsetvnutr_count: TIntegerField;
    ResultDsetvnutr_square: TFloatField;
    ResultDsetzelen_count: TIntegerField;
    ResultDsetzelen_square: TFloatField;
    ResultDsetwork_type: TStringField;
    ResultDsetraskop_dt: TDateTimeField;
    ResultDsetblag_dt: TDateTimeField;
    ResultDsetorder_number: TIntegerField;
    ResultDsetid_order: TIntegerField;
    ResultDsetexcnumber: TStringField;
    ResultDsetexcorder: TStringField;
    ResultDsetdttm_excord: TDateTimeField;
    ResultDsetdttm_planendwork: TDateTimeField;
    ResultDsetstype: TStringField;
    ResultDsetstreet: TStringField;
    ResultDsethnum: TStringField;
    ResultDsetorientir: TStringField;
    ResultDsetsblag_dt: TStringField;
    ResultDsetsdt_excord: TStringField;
    ResultDsetsdt_planendwork: TStringField;
    ResultDsetnumclass: TStringField;
    ResultDsetcentrDor_square: TIntegerField;
    ResultDsetcentrDor_count: TIntegerField;
    ResultDsetform7: TStringField;
    ResultDsetform3: TStringField;
    ResultDsetconfirm: TStringField;
    ResultDsetgroup: TIntegerField;
    ResultDsetorder: TStringField;
    ResultDsetwork_type_Z: TStringField;
    frDBDataSet1: TfrDBDataSet;
    dset_region: TIBDataSet;
    dset: TIBDataSet;
    tran: TIBTransaction;
    Svod_Zel: TkbmMemTable;
    Svod_ZelREgion: TStringField;
    Svod_Zelneed_count: TIntegerField;
    Svod_Zelneed_sq: TFloatField;
    Svod_Zelfact_count: TIntegerField;
    Svod_Zelfact_sq: TFloatField;
    Svod_Zelrasc_count: TIntegerField;
    Svod_Zelrasc_sq: TFloatField;
    Svod_Zeldo_count: TIntegerField;
    Svod_Zeldo_sq: TFloatField;
    Svod_Zelalldo_count: TIntegerField;
    Svod_Zelalldo_sq: TFloatField;
    Svod_Zelproc_count: TIntegerField;
    Svod_Zelproc_sq: TIntegerField;
    Svod_Zelost_count: TIntegerField;
    Svod_Zelost_sq: TFloatField;
    Svod_Zeldin_proc: TIntegerField;
    Svod_Zeldin_sq: TFloatField;
    Svod_Zelid_region: TIntegerField;
    Svod_asf: TkbmMemTable;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    IntegerField2: TIntegerField;
    FloatField1: TFloatField;
    IntegerField3: TIntegerField;
    FloatField2: TFloatField;
    IntegerField4: TIntegerField;
    FloatField3: TFloatField;
    IntegerField5: TIntegerField;
    FloatField4: TFloatField;
    IntegerField6: TIntegerField;
    FloatField5: TFloatField;
    IntegerField7: TIntegerField;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    FloatField6: TFloatField;
    IntegerField10: TIntegerField;
    FloatField7: TFloatField;
    frDBDataSet2: TfrDBDataSet;
    frDBDataSet3: TfrDBDataSet;
    mem_SvodAll: TkbmMemTable;
    mem_SvodAllneed_count_zel: TIntegerField;
    mem_SvodAllneed_sq_zel: TFloatField;
    mem_SvodAllneed_count_asf: TIntegerField;
    mem_SvodAllneed_sq_asf: TFloatField;
    mem_SvodAllalldo_count_zel: TIntegerField;
    mem_SvodAllall_docount_sq: TFloatField;
    mem_SvodAllall_docount_asf: TIntegerField;
    mem_SvodAllall_docsq_zel: TFloatField;
    mem_SvodAllall_docsq_asf: TFloatField;
    mem_SvodAllproc_zel: TIntegerField;
    mem_SvodAllproc_asf: TIntegerField;
    mem_SvodAllost_count_zel: TIntegerField;
    mem_SvodAllost_sq_zel: TFloatField;
    mem_SvodAllost_count_asf: TIntegerField;
    mem_SvodAllost_sq_asf: TIntegerField;
    mem_SvodAllid_region: TIntegerField;
    mem_SvodAllREgion: TStringField;
    frDBD_svod: TfrDBDataSet;
    mem_SvodAllneedadd_count: TIntegerField;
    mem_SvodAllneedall_sq: TFloatField;
    Svod_asfneedall_count: TIntegerField;
    Svod_asfneedall_sq: TFloatField;
    Svod_Zelneedall_count: TIntegerField;
    Svod_Zelneedall_sq: TFloatField;
    Svod_Cheb: TkbmMemTable;
    IntegerField11: TIntegerField;
    StringField2: TStringField;
    IntegerField12: TIntegerField;
    FloatField8: TFloatField;
    IntegerField13: TIntegerField;
    FloatField9: TFloatField;
    IntegerField14: TIntegerField;
    FloatField10: TFloatField;
    IntegerField15: TIntegerField;
    FloatField11: TFloatField;
    IntegerField16: TIntegerField;
    FloatField12: TFloatField;
    IntegerField17: TIntegerField;
    IntegerField18: TIntegerField;
    IntegerField19: TIntegerField;
    FloatField13: TFloatField;
    IntegerField20: TIntegerField;
    FloatField14: TFloatField;
    IntegerField21: TIntegerField;
    FloatField15: TFloatField;
    frDB_SvodCheb: TfrDBDataSet;
    ResultDsetclosed_order: TStringField;
    ResultDsetdate_reability_docs: TStringField;
    ResultDsetpplan_dt: TStringField;
    ResultDsetSroc: TIntegerField;
    ResultDsetprosroch: TIntegerField;
    ResultDsetoverdude_Day: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    F_BegDate, F_EndDate: TDateTime;
    F_FinishBegin, F_FinishEnd:TDateTime;
    F_DopBegin,F_DopEnd:TDateTime;
    F_BLAG: integer;
    F_GZ: boolean;
    F_ASF: boolean;
    F_ForGik:boolean;

    F_isSvod:boolean;
    F_regionID:string;
    F_without_excav:integer;

    F_overdude:boolean;// просроченыые планируемая дата больше чем сейчас DTTM_PLANENDWORK!

    F_ClosedOrder:integer; //закрытые ордера
    function _PrepBaseInfo(percent: integer): boolean;
    procedure _AddReg(id_region:integer; regionname:string);
    function AntiDouble: boolean;



    procedure CalcPartSvod(DsetRes:TkbmMemTable;typ:typDl; arrfield_sq,arrfield_count:array of string); overload;


      public
    { Public declarations }
    property blag: integer read F_BLAG write F_BLAG;
    property BegDate: TDateTime read F_BegDate write F_BegDate;
    property EndDate: TDateTime read F_EndDate write F_EndDate;

    property GZ: boolean read F_GZ write F_GZ;
    property ASF: boolean read F_ASF write F_ASF;
    function PrepareDset: boolean;
    property FinishBegin:TDateTime write F_FinishBegin ;
    property FinishEnd:TDateTime read F_FinishEnd write  F_FinishEnd ;
    property DopBegin:TDateTime write F_DopBegin ;
    property DopEnd:TDateTime write F_DopEnd ;
    property ForGIK:boolean read F_ForGik write  F_ForGik ;
    property _isSvod:boolean write F_isSvod;
    property IDREgions:string write F_regionID;
    property without_excav:integer write F_without_excav;
    function LastMonthDayBlag():TDate; virtual;
    property ClosedOrder:integer write F_ClosedOrder; //0  -все 1 закр  2  откр
     property  overdude:boolean write  F_overdude;

    protected

     SelStr:string;
    procedure OpenSvod(); virtual;
    procedure summfield(resdset:TkbmMemTable;dest: string;sours:array  of string );
    procedure CalcPartSvod(); overload; virtual;
    procedure AddSvod(region_name:string;id_reg:integer); virtual;
    procedure PostSvod(); virtual;
    procedure CalAll();          virtual;
    procedure SetSelStr(); virtual;
    procedure add(Rdset:TkbmMemTable;id_reg:integer;region_name:string);
   function groupsel(id_region:integer):string;  virtual;



  end;

var
  dm_RepBlag4: Tdm_RepBlag4;

implementation

{$R *.dfm}

uses HelpFunctions,Math;

function Tdm_RepBlag4.PrepareDset: boolean;
begin
  ResetProgressFields;

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try

    ResultDset.Close;
    ResultDset.Open;

    Result := _PrepBaseInfo( 100 );

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_RepBlag3.PrepareDset)' );
    end;
  end;
end;

function Tdm_RepBlag4._PrepBaseInfo(percent: integer): boolean;
var
  _progress_shag: integer;
begin
  Result := false;

  dset_Region.Close;
  if F_regionID<>'' then
   dset_Region.SelectSQL.Text:=Format(
      'select NAME,id from S_REGIONS where id>0  and id in %s order by id',
      [F_regionID])
   else
    dset_Region.SelectSQL.Text:='select NAME,id from S_REGIONS where id>0  order by id';


//  dset_Region.SelectSQL.Text:='select NAME,id from S_REGIONS where id>0 order by id';
  dset_Region.Open;
  dset_Region.Last;

  _progress_shag := GetProgressShagLength( percent, dset_Region.RecordCount );
  SetselStr;
  dset_Region.First;
  if F_isSvod then
  OpenSvod();
  if resultdset.Active then resultdset.Close;
  ResultDset.Open;
  while not dset_Region.Eof do
  begin
    if F_IsStopProgress then exit;
    _AddReg( dset_Region.FieldByName( 'ID' ).AsInteger, dset_Region.FieldByName( 'NAME' ).AsString );
    IncProgressStatus( _progress_shag );
    dset_Region.Next;
  end;
  if F_isSvod then
   CalAll();
  dset_Region.Close;

  Result := true;
end;

procedure Tdm_RepBlag4.SetSelStr();
    const SEL_Field='select gb.id_order,  gb.order_number, gb.adres,'+
                  '  gb.class1,  gb.class2, gb.id_dmgloc, '+
                  '  gb.raskop_dt,  gb.cheb_dt,        gb.blag_dt,'+
                  '  gb.r_sqw, gb.r_sqasf, gb.excw_sqasf,gb.excw_sq, '+
                  '  gb.num_form3, gb.num_form7,gb.excorder,'+
                  '  gb.dat_excorder, gb.confirm_blag , '+
                  '  gb.last_work ,gb.STREET_NAME, ADDITIONALADDRESS,HOUSENUM,STREET_TYP, '+
                  '  gb.SPLAN_DT, gb.DATE_READABILITY_DOCS, gb.DAT_CLOSEDORDER , gb.WITH_EXCAV,'+
                  '  gb.DTTM_PLANENDWORK ' +
                  '   from get_blag4(%d,''%s'',''%s'',''%s'') gb  ';
         sel_order=' order  by  STREET_NAME';
   var   sel_where, sel_one:string;
        Sel_str:string;
  function set_withexcav:string;
  begin

    case F_without_excav of
     0:  result:='';
     1:  result:='   with_excav is null';
     2:  result:='  WITH_EXCAV=1 ';
    end;
    if result<>'' then
    begin
     if sel_where <> '' then
      result:='('+sel_where+')'+' and '+ result;
    end
    else
     result:=sel_where;

  end;

  function set_closedOrder:string;
  begin
   case f_ClosedOrder of
    0: result :='';
    1: result := ' DAT_CLOSEDORDER is not null' ;
    2: result := ' DAT_CLOSEDORDER is null';
   end;

  end;

  procedure setOverDude();
  begin
   if F_overdude then
    if sel_where<>'' then
      sel_where:=sel_where+ ' and  (DTTM_PLANENDWORK< current_date) AND (DAT_CLOSEDORDER IS NULL)'
     else
       sel_where:=sel_where+ ' (DTTM_PLANENDWORK< current_date) AND (DAT_CLOSEDORDER IS NULL)';
  end;



begin
 sel_where:='';
    if F_Blag=1 then
    begin
      if F_FinishBegin>0 then
       sel_where:=' (blag_dt>= '''+DateToStr(F_FinishBegin)+''')';
      if F_FinishEnd>0 then
       sel_where:=Sel_Where+' and  (blag_dt<='''+DateToStr(F_FinishEnd+1)+' '')';
      if sel_where<>'' then
       sel_where:='('+sel_where+ 'or (blag_dt is null))'
      else sel_where:='(blag_dt is null)';
      sel_one:='';
      if F_DopBegin>0 then
       sel_one:='raskop_dt>'''+DateToStr(F_DopBegin)+'''';
      if F_DopEnd>0 then
        sel_one:=sel_one+' and raskop_dt<'''+DateToStr(F_DopEnd+1)+''' ';
      if sel_one<>'' then
        sel_where :=sel_where+' or ('+sel_one+')';
    end;
    if F_Blag=2 then
     sel_where:='blag_dt is not null';
  //  Sel_str:= FOrmat(Sel_Field,[id_region,DateToStr(F_BegDate-30),DateToStr(F_BegDate),DateToStr(F_EndDate)]);
    if  not F_Gz  then
        if sel_where <>'' then
           sel_where:= sel_where+ 'and  ( id_dmgloc<>3)'
        else
          sel_where:='( id_dmgloc<>3)';
    sel_where:=set_withexcav;
    if set_closedOrder()<>'' then
      if sel_where <>'' then
        sel_where := sel_where+' and '+set_closedOrder()
      else
        sel_where := ' where'+set_closedOrder();

{    if sel_where <>'' then
      sel_where := sel_where+ ' and '+ set_withexcav
    else
     sel_where:=set_withexcav;}
    setOverDude();
    if sel_where<>'' then
     Sel_str:=Sel_str+' where '+sel_where;
   Sel_str:=Sel_Field+sel_str+sel_order;
   SelStr:=Sel_str;
end;

procedure Tdm_RepBlag4._AddReg(id_region:integer; regionname:string);

  var


        group:integer;
        Sel_str:string;

 function isaddDate:boolean;
 begin
   case F_Blag of
    0:REsult:=true;
    1:begin
        result:= (dset.FieldByName('raskop_dt').AsDateTime>=F_DopBegin) and
          (dset.FieldByName('raskop_dt').AsDateTime<=F_DopEnd+1);
        if group=0 then
            result:=not result;
      end ;
     2: result:=not( dset.FieldByName('blag_dt').IsNull);
     else Result:=true;
    end;
 end;

 function  resOlanDay(dt_plan:TDate):string;
 begin
   result:='';
   Resultdset.FieldByName('prosroch').AsInteger:=0;
   Resultdset.FieldByName('Sroc').AsInteger:=0;


     if (dt_plan > 0 ) then
     begin
      REsult :=
            DateTimeFormat('dd.mm.yyyy',  dt_plan);


      if dset.FieldByName('DAT_CLOSEDORDER').asdatetime = 0 then
        if dt_plan+1<Now() then
        begin
         REsult :=
             REsult+
            #13+PROSROCH;
           Resultdset.FieldByName('Sroc').AsInteger:=1;
         end
        else
          if dt_plan<(Now()+DAYS_EXTRA) then
          begin
             REsult :=
                 REsult+
                  #13+SROCH;
           Resultdset.FieldByName('prosroch').AsInteger:=1;
          end;
     end;
    if Date()< StrToDate(STR_MAX_PLAN_DAY) then
       if dt_plan = 0 then
       begin
          dt_plan := strToDate(STR_PLAN_DAY);
          REsult:= DateTimeFormat('dd.mm.yyyy',  dt_plan);
       end;
  
 end;
 procedure Addtoresult();
   var sq_zel,sq_asf, all_sqr:double;
       total_count:integer;
       place:integer;
       add_zel:boolean;
 begin

   total_count:=0;

   resultdset.Append;
   REsultdset.FieldByName('work_type').AsString:='';
   REsultdset.FieldByName('work_type_Z').AsString:='';

   resultDset.FieldByName('group').AsInteger:=group;
   resultDset.FieldByName('region').AsString:=regionname;
   resultDset.FieldByName('adres').AsString:=dset.fieldbyname('adres').AsString;
   resultDset.FieldByName('street').AsString:=dset.fieldbyname('street_name').AsString;
   resultDset.FieldByName('order_number').AsString:=dset.fieldbyname('order_number').AsString;
   resultDset.FieldByName('numclass').AsString:=dset.fieldbyname('class1').AsString;
   if not dset.FieldByName('class2').IsNull then
     resultDset.FieldByName('numclass').AsString:=resultDset.FieldByName('numclass').AsString+'.'+dset.fieldbyname('class2').AsString;
   sq_asf:=dset.fieldbyname('r_sqasf').AsFloat;
   if dset.FieldByName('excw_sqasf').AsFloat>sq_asf then
    sq_asf:=dset.FieldByName('excw_sqasf').AsFloat;
   all_sqr:=dset.fieldbyname('r_sqw').AsFloat;
   if dset.FieldByName('excw_sq').AsFloat>all_sqr then
    all_sqr:=dset.FieldByName('excw_sq').AsFloat;

  add_zel:=dset.FieldByName('splan_dt').IsNull;
  if not add_zel then
     if group=0 then
      add_zel:=((dset.FieldByName('splan_dt').AsDateTime>F_FinishBegin) and (dset.FieldByName('splan_dt').AsDateTime<F_Finishend)) or(F_Blag=0) or (F_Blag=2)
     else
       add_zel:=true;
   if  all_sqr>sq_asf then
   begin
    sq_zel:=all_sqr-sq_asf
   end
   else
   begin
    all_sqr:=sq_asf;
    sq_zel:=-1;
   end;
    if  (not add_zel) and( sq_zel>0 ) then
      all_sqr:=all_sqr-sq_zel;
    resultDset.fieldbyname('total_square').AsFloat:=all_sqr;
    if (sq_zel>0) and (add_zel) then
    begin
     resultDset.FieldByName('zelen_square').AsFloat:=sq_zel;
     resultDset.FieldByName('zelen_count').AsInteger:=1;
     total_count:=1;
    end;
    place:=4;
     case dset.FieldByName( 'class1' ).AsInteger of
       1,2,3:  place:=dset.FieldByName( 'class1' ).AsInteger ;
       4,5:    place:=3;                  // MV 08.08.2013
                                          // тротуар и отмостка всегда по внутриквартальным дорогам
{       4,5:if (dset.FieldByName('class2').AsInteger<=2)and (dset.FieldByName('class2').AsInteger>0) then
              place:=dset.FieldByName('class2').AsInteger
             else
              place:=3;}  // MV 08.08.2013
       6,7: place:=4;
      end;
  //  if sq_asf>0 then
    case place of
      1:begin
         REsultDset.FieldByName('magistr_count').AsInteger:=1;
         total_count:=total_count+1;
         REsultDset.FieldByName('magistr_square').AsFloat:=sq_asf;
        end;
      2:begin
         REsultDset.FieldByName('centrDor_count').AsInteger:=1;
         total_count:=total_count+1;
         REsultDset.FieldByName('centrDor_square').AsFloat:=sq_asf;
        end;
      3:begin
         REsultDset.FieldByName('vnutr_count').AsInteger:=1;
         total_count:=total_count+1;
         REsultDset.FieldByName('vnutr_square').AsFloat:=sq_asf;
        end;
       else
        begin
         if sq_zel=0 then
           begin
            if add_zel then
            begin
             resultDset.FieldByName('zelen_square').AsFloat:=sq_asf;
             resultDset.FieldByName('zelen_count').AsInteger:=1;
            end;
            total_count:=1;
           end;
        end
    end;

    if total_count=0 then  total_count:=1;
    REsultDset.FieldByName('total_count').AsInteger:=total_count;
    case dset.FieldByName('last_work').AsInteger of

       9,3,2: begin
               if sq_asf>0 then                                     //раскопано
               REsultdset.FieldByName('work_type').AsString:='ШР';
                if sq_zel>0 then
               REsultdset.FieldByName('work_type_Z').AsString:='ШР';
              end;
            1:begin
               if sq_asf>0 then
               REsultdset.FieldByName('work_type').AsString:='ШЗ';     // засыпано
               if sq_zel>0 then
               REsultdset.FieldByName('work_type_Z').AsString:='ШЗ';
              end;
           6:begin
               if sq_asf>0 then
                REsultdset.FieldByName('work_type').AsString:='ШС';     //спланировано
               if (sq_zel>0) and (add_zel) then
               REsultdset.FieldByName('work_type_Z').AsString:='ШС';
              end;
       7,11,8 :begin
               if sq_asf>0 then
                REsultdset.FieldByName('work_type').AsString:='ШЩ';    //защебенено
               if (sq_zel>0) and (add_zel) then
               REsultdset.FieldByName('work_type_Z').AsString:='ШС';
              end;
          5:begin
               if sq_asf>0 then
                REsultdset.FieldByName('work_type').AsString:='ША';   //асфальт
               if (sq_zel>0) and (add_zel) then
               REsultdset.FieldByName('work_type_Z').AsString:='ШС';
             end;
     end;

     if not dset.fieldbyname('num_form3').IsNull then
         REsultdset.FieldByName('form3').AsString:=FormatDateTime('dd.mm.yy',dset.fieldbyname('num_form3').AsDateTime)
     else
      if dset.fieldbyname('class1').AsInteger>2 then
        REsultdset.FieldByName('form3').AsString:='----';
     if not dset.fieldbyname('num_form7').IsNull then
      REsultdset.FieldByName('form7').AsString:=FormatDateTime('dd.mm.yy',dset.fieldbyname('num_form7').AsDateTime)
     else
      if dset.fieldbyname('class1').AsInteger>2 then
        REsultdset.FieldByName('form7').AsString:='----';
     REsultdset.FieldByName('order').AsString:='';
     if not dset.FieldByName('excorder').IsNull then
      REsultdset.FieldByName('order').AsString:='№'+#13+dset.fieldbyname('excorder').AsString;
     if not dset.FieldByName('dat_excorder').IsNull then
       REsultdset.FieldByName('order').AsString:=REsultdset.FieldByName('order').AsString+#13+
                                                     FormatDateTime('dd.mm.yy',dset.FieldByName('dat_excorder').AsDateTime);
     if not dset.FieldByName('DATE_READABILITY_DOCS').IsNull then
     begin
       if dset.FieldByName('dat_excorder').IsNull then
         REsultdset.FieldByName('date_reability_docs').AsString:='П.'
     end
      else
       REsultdset.FieldByName('date_reability_docs').AsString:='' ;


     if not dset.FieldByName('confirm_blag').IsNull then
        REsultdset.FieldByName('confirm').AsString:=FormatDateTime('dd.mm.yy',dset.FieldByName('confirm_blag').AsDateTime);
     REsultdset.FieldByName('raskop_dt').AsDateTime:=dset.fieldbyname('raskop_dt').AsDateTime;
     if not dset.fieldbyname('blag_dt').IsNull then
      REsultdset.FieldByName('blag_dt').AsDateTime:=dset.fieldbyname('blag_dt').AsDateTime
     else
      REsultdset.FieldByName('blag_dt').asdatetime:=0;
    // REsultdset.FieldByName('cheb_dt').AsDateTime:=dset.fieldbyname('cheb_dt').AsDateTime;

    ResultDset.FieldByName('pplan_dt').AsString := resOlanDay(dset.fieldbyName('DTTM_PLANENDWORK').AsDateTime);

      if  dset.FieldByName('DAT_CLOSEDORDER').IsNull then
         ResultDset.FieldByName('closed_order').AsString:=''
      else
         ResultDset.FieldByName('closed_order').AsString:=DateTimeFormat('dd.mm.yy',dset.FieldByName('DAT_CLOSEDORDER').AsDateTime);

     if ForGIK then begin
        ResultDset.FieldByName( 'sblag_dt' ).AsString := DateTimeFormat('dd.mm.yy' ,dset.FieldByName( 'blag_dt' ).AsDateTime);

     ResultDset.FieldByName( 'excorder' ).AsString := dset.FieldByName( 'excorder' ).AsString;
     ResultDset.FieldByName( 'sdt_excord' ).AsString := DateTimeFormat('dd.mm.yyyy', dset.FieldByName( 'dat_excorder' ).AsDateTime);
     ResultDset.FieldByName( 'sdt_planendwork' ).AsString := DateTimeFormat('dd.mm.yyyy',LastMonthDay(f_EndDate));
     ResultDset.FieldByName( 'stype' ).AsString := dset.FieldByName( 'STREET_TYP' ).AsString;
     ResultDset.FieldByName( 'street' ).AsString := dset.FieldByName( 'STREET_NAME' ).AsString;
     ResultDset.FieldByName( 'hnum' ).AsString := dset.FieldByName( 'HOUSENUM' ).AsString;
     ResultDset.FieldByName( 'orientir' ).AsString := dset.FieldByName( 'ADDITIONALADDRESS' ).AsString;
      end
     else
      resultdset.FieldByName('overdude_Day').AsInteger:=0;
     if not dset.FieldByName('DTTM_PLANENDWORK').IsNull AND ( dset.FieldByName('DAT_CLOSEDORDER').IsNull) then
      resultdset.FieldByName('overdude_Day').AsInteger:=round(dset.fieldbyname('DTTM_PLANENDWORK').AsFloat)-floor(Date());
  

      if F_isSvod then
      begin
          CalcPartSvod();
      end;

     resultdset.Post;


 end;
begin
   {sel_where:='';
    if F_Blag=1 then
    begin
      if F_FinishBegin>0 then
       sel_where:=' (blag_dt>= '''+DateToStr(F_FinishBegin)+''')';
      if F_FinishEnd>0 then
       sel_where:=Sel_Where+' and  (blag_dt<='''+DateToStr(F_FinishEnd)+''')';
      if sel_where<>'' then
       sel_where:='('+sel_where+ 'or (blag_dt is null))'
      else sel_where:='(blag_dt is null)';
      sel_one:='';
      if F_DopBegin>0 then
       sel_one:='raskop_dt>'''+DateToStr(F_DopBegin)+'''';
      if F_DopEnd>0 then
        sel_one:=sel_one+' and raskop_dt<'''+DateToStr(F_DopEnd)+'''';
      if sel_one<>'' then
        sel_where :=sel_where+' or ('+sel_one+')';
    end;
    if F_Blag=2 then
     sel_where:='blag_dt is not null';}
   // if ClassName='Tdm_RepGreenSpring' then

    Sel_str:= groupsel(id_region);
    {if sel_where<>'' then
     Sel_str:=Sel_str+' where '+sel_where;
   Sel_str:=Sel_str+sel_order; }
   MyOpenSql(dset,sel_str);
   if F_isSvod then
    AddSvod(regionname,id_region);
   dset.First;
   group:=0;
   while not dset.Eof
   do
   begin
     if isaddDate then
      if  AntiDouble then
        AddToResult();
     dset.Next;
   end;
   if F_Blag=1 then
    if F_DopBegin>0 then
    begin
    group:=1;
    dset.First;

   while not dset.Eof
   do
   begin
     if isaddDate then
      if  AntiDouble then
        AddToResult();
     dset.Next;
   end;
   end;
   if F_isSvod then
   PostSvod;
   dset.Close;


end;

function Tdm_RepBlag4.AntiDouble: boolean;
    var _id: integer;
        _res : boolean;
    begin
     // здесь уберём повторяющиеся наряды, а то задолбался колупаться в базе
     _id := dset.FieldByName( 'id_order' ).AsInteger;
     _res := ResultDset.Locate('id_order', _id, [loCaseInsensitive]);
     Result := not _res;
    end;

procedure Tdm_RepBlag4.DataModuleCreate(Sender: TObject);
begin
  inherited;
F_isSvod:=false;
end;

procedure Tdm_RepBlag4.OpenSvod();
begin
 if Svod_Zel.Active then
   Svod_Zel.Close;
 if Svod_asf.Active then
  Svod_asf.Close;
 if Svod_Cheb.Active then
   Svod_Cheb.Close;
 Svod_asf.Open;
 Svod_Zel.Open;
 Svod_Cheb.Open;
end;



procedure Tdm_RepBlag4.add(Rdset:TkbmMemTable; id_reg:integer;region_name:string);
 var i:integer;
 begin
  Rdset.Append;
  Rdset.FieldByName('id_region').AsInteger:=id_reg;
  Rdset.FieldByName('region').AsString:=trim(region_name);
  for i:=2 to Rdset.FieldCount-1 do
    Rdset.Fields[i].Value:=0;
 end;

procedure Tdm_RepBlag4.AddSvod(region_name:string;id_reg:integer);



begin
  add(Svod_zel,id_reg,region_name);
  add(Svod_asf,id_reg,region_name);
  add(Svod_Cheb,id_reg,region_name);
end;

procedure Tdm_RepBlag4.PostSvod();
   procedure Calsdset(dset:TkbmMemTable);
   var c:double;
   begin
     dset.FieldByName('alldo_count').AsInteger:=dset.fieldbyname('fact_count').AsInteger+
                                                dset.fieldbyname('do_count').AsInteger;
     dset.FieldByName('alldo_sq').AsFloat:=dset.fieldbyname('fact_sq').AsFloat+
                                                dset.fieldbyname('do_sq').AsFloat;
     dset.fieldbyname('needall_count').AsInteger:=dset.fieldbyname('need_count').AsInteger+dset.fieldbyname('rasc_count').AsInteger;
     dset.fieldbyname('needall_sq').AsInteger:=dset.fieldbyname('need_sq').AsInteger+dset.fieldbyname('rasc_sq').AsInteger;

     if  dset.fieldbyname('needall_count').AsFloat>0 then
     begin
      c:=dset.FieldByName('alldo_count').AsFloat/(dset.fieldbyname('needall_count').AsFloat)*100;
      dset.FieldByName('proc_count').AsInteger:=round(c);
     end;
     if dset.fieldbyname('needall_sq').AsFloat>0 then
     begin
      c:=dset.FieldByName('alldo_sq').AsFloat/(dset.fieldbyname('needall_sq').AsFloat)*100;
      dset.FieldByName('proc_sq').AsInteger:=round(c);
     end;
     dset.FieldByName('ost_count').AsInteger:=dset.fieldbyname('need_count').AsInteger+
                                                 dset.fieldbyname('rasc_count').AsInteger-
                                                  dset.FieldByName('alldo_count').AsInteger;
     dset.FieldByName('ost_sq').AsFloat:=dset.fieldbyname('need_sq').AsFloat+
                                                 dset.fieldbyname('rasc_sq').AsFloat-
                                                  dset.FieldByName('alldo_sq').AsFloat;
     if dset.fieldbyname('need_sq').AsFloat>0 then
     begin
       c:=dset.FieldByName('ost_sq').AsFloat/dset.fieldbyname('need_sq').AsFloat*100-100;
      dset.FieldByName('din_proc').AsFloat:=round(c);
     end;
     dset.fieldbyname('din_sq').AsFloat:=dset.FieldByName('ost_sq').AsFloat-dset.fieldbyname('need_sq').AsFloat

   end;

begin
  Calsdset(Svod_Zel);
  Svod_Zel.Post;
  Calsdset(Svod_asf);
  Svod_asf.Post;
  Calsdset(Svod_Cheb);
  Svod_Cheb.Post;
end;



procedure Tdm_RepBlag4.summfield(resdset:TkbmMemTable;dest: string;sours:array  of string );
 var i:integer;
     sf:double;

 begin
   sf:=0;
   for i:=0 to Length(sours)-1 do
     sf:=sf+resultdset.fieldbyname(sours[i]).AsFloat;
   resdset.FieldByName(dest).AsFloat:=resdset.FieldByName(dest).AsFloat+sf;
 end;

procedure Tdm_RepBlag4.CalcPartSvod(DsetRes:TkbmMemTable;typ:typDl;
                                   arrfield_sq,arrfield_count:array of string);


begin

  if (resultDset.FieldByName('group').AsInteger=0)then
  begin
    summfield(DsetRes,'need_count',arrfield_count);
    summfield(DsetRes,'need_sq', arrfield_sq);
    case typ  of
     zelen:  if resultDset.FieldByName('work_type_Z').AsString='ШС'  then
               begin
                 summfield(DsetRes,'fact_count',arrfield_count);
                 summfield(DsetRes,'fact_sq', arrfield_sq);
               end;
     tasf: if resultDset.FieldByName('work_type').AsString='ША'  then
               begin
                 summfield(DsetRes,'fact_count',arrfield_count);
                 summfield(DsetRes,'fact_sq', arrfield_sq);
               end;
     cheb: if (resultDset.FieldByName('work_type').AsString ='ША')or
              ( resultDset.FieldByName('work_type').AsString ='ШЩ')  then
               begin
                 summfield(DsetRes,'fact_count',arrfield_count);
                 summfield(DsetRes,'fact_sq', arrfield_sq);
               end;

      end;

 end ;
  if resultDset.FieldByName('group').AsInteger=1 then
   begin
      summfield(DsetRes,'rasc_count',arrfield_count);
      summfield(DsetRes,'rasc_sq',arrfield_sq);
      case typ  of
          zelen: if resultDset.FieldByName('work_type_Z').AsString='ШС'  then
                  begin
                      summfield(DsetRes,'do_count',arrfield_count);
                      summfield(DsetRes,'do_sq', arrfield_sq);
                  end;
          tasf: if resultDset.FieldByName('work_type').AsString='ША'  then
                  begin
                      summfield(DsetRes,'do_count',arrfield_count);
                      summfield(DsetRes,'do_sq', arrfield_sq);
                  end;
           cheb: if (resultDset.FieldByName('work_type').AsString='ША')  or
                    ( resultDset.FieldByName('work_type').AsString ='ШЩ')  then
                  begin
                      summfield(DsetRes,'do_count',arrfield_count);
                      summfield(DsetRes,'do_sq', arrfield_sq);
                  end;

      end;
   end;


end;

procedure Tdm_RepBlag4.CalAll();
const fields:array [0..6] of string =('needall_count','needall_sq','alldo_count', 'alldo_sq', 'ost_count','ost_sq','proc_count');
      dops:array [0..1] of string =('_zel','_asf');
var i,j:integer;
    c:double;
 procedure CountSum(fieldname:string);
 var s:double;
 begin
   s:=0;
   mem_Svodall.Last;
   mem_Svodall.FieldByName(fieldname).AsFloat:=0;
   mem_Svodall.First;
   while not mem_Svodall.Eof do
    begin
     s:=s+mem_Svodall.fieldbyname(fieldname).AsFloat;
    end;
     mem_Svodall.FieldByName(fieldname).AsFloat:=s;
 end;

begin
   if mem_Svodall.Active then
    mem_Svodall.Close;
   mem_Svodall.Open;


   Svod_Zel.First;
   Svod_asf.First;
   while not Svod_Zel.Eof do
   begin
    mem_Svodall.Append;
    mem_Svodall.FieldByName('id_region').AsInteger:=Svod_Zel.fieldbyname('id_region').AsInteger;
    mem_Svodall.FieldByName('region').AsString:=Svod_Zel.fieldbyname('region').AsString;
    for i:=0 to 6 do
     begin
       mem_Svodall.FieldByName(fields[i]+'_zel').AsFloat:=Svod_Zel.fieldbyname(fields[i]).AsFloat;
       mem_Svodall.FieldByName(fields[i]+'_asf').AsFloat:=Svod_Asf.fieldbyname(fields[i]).AsFloat;
     end;
     mem_Svodall.Post;
     Svod_Zel.Next;
     Svod_asf.Next;
   end;


end;
procedure Tdm_RepBlag4.CalcPartSvod();
begin
  CalcPartSvod(Svod_Zel,zelen,zel_sq,zel_count);
  CalcPartSvod(Svod_asf,tasf,asf_sq,asf_count);
  CalcPartSvod(Svod_cheb,cheb,asf_sq,asf_count);
end;

function Tdm_RepBlag4.groupsel(id_region:integer):string;
begin
result:=FOrmat(SelStr,[id_region,DateToStr(F_BegDate-30),DateToStr(F_BegDate),DateToStr(F_EndDate)]);
end;


function Tdm_RepBlag4.LastMonthDayBlag():TDate;
begin
result:=LastMonthDay(f_EndDate);
end;



end.

