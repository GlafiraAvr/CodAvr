unit NumSOBuffDModule;

interface

{$I !TEST_DEFINE.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseBuffDModule, IBDatabase, IBCustomDataSet, DB, kbmMemTable,
  DModule, IBSQL, ADODB,GlobalData;

type

  Tdm_NumSOBuff = class(Tdm_BaseBuff)
    mt_BuffDataid_order: TIntegerField;
    mt_BuffDataid: TIntegerField;       
    mt_BuffDatanumber: TIntegerField;
    mt_BuffDataDate_Recive_Request: TDateTimeField;
    mt_BuffDataNUMBER_OUR_REQUEST: TIntegerField;
    mt_BuffDataDATE_OUR_REQUEST: TDateTimeField;
    mt_BuffDataRECIVED_FROM: TStringField;
    mt_BuffDataid_1562: TIntegerField;
    mt_BuffDatastate_inner: TIntegerField;
    mt_BuffDataDatePrin: TDateTimeField;
    mt_BuffDataid_officials: TIntegerField;
    dset_officials: TIBDataSet;
    mt_BuffDataname_officials: TStringField;
    ADO_1562: TADOQuery;
    mt_BuffDatadel_state: TIntegerField;
    sql_updelete: TIBSQL;
    mt_BuffDatastate_outer: TIntegerField;
    mt_BuffDataabonent: TStringField;
    mt_BuffDataphone: TStringField;
    mt_BuffDataRegion: TStringField;
    mt_BuffDataadress: TStringField;
    mt_BuffDataabout: TStringField;
    mt_BuffDataID_OFFICIALS_PHONED: TIntegerField;
    mt_BuffDatais_phobed: TBooleanField;
    mt_BuffDataadd_excav: TBooleanField;
    mt_BuffDatais_excav: TIntegerField;
    mt_BuffDataDateClosed: TDateTimeField;
    mt_BuffDatais_closed: TBooleanField;
    mt_BuffDatastate_excav: TIntegerField;
    mt_BuffDatadeleted: TBooleanField;
    procedure mt_BuffDatanumberSetText(Sender: TField; const Text: String);
    procedure DataModuleCreate(Sender: TObject);
    procedure mt_BuffDataCalcFields(DataSet: TDataSet);
  private
    F_OrderID: integer;
    F_ID_DIST:integer;
    F_for_vds:integer;
    F_OrderClosed:boolean;
    table:string;
    F_ExcavList:TStringlist; //список для кап ремонта
    F_OrderNumber:string;  //???????
    F_DateOrder:tDateTime;   //???? ??????????? ??????
  protected
    procedure FillBuffData; override;
    procedure InsertBuffRec; override;
    procedure UpdateBuffRec; override;
    procedure DeleteBuffRec; override;
    procedure CangeVds(for_vds:integer);
  public
    procedure ISSentRallBack; override;
    property OrderID: integer read F_OrderID write F_OrderID;
    property for_vds: integer read F_for_vds write CangeVds;
    property id_disp: integer write F_ID_DIST;
    function GetAllNumSO: string;
    function GetAllNumSOViw: string;
    property OrderClosed:boolean write F_OrderClosed;
    function GetAllIDSOList: TstringList;
    function getStateouter:integer;
    function GetAllNumSO_1562: string; //17.08.2012
    function GetAllIDSOList_1562: TstringList;
    function GetAllIDSOList_1562tel: TstringList;
    function GetAllIDSOList_1562Och: TstringList;
    function GetForExcavform: String; //список заявок которые нужно вернуть из кап ремонта
    function  SetStateKap(State:integer): boolean ; //усттановим статус заявок кап ремонт!
    property OrderNumber:string write F_orderNumber;  //???????
    property DateOrder:tDateTime write F_DateOrder;   //???? ??????????? ??????
  end;


implementation

{$R *.dfm}

{ Tdm_NumSOBuff }

uses HelpFunctions,workSQL;

const sql_sqlupdel='update %s set date_recive_request=null, '+      //если наояд закрыт помечаем как удаленную
                                         ' id_1562=null, '+
                                         ' date_our_request=null, '+
                                         ' state_inner=2, '+
                                         ' state_outer=2 %s' +                                          
                                         ' where id = :pID ';
        sql_sqldelete='delete from %s where id = :pID';


procedure Tdm_NumSOBuff.DeleteBuffRec;
var app:integer;
function addDel():string;
begin
  if for_vds=0 then
   result:=' , F_STATE_EXCAV =null '
  else
  result:='';
end;
begin
//0 - vds 1 - ns 2 och vod
  app:=abs(F_for_vds-1);
{ т.к. в  закрытых нарядах могут быть открытые заявки то проверяем и статус заявки
заявка принята     state_inner=1 иначе заявка выполненна или отказана}
 if (F_OrderClosed) and (mt_BuffData.FieldByName('state_inner').AsInteger<>1) then
 begin
 sql_Delete.SQL.Text:=Format(sql_sqlupdel,[table,addDel]);
 sql_Delete.ParamByName('pID').AsInteger:=mt_BuffData.FieldByName( 'ID' ).AsInteger;
 end
 else
 begin

