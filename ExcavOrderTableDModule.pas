unit ExcavOrderTableDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class,DModule, IBCustomDataSet, DB,
  FR_DSet, FR_DBSet, RxMemDS;

type
  Tdm_ExcavOrderTable = class(Tdm_NGReportBase)
    rm_result: TRxMemoryData;
    frDBresult: TfrDBDataSet;
    rm_resultregion_id: TIntegerField;
    rm_resultregion: TStringField;
    rm_resultcount_all: TIntegerField;
    rm_resultexorder_count: TIntegerField;
    rm_resultclosed_order_count: TIntegerField;
    dset: TIBDataSet;
    rm_resultcount_taken: TIntegerField;
    dset_closedOrder: TIBDataSet;
    rm_resultcount_closedOrder: TIntegerField;
    rm_resultcount_form3: TIntegerField;
    rm_resultcount_form7: TIntegerField;
    rm_resultclosed_keeper_id_1: TIntegerField;
    rm_resultclosed_keeper_id_2: TIntegerField;
    rm_resultclosed_keeper_id_3: TIntegerField;
    rm_resultclosed_keeper_id_4: TIntegerField;
    rm_resultclosed_keeper_null: TIntegerField;
    rm_resultbalancekeeper_nulll: TIntegerField;
    rm_resultbalancekeeper_1: TIntegerField;
    rm_resultbalancekeeper_2: TIntegerField;
    rm_resultbalancekeeper_3: TIntegerField;
    rm_resultbalancekeeper_4: TIntegerField;
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
    str_sql:string;
    function getRegion():boolean;
    procedure clear();
    procedure prepareSQL();
    function ComplitResult():boolean;
  public
    { Public declarations }
    function prepareDsets():boolean;
   property  BegDate:TDateTime write F_BegDate;
   property  EndDate: TDateTime write  F_EndDate;
    property FinishBegin :  TDateTime write F_FinishBegin;
   property  FinishEnd:TDateTime write F_FinishEnd;
     property DopBegin:TDateTime write F_DopBegin;
     property DopEnd:TDateTime write F_DopEnd;
    property BLAG: integer write F_BLAG;
     property GZ: boolean write F_GZ;
    property ASF: boolean write F_ASF;
    property ForGik:boolean write F_ForGik;


    property IDREgions:string write F_regionID;
    property without_excav:integer write F_without_excav;

    property overdude:boolean write F_overdude;// просроченыые планируемая дата больше чем сейчас DTTM_PLANENDWORK!

    property ClosedOrder:integer write F_ClosedOrder; //закрытые ордера

  end;

const
  SQL_Closed_order = 'select ei.fk_excinfo_balancekeeper, count(*) as val from excavationsinfo ei  ' +
                         ' join orders o on ei.fk_excinfo_orders=o.id and o.fk_orders_regions=%d'+
                         '  where ei.dat_closedorder between ''%s'' and ''%s'' group by 1 ';
var
  dm_ExcavOrderTable: Tdm_ExcavOrderTable;

implementation
uses HelpFunctions;

{$R *.dfm}
procedure Tdm_ExcavOrderTable.clear();
begin
 if rm_result.Active then
   rm_result.Close;
 rm_result.Open;
end;


function Tdm_ExcavOrderTable.getRegion():boolean;
begin
  result:=true;
  try
   if F_regionID <>'' then
    MyOpenIBDS(dset,'select id, name from s_regions where id>0 and id in'+F_regionID+' order by id')
   else
    MyOpenIBDS(dset,'select id, name from s_regions where id>0 order by id');
   dset.First;
   while not dset.Eof do
   begin
    rm_result.Append;
    rm_result.FieldByName('region_id').AsInteger:=dset.fieldbyname('id').AsInteger;
    rm_result.FieldByName('region').AsString:=dset.fieldbyname('name').asstring;
    rm_result.Post;
    dset.Next;
   end;
 except on e:exception do
 begin
  // Application.MessageBox('Ошибка формирование районов!!','',ICON_Error+MBICON_OK);
   result:=false;
 end;

 end

end;

