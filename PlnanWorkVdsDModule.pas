unit PlnanWorkVdsDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class,DModule, FR_DSet, FR_DBSet,
  RxMemDS, IBDatabase, DB, IBCustomDataSet;

type
  Tdm_PlanWorkVds = class(Tdm_NGReportBase)
    dset_work: TIBDataSet;
    tran: TIBTransaction;
    md_table: TRxMemoryData;
    frDBDataSet1: TfrDBDataSet;
    dset_maters: TIBDataSet;
    md_tableRegion: TStringField;
    md_tablebrigadier: TStringField;
    md_tableworkerscount: TIntegerField;
    md_tablestartdate: TStringField;
    md_tableADRESS: TStringField;
    md_tableWork_avar: TStringField;
    md_tableWork_tex: TStringField;
    md_tableMater_name: TStringField;
    md_tableMater_quantity: TIntegerField;
    md_tableAddInfo: TStringField;
    md_tableMater_quantity_string: TStringField;
    dset_main: TIBDataSet;
    md_tablestrartDateD: TDateTimeField;
    md_tableplanendDate: TDateTimeField;
    procedure DataModuleDestroy(Sender: TObject);
  private
    F_Dt:TDate;
    { Private declarations }
  public
    { Public declarations }
    property _Dt:TDate write F_Dt;
    function PrepareDsets:boolean;
  end;

 const
  SQL_main  =' select d.id, sr.name region, b.name brigadier, '+
             '  d.workerscount, d.startdate,d.planenddate, '+
             '  (select ADRES from get_adres_vds(o.fk_orders_streets,o.housenum,o.housingnum,'+
                                               ' o.porchnum, o.floornum,o.apartmentnum,'+
                                               ' o.porchkod)) adress '+
             '  from departures_vds d join orders_vds o     on o.id=d.fk_departures_orders '+
             '  join s_regions sr on o.fk_orders_regions=sr.id '+
             '  join brigadiers b on b.id=d.fk_departures_brigadiers '+
             '  where d.PLANSTARTDATE>''%s 00:00'' and d.PLANSTARTDATE<''%s 23:59'' '+
             '  order by o.fk_orders_regions, d.id ';
   SQL_work='select  d.id, '+
                 ' pw.fk_depworks_work, sw.name work_name'+
                 ' from departures_vds d left join orders_vds o on o.id=d.fk_departures_orders'+
                 ' left join plan_dep_works_vds  pw on pw.fk_depworks_departure=d.id'+
                 ' left join s_works sw on sw.id=pw.fk_depworks_work '+
                 ' left join s_regions sr on o.fk_orders_regions=sr.id '+
                 ' left join brigadiers b on b.id=d.fk_departures_brigadiers '+
                 ' where  d.PLANSTARTDATE>''%s 00:00'' and d.PLANSTARTDATE<''%s 23:59'' '+
                 ' order by o.fk_orders_regions,d.id';

   SQL_maters=' select o.fk_orders_regions, d.id,trim(m.name)||'' ''||trim(m.MEASUREMENT) name, pm.quantity '+
              ' from departures_vds d left join depplanmaters_vds pm on pm.fk_departure=d.id '+
              ' left join materials m on m.id=pm.fk_mater '+
              ' left join orders_vds o on o.id=d.fk_departures_orders '+
              ' where d.PLANSTARTDATE>''%s 00:00'' and d.PLANSTARTDATE<''%s 23:59'' '+
              ' order by 1 , d.id';

var
  dm_PlanWorkVds: Tdm_PlanWorkVds;

implementation

{$R *.dfm}

function Tdm_PlanWorkVds.PrepareDsets:boolean;
var dt_str, str_work,str_mater,q_mater:string;
     init:boolean;
 procedure doinit();
 begin
       md_table.Append;
       md_table.FieldByName('Region').AsString:=dset_main.fieldbyname('Region').AsString;
       md_table.FieldByName('brigadier').AsString:=dset_main.fieldbyname('brigadier').AsString;
       md_table.FieldByName('workerscount').AsInteger:=dset_main.fieldbyname('workerscount').AsInteger;
       md_table.FieldByName('startdate').AsString:=dset_main.fieldbyname('startdate').AsString;
       md_table.FieldByName('Adress').AsString:=dset_main.fieldbyname('Adress').AsString;
       md_table.FieldByName('strartDateD').AsDateTime:=dset_main.fieldbyname('startdate').AsDateTime;
       md_table.FieldByName('planendDate').AsDateTime:=dset_main.fieldbyname('planenddate').AsDateTime;
       init:=true;
 end;
begin
Result:=false;
  dt_str:=DateToStr(F_Dt);
  dset_main.SelectSQL.Text:=Format(SQL_main,[dt_str, dt_str]);
  dset_work.SelectSQL.Text:=Format(SQL_work,[dt_str, dt_str]);
  dset_maters.SelectSQL.Text:=Format(SQL_maters,[dt_str, dt_str]);
  dset_main.Open;
  dset_main.First;
  dset_work.Open;
  dset_work.First;
  dset_maters.Open;
  dset_maters.First;
  if md_table.Active then md_table.Close;
  md_table.Open;
  init:=false;
  while not dset_main.Eof do
  begin
     if dset_main.FieldByName('id').AsInteger=dset_work.FieldByName('id').AsInteger then
     if  not dset_work.FieldByName('work_name').IsNull then
     begin
       doinit();
       str_work:='';
       while (dset_work.FieldByName('id').AsInteger=dset_main.FieldByName('id').AsInteger) and
           ( not  dset_work.Eof) do
       begin
           str_work:=str_work+#13+trim(dset_work.fieldbyname('work_name').AsString)+';';
           dset_work.Next;
       end;
       delete(str_work,1,1);
       md_table.FieldByName('Work_avar').AsString:=str_work;
     end
     else dset_work.Next;
     if   dset_main.FieldByName('id').AsInteger=dset_maters.FieldByName('id').AsInteger then
     if not dset_maters.FieldByName('name').IsNull then
     begin
      if not init then doinit();
      str_mater:='';
      q_mater:='';
      while (dset_maters.FieldByName('id').AsInteger=dset_main.FieldByName('id').AsInteger) and
         (not dset_maters.Eof) do
         begin
            str_mater:=str_mater+#13+trim(dset_maters.fieldbyname('name').AsString);
            q_mater:=q_mater+#13+dset_maters.fieldbyname('quantity').AsString;
            dset_maters.Next;
         end;
        delete(str_mater,1,1);
        delete(q_mater,1,1);
        md_table.FieldByName('Mater_name').AsString:=str_mater;
        md_table.FieldByName('Mater_quantity_string').AsString:=q_mater;
     end else dset_maters.Next;
     if init then   md_table.Post;
     dset_main.Next;
     init:=false;
  end;


Result:=true;
end;

procedure Tdm_PlanWorkVds.DataModuleDestroy(Sender: TObject);
begin
  inherited;
md_table.Close;
dset_main.Close;
dset_work.Close;
dset_maters.Close;
end;

end.
