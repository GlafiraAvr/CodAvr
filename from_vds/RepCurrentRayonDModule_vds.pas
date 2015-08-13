unit RepCurrentRayonDModule_vds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RepClosedOrdersDModule_vds, FR_DSet, FR_DBSet, IBCustomDataSet,
  IBDatabase, DB, RxMemDS, FR_Class;

type
  Tdm_RepCurrentRayon_vds = class(Tdm_RepClosedOrders_vds)
    ResultDsetstreet_num: TIntegerField;
    ResultDsethousenum: TStringField;
    ResultDsetPorchNum: TStringField;
    ResultDsetfloornum: TStringField;
    ResultDsetapartmentnum: TStringField;
    dset_street: TIBDataSet;
    ResultDsetstreet_name: TStringField;
    ResultDsetstr_type: TStringField;
  private
   { Private declarations }
    F_MainSqlString: string;
    F_RecCountSqlString: string;
    F_RegID: integer;
    F_RecordCount:integer;
    F_ALLChecked: boolean;
    F_DtBeg: TDate;
    F_DtEnd: TDate;
    F_RegionsID: string;
    function GetWorks(OrderID: integer): string;
    function FillResultDset: boolean; overload;
    procedure SetRecordCount;
    procedure SetSqlString;

  public
    { Public declarations }
    property RecordCount:integer read F_recordCount;
    property ALLChecked: boolean write F_ALLChecked;
    property DtBeg: TDate read F_DtBeg write F_DtBeg;
    property DtEnd: TDate read F_DtEnd write F_DtEnd;
    property RegionsID: string read F_RegionsID write F_RegionsID;
    function PrepareDset: boolean;
    property RegID: integer write F_RegID;
    procedure FillSummary(RegID: integer);
    procedure Init;
  end;

var
  dm_RepCurrentRayon_vds: Tdm_RepCurrentRayon_vds;

implementation

{$R *.dfm}


uses HelpFunctions;

function Tdm_RepCurrentRayon_vds.FillResultDset: boolean;

    procedure GetDisconnections(OrderID: integer);
      var _DisAdres, _DisType, _DisDate, _s13: string;
      begin
        _DisAdres := '';
        _DisType := '';
        _DisDate := '';
        _s13 := '';
        if dset_disconnections.Active then dset_disconnections.Close;
        dset_disconnections.ParamByName('pOrderID').AsInteger:=OrderID;
        dset_disconnections.Open;
        dset_disconnections.First;
        while not dset_disconnections.Eof do
        begin
          _DisAdres := _DisAdres + _s13 + trim(dset_disconnections.FieldByName('DisAdres').AsString);
          _DisType := _DisType + _s13 + trim(dset_disconnections.FieldByName('DisType').AsString);
          _DisDate := _DisDate + _s13 + trim(dset_disconnections.FieldByName('dttm_discon').AsString);
          dset_disconnections.Next;
          if not dset_disconnections.Eof then _s13 := '; ' + #13 ;
        end;
          ResultDset.FieldByName('DisAdres').AsString:=_DisAdres;
          ResultDset.FieldByName('Distype').AsString:=_DisType;
          ResultDset.FieldByName('dttm_discon').AsString:=_DisDate+' ';
        dset_disconnections.Close
      end;

     procedure GetStreet(Street_ID:integer);
     begin
      if dset_street.Active then dset_street.Close;
      dset_street.ParamByName('id_street').AsInteger:=Street_ID;
      dset_street.Open;
      dset_street.First;
      ResultDset.FieldByName('street_name').AsString:=trim(dset_street.FieldByName('name').AsString);
      ResultDset.FieldByName('str_type').AsString:=trim(dset_street.FieldByName('s_type').AsString);
      dset_street.Close;
     end;

var
  i: integer;
  _tel, _fio, _adr : string;
