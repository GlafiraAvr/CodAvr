unit Svodka062DModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DB, kbmMemTable, FR_DSet,
  FR_DBSet, DModule, IBCustomDataSet, IBDatabase, IBSQL;

type
  TOrderType = (otAll, otOpen, otClose);

  Tdm_Svodka062 = class(Tdm_NGReportBase)
    ResultDset: TkbmMemTable;
    frDS_Result: TfrDBDataSet;
    ResultDsetworks: TStringField;
    tran: TIBTransaction;
    dset: TIBDataSet;
    ResultDsetSONums: TStringField;
    ResultDsetid: TIntegerField;
    ResultDsetOrderNumber: TIntegerField;
    ResultDsetDateComing: TDateTimeField;
    ResultDsetDateClosed: TDateTimeField;
    ResultDsetadres: TStringField;
    ResultDsetregion: TStringField;
    ResultDsetdamageplace: TStringField;
    ResultDsetfk_orders_off: TIntegerField;
    ResultDsetstr_orders_off: TStringField;
    ResultDsetdtr_brigg: TStringField;
    ResultDsetaddtionalinfo: TStringField;
    ResultDsetDEP_ID: TIntegerField;
    dset_trans: TIBDataSet;
    tran_1562_1: TIBTransaction;
    ResultDsetid_regin: TIntegerField;
    ResultDsetid_dplace: TIntegerField;
    IBSQL1: TIBSQL;
    ResultDsetNumberOurRequest: TStringField;
    ResultDsetDateOurRequest: TStringField;     //glasha 14.07.2011
    procedure DataModuleCreate(Sender: TObject);
  private
    F_BegDt,
    F_EndDt: TDateTime;
    F_OrderType: TOrderType;
    KolZayav062:integer;//-- Глад 08.09.2008
    procedure FillResultDset;
    procedure SentData;
  public
    property BegDt: TDateTime read F_BegDt write F_BegDt;
    property EndDt: TDateTime read F_EndDt write F_EndDt;
    property KolZayav:integer read KolZayav062;//-- Глад 08.09.2008
    property OrderType: TOrderType read F_OrderType write F_OrderType;
    procedure PrepareDset;
    procedure To1526;

  end;

implementation

{$R *.dfm}

uses HelpFunctions, DataSetTree,StringConsts,NGBaseReport;

procedure Tdm_Svodka062.DataModuleCreate(Sender: TObject);
begin
  inherited;
  F_BegDt := 0;
  F_EndDT := 0;
  F_OrderType := otAll;
end;