 sql_delete.SQL.Text:=Format(sql_sqlupdel,[table, addDel]);
 sql_Delete.ParamByName( 'pID' ).AsInteger := mt_BuffData.FieldByName( 'ID' ).AsInteger;
  if not mt_BuffData.FieldByName( 'del_state' ).IsNull  then
    if  mt_BuffData.FieldByName( 'del_state' ).AsInteger=0 then
     begin //отсылка отказа без смены службы
      dm_workSQL.RallBack1562(mt_BuffData[ 'id_1562' ],  mt_BuffData[ 'id_order' ],app,f_OrderNumber,F_DateOrder);
     end
     else
     begin  //отсылка отказа co сменой службы
      app:=abs(app-1);
      dm_workSQL.RallBack1562(mt_BuffData[ 'id_1562' ],  mt_BuffData[ 'id_order' ],app,f_OrderNumber,F_DateOrder);
     end;
 end;

end;

procedure Tdm_NumSOBuff.FillBuffData;
 function formAdress(val:string;add_str:string=''):string;
 begin
  Result:='';
  if trim(val)<>'' then
   Result:=Result+add_str+trim(val)+' ';
 end;
 function setadd_excav:string;
 begin
  if F_for_vds=1 then
   result:='0'
  else
   result:='';
 end;
 function setadd_sate_excav:string;
 begin
  if F_for_vds=1 then
   result:='null'
  else
   result:='F_STATE_EXCAV';
 end;
var list_1562:TstringList;
    sel_msSQL:string;
    about:string;
begin
  list_1562:=TStringList.Create;
  MyOpenIBDS( dset,
    {' select id, id_order, number' +
    ' from numsorders' +
    ' where id_order = ' + IntToStr( F_OrderID ) +
    ' order by number' );}
    format(
    ' select n.id, id_order, number, date_recive_request, id_1562,'+
    ' number_our_request, date_our_request, rtrim(recived_from) recived_from, state_inner,DatePrin,id_officials,name,state_outer,'+
    ' adress, abonent,phone,about,ID_OFFICIALS_PHONED,%s add_excav,dateclosed, %s state_excav  ' +
    ' from '+table+' n'+
    ' left join S_OFFICIALS  so on  n.id_officials=so.id'+
    ' where  id_order = ' + IntToStr( F_OrderID ) +
    ' order by id_1562',[Setadd_excav(),setadd_sate_excav()] ));
{$IFDEF spisok1562}
//
{$endif}

  dset.First;
  while not dset.Eof do
  begin
    mt_BuffData.Append;
    mt_BuffData[ 'id' ] := dset[ 'id' ];
    mt_BuffData[ 'id_order' ] := dset[ 'id_order' ];
    mt_BuffData[ 'number' ] := dset[ 'number' ];
    mt_BuffData[ 'REC_STATE' ] := Ord( rsOriginal );
    if  dset[ 'date_recive_request' ]>0 then
    mt_BuffData[ 'date_recive_request' ] := dset[ 'date_recive_request' ];

    mt_BuffData[ 'id_1562' ] := dset[ 'id_1562' ];
    mt_BuffData[ 'number_our_request' ] := dset[ 'number_our_request' ];
    mt_BuffData[ 'date_our_request' ] := dset[ 'date_our_request' ];
    mt_BuffData[ 'recived_from' ] := dset[ 'recived_from' ];
    mt_BuffData[ 'state_inner' ] := dset[ 'state_inner' ];
    mt_BuffData[ 'DatePrin' ] := dset[ 'DatePrin' ];
    mt_BuffData[ 'id_officials' ] := dset[ 'id_officials' ];
    mt_BuffData[ 'name_officials' ] := dset[ 'name' ];
    mt_BuffData[ 'state_outer' ] := dset[ 'state_outer' ];
    mt_BuffData[ 'ID_OFFICIALS_PHONED' ] := dset[ 'ID_OFFICIALS_PHONED' ];
    mt_BuffData.fieldbyname('is_phobed').AsBoolean:= mt_BuffData.FieldByName('ID_OFFICIALS_PHONED').AsInteger>0;
    mt_BuffData.fieldbyname('is_excav').asinteger:=dset.FieldByName('add_excav').AsInteger;
    mt_BuffData.FieldByName('DateClosed').AsDateTime:=dset.fieldbyname('dateclosed').AsDateTime;
    mt_BuffData.FieldByName('is_deleted').AsBoolean:= (dset.FieldByName( 'id_1562' ).IsNull);
    if for_vds =0 then
     mt_BuffData.FieldByName('state_excav').asinteger:=dset.fieldbyname('state_excav').asinteger;


    with   mt_BuffData do begin
        Fieldbyname('abonent').AsString:=dset.fieldbyname('abonent').AsString;

         Fieldbyname('phone').AsString:=dset.fieldbyname('phone').AsString;
         Fieldbyname('about').AsString:=dset.fieldbyname('about').AsString;
         Fieldbyname('adress').AsString :=dset.fieldbyname('adress').AsString;
    end;


    mt_BuffData.Post;
    list_1562.Add(dset.fieldbyname('id_1562').AsString);


    dset.Next;
  end;

  if (list_1562.Count>0) and (ADO_1562.Connection.Connected) then
  try
   if  not ADO_1562.Connection.Connected then
     dm_main.ConnectADO1562('','');
   sel_msSQL:='select id, NumberReceivedRequest  number_1562, '+
               ' [NumberOurRequest] our_number, '+
               ' [abonent], '+
               ' [phone], '+
               ' [rayon_name] Region,'+
               ' [s_types_name] str_type,'+
               ' [name_street] street,'+
               ' [HOUSE] ,'+
               ' [APPARTMENT],'+
               ' [NumberFloor], '+
               ' [Podesd], ' +
               ' [about],'+
               ' [opened]'+
               ' from DateTime_KhNew_Select_vw where id =%s '+
               ' order by 1';

   mt_BuffData.First;

   while not mt_BuffData.Eof do
   begin

     if  (not mt_BuffData.FieldByName('id_1562').IsNull) and
     (trim(mt_BuffData.FieldByName('about').AsString)='') then
     begin
       ADO_1562.SQL.Text:=Format(sel_msSQL,[mt_BuffData.FieldByName('id_1562').AsString]);
       ADO_1562.Open;
       ADO_1562.First;
       mt_buffData.Edit;
       about:='';
       with mt_buffData do begin
         Fieldbyname('abonent').AsString:=ADO_1562.fieldbyname('abonent').AsString;
         Fieldbyname('Region').AsString:=ADO_1562.fieldbyname('Region').AsString;
         Fieldbyname('phone').AsString:=ADO_1562.fieldbyname('phone').AsString;
         Fieldbyname('about').AsString:=ADO_1562.fieldbyname('about').AsString;
       end;
       with  ADO_1562 do begin
         about:=about+formAdress(FieldByName('str_type').AsString);
         about:=about+formAdress(FieldByName('street').AsString);
         about:=about+formAdress(FieldByName('HOUSE').AsString ,'д.');
         about:=about+formAdress(FieldByName('APPARTMENT').AsString, 'кв.');
         about:=about+formAdress(FieldByName('Podesd').AsString, 'под.');
         about:=about+formAdress(FieldByName('NumberFloor').AsString, 'эт.');
       end;
       mt_buffData.FieldByName('adress').AsString:=about;
       ADO_1562.Close;
       mt_buffData.Post;
      end ;
      mt_buffData.Next;

   end;
  except on e:EADOError do
   begin
    e.Message:='Ошибка приформировании списка заявок MSSQl'+#13+e.Message;
    Raise e;
   end
  end;
 list_1562.Free;
