unit STexnikDmodule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DB, RxMemDS, IBCustomDataSet,DModule,
  IBDatabase, FR_DSet, FR_DBSet;

type
  Tdm_STexn = class(Tdm_NGReportBase)
    dset: TIBDataSet;
    md_REsult: TRxMemoryData;
    md_REsultid_Region: TIntegerField;
    md_REsultRegion: TStringField;
    md_REsultfk_order_damageplace: TIntegerField;
    md_REsultdamagePlace: TStringField;
    md_REsultplan_people: TIntegerField;
    md_REsultExcav: TStringField;
    md_REsultavm: TStringField;
    md_REsultSams: TStringField;
    md_REsultBort: TStringField;
    md_REsultAvKran: TStringField;
    md_REsultBuld: TStringField;
    md_REsultpogr: TStringField;
    md_REsultgmolot: TStringField;
    md_REsultpris: TStringField;
    md_REsulttrak: TStringField;
    md_REsultadd_info: TStringField;
    md_REsultAdress: TStringField;
    md_REsultS_DateTime: TDateTimeField;
    tran: TIBTransaction;
    md_REsultDepId: TIntegerField;
    frDBDataSet1: TfrDBDataSet;
    md_REsultbrig: TStringField;
    md_REsultBar: TStringField;
  private
    { Private declarations }
    F_Date:TDate;
  public
  property Date:TDate Write F_Date; //ââîäèìàÿ äàòà
  function PrepareDsets():boolean;
    { Public declarations  }
  end;

 {çàïğëàí òåõíèêà èç equip_paln_departure â âûåçäàõ äàòà íà÷àëà ğàáîò êîòîğûõ áîëüùå
   ââåäåííîé äàòû è ìåíüøå äàòà+1}

 const SQL=' select d.id DepId, o.fk_orders_regions, o.fk_orders_damagelocality, d.startdate, '+
           ' ep.fk_id_equipment,e.fk_equip_typ,e.gos_number, e.name, e.v_kovsh, '+
           ' sr.name as Region, sd.name damagePlace, d.StartDate,d.plan_people,'+
           '(select ADRES from Get_Adres'+
           '(o.fk_orders_housetypes,o.fk_orders_streets,o.housenum, o.additionaladdress)) adress , '+
           ' d.fk_departures_brigadiers,  b.name brig'+
           '  from departures d join orders o on o.id=d.fk_departures_orders '+
           '  join equip_paln_departure ep on ep.fk_id_departures=d.id '+
           '  join equipment e on e.id=ep.fk_id_equipment '+
           '  join s_regions sr on sr.id=o.fk_orders_regions '+
           '  join s_damagelocality sd on sd.id=o.fk_orders_damagelocality '+
           '  join brigadiers b on b.id=d.fk_departures_brigadiers'+
           '  where d.startdate>:date and  d.startdate<:date+1 '+
           '  order by 2,4,1,5';
          group_fields: array [1..10] of string= ('Excav','avm','Sams','Bort', 'AvKran','Buld','pogr','gmolot', 'pris','trak' );
          id_typ : array[1..10] of integer =(1,10,4,11,6,2,23,8,9,3);
          count_f=10;

var
  dm_STexn: Tdm_STexn;

implementation

{$R *.dfm}


function Tdm_STexn.PrepareDsets;
var id_Dep,i:integer;
    s:string;
begin
 Result:=False;
 dset.SelectSQL.Text:=SQL;
 dset.ParamByName('date').AsDate:=F_Date;

 dset.Open;

 dset.First;
 if md_Result.Active then
  md_Result.Close;
  md_Result.Open;
 while not dset.Eof do
 begin
   id_Dep:=dset.fieldbyname('DepID').asinteger;
   md_result.Append;
   md_result.FieldByName('DepId').asinteger:=id_Dep;
   md_result.FieldByName('id_Region').asinteger:=dset.fieldbyname('fk_orders_regions').asinteger;
   md_result.FieldByName('Region').AsString:=dset.fieldbyname('Region').AsString;
   md_result.FieldByName('fk_order_damageplace').AsInteger:=dset.fieldbyname('fk_orders_damagelocality').AsInteger;
   md_result.FieldByName('damagePlace').AsString:=trim(dset.fieldbyname('damagePlace').AsString);
   md_result.FieldByName('plan_people').AsInteger:=dset.fieldbyname('plan_people').AsInteger;
   md_result.FieldByName('S_DateTime').AsDateTime:=dset.fieldbyname('StartDate').AsDateTime;
   md_result.FieldByName('adress').AsString:=trim(dset.fieldbyname('adress').AsString);
   md_result.FieldByName('brig').AsString:=trim(dset.fieldbyname('brig').AsString);
   for i:=1 to count_f  do
      md_result.FieldByName(group_Fields[i]).AsString:='';
   while (dset.fieldbyname('DepID').asinteger=id_Dep)and(not dset.Eof) do
   begin
     for i:=1 to count_f  do
      if dset.FieldByName('fk_equip_typ').AsInteger=id_typ[i] then
       begin
         md_Result.FieldByName(group_fields[i]).AsString:=md_Result.FieldByName(group_fields[i]).AsString+ #13+
                                                          trim(dset.fieldByname('gos_number').AsString)+#13+
                                                          trim(dset.fieldByname('name').AsString)+' ' +
                                                          trim(dset.fieldByname('v_kovsh').AsString)+';';
       end;
     dset.Next;

   end;
   for i:=1 to count_f  do
   begin
    s:=md_result.FieldByName(group_Fields[i]).AsString;
    delete(s,1,1);
    md_result.FieldByName(group_Fields[i]).AsString:=s;

   end;
   md_result.Post;
 end;

Result:=true;
end;

end.