procedure Tdm_Svodka062.FillResultDset;
  function _AddCond: string;
  begin
    if F_OrderType = otClose then
      Result :=
        ' where ( o.DateClosed >= ''' + DateTimeToStr( F_BegDt ) + ''' ) and' +
        ' ( o.DateClosed <= ''' + DateTimeToStr( F_EndDt ) + ''' )'
    else
      Result :=
        ' where ( o.DateComing >= ''' + DateTimeToStr( F_BegDt ) + ''' ) and' +
        ' ( o.DateComing <= ''' + DateTimeToStr( F_EndDt ) + ''' )';

    case F_OrderType of
      otOpen: Result := Result + ' and ( o.isclosed = 0 ) ';
      otClose: Result := Result + ' and ( o.isclosed = 1 ) ';
    end;
  end;

  function _PrepWork( _name: string; _diam: integer; _kol: double ): string;
  begin
    Result := trim( _name );
    if _diam > 0 then
      Result := Result + ' d=' + IntToStr( _diam );
    if _kol > 0 then
      Result := Result + ' (кол: ' + FormatFloat( '0.##', _kol ) +')';
  end;
var
  _DSTree: TDataSetTree;
  _node: TTreeNode;
  i, j: integer;
  _SONums, _works: string;
  _SOOur,_SDate:string;
 // _DepID: integer;
 // _fk_close_off:integer;      //glasha 14.07.2011
  //_fk_brigadiers:integer;     //glasha 14.07.2011


  id_o:integer;
begin
  ResultDset.Close;
  ResultDSet.Open;

  {Заносим основную информацию}
  {MyOpenIBDS( dset,
    'select o.id , nso.number NumSO , o.ordernumber , o.datecoming , o.dateclosed ' +
    ' , (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,     o.housenum, o.additionaladdress)) Adres ' +
    ', (select name from s_regions  where id = o.fk_orders_regions)  region ' +
    ' , (select name from s_damageplace  where id = o.fk_orders_damageplace)  damageplace ' +
    ', o.fk_orders_officialclosed '+//glasha 14.07.2011
    ' from orders o, numsorders nso ' +
    ' where (nso.id_order = o.id) ' +
    _AddCond +
    ' order by o.datecoming, 6, o.ordernumber, nso.number' );}

 //18.07.2011
  MyOpenIBDS( dset,
  'select o.id , nso.number NumSO , o.ordernumber , o.datecoming , o.dateclosed'+
  '  , o.fk_orders_regions id_region ,o.fk_orders_damageplace id_dplace, NUMBER_OUR_REQUEST, DATE_OUR_REQUEST'+
  '  , (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,     o.housenum, o.additionaladdress)) Adres'+
  '  , (select name from s_regions  where id = o.fk_orders_regions)  region'+
  '  , (select name from s_damageplace  where id = o.fk_orders_damageplace)  damageplace'+
  '  , s.name Dispet'+
  '  ,d.additionalinfo'+
  '  ,d.id DEP_ID'+
  '  ,b.name bname '+
  '  from orders o '+
  '  inner join numsorders nso on nso.id_order = o.id'+
  '  left join  s_officials s on  s.id=o.fk_orders_officialclosed'+
  '  left join   departures d on   d.fk_departures_orders=o.id'+
  '  inner join  brigadiers b on d.fk_departures_brigadiers=b.id'+
        _AddCond+
  ' and d.startdate= (SELECT MAX(d2.startdate)'+
                               '  FROM departures d2 where'+
                               '  d2.fk_departures_orders=o.id )'+
   '   order by o.datecoming, 6, o.ordernumber, nso.number');
  _DSTree := TDataSetTree.Create( dset );
  try
    _DSTRee.AddCheckFieldName( 'id' );
    _DSTree.BuildTree;
    KolZayav062:=0;//-- Глад 08.09.2008
    for i := 0 to _DSTree.NodeCount - 1 do
    begin
      _node := _DSTree.NodeList[ i ];
      if _node.NodeKind = nkData then
      begin
        _SOOur:='';
        _SONums := '';
        _SDate:='';
        for j := 0 to _node.RecordCount - 1 do begin
          if frac(KolZayav062 / 2) = 0 then begin
             _SONums := _SONums + ', '+ _node.RecordList[ j ].FieldByName( 'NumSO' ).AsString;
             _SOOur:=_SOOur+', '+ _node.RecordList[ j ].FieldByName( 'NUMBER_OUR_REQUEST').AsString;
             _SDate:=_SDate+', '+DateTimeFormat('dd.mm.yy', _node.RecordList[ j ].FieldByName( 'DATE_OUR_REQUEST').AsDateTime);
            end
            else
            begin
             _SONums := _SONums + ', ' + #13 + _node.RecordList[ j ].FieldByName( 'NumSO' ).AsString;
             _SOOur:=_SOOur+', '+#13+_node.RecordList[ j ].FieldByName( 'NUMBER_OUR_REQUEST').AsString;
             _SDate:=_SDate+', '+#13+DateTimeFormat('dd.mm.yy', _node.RecordList[ j ].FieldByName( 'DATE_OUR_REQUEST').AsDateTime);
            end;

          inc(KolZayav062);//-- Глад 08.09.2008
        end;
        Delete( _SONums, 1, 1 );
        Delete( _SOOur, 1, 1 );
        Delete( _SDate, 1, 1 );


        ResultDset.Append;
        ResultDset.FieldByName( 'id' ).AsInteger := _node.RecordList[ 0 ].FieldByName( 'id' ).AsInteger;
        ResultDset.FieldByName( 'OrderNumber' ).AsInteger := _node.RecordList[ 0 ].FieldByName( 'OrderNumber' ).AsInteger;
        ResultDset.FieldByName( 'DateComing' ).AsDateTime := _node.RecordList[ 0 ].FieldByName( 'DateComing' ).AsDateTime;
        ResultDset.FieldByName( 'DateClosed' ).Value := _node.RecordList[ 0 ].FieldByName( 'DateClosed' ).Value;
        ResultDset.FieldByName( 'Adres' ).AsString := _node.RecordList[ 0 ].FieldByName( 'Adres' ).AsString;
        ResultDset.FieldByName( 'Region' ).AsString := _node.RecordList[ 0 ].FieldByName( 'Region' ).AsString;
        ResultDset.FieldByName( 'DamagePlace' ).AsString := _node.RecordList[ 0 ].FieldByName( 'DamagePlace' ).AsString;
        ResultDset.FieldByName( 'SONums' ).AsString := _SONums;
//        ResultDset.FieldByName( 'fk_orders_off' ).AsInteger := _node.RecordList[ 0 ].FieldByName( 'fk_orders_officialclosed' ).AsInteger;  //glasha 14.07.2011
        ResultDset.FieldByName ('str_orders_off').AsString:=_node.RecordList[ 0 ].FieldByName( 'Dispet' ).AsString;  //glasha 18.07.2011
        ResultDset.FieldByName ('dtr_brigg').AsString:=_node.RecordList[ 0 ].FieldByName( 'bname' ).AsString;  //glasha 18.07.2011
        ResultDset.FieldByName ('addtionalinfo').AsString:=_node.RecordList[ 0 ].FieldByName( 'additionalinfo' ).AsString;//glasha 18.07.2011
 //       ResultDset.FieldByName ('DEP_ID').AsInteger:=_node.RecordList[ 0 ].FieldByName( 'DEP_ID' ).AsInteger;//glasha 18.07.2011
        ResultDset.FieldByName ('id_region').AsInteger := _node.RecordList[0].fieldByName('id_region').AsInteger; //20.07.2011

        ResultDset.FieldByName('id_dplace').AsInteger := _node.RecordList[0].fieldbyname('id_dplace').AsInteger;
        ResultDset.FieldByName ('NumberOurRequest').asstring:=_SOOur;
        ResultDset.FieldByName ('DateOurRequest').AsString:= _node.RecordList[0].fieldbyname('datecoming').AsString;
        ResultDSet.Post;
      end;
    end;
    frVariables['KolZayav'] := KolZayav062;

  finally
    _DSTree.Free;
  end;
  {/Заносим основную информацию}



  {Заносим дополнительную информацию}
  ////{18.07.2011
  MyOpenIBDS( dset,'  select   o.id  '+
  '  , sw.name, std.diameter, dw.quantity'+
  '  from orders o  inner join   departures d on   d.fk_departures_orders=o.id'+
  '  left join   departureworks dw on dw.FK_DEPWORKS_DEPARTURE=d.id'+
  '   left join s_works sw on sw.id = dw.fk_depworks_work'+
  '   right join s_tubediameter std on std.id = dw.fk_depworks_diameter'+
     _AddCond+
  ' and d.startdate= (SELECT MAX(d2.startdate)'+
                                '   FROM departures d2 where'+
                                '   d2.fk_departures_orders=o.id )'+
  '    order by o.datecoming,  o.ordernumber');
  //}
  if not ResultDset.IsEmpty then
  begin
    ResultDset.First;
    while not ResultDset.Eof do
    begin
     { MyOpenIBDS( dset,
        ' select id, AdditionalInfo' +
        ',fk_departures_brigadiers'+  //glasha 14.07.2011
        ' from departures' +
        ' where ( fk_departures_orders = ' + ResultDset.FieldByName( 'id' ).AsString + ' )' +
        ' order by DepNumber asc, StartDate asc' );
      _fk_brigadiers:=0;      }
     // if not dset.IsEmpty then
      begin
       // dset.Last;

       // _fk_brigadiers:=dset.FieldByName('fk_departures_brigadiers').AsInteger; //glasha 14.07.2011

        //_DepID := dset.FieldByName( 'id' ).AsInteger;
        // _DepID := ResultDset.FieldByName ('DEP_ID').AsInteger;//18.07.2011
         id_o := ResultDset.FieldByName( 'id' ).AsInteger ;// 18.07.2011
        _works := trim( ResultDset.FieldByName ('addtionalinfo').AsString ); //было из   dset 18.07.2011
         if _works <> '' then _works := _works + '. ';

       { MyOpenIBDS( dset,
          ' select sw.name, std.diameter, sum(dw.quantity) quantity' +
          ' from departureworks dw' +
          ' left join s_works sw on sw.id = dw.fk_depworks_work' +
          ' left join s_tubediameter std on std.id = dw.fk_depworks_diameter' +
          ' where FK_DEPWORKS_DEPARTURE = ' + IntToStr( _DepID ) +
          ' group by sw.name, std.diameter' +
          ' order by 1, 2, 3' );
        dset.First;   }

        dset.Locate('id',id_o,[loCaseInsensitive]); // 18.07.2011

        while  (dset.FieldByName('id').AsInteger=id_o) and ( not dset.Eof) do //18.07.2011 not  dset.Eof
        begin
          _works := _works +
            _PrepWork( dset.FieldByName( 'name' ).AsString,
                       dset.FieldByName( 'diameter' ).AsInteger,
                       dset.FieldByName( 'quantity' ).AsFloat ) + '; ';
          dset.Next;
        end;


        if   not  ResultDset.FieldByName( 'DateClosed').IsNull
         then
         _works := _works +' бригадир '+trim(   ResultDset.FieldByName ('dtr_brigg').AsString)+'; ';//glasha 18.07.2011

        if  not ResultDset.FieldByName( 'DateClosed').IsNull then
          _works := _works +' диспетчер '+trim(ResultDset.FieldByName ('str_orders_off').AsString)+'; ';//glasha 18.07.2011
        // glasha 2011}
        ResultDset.Edit;
        ResultDset.FieldByName( 'works' ).AsString := _works;
        ResultDset.Post;
      end;
      ResultDset.Next;
    end;
  end;
  {/Заносим дополнительную информацию}
end;

procedure Tdm_Svodka062.PrepareDset;
begin
  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    FillResultDset;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      E.Message := E.Message + '(Tdm_Svodka062.PrepareDset)';
      raise;
    end;
  end;
end;

//20.07.2011    Передача данных в базу
procedure Tdm_Svodka062.To1526;
begin
//

//
{ try
   if not DM_Main.IBDatabase1562_1.Connected then
     DM_Main.Connect1562_1('AVR_VDS','avr_vds_pwd');
   if DM_Main.IBDatabase1562_1.Connected then
     try
       if tran_1562_1.InTransaction then
         tran_1562_1.Rollback;
       tran_1562_1.StartTransaction;
      // SentData;    //!!! не могу найти таблицу TRANSFERFROM
       tran_1562_1.Commit;
     except
        on E:exception do
        begin
           tran_1562_1.Rollback;
           E.Message := E.Message + '(Tdm_Svodka062.To1562)';
        raise;
        end;
     end;
 except
    on E:exception do
    begin
      E.Message := E.Message + '(Tdm_Svodka062.Connect)';
      raise;
    end;
 end;   }
end;


//!!! не могу найти таблицу TRANSFERFROM
procedure  Tdm_Svodka062.SentData;
var
  //nso:integer;
  i:integer;
  str:string ;
  nstr:string;
  p:integer;
  col_z:integer;
  SQL:string;

  locat, isempt:boolean;
   bar_len,bar:integer; //progress bar
begin

  bar_len:=KolZayav062;
  bar:=0;

  col_z:=0;
  isempt:=false;
 { MyOpenIBDS(dset_trans,' select count(ID_TRANSFER_FROM) from TRANSFERFROM');
  if dset_trans.Fields[0].AsInteger>0 then
   MyOpenIBDS(dset_trans,'select * from TRANSFERFROM')
  else
   isempt:=true;
  locat:=true;}
  ResultDset.First;

  while  not ResultDset.Eof  do begin
    if not ResultDset.FieldByName('DateClosed').IsNull   then
    begin
       str :=  ResultDset.FieldByName( 'SONums' ).AsString ;
       delete(str,1,1);
       if str[1]=#13 then delete(str,1,1);
         p:=1;
       while p>0 do begin
         p := Pos(',',str);
         if p>0 then
           nstr :=  Copy(str,1,p-1)
         else
           nstr := str;
         i := StrToInt(nstr);
         delete(str,1,p+1);
         if str[1]=#13 then
          delete(str,1,1);
       //  if not isempt then locat:=  not dset_trans.Locate('NUMBER_TENDER;DATECLOSING;WHO_TRANSFER',vararrayof([i,ResultDset.fieldbyName('DateClosed').AsVariant,1]) ,[loCaseInsensitive]);
       //  if locat then
         begin
           SQL:='update or insert into  TRANSFERFROM  (WHO_TRANSFER,id_rayon,dateclosing,id_damageplace,works,NUMBER_TENDER)'+
                   'values ( ';
           SQL:=SQL+'1,';
           SQL:=SQL+ResultDset.fieldbyName('id_region').AsString+',';
           SQL:=SQL+''''+ResultDset.fieldbyName('DateClosed').AsString+''',';
           SQL:=SQL+ResultDset.fieldbyName('id_dplace').AsString+',';
           SQL:=SQL+''''+ResultDset.fieldbyName('works').AsString+''',';
           SQL:=SQL+nstr+')';
           SQL:=SQL+' matching (WHO_TRANSFER,id_rayon,dateclosing,NUMBER_TENDER)';
           MyExecIBSQL(IBSQL1,SQL);
           inc(col_z);
         end;
         inc(bar);
         OnChangeProgressStatus(bar_len,bar);

       end;
    end;
    ResultDset.Next;

    str:='Передано '+IntTOStr(col_z)+' заявок ' ;
  //     Application.MessageBox(str,'lkl;' ,MB_OK+MB_ICONINFORMATION	 );
  end;
 Application.MessageBox(PCHAR(str){'Информация передана!'}, gc_strDispAVR ,MB_OK+MB_ICONINFORMATION	 );

end;
//
end.