end;


procedure Tdm_NumSOBuff.InsertBuffRec;
begin
  sql_Insert.ParamByName( 'pOrderID' ).AsInteger := F_OrderID;
  sql_Insert.ParamByName( 'pNumber' ).AsInteger := mt_BuffData.FieldByName( 'number' ).AsInteger;
end;

procedure Tdm_NumSOBuff.UpdateBuffRec;
begin
  sql_Update.ParamByName( 'pID' ).AsInteger := mt_BuffData.FieldByName( 'ID' ).AsInteger;
  sql_Update.ParamByName( 'pNumber' ).AsInteger := mt_BuffData.FieldByName( 'number' ).AsInteger;
  if for_vds =0 then
    sql_Update.ParamByName( 'state_excav' ).AsInteger := mt_BuffData.FieldByName( 'state_excav' ).AsInteger;
  if mt_BuffData.FieldByName('is_phobed').AsBoolean then
   sql_Update.ParamByName( 'ID_officials' ).AsInteger:= g_IDOfficial
  else
   sql_Update.ParamByName( 'ID_officials' ).AsVariant:=null;
end;

procedure Tdm_NumSOBuff.mt_BuffDatanumberSetText(Sender: TField;
  const Text: String);
var
  _val: integer;
begin
  inherited;
  try
    _val := StrToInt( Text );
    Sender.AsInteger := _val;
  except
    Application.MessageBox( 'Введенное значение превышает допустимое значение!',
      'Диспетчер АВР', MB_OK + MB_ICONWARNING );
  end;