begin
  ResultDset.Close;
  ResultDset.Open;

  MyOpenIBDS(dset_tmp, F_MainSqlString);
  dset_tmp.First;
  while not dset_tmp.Eof do
  begin
    _tel := '';
    _fio := '';
    _adr := '';
    ResultDset.Append;
    for i:=0 to dset_tmp.FieldCount-1 do
      ResultDset.FieldByName(dset_tmp.Fields[i].FieldName).Value:=
        dset_tmp.Fields[i].Value;

   GetDisconnections(dset_tmp.FieldByName('ID').AsInteger);

   { _tel := dset_tmp.FieldByName('APPLICANTPHONE').AsString;
    if _tel <> '' then _tel := ', тел.'+_tel;
    _fio := dset_tmp.FieldByName('APPLICANTFIO').AsString;
    if _fio <> '' then _fio := ', ' + _fio;           // + #13
    _adr := trim(ResultDset.FieldByName('Adres').AsString)+ _tel + _fio;
    ResultDset.FieldByName('Adres').AsString := _adr;                   }
    ResultDset.FieldByName('WORKS').AsString:=GetWorks(dset_tmp.FieldByName('ID').AsInteger);
   // ResultDset.FieldByName('WORKS').AsString:=ResultDset.FieldByName('WORKS').AsString +
   //                       ResultDset.FieldByName('ADDITIONALINFO').AsString;
   GetStreet(dset_tmp.FieldByName('street_num').AsInteger );
    ResultDset.Post;

    dset_tmp.Next;
  end;

end;


function Tdm_RepCurrentRayon_vds.GetWorks(OrderID: integer): string;
var _res: string;
begin
  Result:='';

  dset_Works.Close;
  dset_Works.ParamByName('pOrderID').AsInteger:=OrderID;
  dset_Works.Open;
  dset_Works.First;
  while not dset_Works.Eof do
  begin
    Result:=Result+', '+NameCase(dset_Works.FieldByName('WorksName').AsString);
    dset_Works.Next;
  end;

  Delete(_res, 1, 2);

  MyOpenIBDS(dset_dep,
    ' select ADDITIONALINFO'+
    ' from DEPARTURES_vds'+
    ' where (FK_DEPARTURES_ORDERS = '+ IntToStr(OrderID) +')'+
    ' and (id = (select max(id) from departures_vds where fk_departures_orders = '+ IntToStr(OrderID) +'))');
    dset_dep.First;
    while (not dset_dep.Eof) do
      begin
      _res := _res + dset_dep.FieldByName('ADDITIONALINFO').AsString;
      dset_dep.Next;
      end;
    dset_dep.Close;

  Result := _res;
end;

