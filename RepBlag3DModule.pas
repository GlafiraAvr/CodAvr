
unit RepBlag3DModule;

interface
{
 Дата фактического благоустройства выбирается
 если последняя работа спланировано есть дата благоустрия для зеленойполосы
                       щебенено есть дата благоустрия для грунтовой дороги
                       асфальт есть дата благоустрия для отмостки
       последняя работа асфальт есть форма 3 форма7 дата благоустройство подтвердил и ордер для
         Проезжая магистральная? Проезжая внутриквартальная,Тротуар,Проезжая центральная и
         отмостки радом с проежей магистралью (Дата вбираестся как максимальная из форм 7 и 3 даты благоуст подт и даты последней работы и даты ордера)
}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DB, kbmMemTable, IBDatabase,
  IBCustomDataSet, DModule, FR_DSet, FR_DBSet;
const
   Gran_Dt='01.01.2013';
   GranDate2='01.07.2013';
type
  Tdm_RepBlag3 = class(Tdm_NGReportBase)
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
    ResultDsetraskop_dt: TDateTimeField;
    ResultDsetpplan_dt: TDateTimeField;
    ResultDsetblag_dt: TDateTimeField;
    dset_Region: TIBDataSet;
    tran: TIBTransaction;
    dset_RegionID: TIntegerField;
    dset_RegionNAME: TIBStringField;
    dset_tmp: TIBDataSet;
    ResultDsetwork_type: TStringField;
    frDBResult: TfrDBDataSet;
    ResultDsetorder_number: TIntegerField;
    dset_tmp2: TIBDataSet;
    ResultDsetid_order: TIntegerField;
    ResultDsetexcorder: TStringField;
    ResultDsetdttm_excord: TDateTimeField;
    ResultDsetdttm_planendwork: TDateTimeField;
    ResultDsetexcnumber: TStringField;
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
  private
    F_BegDate,
    F_EndDate: TDateTime;
    F_FinishBegin, F_FinishEnd:TDateTime;
    F_DopBegin,F_DopEnd:TDateTime;
    F_BLAG: integer;
    F_GZ: boolean;
    F_ASF: boolean;
    F_ForGIK: boolean;
    function AntiDouble: boolean;
    function AddItGreen(group:integer; blag_dt:TDateTime): boolean;
    function GetCountExc: integer;

    function _PrepBaseInfo( percent: integer ): boolean; virtual;
    procedure _AddReg( _RegID: integer; _RegName: string );

  public
    property BegDate: TDateTime read F_BegDate write F_BegDate;
    property EndDate: TDateTime read F_EndDate write F_EndDate;
    property blag: integer read F_BLAG write F_BLAG;
    property GZ: boolean read F_GZ write F_GZ;
    property ASF: boolean read F_ASF write F_ASF;
    property ForGIK: boolean read F_ForGIK write F_ForGIK;
    function PrepareDset: boolean;
    property FinishBegin:TDateTime write F_FinishBegin;
    property FinishEnd:TDateTime write  F_FinishEnd;
    property DopBegin:TDateTime write F_DopBegin;
    property DopEnd:TDateTime write F_DopEnd;
  end;

implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_RepBlag3 }

function Tdm_RepBlag3.PrepareDset: boolean;
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

function Tdm_RepBlag3._PrepBaseInfo(percent: integer): boolean;
var
  _progress_shag: integer;
begin
  Result := false;

  dset_Region.Close;
  dset_Region.Open;
  dset_Region.Last;

  _progress_shag := GetProgressShagLength( percent, dset_Region.RecordCount );

  dset_Region.First;
  while not dset_Region.Eof do
  begin
    if F_IsStopProgress then exit;
    _AddReg( dset_Region.FieldByName( 'ID' ).AsInteger, dset_Region.FieldByName( 'NAME' ).AsString );
    IncProgressStatus( _progress_shag );
    dset_Region.Next;
  end;
  dset_Region.Close;

  Result := true;
end;