end;

function Tdm_NumSOBuff.GetAllNumSO: string;
var fl:boolean;
begin
  Result :='';
  fl:=true;
  if ( mt_BuffData.Active ) and ( not mt_BuffData.IsEmpty ) then
  begin
    mt_BuffData.First;
    while not mt_BuffData.Eof do
    begin
      if  not (mt_BuffData.FieldByName('RECIVED_FROM').IsNull) then
       fl:=mt_BuffData.FieldByName('state_inner').IsNull;
     if not fl then
      fl:=(mt_BuffData.FieldByName('state_inner').asinteger=1);
     if fl then
         Result:=Result+mt_BuffData.FieldByName( 'number').AsString+', ';
      mt_BuffData.Next;
    end;
  end;
 Delete(Result,length(Result)-1,1);

end;


function Tdm_NumSOBuff.GetAllNumSO_1562: string;
var fl:boolean;
begin
  Result :='';
   fl:=true;
  if ( mt_BuffData.Active ) and ( not mt_BuffData.IsEmpty ) then
  begin
    mt_BuffData.First;
    while not mt_BuffData.Eof do
    begin
      if  not (mt_BuffData.FieldByName('RECIVED_FROM').IsNull) then
       fl:=mt_BuffData.FieldByName('state_inner').IsNull;
     if not fl then
      fl:=(mt_BuffData.FieldByName('state_inner').asinteger=1);
     if fl and (mt_BuffData.FieldByName( 'number').asinteger<>0)  then
         Result:=Result+mt_BuffData.FieldByName( 'number').AsString+', ';
      mt_BuffData.Next;
    end;
  end;
 Delete(Result,length(Result)-1,1);

end;

function Tdm_NumSOBuff.GetAllNumSOViw: string;
var fl:boolean;
begin
  Result :='';

  if ( mt_BuffData.Active ) and ( not mt_BuffData.IsEmpty ) then
  begin
    mt_BuffData.First;
    while not mt_BuffData.Eof do

    begin
     fl:= not mt_BuffData.FieldByName('state_inner').IsNull;
    // if not fl then
     // fl:=(mt_BuffData.FieldByName('state_inner').asinteger=1);
     if fl then
     begin
      Result:=Result+mt_BuffData.FieldByName( 'number').AsString+'('+ mt_BuffData.FieldByName( 'id_1562' ).AsString+'), '+#13 ;
     end;
      mt_BuffData.Next;
    end;
  end;
 Delete(Result,length(Result)-2,2);

end;

function Tdm_NumSOBuff.GetAllIDSOList: TstringList;
var fl:boolean;
begin
  REsult:=TStringList.Create;
  if ( mt_BuffData.Active ) and ( not mt_BuffData.IsEmpty ) then
  begin
    mt_BuffData.First;
    while not mt_BuffData.Eof do

    begin
     fl:=mt_BuffData.FieldByName('state_inner').IsNull;
     if not fl then
      fl:=(mt_BuffData.FieldByName('state_inner').asinteger=1);
     if fl then
     begin
      Result.add(mt_BuffData.FieldByName( 'id_1562').AsString);
     end;
      mt_BuffData.Next;
    end;
  end;