procedure Tdm_ExcavOrderTable.prepareSQL();
const SQL='select count(gb.id_order) count_all,count(dat_excorder) exorder_count,count(DAT_CLOSEDORDER) closed_order_count, '+
          ' sum(iif(((DATE_READABILITY_DOCS is not null) and (dat_excorder is null)),1,0)) count_taken ,'+
          ' count(NUM_FORM3) count_form3, '+
          ' count(NUM_FORM7) count_form7, '+
          ' sum(iif(fk_excinfo_balancekeeper is null,1,0)) balancekeeper_null, '+
          ' sum (iif(fk_excinfo_balancekeeper =1,1,0)) balancekeeper_1, '+
          ' sum (iif(fk_excinfo_balancekeeper =2,1,0)) balancekeeper_2, '+
          ' sum (iif(fk_excinfo_balancekeeper =3,1,0)) balancekeeper_3, '+
          ' sum (iif(fk_excinfo_balancekeeper =4,1,0)) balancekeeper_4 '+
          ' from get_blag4(%d,''%s'',''%s'',''%s'') gb';

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
  str_sql:='';
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
     str_sql:=SQL+' where '+sel_where
   else
   str_sql:=SQL+str_sql;

end;

function Tdm_ExcavOrderTable.ComplitResult:boolean;
  procedure feeldClosed();
  var sum:integer;
  begin
    sum:=0;
    if rm_result.State =dsEdit then
    begin
      if dset_closedOrder.Active then
        begin

          dset_closedOrder.First;
          while not dset_closedOrder.Eof do begin
            if dset_closedOrder.FieldByName('fk_excinfo_balancekeeper').IsNull then
              rm_result.FieldByName('closed_keeper_null').AsInteger:=dset_closedOrder.FieldByName('val').AsInteger
            else
              rm_result.FieldByName('closed_keeper_id_'+
                   dset_closedOrder.FieldByName('fk_excinfo_balancekeeper').AsString).AsInteger
                   :=dset_closedOrder.FieldByName('val').AsInteger;
           sum:=sum+dset_closedOrder.FieldByName('val').AsInteger;
           dset_closedOrder.Next;
          end;
        end;
    end;
   rm_result.FieldByName('count_closedOrder').AsInteger:=sum;

  end;
var  progress_shag: integer;
begin
result:=false;
 progress_shag := GetProgressShagLength( 100, rm_result.RecordCount );
 rm_result.First;
 while not  rm_result.Eof do
 begin
  myOpenIBDS(dset,format(str_sql,[rm_result.FieldByName('region_id').AsInteger,
    datetimeToStr(F_BegDate-30),datetimeToStr(F_BegDate),
    datetimeToStr(F_EndDate)]));
  myOpenIBDS(dset_closedOrder,format( SQL_Closed_order ,
    [rm_result.FieldByName('region_id').AsInteger,
    datetimeToStr(F_BegDate),
    datetimeToStr(F_EndDate)]));
  rm_result.Edit;
  rm_result.FieldByName('count_all').AsInteger:=dset.fieldbyname('count_all').AsInteger;
  rm_result.FieldByName('exorder_count').AsInteger:=dset.fieldbyname('exorder_count').AsInteger;
  feeldClosed();
  rm_result.FieldByName('count_taken').AsInteger:=dset.fieldbyname('count_taken').AsInteger;
 // rm_result.FieldByName('count_closedOrder').AsInteger:=dset_closedOrder.Fields[0].AsInteger;
  rm_result.FieldByName('count_form3').AsInteger:=dset.fieldbyname('count_form3').AsInteger;
  rm_result.FieldByName('count_form7').AsInteger:=dset.fieldbyname('count_form7').AsInteger;
  rm_result.FieldByName('closed_order_count').AsInteger:=dset.fieldbyname('closed_order_count').AsInteger;
  rm_result.FieldByName('balancekeeper_nulll').AsInteger:=
      dset.fieldbyname('balancekeeper_null').AsInteger;

  rm_result.FieldByName('balancekeeper_1').AsInteger:=
      dset.fieldbyname('balancekeeper_1').AsInteger;
  rm_result.FieldByName('balancekeeper_2').AsInteger:=
      dset.fieldbyname('balancekeeper_2').AsInteger;
  rm_result.FieldByName('balancekeeper_3').AsInteger:=
      dset.fieldbyname('balancekeeper_3').AsInteger;
  rm_result.FieldByName('balancekeeper_4').AsInteger:=
      dset.fieldbyname('balancekeeper_4').AsInteger;





  rm_result.Post;
  rm_result.Next;
  IncProgressStatus( progress_shag );
 end;
 result:=true;
 dset.Close;
 dset_closedOrder.Close;
end ;


function Tdm_ExcavOrderTable.prepareDsets:boolean;
begin
  result:=false;
  clear();
  if getRegion() then
  begin
   prepareSQL();
   result:=ComplitResult;
  end;
end;


end.