procedure Tdm_RepBlag3._AddReg( _RegID: integer; _RegName: string );
var  _fieldlist, _join, _SQL: string;
     group:integer;
     add:boolean;
     place:integer;
      calc_blag_dt:TDate;
     function isDateBlag():TDate;
      var typ:integer;

          max_dt:TDateTime;
       function max(dt1,dt2:TDateTime):TDateTime;
       begin
         if dt1>dt2 then Result:=dt1
         else Result:=dt2;
       end;
     begin
       if dset_tmp.FieldByName( 'ID_DMGLOC' ).AsInteger=5 //грунтовая дорога
          then
           if dset_tmp.fieldbyname('cheb_dt').AsDateTime>dset_tmp.fieldbyname('blag_dt').AsDateTime then
             Result:=dset_tmp.fieldbyname('cheb_dt').AsDateTime
           else
            Result:=dset_tmp.fieldbyname('blag_dt').AsDateTime
        else
          Result:=dset_tmp.fieldbyname('blag_dt').AsDateTime;
        if Result=0 then exit;
        if dset_tmp.FieldByName('raskop_dt').AsDateTime<StrToDate(Gran_Dt)  then
         exit;

        typ:=2;
        case dset_tmp.FieldByName('id_dmgloc').AsInteger of
         1,10:typ:=1;     //Проезжая магистральная,Проезжая центральная
         7:if dset_tmp.FieldByName('class2').AsInteger=1 then typ:=1 else typ:=3;  //тротуар
         3,5,8:typ:=2;             // зеленая полоса грунтовая дорога отмостка   
         6:typ:=3;    //Проезжая внутриквартальная

        end;
        if typ=2 then
          begin
             if dset_tmp.FieldByName('comfirmblag').IsNull then    //нет благ подтвердил
                      Result:=0
            else
            REsult:=dset_tmp.FieldByName('comfirmblag').AsDateTime;
            exit;
          end;
        if typ=1 then
        if
         (dset_tmp.fieldbyname('dat_form3').IsNull) or

         (dset_tmp.fieldbyname('dttm_excord').IsNull) then
         begin
          REsult:=0;
          exit;
         end
         else
       {  max_dt:=max(dset_tmp.fieldbyname('dat_form7').AsDateTime,dset_tmp.fieldbyname('dat_form3').AsDateTime);
         max_dt:=max(max_dt,dset_tmp.fieldbyname('comfirmblag').AsDateTime);
         max_dt:=max(max_dt,dset_tmp.fieldbyname('dttm_excord').AsDateTime);}
         REsult:=dset_tmp.fieldbyname('dat_form3').AsDateTime;
{        if dset_tmp.fieldbyname('dat_form7').IsNull then
         begin
          Result:=0;
          exit;
         end
         else
          max_dt:=dset_tmp.fieldbyname('dat_form7').AsDateTime;
        if dset_tmp.FieldByName('dat_form3').IsBlob then
        begin
         Result:=0
         e
         max
 }      if typ=3 then
         begin
           //Result:=dset_tmp.fieldbyname('blag_dt').AsDateTime;
           if Now>StrToDate(GranDate2)  then
             if dset_tmp.FieldByName('comfirmblag').IsNull then
              Result:=0
             else
               Result:=dset_tmp.fieldbyname('blag_dt').AsDateTime;
         end
     end;

     function AddItMag: boolean; //совместим с зеленой зоной т.к. дату благоустройства уже определили
      var _wt :integer;
      begin

        Result:=false;
        if (not GZ)and((dset_tmp.FieldByName('id_dmgloc').AsInteger=3)or(dset_tmp.FieldByName('id_dmgloc').AsInteger=5)) then
        begin
         result:=false;
         exit;
        end;
       _wt := dset_tmp.FieldByName( 'last_exc_wrktype' ).AsInteger;
        if dset_tmp.FieldByName('EXC_SQUARE').AsFloat=0 then
        begin
         result:=false;
         exit;
        end;
       case blag of
        0: Result := true;
        1: begin
            if group=0 then
            {begin
             if ASF then
               begin //если асфальтировка, то только без асфальт.
                if (_wt <> 5) then Result := true else Result := false;
               end;
             if not ASF then //если щебенение, то только без асфальт. и без щебёнки
               begin
                if (_wt <> 5) and (_wt <> 11) and (_wt <> 7) then Result := true else Result := false;
               end;
              end
              }
              if (dset_tmp.FieldByName('raskop_dt').AsDateTime>=F_DopBegin) and
                 (dset_tmp.FieldByName('raskop_dt').AsDateTime<=F_DopEnd) then
                 begin
                  REsult:=false;
                  exit
                 end
              else
               Result:=(calc_blag_dt=0)
            else
            if (dset_tmp.FieldByName('raskop_dt').AsDateTime>=F_DopBegin) and
               (dset_tmp.FieldByName('raskop_dt').AsDateTime<=F_DopEnd) then
             Result:=true;
             if not REsult then
                 if (calc_blag_dt>=F_FinishBegin) and
                   ( calc_blag_dt<F_FinishEnd+1) then
                    Result:=true;

           end;
        2: begin
            { if ASF then
               begin //если асфальтировка, то только асфальт.
                if _wt = 5 then Result := true else Result := false;
               end;
             if not ASF then //если щебенение, то асфальт. или  щебёнка
               begin
                if (_wt = 5) or (_wt = 11) or (_wt = 7) then Result := true else Result := false;
               end;}
             Result:=(calc_blag_dt>0);
           end;
       end; //case

      end;


  function get_asf(_id: integer): Real;
     var _sql: string;
         _res: real;
     begin
       _sql := 'select last_raskop_dt, total_asf_square from get_raskop_asf_info('+
                 dset_tmp.FieldByName( 'id_order' ).AsString+', '''+DateToStr( F_EndDate )+''' )';
       if dset_tmp2.Active then dset_tmp2.Close;
       MyOpenIBDS( dset_tmp2, _sql);
       dset_tmp2.First;
       if dset_tmp2.Eof then _res := 0 else
         _res := dset_tmp2.FieldByName('total_asf_square').AsFloat;
       dset_tmp2.Close;
       Result := _res;
     end;

  procedure _From_dset_tmp_to_ResultDset;
    var
      _square, _sq_asf: double;
      _tc: integer;
      place: integer;
      zelen_count:integer;
    begin
      _square := dset_tmp.FieldByName( 'exc_square' ).AsFloat;
      _sq_asf := get_asf(dset_tmp.FieldByName( 'id_order' ).AsInteger);

      ResultDset.FieldByName( 'order_number' ).AsInteger := dset_tmp.FieldByName( 'order_number' ).AsInteger;
      ResultDset.FieldByName( 'region' ).AsString := _RegName;
      ResultDset.FieldByName( 'adres' ).AsString := dset_tmp.FieldByName( 'adres' ).AsString;
      //ResultDset.FieldByName( 'total_count' ).AsInteger := 1;
      _tc := 0;
      ResultDset.FieldByName( 'total_square' ).AsFloat := _square;
      place:=0;
      case dset_tmp.FieldByName( 'class1' ).AsInteger of
       1,2,3:  place:=dset_tmp.FieldByName( 'class1' ).AsInteger ;
       4,5:if (dset_tmp.FieldByName('class2').AsInteger<=2)and (dset_tmp.FieldByName('class2').AsInteger>0) then
              place:=dset_tmp.FieldByName('class2').AsInteger
             else
              place:=3;
       6,7: place:=4;
      end;

      case place of
        1://1,2:
          begin
            ResultDset.FieldByName( 'magistr_square' ).AsFloat := _sq_asf ;//_square;
            if _sq_asf >0 then
               ResultDset.FieldByName( 'magistr_count' ).AsInteger := GetCountExc;
            if (_square > _sq_asf) then
               begin
                 ResultDset.FieldByName( 'zelen_square' ).AsFloat := _square - _sq_asf;
                 ResultDset.FieldByName( 'zelen_count' ).AsInteger := GetCountExc;
               end;
            _tc := _tc + ResultDset.FieldByName( 'magistr_count' ).AsInteger;
          end;
        2:begin
            ResultDset.FieldByName( 'centrDor_square' ).AsFloat := _sq_asf ;//_square;
            if _sq_asf >0 then
               ResultDset.FieldByName( 'centrDor_count' ).AsInteger := GetCountExc;
            if (_square > _sq_asf) then
               begin
                 ResultDset.FieldByName( 'zelen_square' ).AsFloat := _square - _sq_asf;
                 ResultDset.FieldByName( 'zelen_count' ).AsInteger := GetCountExc;
               end;
            _tc := _tc + ResultDset.FieldByName( 'magistr_count' ).AsInteger;
          end;
        3:// 6,7,8:
          begin
            ResultDset.FieldByName( 'vnutr_square' ).AsFloat := _sq_asf;
            if _sq_asf > 0 then ResultDset.FieldByName( 'vnutr_count' ).AsInteger := GetCountExc;
            if (_square > _sq_asf) then
               begin
                 ResultDset.FieldByName( 'zelen_square' ).AsFloat := _square - _sq_asf;
                 ResultDset.FieldByName( 'zelen_count' ).AsInteger := GetCountExc;
               end;
            _tc := _tc + ResultDset.FieldByName( 'vnutr_count' ).AsInteger;
          end;
        4://3,5:
          begin
            if _sq_asf >0 then
              begin
                ResultDset.FieldByName( 'vnutr_square' ).AsFloat := _sq_asf;
                ResultDset.FieldByName( 'vnutr_count' ).AsInteger := GetCountExc;
                if (_square > _sq_asf ) then
                  ResultDset.FieldByName( 'zelen_square' ).AsFloat := _square - _sq_asf;
                  ResultDset.FieldByName( 'zelen_count' ).AsInteger := GetCountExc;
              end
             else
              begin
                ResultDset.FieldByName( 'zelen_square' ).AsFloat := _square;
                ResultDset.FieldByName( 'zelen_count' ).AsInteger := GetCountExc;
              end;
            _tc := _tc + ResultDset.FieldByName( 'zelen_count' ).AsInteger;
          end;
      end;


      _tc := ResultDset.FieldByName( 'magistr_count' ).AsInteger +
             ResultDset.FieldByName( 'vnutr_count' ).AsInteger +
             ResultDset.FieldByName( 'zelen_count' ).AsInteger+
             ResultDset.FieldByName( 'centrDor_count' ).AsInteger;
      ResultDset.FieldByName( 'total_count' ).AsInteger := _tc;

      zelen_count:=   ResultDset.FieldByName( 'zelen_count' ).AsInteger;

      case dset_tmp.FieldByName( 'last_exc_wrktype' ).AsInteger of
        1: //засыпано
          begin
           if zelen_count>0 then
             ResultDset.FieldByName( 'work_type_Z').AsString:='ШЗ';
           if (_sq_asf>0) and (place<4) then
            ResultDset.FieldByName( 'work_type' ).AsString := 'ШЗ';
          end;
        6: //спланировано
          begin
           if zelen_count>0 then
             ResultDset.FieldByName( 'work_type_Z' ).AsString := 'ШС';
           if (_sq_asf>0)and (place<4) then
             ResultDset.FieldByName( 'work_type' ).AsString := 'ШС';
          end;
        7,11: //защебенено
          begin
          if  zelen_count>0 then
             ResultDset.FieldByName( 'work_type_Z' ).AsString := 'ШC';
          if  (_sq_asf>0) and (place<4) then
              ResultDset.FieldByName( 'work_type' ).AsString := 'ШЩ';
          end;
        5: //асфальтировка
          begin
           if zelen_count>0 then
            ResultDset.FieldByName( 'work_type_Z' ).AsString := 'ШC';
           if (_sq_asf>0)and (place<4) then
             ResultDset.FieldByName( 'work_type' ).AsString := 'ША';
          end;
        else
        begin
          if zelen_count>0 then
           ResultDset.FieldByName( 'work_type_Z' ).AsString := 'ШР';
          if (_sq_asf>0) and (place<4) then
           ResultDset.FieldByName( 'work_type' ).AsString := 'ШР';

        end
      end;


      ResultDset.FieldByName( 'raskop_dt' ).AsDateTime := dset_tmp.FieldByName( 'raskop_dt' ).AsDateTime;

      ResultDset.FieldByName( 'pplan_dt' ).AsDateTime:=LastMonthDay(); //dset_tmp.FieldByName( 'DTTM_PLANENDWORK' ).AsDateTime;



      if not ForGIK then   begin
        ResultDset.FieldByName( 'blag_dt' ).AsDateTime :=calc_blag_dt;
        ResultDset.FieldByName('form7').AsString:=DateTimeFormat('dd.mm.yy',dset_tmp.fieldbyname('dat_form7').asdatetime);
        ResultDset.FieldByName('form3').AsString:=dset_tmp.fieldbyname('num_form3').AsString;
        if ResultDset.FieldByName('form3').AsString<>''
         then ResultDset.FieldByName('form3').AsString:='№'+ResultDset.FieldByName('form3').AsString+#13;
        ResultDset.FieldByName('form3').AsString:=ResultDset.FieldByName('form3').AsString+DateTimeFormat('dd.mm.yy',dset_tmp.fieldbyname('dat_form3').asdatetime);
        ResultDset.FieldByName('confirm').AsString:=DateTimeFormat('dd.mm.yy',dset_tmp.fieldbyname('COMFIRMBLAG').asdatetime);
        if  not  dset_tmp.fieldbyname('EXORDER').IsNull then
         REsultDset.FieldByName('order').AsString:='№'+dset_tmp.fieldbyname('EXORDER').AsString+
                     ' '+DateTimeFormat('dd.mm.yy',dset_tmp.fieldbyname('DTTM_EXCORD').AsDateTime);
        {}
      end;
      ResultDset.FieldByName( 'id_order' ).AsInteger := dset_tmp.FieldByName( 'id_order' ).AsInteger;
      ResultDset.FieldByName( 'numclass' ).asstring := trim(dset_tmp.FieldByName( 'class1' ).Asstring)+'.'+
                                                        trim(dset_tmp.FieldByName( 'class2' ).Asstring);

      if ForGIK then begin
        ResultDset.FieldByName( 'sblag_dt' ).AsString := DateTimeFormat('dd.mm.yyyy' ,dset_tmp.FieldByName( 'blag_dt' ).AsDateTime);
        ResultDset.FieldByName( 'excnumber' ).AsString := dset_tmp.FieldByName( 'excnumber' ).AsString;
        ResultDset.FieldByName( 'excorder' ).AsString := dset_tmp.FieldByName( 'excorder' ).AsString;
        ResultDset.FieldByName( 'sdt_excord' ).AsString := DateTimeFormat('dd.mm.yyyy', dset_tmp.FieldByName( 'dttm_excord' ).AsDateTime);
        ResultDset.FieldByName( 'sdt_planendwork' ).AsString := DateTimeFormat('dd.mm.yyyy', dset_tmp.FieldByName( 'dttm_planendwork' ).AsDateTime);

        ResultDset.FieldByName( 'stype' ).AsString := dset_tmp.FieldByName( 'stype' ).AsString;
        ResultDset.FieldByName( 'street' ).AsString := dset_tmp.FieldByName( 'street' ).AsString;
        ResultDset.FieldByName( 'hnum' ).AsString := dset_tmp.FieldByName( 'hnum' ).AsString;
        ResultDset.FieldByName( 'orientir' ).AsString := dset_tmp.FieldByName( 'orientir' ).AsString;
      end;

        ResultDset.FieldByName( 'pplan_dt' ).AsDateTime:=LastMonthDay(ResultDset.FieldByName( 'blag_dt' ).AsDateTime);
 {       if  ResultDset.FieldByName( 'blag_dt' ).AsDateTime>0 then
         ResultDset.FieldByName( 'pplan_dt' ).AsDateTime:=ResultDset.FieldByName( 'blag_dt' ).AsDateTime
        else
           ResultDset.FieldByName( 'pplan_dt' ).AsDateTime:=LastMonthDay();} //dset_tmp.FieldByName( 'DTTM_PLANENDWORK' ).AsDateTime;
    end;


begin

   _fieldlist := 'gb.ID_ORDER, gb.ORDER_NUMBER, gb.ADRES,'+
               ' gb.EXC_SQUARE, gb.ID_DMGLOC,gb.ID_ADDDMGLOC,gb.class1,gb.class2,  gb.LAST_EXC_WRKTYPE, gb.RASKOP_DT '+
               ', gb.BLAG_DT, gb.PPLAN_DT, ''V''||lpad(e.excnumber, 5, ''0'') excnumber, ei.excorder, ei.dttm_excord, e.dttm_planendwork'+
               ', (select name from s_streettypes where id = (select ss.fk_streets_streettypes from s_streets ss where ss.id = o.fk_orders_streets)) stype '+
               ', (select name from s_streets where id = o.fk_orders_streets) street, rtrim(o.housenum) hnum , trim(o.additionaladdress) orientir, e.excnumber exn ';

   _join := ' gb '+
      'join excavations e on ((e.fk_excavations_orders = gb.ID_ORDER) and (e.excnumber is not null)) '+
      ' join excavationsinfo ei on  ei.ei.fk_excinfo_orders=gb.id_order '+

      'left join orders o on(o.id = gb.ID_ORDER) order by exn';


  if ForGIK then  _SQL := Format('select %s from get_blag2( %d, ''%s'', ''%s'', ''%s'' ) %s'
                                  , [ _fieldlist , _RegID, DateToStr( F_BegDate - 60 ), DateToStr( F_BegDate ), DateToStr( F_EndDate ), _join ] )
            else  _SQL := Format( 'select * from get_blag2( %d, ''%s'', ''%s'', ''%s'' ) gb '+
                                  ' left join excavationsinfo  ei on ei.fk_excinfo_orders=gb.id_order'
                                ,[ _RegID, DateToStr( F_BegDate - 60 ), DateToStr( F_BegDate ), DateToStr( F_EndDate )] );

    MyOpenIBDS( dset_tmp, _SQL );
     {без сортировки по месту }
    group:=0;
    dset_tmp.First;
    while not dset_tmp.Eof do
    begin
       if not ForGik then
        calc_blag_dt:=dset_tmp.fieldbyname('blag_dt').AsDateTime
       else
        calc_blag_dt:=dset_tmp.fieldbyname('blag_dt').AsDateTime;
       if  AntiDouble then
       begin
     
       Add:=false;
     {   case dset_tmp.FieldByName( 'class1' ).AsInteger of
       1,2,3:  place:=dset_tmp.FieldByName( 'class1' ).AsInteger ;
       4,5:if (dset_tmp.FieldByName('class2').AsInteger<=2)and (dset_tmp.FieldByName('class2').AsInteger>0) then
              place:=dset_tmp.FieldByName('class2').AsInteger
             else
              place:=3;
       6,7: place:=4;
      end;
       case place of
          1,2,3 :Add:=(AddItMag)and( AntiDouble);

           4,5:Add:=(AddItMag)and( AntiDouble);
        end;                       }
    Add:=(AddItMag);
    // if (dset_tmp.FieldByName( 'id_dmgloc' ).AsInteger in [ 6,7,8 ]) and AddItMag
    //  and AntiDouble then
    if Add then
      begin
        ResultDset.Append;
        _From_dset_tmp_to_ResultDset;
        ResultDset.FieldByName('group').AsInteger:=_RegID*10;
        ResultDset.Post;
      end;
    end;
      dset_tmp.Next;
    end;
    if (blag=1) and (F_DopBegin>0) then begin
     group:=1;
     dset_tmp.First;
     while not dset_tmp.Eof do
     begin
       if not ForGik then
        calc_blag_dt:=isDateBlag()
       else
        calc_blag_dt:=dset_tmp.fieldbyname('blag_dt').AsDateTime;
       {case dset_tmp.FieldByName( 'id_dmgloc' ).AsInteger of
           6,7,8 :Add:=( AntiDouble);
           1,2,10:Add:=( AntiDouble);
           3,5:Add:=(AddItGreen(group))and( AntiDouble);
        end;}
         Add:=(AddItMag())and( AntiDouble);

    // if (dset_tmp.FieldByName( 'id_dmgloc' ).AsInteger in [ 6,7,8 ]) and AddItMag
    //  and AntiDouble then
    if add then
       begin
        ResultDset.Append;
        _From_dset_tmp_to_ResultDset;
        ResultDset.FieldByName('group').AsInteger:=_RegID*10+group;
        ResultDset.Post;
       end;
       dset_tmp.Next;
     end;
    end;

    {1 внутриквартальная, отмостка}
  {  dset_tmp.First;
    while not dset_tmp.Eof do
    begin
      if (dset_tmp.FieldByName( 'id_dmgloc' ).AsInteger in [ 6,7,8 ]) and AddItMag
      and AntiDouble then
      begin
        ResultDset.Append;
        _From_dset_tmp_to_ResultDset;
        ResultDset.Post;
      end;
      dset_tmp.Next;
    end;
    {/1}

    {2 магистраль, центральная}

    {dset_tmp.First;
    while not dset_tmp.Eof do
    begin
      if (dset_tmp.FieldByName( 'id_dmgloc' ).AsInteger in [ 1,2,10 ]) and AddItMag
      and AntiDouble then
      begin
        ResultDset.Append;
        _From_dset_tmp_to_ResultDset;
        ResultDset.Post;
      end;
      dset_tmp.Next;
    end;
    {/2}


    {3 зелёная зона}
 {  if GZ then
    begin
      dset_tmp.First;
      while not dset_tmp.Eof do
      begin
       if (dset_tmp.FieldByName( 'id_dmgloc' ).AsInteger in [ 3,5 ]) and AddItGreen
       and AntiDouble then
        begin
          ResultDset.Append;
          _From_dset_tmp_to_ResultDset;
          ResultDset.Post;
        end;
        dset_tmp.Next;
      end;
    end;
    {/3}

    dset_tmp.Close;
    resultDset.SortID
end;



function Tdm_RepBlag3.AddItGreen(group:integer;blag_dt:TDatetime): boolean;
     var _sql: string;
         _ct: integer;
     begin  // проверяем, а есть ли для наряда "спланировано" (6)
       _sql := 'select count(fk_excavations_excwt) ct'+
        ' from excavations '+
        ' where fk_excavations_excwt = 6 '+
        ' and fk_excavations_orders = ' + dset_tmp.FieldByName( 'id_order' ).AsString;
       if dset_tmp2.Active then dset_tmp2.Close;
       MyOpenIBDS( dset_tmp2, _sql);
       dset_tmp2.First;
       _ct := dset_tmp2.FieldByName('ct').AsInteger;
       dset_tmp2.Close;
       result:=false;
       case blag of
        0: Result := true;
        1:begin
          if (group=1) and (dset_tmp.FieldByName('raskop_dt').AsDateTime>F_DopBegin) and
            (dset_tmp.FieldByName('raskop_dt').AsDateTime<F_DopEnd)
           then Result := true
           else
            if Blag_dt = 0 then
              else Result := false;
           if not result then
            if (dset_tmp.FieldByName('blag_dt').AsDateTime>F_FinishBegin) and
               (dset_tmp.FieldByName('blag_dt').AsDateTime<F_FinishEnd) then REsult:=true;
           end;
        2: if _ct > 0 then Result := true
            else Result := false;
       end;
     end;

function Tdm_RepBlag3.AntiDouble: boolean;
    var _id: integer;
        _res : boolean;
    begin
     // здесь уберём повторяющиеся наряды, а то задолбался колупаться в базе
     _id := dset_tmp.FieldByName( 'id_order' ).AsInteger;
     _res := ResultDset.Locate('id_order', _id, [loCaseInsensitive]);
     Result := not _res;
    end;

function Tdm_RepBlag3.GetCountExc: integer;
     var _sql: string;
         _ct: integer;
     begin  // проверяем, количество для наряда "раскопано" (1)
      { _sql := 'select count(dw.fk_depworks_departure) ct'+
        ' from departureworks dw '+
        ' where dw.fk_depworks_work = 1 '+
        ' and dw.fk_depworks_order = ' + dset_tmp.FieldByName( 'id_order' ).AsString;
       if dset_tmp2.Active then dset_tmp2.Close;
       MyOpenIBDS( dset_tmp2, _sql);
       dset_tmp2.First;
       _ct := dset_tmp2.FieldByName('ct').AsInteger;
       dset_tmp2.Close;
       } // теперь просто 1 ставим by Vadim 23.06.2010
    Result := 1;//_ct;

end;

end.