end;


function Tdm_NumSOBuff.GetAllIDSOList_1562: TstringList;
var fl:boolean;
begin
  REsult:=TStringList.Create;
  if ( mt_BuffData.Active ) and ( not mt_BuffData.IsEmpty ) then
  begin
    mt_BuffData.First;
    while not mt_BuffData.Eof do

    begin
     fl:=mt_BuffData.FieldByName('state_inner').IsNull;
     if not fl then
      fl:=(mt_BuffData.FieldByName('state_inner').asinteger=1);
     if fl and (mt_BuffData.FieldByName('number').asinteger<>0)and ( not mt_BuffData.FieldByName('id_1562').IsNull)
     and (trim( mt_BuffData.FieldByName('RECIVED_FROM').AsString)='1562') then
     begin
      Result.add(mt_BuffData.FieldByName( 'id_1562').AsString);
     end;
      mt_BuffData.Next;
    end;
  end;
end;


function Tdm_NumSOBuff.GetAllIDSOList_1562tel: TstringList;
var fl:boolean;
begin
  REsult:=TStringList.Create;
  if ( mt_BuffData.Active ) and ( not mt_BuffData.IsEmpty ) then
  begin
    mt_BuffData.First;
    while not mt_BuffData.Eof do

    begin
     fl:=mt_BuffData.FieldByName('state_inner').IsNull;
     if not fl then
      fl:=(mt_BuffData.FieldByName('state_inner').asinteger=1);
     if fl and (mt_BuffData.FieldByName('number').asinteger=0)and
            ( not mt_BuffData.FieldByName('id_1562').IsNull)
            and(trim( mt_BuffData.FieldByName('RECIVED_FROM').AsString)='По телефону')  then
     begin
      Result.add(mt_BuffData.FieldByName( 'id_1562').AsString);
     end;
      mt_BuffData.Next;
    end;
  end;
end;

function Tdm_NumSOBuff.GetAllIDSOList_1562Och: TstringList;
var fl:boolean;
begin
  REsult:=TStringList.Create;
  if ( mt_BuffData.Active ) and ( not mt_BuffData.IsEmpty ) then
  begin
    mt_BuffData.First;
    while not mt_BuffData.Eof do

    begin
     fl:=mt_BuffData.FieldByName('state_inner').IsNull;
     if not fl then
      fl:=(mt_BuffData.FieldByName('state_inner').asinteger=1);
     if fl and
            ( not mt_BuffData.FieldByName('id_1562').IsNull)
            and(trim(mt_BuffData.FieldByName('RECIVED_FROM').AsString)='Очиствод')  then
     begin
      Result.add(mt_BuffData.FieldByName('id_1562').AsString);
     end;
      mt_BuffData.Next;
    end;
  end;
end;


procedure Tdm_NumSOBuff.DataModuleCreate(Sender: TObject);
begin
  inherited;
F_for_vds:=0;
table:='numsorders';

dset_officials.Open;
end;

procedure Tdm_NumSOBuff.CangeVds(for_vds:integer);
begin
  F_for_vds:=for_vds;
  case  F_for_vds of
  0: table:='numsorders';
  1:  table:='numsorders_vds';
  end;
  sql_insert.SQL.Clear;
  sql_insert.SQL.Add('insert into '+ table+' (id_order, number) values(:pOrderID, :pNumber)'); //вставляем номер заявки руками
  sql_update.SQL.Clear;
  if f_for_vds=0 then
   sql_update.SQL.Add('update '+ table+' set number = :pNumber, ID_OFFICIALS_PHONED=:id_officials, f_state_excav=:state_excav where id = :pID')
  else
    sql_update.SQL.Add('update '+ table+' set number = :pNumber, ID_OFFICIALS_PHONED=:id_officials  where id = :pID');
  sql_delete.SQL.Clear;
  sql_delete.SQL.Add('delete from '+ table+' where id = :pID'); //удаляем из открытого наряда'
  sql_updelete.SQL.Text:='update '+table+' set date_recive_request=null, '+      //если наояд закрыт помечаем как удаленную
                                         ' id_1562=null, '+
                                         ' ns.number_our_request=null, '+
                                         ' ns.date_our_request=null, '+
                                         ' ns.date_our_request=null, '+
                                         ' ns.recived_from=null, '+
                                         ' ns.state_inner=2, '+
                                         'ns.state_inner=2 '+
                                         ' where id = :pID ' ;