procedure Tdm_RepCurrentRayon_vds.FillSummary(RegID: integer);
begin
    //
   case RegID of
   1: begin//
         frVariables['lreg'] := 'Дзержинского';
         frVariables['ln1'] := '';
         frVariables['rn1'] := '';
         frVariables['ln2'] := '';
         frVariables['rn2'] := '';
         frVariables['ln3'] := '';
         frVariables['rn3'] := '';

         frVariables['bossVDS'] := '';
         frVariables['lb1'] := '';
         frVariables['rb1'] := '';
         frVariables['lb2'] := '';
         frVariables['rb2'] := '';
         frVariables['lb3'] := '';
         frVariables['rb3'] := '';

         frVariables['ln1'] := '';
         frVariables['rn1'] := '';
         frVariables['ln2'] := '';
         frVariables['rn2'] := '';
         frVariables['ln3'] := '';
         frVariables['rn3'] := '';

         frVariables['lvs1'] := '';
         frVariables['rvs1'] := '';
         frVariables['lvs2'] := '';
         frVariables['rvs2'] := '';
         frVariables['lvs3'] := '';
         frVariables['rvs3'] := '';

         frVariables['lns1'] := '';
         frVariables['rns1'] := '';
         frVariables['lns2'] := '';
         frVariables['rns2'] := '';
         frVariables['lns3'] := '';
         frVariables['rns3'] := '';
      end;
   2: begin//
         frVariables['lreg'] := 'Киевского';
         frVariables['ln1'] := '';
         frVariables['rn1'] := '';
         frVariables['ln2'] := '';
         frVariables['rn2'] := '';
         frVariables['ln3'] := '';
         frVariables['rn3'] := '';

         frVariables['bossVDS'] := '';
         frVariables['lb1'] := '';
         frVariables['rb1'] := '';
         frVariables['lb2'] := '';
         frVariables['rb2'] := '';
         frVariables['lb3'] := '';
         frVariables['rb3'] := '';

         frVariables['ln1'] := '';
         frVariables['rn1'] := '';
         frVariables['ln2'] := '';
         frVariables['rn2'] := '';
         frVariables['ln3'] := '';
         frVariables['rn3'] := '';

         frVariables['lvs1'] := '';
         frVariables['rvs1'] := '';
         frVariables['lvs2'] := '';
         frVariables['rvs2'] := '';
         frVariables['lvs3'] := '';
         frVariables['rvs3'] := '';

         frVariables['lns1'] := '';
         frVariables['rns1'] := '';
         frVariables['lns2'] := '';
         frVariables['rns2'] := '';
         frVariables['lns3'] := '';
         frVariables['rns3'] := '';
      end;
   3: begin//
         frVariables['lreg'] := 'Коминтерновского';
         frVariables['ln1'] := '';
         frVariables['rn1'] := '';
         frVariables['ln2'] := '';
         frVariables['rn2'] := '';
         frVariables['ln3'] := '';
         frVariables['rn3'] := '';

         frVariables['bossVDS'] := '';
         frVariables['lb1'] := '';
         frVariables['rb1'] := '';
         frVariables['lb2'] := '';
         frVariables['rb2'] := '';
         frVariables['lb3'] := '';
         frVariables['rb3'] := '';

         frVariables['ln1'] := '';
         frVariables['rn1'] := '';
         frVariables['ln2'] := '';
         frVariables['rn2'] := '';
         frVariables['ln3'] := '';
         frVariables['rn3'] := '';

         frVariables['lvs1'] := '';
         frVariables['rvs1'] := '';
         frVariables['lvs2'] := '';
         frVariables['rvs2'] := '';
         frVariables['lvs3'] := '';
         frVariables['rvs3'] := '';

         frVariables['lns1'] := '';
         frVariables['rns1'] := '';
         frVariables['lns2'] := '';
         frVariables['rns2'] := '';
         frVariables['lns3'] := '';
         frVariables['rns3'] := '';
      end;
   4: //Ленинский
      begin
         frVariables['lreg'] := 'Ленинского';
         frVariables['ln1'] := '26';
         frVariables['rn1'] := '27';
         frVariables['ln2'] := '28';
         frVariables['rn2'] := '29';
         frVariables['ln3'] := '62';
         frVariables['rn3'] := '63';

         frVariables['bossVDS'] := 'В.Н. Гринько';
         frVariables['lb1'] := 'Романов С.А.';
         frVariables['rb1'] := 'Кондратюк Б.Г.';
         frVariables['lb2'] := 'Маслий Н.И.';
         frVariables['rb2'] := 'Горбенко Т.А.';
         frVariables['lb3'] := 'Сущенко М.И.';
         frVariables['rb3'] := 'Чудановских В.И.';  //frVariables['rb3'] := 'Мареева В.В.';
         {
         frVariables['ln1'] := '';
         frVariables['rn1'] := '';
         frVariables['ln2'] := '';
         frVariables['rn2'] := '';
         frVariables['ln3'] := '';
         frVariables['rn3'] := '';
         }
         frVariables['lvs1'] := 'Начальник участка №';
         frVariables['rvs1'] := 'Начальник участка №';
         frVariables['lvs2'] := 'Начальник участка №';
         frVariables['rvs2'] := 'Начальник участка №';
         frVariables['lvs3'] := 'Начальник участка №';
         frVariables['rvs3'] := 'Начальник участка №';

         frVariables['lns1'] := 'КП "Жилкомсервис"';
         frVariables['rns1'] := 'КП "Жилкомсервис"';
         frVariables['lns2'] := 'КП "Жилкомсервис"';
         frVariables['rns2'] := 'КП "Жилкомсервис"';
         frVariables['lns3'] := 'КП "Жилкомсервис"';
         frVariables['rns3'] := 'КП "Жилкомсервис"';
      end;
   5: begin//
         frVariables['lreg'] := 'Московского';
         frVariables['ln1'] := '';
         frVariables['rn1'] := '';
         frVariables['ln2'] := '';
         frVariables['rn2'] := '';
         frVariables['ln3'] := '';
         frVariables['rn3'] := '';

         frVariables['bossVDS'] := '';
         frVariables['lb1'] := '';
         frVariables['rb1'] := '';
         frVariables['lb2'] := '';
         frVariables['rb2'] := '';
         frVariables['lb3'] := '';
         frVariables['rb3'] := '';

         frVariables['ln1'] := '';
         frVariables['rn1'] := '';
         frVariables['ln2'] := '';
         frVariables['rn2'] := '';
         frVariables['ln3'] := '';
         frVariables['rn3'] := '';

         frVariables['lvs1'] := '';
         frVariables['rvs1'] := '';
         frVariables['lvs2'] := '';
         frVariables['rvs2'] := '';
         frVariables['lvs3'] := '';
         frVariables['rvs3'] := '';

         frVariables['lns1'] := '';
         frVariables['rns1'] := '';
         frVariables['lns2'] := '';
         frVariables['rns2'] := '';
         frVariables['lns3'] := '';
         frVariables['rns3'] := '';
      end;
   6: begin// Октябрьский
         frVariables['lreg'] := 'Октябрьского';
         frVariables['ln1'] := '';  //42
         frVariables['rn1'] := '';  //43
         frVariables['ln2'] := '';  //44
         frVariables['rn2'] := '';  //45
         frVariables['ln3'] := '';  //65
         frVariables['rn3'] := '';  //66

         frVariables['bossVDS'] := 'В.В. Воронцов';
         frVariables['lb1'] := '';// А.Н. Канунникова';
         frVariables['rb1'] := '';// В.С. Даниленко';
         frVariables['lb2'] := '';// Е.А. Сопина';
         frVariables['rb2'] := '';// М.Ю. Линник';
         frVariables['lb3'] := '';// В.Ф. Бережанская';
         frVariables['rb3'] := '';// О.И. Стовбир';

         frVariables['ln1'] := '';
         frVariables['rn1'] := '';
         frVariables['ln2'] := '';
         frVariables['rn2'] := '';
         frVariables['ln3'] := '';
         frVariables['rn3'] := '';

         frVariables['lvs1'] := '';
         frVariables['rvs1'] := '';
         frVariables['lvs2'] := '';
         frVariables['rvs2'] := '';
         frVariables['lvs3'] := '';
         frVariables['rvs3'] := '';

         frVariables['lns1'] := '';
         frVariables['rns1'] := '';
         frVariables['lns2'] := '';
         frVariables['rns2'] := '';
         frVariables['lns3'] := '';
         frVariables['rns3'] := '';
      end;
   7: begin//
         frVariables['lreg'] := 'Орджоникидзевского';
         frVariables['ln1'] := '';
         frVariables['rn1'] := '';
         frVariables['ln2'] := '';
         frVariables['rn2'] := '';
         frVariables['ln3'] := '';
         frVariables['rn3'] := '';

         frVariables['bossVDS'] := '';
         frVariables['lb1'] := '';
         frVariables['rb1'] := '';
         frVariables['lb2'] := '';
         frVariables['rb2'] := '';
         frVariables['lb3'] := '';
         frVariables['rb3'] := '';

         frVariables['ln1'] := '';
         frVariables['rn1'] := '';
         frVariables['ln2'] := '';
         frVariables['rn2'] := '';
         frVariables['ln3'] := '';
         frVariables['rn3'] := '';

         frVariables['lvs1'] := '';
         frVariables['rvs1'] := '';
         frVariables['lvs2'] := '';
         frVariables['rvs2'] := '';
         frVariables['lvs3'] := '';
         frVariables['rvs3'] := '';

         frVariables['lns1'] := '';
         frVariables['rns1'] := '';
         frVariables['lns2'] := '';
         frVariables['rns2'] := '';
         frVariables['lns3'] := '';
         frVariables['rns3'] := '';
      end;
   8: begin//
         frVariables['lreg'] := 'Фрунзенского';
         frVariables['ln1'] := '';
         frVariables['rn1'] := '';
         frVariables['ln2'] := '';
         frVariables['rn2'] := '';
         frVariables['ln3'] := '';
         frVariables['rn3'] := '';

         frVariables['bossVDS'] := '';
         frVariables['lb1'] := '';
         frVariables['rb1'] := '';
         frVariables['lb2'] := '';
         frVariables['rb2'] := '';
         frVariables['lb3'] := '';
         frVariables['rb3'] := '';

         frVariables['ln1'] := '';
         frVariables['rn1'] := '';
         frVariables['ln2'] := '';
         frVariables['rn2'] := '';
         frVariables['ln3'] := '';
         frVariables['rn3'] := '';

         frVariables['lvs1'] := '';
         frVariables['rvs1'] := '';
         frVariables['lvs2'] := '';
         frVariables['rvs2'] := '';
         frVariables['lvs3'] := '';
         frVariables['rvs3'] := '';

         frVariables['lns1'] := '';
         frVariables['rns1'] := '';
         frVariables['lns2'] := '';
         frVariables['rns2'] := '';
         frVariables['lns3'] := '';
         frVariables['rns3'] := '';
      end;
   9: begin//
         frVariables['lreg'] := '';
         frVariables['ln1'] := '';
         frVariables['rn1'] := '';
         frVariables['ln2'] := '';
         frVariables['rn2'] := '';
         frVariables['ln3'] := '';
         frVariables['rn3'] := '';

         frVariables['bossVDS'] := 'Червонозаводского';
         frVariables['lb1'] := '';
         frVariables['rb1'] := '';
         frVariables['lb2'] := '';
         frVariables['rb2'] := '';
         frVariables['lb3'] := '';
         frVariables['rb3'] := '';

         frVariables['ln1'] := '';
         frVariables['rn1'] := '';
         frVariables['ln2'] := '';
         frVariables['rn2'] := '';
         frVariables['ln3'] := '';
         frVariables['rn3'] := '';

         frVariables['lvs1'] := '';
         frVariables['rvs1'] := '';
         frVariables['lvs2'] := '';
         frVariables['rvs2'] := '';
         frVariables['lvs3'] := '';
         frVariables['rvs3'] := '';

         frVariables['lns1'] := '';
         frVariables['rns1'] := '';
         frVariables['lns2'] := '';
         frVariables['rns2'] := '';
         frVariables['lns3'] := '';
         frVariables['rns3'] := '';
      end;

   end;//case


