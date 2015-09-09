unit BlagPodrDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, IBDatabase, DB, IBCustomDataSet,
  FR_DSet, FR_DBSet, kbmMemTable;
 const id_asfCompSourse=6;
 const id_asfCompDest=9 ;

type
  Tdm_BlagPodr = class(Tdm_NGReportBase)
    Dset: TIBDataSet;
    tran: TIBTransaction;
    frDBResult: TfrDBDataSet;
    ResultDset: TkbmMemTable;
    ResultDsetordernumber: TStringField;
    ResultDsetRegions: TStringField;
    ResultDsetadres: TStringField;
    ResultDsetdlname: TStringField;
    ResultDsetsquare: TIntegerField;
    ResultDsetdtime: TDateTimeField;
    ResultDsetasfcompany: TStringField;
    ResultDsetmonth: TStringField;
    memSvod: TkbmMemTable;
    frDbSvod: TfrDBDataSet;
    ResultDsetnummonth: TIntegerField;
    memasfcompany: TkbmMemTable;
    memasfcompanyasfcompany: TStringField;
    frDBmemasfcompany: TfrDBDataSet;
    ResultDsetid_asfcompany: TIntegerField;
    memasfcompanyid_asfcomp: TIntegerField;
  private
    { Private declarations }
    F_DtBeg: TDateTime;
    F_DtEnd: TDateTime;
    F_RegionsID: string;
    F_asfcompanyID:string;
    Grant_dt :TDateTime;
    procedure FillResultDset;
    function AddFieldToMemTable(const AFieldName: string;
  AFieldClass: TFieldClass; ASize: Word; ACalculated: boolean; ADispLabel: string=''): TField;
  procedure DeleteAllFieldsFromMemTable;
  public
    { Public declarations }
    property DtBeg: TDateTime read F_DtBeg write F_DtBeg;
    property DtEnd: TDateTime read F_DtEnd write F_DtEnd;
    property RegionsID: string read F_RegionsID write F_RegionsID;
    property asfcompanyID: string read F_asfcompanyID write F_asfcompanyID;

    function PrepareDset: boolean;
    procedure SaveAsfcompany ;
  end;

var
  dm_BlagPodr: Tdm_BlagPodr;

implementation

{$R *.dfm}

uses HelpFunctions,DateUtils;

function Tdm_BlagPodr.PrepareDset: boolean;
begin
   Result := true;

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    FillResultDset;
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_UseEquip.PrepareDset)' );
    end;
  end;
end;

procedure Tdm_BlagPodr.FillResultDset;
var i: integer;
    RegCondition: string;
    AasfcompanyCond:string;
    nm:integer;
    asfcomp:integer;
    count, square:integer;
    monthyear:integer;
   endmonthyear:integer;
   month:integer;
begin
  Grant_dt:=StrToDate('01.01.'+IntTOStr(GetYear(F_DtBeg)-1));
  if F_RegionsID <> '' then RegCondition := ' and (o.fk_orders_regions in '+ F_RegionsID + ') '
      else RegCondition := '';
 
  if F_asfcompanyID <> '' then AasfcompanyCond := ' and ( fk_asfcompany in '+ F_asfcompanyID + ') '
      else AasfcompanyCond := '';
   if pos('3',F_asfcompanyID)>0 then
   begin
     insert('(',AasfcompanyCond,pos('(',AasfcompanyCond));
     AasfcompanyCond := ' '+AasfcompanyCond +' or (fk_asfcompany is null))';
   end;  