end;

//Здесь будем ппроверять принята ли заявка автоматически если да то определим нужно ли ее отправить другой службе?
procedure Tdm_NumSOBuff.ISSentRallBack;
begin
   inherited;
  if  not mt_BuffData.FieldByName('id_1562').IsNull then
  begin
    mt_BuffData.FieldByName('del_state').AsInteger:=0;
    case  F_for_vds of
    0: if   Application.MessageBox('Сохранить заявку для принятия Наружными сетями ?',
                                 'Внимание!',MB_YesNo+MB_ICONQUESTION)=ID_No then
          mt_BuffData.FieldByName('del_state').AsInteger:=1;
    1: if   Application.MessageBox('Сохранить заявку для принятия  Внутредомовыми сетями?',
                                 'Внимание!',MB_YesNo+MB_ICONQUESTION)=ID_No then
          mt_BuffData.FieldByName('del_state').AsInteger:=1;
    end;
  end;
end;


function Tdm_NumSOBuff.GetStateouter:integer;
begin

 if mt_BuffData.FieldValues['state_outer'].isnull then
  Result:=0
 else
  REsult:=mt_BuffData.FieldValues['state_outer'].asinteger;
end;

procedure Tdm_NumSOBuff.mt_BuffDataCalcFields(DataSet: TDataSet);
begin
  inherited;
   mt_BuffData.FieldByName('add_excav').AsBoolean:=
  ( mt_BuffData.FieldByName('is_excav').AsInteger=1);
  mt_BuffData.FieldByName('is_closed').AsBoolean:=(mt_BuffData.FieldByName('state_inner').AsInteger>=2);

end;

function Tdm_NumSOBuff.GetForExcavform: String;
begin
   if F_ExcavList=nil then
    F_ExcavList:=TstringList.Create;
   F_ExcavList.Clear;
   result:='';
   if ( mt_BuffData.Active ) and ( not mt_BuffData.IsEmpty ) then
  begin
    mt_BuffData.First;
    while not mt_BuffData.Eof do begin
     if (trim(mt_BuffData.FieldByName('RECIVED_FROM').AsString)='1562') and
     ((mt_BuffData.FieldByName('state_inner').AsInteger in [3,2]) and
     (not  mt_BuffData.FieldByName('id_1562').IsNull)
     and  (mt_BuffData.FieldByName('is_excav').AsInteger=1)) then
           begin
            result:=result+#13+'№'+mt_BuffData.fieldbyname('number').AsString+' ('+
                      mt_BuffData.fieldbyname('NUMBER_OUR_REQUEST').AsString+')';
           F_ExcavList.Add(mt_BuffData.FieldByName('id').AsString) ;
          end ;

      mt_BuffData.Next;
    end;
   end;
   delete(result,1,1);
end;

function  Tdm_NumSOBuff.SetStateKap(State:integer): boolean ; //установим статус заявок в капремонте отложеные проверенные
var  recNo:integer;
begin
 result:=false;
 if ( mt_BuffData.Active ) and ( not mt_BuffData.IsEmpty ) then
 begin
  mt_BuffData.First;
  for  recNo:=0 to F_ExcavList.Count-1 do
    if mt_BuffData.Locate('id',VarArrayOf([StrToInt(F_ExcavList[RecNo])]),[loCaseInsensitive]) then
     begin
       if (mt_BuffData.FieldByName('state_inner').AsInteger in [3,2]) and
       (mt_BuffData.FieldByName('state_excav').AsInteger<>State) then
       begin
        if mt_BuffData.State=dsBrowse then
          mt_BuffData.Edit;
        mt_BuffData.FieldByName('state_excav').AsInteger:=State;
        mt_BuffData.FieldByName('REC_STATE').AsInteger:=Ord( rsModifed );
        mt_BuffData.Post;

        mt_BuffData.Next;
      end

   end;

 end;
result:=true;
end;

end.