end;


function Tdm_RepCurrentRayon_vds.PrepareDset: boolean;
begin
  Result:=false;

  ResetProgressFields;

  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
    FillResultDset;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(Tdm_RepDiscon.PrepareDsets)');
    end;
  end;

  Result:=true;
end;


procedure Tdm_RepCurrentRayon_vds.Init;
begin
  SetSqlString;
  SetRecordCount;
end;

procedure Tdm_RepCurrentRayon_vds.SetRecordCount;
begin
  MyOpenIBDS(dset_tmp, F_RecCountSqlString);
  F_RecordCount:=dset_tmp.FieldByName('RecCount').AsInteger;
end;


procedure Tdm_RepCurrentRayon_vds.SetSqlString;
var
  RegCond, DtCond, SqlBottom, CheckCond: string;
begin
  //F_ALLChecked:= false; // пока что пусть будет так :), т.е. только закрытые
  if not F_ALLChecked then CheckCond := ' and (o.isclosed= 1 ) '
  else CheckCond := '';

  if trim(F_RegionsID)<>'' then
    RegCond:=Format(' and (o.fk_orders_regions in%s)', [F_RegionsID])
  else
    RegCond:='';

  DtCond:=Format(' and (o.DateComing>%s) and (o.DateComing<=%s)',
        [QuotedStr(DateToStr(F_DtBeg)), QuotedStr(DateToStr(F_DtEnd+1))]);

  SqlBottom:=Format(
    ' from Orders_vds o'+
    ' where ( 1 = 1 ) %s %s %s',[ CheckCond, DtCond, RegCond]);

  F_RecCountSqlString:=
    ' select count(*) RecCount'+
    SqlBottom;

  F_MainSqlString:=
    ' select o.id, o.datecoming, o.OrderNumber, o.dateclosed,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Region,'+
    ' (select name from s_applicant_vds where id=o.fk_orders_applicant) Applicant,'+
    ' o.fk_orders_streets street_num, o.housenum, o.PorchNum, o.floornum, o.apartmentnum, '+
    ' (select name from s_district_vds where id=o.fk_orders_district) District'+
    ', (select name from brigadiers where id=o.fk_orders_brigadiers) brigadier'+
    ', (select messagename from s_messagetypes_vds where id=o.fk_orders_messagetypes) MessageTypes'+
    ' , o.additionalinfo, o.APPLICANTPHONE, o.APPLICANTFIO'+
    SqlBottom+
    ' order by 5, 2';
end;



end.