MyOpenIBDS(dset,
          'select ''1'' MainGr, gb.ordernumber, '+
          '(select name from s_regions sr where sr.id=o.fk_orders_regions) Regions, '+
          ' (select adres from get_adres(o.fk_orders_housetypes,o.fk_orders_streets, '+
            ' o.housenum,o.additionaladdress)) adres, '+
          ' (select name from  s_damagelocality sd where sd.id=o.fk_orders_damagelocality) dlname, '+
          ' gb.square, work_dt dtime, asfcompany, '+
          ' coalesce (gb.asfcompany,(select name from s_asfcompany where id=3)) asfcompany, '+
          '  coalesce( fk_asfcompany,3) fk_excavations_asfcompany '+
          ' from GET_BLAG_PODR1(''' + DateToStr( Grant_dt ) + ''') gb '+
          '  join  orders o on o.id=gb.id_order '+
          ' where work_dt>''' + DateToStr(F_DtBeg ) + ''''+
           ' and work_dt<''' + DateToStr(  F_DtEnd + 1 ) + ''''+
           RegCondition+
           AasfcompanyCond);
 { MyOpenIBDS( Dset,
    ' select ''1'' MainGr, o.id, o.ordernumber' +
    ' , (select name from s_Regions where id=o.fk_orders_regions) Regions' +
    ' , (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,  o.housenum, o.additionaladdress)) adres' +
    ' , (select dl.name from s_damagelocality dl where dl.id = o.fk_orders_damagelocality) dlname'+
    ' , e.square, e.dtime '+
    ' , (select sa.name from s_asfcompany sa where sa.id = e.fk_excavations_asfcompany and sa.ACTIVITY is null ) asfcompany '+
    ' , e.fk_excavations_asfcompany '+
    '  from excavations e '+
    ' left join orders o on (e.fk_excavations_orders = o.id ) '+
    ' where ( e.square > 0  )  ' +
    ' and ( e.fk_excavations_excwt = 5 ) '+
    ' and ( e.dtime < ''' + DateToStr( F_DtEnd + 1 ) + ''' )' +
    ' and ( e.dtime >= ''' + DateToStr( F_DtBeg ) + ''' )' +
     RegCondition+
    AasfcompanyCond +
    ' order by 2' );
 }
  if ResultDset.Active then ResultDset.Close;
  ResultDset.Open;


  dset.first;
  while not dset.eof do
    begin
     ResultDset.Append;
     for i:= 0 to ResultDset.FieldCount - 3 do
        begin
           //
         ResultDset.Fields[i] := dset.FieldByName(ResultDset.Fields[i].FieldName);
        end;
      if  trim(dset.FieldByName('asfcompany').AsString) = '' then
      begin
         ResultDset.FieldByName('asfcompany').AsString := '—обств. силами' ;
         ResultDset.FieldByName('fk_excavations_asfcompany').AsInteger := 3 ;
       end;

       ResultDset.FieldByName('nummonth').asinteger:=MonthOf(ResultDset.fieldbyname('dtime').AsDateTime)+GetYear(ResultDset.fieldbyname('dtime').AsDateTime)*12;
       ResultDset.FieldByName('month').AsString:=RussianMonth(MonthOf(ResultDset.fieldbyname('dtime').AsDateTime));
       ResultDset.Post;
     dset.Next;
//     ResultDset.SortFields := 'asfcompany';
   //  ResultDset.SortOn('ordernumber', []);
     ResultDset.SortOn('asfcompany;dtime', []);
//     ResultDset.Sort([]);
    end;
   //заполн€ем итог
   SaveAsfcompany;
   //заполним мес€ци
   monthyear:=MonthOf(F_DtBeg)+GetYear(F_DtBeg)*12;
   endmonthyear:=MonthOf(F_DtEnd)+GetYear(F_DtEnd)*12;
   month:=MonthOf(F_DtBeg);
   memSvod.Open;
   while monthyear<=endmonthyear do
   begin
    memSvod.Append;
    memSvod.FieldByName('month').AsString:=RussianMonth(month);
    memSvod.FieldByName('monthyear').AsInteger:=monthyear;
    month:=month+1;
    if month>12 then
     month:=1;
    monthyear:=monthyear+1;
    memSvod.Post;
   end;

   ResultDset.SortOn('nummonth;fk_excavations_asfcompany', []);


   ResultDset.First;
   memSvod.First;
   while  not ResultDset.Eof do
   begin
    memSvod.Edit;
   // memSvod.FieldByName('month').AsString:=ResultDset.FieldByName('month').asstring;
    nm:=ResultDset.FieldByName('nummonth').asinteger;
    memasfcompany.First;
    while (memSvod.FieldByName('monthyear').AsInteger=ResultDset.FieldByName('nummonth').asinteger) and ( not ResultDset.Eof)and (not memasfcompany.Eof)  do
    begin
     asfcomp:=memasfcompany.fieldbyname('id_asfcomp').AsInteger;

     memSvod.FieldByName('Comp'+Inttostr(asfcomp)+'_count').AsInteger:=0;
     memSvod.FieldByName('Comp'+Inttostr(asfcomp)+'_square').AsInteger:=0;
     while (asfcomp=ResultDset.fieldbyname('fk_excavations_asfcompany').AsInteger)
     and (not ResultDset.Eof)  do
     begin
      memSvod.FieldByName('Comp'+Inttostr(asfcomp)+'_count').AsInteger:=memSvod.FieldByName('Comp'+Inttostr(asfcomp)+'_count').AsInteger+1;
      memSvod.FieldByName('Comp'+Inttostr(asfcomp)+'_square').AsInteger:=memSvod.FieldByName('Comp'+Inttostr(asfcomp)+'_square').AsInteger+ResultDset.FieldByName('square').AsInteger;
      ResultDset.Next;
     end;
     memasfcompany.Next;
    end;
    count:=0;
    square:=0;
    for i:=0 to memasfcompany.RecordCount-1 do begin
     count:=count+memSvod.Fields[i*2+1].AsInteger;
     square:=square+memSvod.Fields[i*2+2].AsInteger;
    end;
    memSvod.FieldByName('Comp0_count').AsInteger:=count;
    memSvod.FieldByName('Comp0_square').AsInteger:=square;
    memSvod.Post;
    memSvod.Next;
   end;
   //memSvod.MasterFields:='asfcompany';
   // заполн€ем итог
   ResultDset.SortOn('asfcompany;dtime', []);


end;

procedure Tdm_BlagPodr.SaveAsfcompany ;
 var V:Variant;
 procedure addfields(name:string; labe:string='');
 begin
  AddFieldToMemTable('Comp'+name+'_count', TIntegerField,0,false,labe);
  AddFieldToMemTable('Comp'+name+'_square', TIntegerField,0,false,labe);
 end;
var cond:string;
begin
 DeleteAllFieldsFromMemTable;
 AddFieldToMemTable('month',TStringField,20,false);

 if F_asfcompanyID<>'' then
  cond:=' and  sa.id in '+F_asfcompanyID;
 if memasfcompany.Active then
   memasfcompany.Close;
 MyOpenIBDS(dset, 'select id, trim(sa.name)  name from s_asfcompany sa where id>0 and sa.activity is null  '+cond+' order by id');
 memasfcompany.Open;
 dset.First;
 while  not dset.Eof do
 begin
  memasfcompany.Append;
  if (dset.FieldByName('id').asinteger=id_asfCompSourse) then
   begin

    memasfcompany.FieldByName('asfcompany').AsString:=dset.Lookup('id',VarArrayOf([id_asfCompDest]),'name');
    memasfcompany.FieldByName('id_asfcomp').asinteger:=id_asfCompDest;
   end
  else
  { if (dset.FieldByName('id').asinteger=id_asfCompDest) then
   begin
     memasfcompany.FieldByName('asfcompany').AsString:=dset.Lookup('id',VarArrayOf([id_asfCompSourse]),'name');
     memasfcompany.FieldByName('id_asfcomp').asinteger:=id_asfCompSourse;
   end
   else}
   begin
    memasfcompany.FieldByName('asfcompany').AsString:=dset.FieldByName('name').AsString;
    memasfcompany.FieldByName('id_asfcomp').asinteger:=dset.FieldByName('id').asinteger;
   end;
  addfields(memasfcompany.FieldByName('id_asfcomp').asstring,memasfcompany.FieldByName('asfcompany').AsString);
  dset.Next;
  memasfcompany.Post;
 end;
  addfields('0','»того');
  AddFieldToMemTable('monthyear',TIntegerField,0,false);


end;

function Tdm_BlagPodr.AddFieldToMemTable(const AFieldName: string;
  AFieldClass: TFieldClass; ASize: Word; ACalculated: boolean; ADispLabel: string=''): TField;
begin
  Result:=memSvod.FindField(AFieldName); // Field may already exists!
  if Result<>nil then Exit;

  Result:=AFieldClass.Create(nil);
  with Result do
  try
    FieldName:=AFieldName;
    if (Result is TStringField) or (Result is TBCDField) or (Result is TBlobField) or
      (Result is TBytesField) or (Result is TVarBytesField) then
    begin
      Size:=ASize;
    end;
    Calculated:=ACalculated;
    DataSet:=memSvod;
    DisplayLabel:=ADispLabel;
    Name:=memSvod.Name+AFieldName;
  except
    Free; // We must release allocated memory on error!
    raise;
  end;
end;

procedure Tdm_BlagPodr.DeleteAllFieldsFromMemTable;
begin
  memSvod.Close;
  while memSvod.FieldCount>0 do
  begin
    memSvod.Fields[0].Free;
  end;
end;

end.
