unit DepPlanWorMatDModule;

interface

uses
  SysUtils, Classes,DModule, IBDatabase, DB, IBCustomDataSet, kbmMemTable,
  GlobalVocCacheDModule, TrudoZatratDModule;

type
  Tdm_DepPlanWorMat = class(TDataModule)
    dset_works: TIBDataSet;
    dset_maters: TIBDataSet;
    tran: TIBTransaction;
    mt_works: TkbmMemTable;
    mt_maters: TkbmMemTable;
    mt_diametr: TkbmMemTable;
    dset_worksID: TIntegerField;
    dset_worksFK_DEPWORKS_DEPARTURE: TIntegerField;
    dset_worksFK_DEPWORKS_ORDER: TIntegerField;
    dset_worksFK_DEPWORKS_WORK: TIntegerField;
    dset_worksQUANTITY: TIBBCDField;
    dset_worksWORK_TIME: TIBBCDField;
    dset_worksFK_DEPWORKS_BWORK: TIntegerField;
    dset_worksFK_DEPWORKS_DEPBWORK: TIntegerField;
    dset_worksADDITIONALINFO: TIBStringField;
    dset_worksMEASUR_QUANTITY: TIBBCDField;
    dset_worksEXC_DEPTH: TIBBCDField;
    dset_worksEXC_WIDTH: TIBBCDField;
    dset_worksEXC_LENGTH: TIBBCDField;
    dset_worksFK_DEPWORKS_OFFICPOST_INS: TIntegerField;
    dset_worksNUM_WORK: TSmallintField;
    dset_worksSQUARE_ASF: TIBBCDField;
    dset_worksFACT_DATETIME: TDateTimeField;
    dset_worksclc_WorkTime: TFloatField;
    dset_worksclc_Measur_Quamtity: TFloatField;
    dset_worksclcWT_INFO: TStringField;
    dset_worksipWork: TStringField;
    dset_worksipDiam: TStringField;
    dset_worksWORKNAME: TIBStringField;
    dset_worksDIAM: TIntegerField;
    dset_worksIDDIAM: TIntegerField;
    dset_worksFK_DEPWORKS_DIAMETER: TIntegerField;
    dset_worksclcWorkTime: TFloatField;
    dset_worksclcMEASUR_QUNTITy: TFloatField;
    dset_worksclcWork: TStringField;
    dset_matersID: TIntegerField;
    dset_matersFK_DEPARTURE: TIntegerField;
    dset_matersFK_ORDER: TIntegerField;
    dset_matersFK_MATER: TIntegerField;
    dset_matersFK_DIAMETER: TIntegerField;
    dset_matersQUANTITY: TIBBCDField;
    dset_matersMATERNAME: TIBStringField;
    dset_matersDIAM: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure dset_worksCalcFields(DataSet: TDataSet);
    procedure dset_worksBeforePost(DataSet: TDataSet);
    procedure dset_worksAfterInsert(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure dset_matersAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
    ListVork:TList;
    F_OrderID:integer;
    F_depID:integer;
    F_TrudoZatrat: Tdm_TrudoZatrat;
    F_MaxNUMWORK :integer;
    f_typ:integer;
    procedure OpenVoks();
    procedure OpenWorks();
    procedure OpenMaters();
    procedure SetTables(typ:integer);


  public
    { Public declarations }
    F_DefaultOfficPostIns:integer;
    property OrderID:integer write F_orderid;
    property depID:integer write F_DepID;
    procedure Open;
    procedure StartTran();
    procedure CommitTran();
    procedure TranRallBack();
    property typ:integer write SetTables;
  end;

 const SQL_Work_Sel=' select dw.ID, '+
                    '  dw.FK_DEPWORKS_DEPARTURE ,'+
                    '  dw.FK_DEPWORKS_ORDER,'+
                    '  dw.FK_DEPWORKS_WORK,' +
                    '  dw.FK_DEPWORKS_DIAMETER IDDIAM, '+
                    '  dw.QUANTITY, '+
                    '  dw.WORK_TIME, '+
                    '  dw.FK_DEPWORKS_BWORK, '+
                    '  dw.FK_DEPWORKS_DEPBWORK, '+
                    '  dw.ADDITIONALINFO, '+
                    '  dw.MEASUR_QUANTITY, '+
                    '  dw.EXC_DEPTH, '+
                    '   dw.EXC_WIDTH, '+
                    '  dw.EXC_LENGTH, '+
                    '  dw.FK_DEPWORKS_OFFICPOST_INS, '+
                    '  dw.NUM_WORK, '+
                    '   dw.SQUARE_ASF,'+
                    '   dw.FK_DEPWORKS_DIAMETER , '+
                    ' dw.Fact_Datetime, '+
                    ' sw.name workname,sd.diameter diam '+
                    ' from %s dw '+
                    ' left join s_works sw on sw.id = dw.FK_DEPWORKS_WORK '+
                    ' left join s_tubediameter sd on sd.id = dw.FK_DEPWORKS_DIAMETER '+
                    ' where '+
                    ' (dw.FK_DEPWORKS_ORDER = :pOrderID ) and '+
                    ' (dw.FK_DEPWORKS_DEPARTURE = :pDepID) '+
                    ' order by dw.NUM_WORK, sw.NAME, sd.DIAMETER';

       SQL_Work_Ref=' select dw.ID, '+
                    ' dw.FK_DEPWORKS_DEPARTURE , '+
                    ' dw.FK_DEPWORKS_ORDER, '+
                    ' dw.FK_DEPWORKS_WORK, '+
                    ' dw.FK_DEPWORKS_DIAMETER IDDIAM, '+
                    ' dw.QUANTITY, '+
                    ' dw.WORK_TIME, '+
                    ' dw.FK_DEPWORKS_BWORK, '+
                    ' dw.FK_DEPWORKS_DEPBWORK, '+
                    ' dw.ADDITIONALINFO, '+
                    ' dw.MEASUR_QUANTITY, '+
                    ' dw.EXC_DEPTH, '+
                    ' dw.EXC_WIDTH, '+
                    ' dw.EXC_LENGTH, '+
                    ' dw.FK_DEPWORKS_OFFICPOST_INS, '+
                    ' dw.NUM_WORK, '+
                    ' dw.SQUARE_ASF, '+
                    ' dw.Fact_Datetime, '+
                    ' sw.name workname,sd.diameter diam '+
                    ' from %s dw '+
                    ' left join s_works sw on sw.id = dw.FK_DEPWORKS_WORK '+
                    ' left join s_tubediameter sd on sd.id = dw.FK_DEPWORKS_DIAMETER '+
                    ' where '+
                    ' (dw.FK_DEPWORKS_ORDER = :pOrderID ) and '+
                    ' (dw.FK_DEPWORKS_DEPARTURE = :pDepID) '+
                    ' order by dw.NUM_WORK, sw.NAME, sd.DIAMETER ';
       SQL_Work_Ins=' insert into %s ( '+
                    ' ID, FK_DEPWORKS_DEPARTURE, FK_DEPWORKS_ORDER, '+
                    ' FK_DEPWORKS_WORK, FK_DEPWORKS_BWORK, FK_DEPWORKS_DIAMETER, '+
                    ' QUANTITY, WORK_TIME, ADDITIONALINFO, '+
                    ' MEASUR_QUANTITY, EXC_DEPTH, EXC_WIDTH,'+
                    ' EXC_LENGTH, FK_DEPWORKS_OFFICPOST_INS, NUM_WORK,'+
                    ' SQUARE_ASF, fact_Datetime) '+
                    ' values( '+
                    ' :ID, :FK_DEPWORKS_DEPARTURE, :FK_DEPWORKS_ORDER, '+
                    ' :FK_DEPWORKS_WORK, :FK_DEPWORKS_BWORK, :IDDIAM, '+
                    ' :QUANTITY, :WORK_TIME, :ADDITIONALINFO, '+
                    ' :MEASUR_QUANTITY,  :EXC_DEPTH, :EXC_WIDTH,'+
                    ' :EXC_LENGTH, :FK_DEPWORKS_OFFICPOST_INS,:NUM_WORK,'+
                    ' :SQUARE_ASF, :fact_Datetime)';
       SQL_Work_Upd=' update %s set '+
                    ' FK_DEPWORKS_BWORK = :FK_DEPWORKS_BWORK, '+
                    ' FK_DEPWORKS_WORK = :FK_DEPWORKS_WORK, '+
                    ' FK_DEPWORKS_DIAMETER = :IdDiam, '+
                    ' QUANTITY = :QUANTITY, '+
                    ' WORK_TIME = :WORK_TIME, '+
                    ' ADDITIONALINFO = :ADDITIONALINFO, '+
                    ' MEASUR_QUANTITY = :MEASUR_QUANTITY, '+
                    ' EXC_DEPTH = :EXC_DEPTH, '+
                    ' EXC_WIDTH = :EXC_WIDTH, '+
                    ' EXC_LENGTH = :EXC_LENGTH, '+
                    ' NUM_WORK = :NUM_WORK, '+
                    ' SQUARE_ASF = :SQUARE_ASF '+
                    ' where ID = :ID ';
       SQL_Work_Del=' delete from %s where id=:id ';

       SQL_Mat_Sel=' select pm.id, pm.fk_departure, pm.fk_order, pm.fk_mater,'+
                   ' pm.fk_diameter, pm.quantity,'+
                   '  m.name MaterName, d.diameter diam '+
                   ' from %s pm left  join MATERIALS m on pm.fk_mater=m.id '+
                   ' left join s_tubediameter d on d.id=pm.fk_diameter'+
                   ' where pm.fk_departure=:pDepID and pm.fk_order=:pOrderID';
       SQL_Mat_Ref='select pm.id, pm.fk_departure, pm.fk_order, pm.fk_mater, pm.fk_diameter, '+
                   ' pm.quantity, m.name MaterName, d.diameter diam'+
                   ' from %s pm left  join MATERIALS m on pm.fk_mater=m.id '+
                   ' left join s_tubediameter d on d.id=pm.fk_diameter '+
                   ' where pm.fk_departure=:pDepID and pm.fk_order=:pOrderID';
       SQL_Mat_Ins=' insert into %s '+
                   ' (id, fk_departure,  fk_order, '+
                   '  fk_mater,  fk_diameter,  quantity ) '+
                   ' values '+
                   ' (:id, :fk_departure, :fk_order, '+
                   ' :fk_mater, :fk_diameter, :quantity ) ';
       SQL_Mat_Upd=' update %s '+
                   'set '+
                   ' fk_departure=:fk_Departure, '+
                   ' fk_order=:fk_order, '+
                   ' fk_mater=:fk_mater, '+
                   ' fk_diameter=:fk_diameter, '+
                   '  quantity=:quantity '+
                   ' where id=:id';

       SQL_Mat_Del=' delete from %s where id=:id';


       Gen_Work_NS='GEN_PLAN_DEP_WORKS_ID';
       Gen_Work_VDS='GEN_PLAN_DEP_WORKS_VDS_ID';
       Gen_Mat_NS='GEN_DEPPLANMATERS_ID';
       Gen_Mat_VDS='GEN_DEPPLANMATERS_VDS_ID';

       table_work_ns='PLAN_DEP_WORKS';
       table_work_vds='PLAN_DEP_WORKS_vds';
       table_mat_ns='DEPPLANMATERS';
       table_mat_vds='DEPPLANMATERS_vds';

implementation

{$R *.dfm}

procedure  Tdm_DepPlanWorMat.StartTran;
begin
 if   tran.InTransaction then tran.Commit;
 tran.StartTransaction;
end;

procedure Tdm_DepPlanWorMat.TranRallBack();
begin
 if tran.InTransaction then tran.Rollback;
end;

procedure Tdm_DepPlanWorMat.CommitTran;
begin
 if tran.InTransaction then tran.Commit;
end;

procedure Tdm_DepPlanWorMat.Open;
begin
   OpenVoks();
   OpenWorks();
   OpenMaters();

end  ;


procedure  Tdm_DepPlanWorMat.OpenVoks;
var i:integer;
begin

  ListVork.Add(mt_works);
  ListVork.Add(mt_maters);
  ListVork.Add(mt_diametr);

  for i:=0 to ListVork.Count-1 do
   if  TkbmMemTable(ListVork.Items[i]).Active then
        TkbmMemTable(ListVork.Items[i]).Close;
  dm_GlobalVocCache.CheckVocs(ListVork);
  mt_maters.Open;
  mt_works.Open;
  mt_diametr.Open;
end;


procedure Tdm_DepPlanWorMat.DataModuleCreate(Sender: TObject);
begin
 ListVork:=TList.Create;
 F_TrudoZatrat := Tdm_TrudoZatrat.Create( nil );
end;

procedure Tdm_DepPlanWorMat.OpenWorks();
begin
  dset_works.ParamByName('pOrderID').AsInteger:=F_orderId;
  dset_works.ParamByName('pDepID').AsInteger:=  F_depID;
  dset_works.Open;
  dset_works.Last;
  F_MaxNUMWORK:=dset_works.fieldByname('NUM_WORK').AsInteger;
end;

procedure Tdm_DepPlanWorMat.OpenMaters();
begin
  dset_maters.ParamByName('pOrderID').AsInteger:=F_orderId;
  dset_maters.ParamByName('pDepID').AsInteger:=  F_depID;
  dset_maters.Open;
  dset_maters.Last;

end;



procedure Tdm_DepPlanWorMat.dset_worksCalcFields(DataSet: TDataSet);
 function _Okrug( _val: double ): double;
  begin
    Result := trunc( _val * 100 )/100;
  end;
begin
 with DataSet do
  begin
    if  ( State in [dsInsert, dsEdit ] ) then
    begin
      F_TrudoZatrat.WorkID := FieldByName( 'FK_DEPWORKS_WORK' ).AsInteger;
      F_TrudoZatrat.DiamID := FieldByName( 'IDDiam' ).AsInteger;
      if F_TrudoZatrat.CalcTZFromVC then
      begin
        FieldByName( 'clcWORKTIME' ).AsFloat := F_TrudoZatrat.TrudoZatrat;
        FieldBYName( 'clcMEASUR_QUANTITY' ).AsFloat := F_TrudoZatrat.KolEd;
        FieldByName( 'clcWT_INFO' ).AsString :=
          FormatFloat( '0.##', F_TrudoZatrat.TrudoZatrat ) + ' на ' +
          FormatFloat( '0.##', F_TrudoZatrat.KolEd ) + ' ед.';
      end else
      begin
        FieldByName( 'clcWORKTIME' ).Clear;
        FieldBYName( 'clcMEASUR_QUANTITY' ).AsFloat := 1;
        FieldByName( 'clcWT_INFO' ).AsString := 'Соответствующее значение не задано';
      end;
    end;



    //////////////////////////////////////////

  {  if FieldByName( 'MEASUR_QUANTITY' ).AsFloat >0 then
      FieldByName( 'clcFULL_WORKTIME' ).AsFloat :=
        _Okrug( ( FieldByName( 'WORK_TIME' ).AsFloat/FieldByName( 'MEASUR_QUANTITY' ).AsFloat  ) * FieldByName( 'QUANTITY' ).AsFloat );}

  //  FieldByName( 'clcWORK' ).AsString := GetFullWorkName( FieldByName( 'lpWORK' ).AsString, FieldByName( 'lpMEASUREMENT' ).AsString );
   // FieldByName( 'clc_IS_CAN_EDIT' ).AsBoolean := ( FieldByName( 'FK_DEPWORKS_OFFICPOST_INS' ).AsInteger = F_DefaultOfficPostIns );
  end;
end;

procedure Tdm_DepPlanWorMat.dset_worksBeforePost(DataSet: TDataSet);
var i:integer;
begin
with dset_Works do
 begin
   i:=FieldByname('FK_DEPWORKS_WORK').asinteger;
   if State in [dsEdit, dsInsert] then
   begin
    if FieldByName('clcWORKTIME').asfloat<>0 then
       FieldByName('WORK_TIME').asfloat:=FieldByName('clcWORKTIME').asfloat;
     if  FieldBYName( 'clcMEASUR_QUANTITY' ).AsFloat<>1 then
       FieldBYName( 'MEASUR_QUANTITY' ).AsFloat:=FieldBYName( 'clcMEASUR_QUANTITY' ).AsFloat;
    end;
 end
end;

procedure Tdm_DepPlanWorMat.dset_worksAfterInsert(DataSet: TDataSet);
begin
  dset_Works.FieldByName( 'FK_DEPWORKS_ORDER' ).AsInteger := F_OrderID;
  dset_Works.FieldByName( 'FK_DEPWORKS_DEPARTURE' ).AsInteger := F_DepID;
  dset_Works.FieldByName( 'IDDIAM' ).AsInteger := -1;
  dset_Works.FieldByName( 'QUANTITY' ).AsFloat := 1;
  F_MaxNUMWORK := F_MaxNUMWORK + 1;
  dset_Works.FieldByName( 'NUM_WORK' ).AsInteger := F_MaxNUMWORK;
  dset_Works.FieldByName('FACT_DATETIME').AsDateTime:=now();
end;

procedure Tdm_DepPlanWorMat.DataModuleDestroy(Sender: TObject);
begin
if tran.InTransaction then
Tran.Commit;
 F_TrudoZatrat.Free;
ListVork.Clear;
mt_works.Close;
mt_maters.Close;
mt_diametr.Close;
end;

procedure Tdm_DepPlanWorMat.dset_matersAfterInsert(DataSet: TDataSet);
begin
dset_maters.FieldByName('fk_departure').AsInteger:=F_DepID;
dset_maters.FieldByName('fk_order').AsInteger:=F_OrderId;
dset_maters.FieldByName('fk_diameter').AsInteger:=-1;
end;

procedure Tdm_DepPlanWorMat.SetTables(typ:integer);
var table_mat,table_work:string;
begin
 f_typ:=typ;
 case typ of
  1: begin
       table_mat:=table_mat_ns;
       table_work:=table_work_ns;
       dset_works.GeneratorField.Generator:=Gen_work_ns;
       dset_maters.GeneratorField.Generator:=Gen_mat_ns;
     end;
  2: begin
       table_mat:=table_mat_vds;
       table_work:=table_work_vds;
       dset_works.GeneratorField.Generator:=Gen_work_vds;
       dset_maters.GeneratorField.Generator:=Gen_mat_vds;
     end;
  end;

   dset_works.SelectSQL.Text:=Format(SQL_Work_Sel,[table_work]);
   dset_works.RefreshSQL.Text:=Format(SQL_Work_Ref,[table_work]);
   dset_works.InsertSQL.Text:=Format(SQL_Work_Ins,[table_work]);
   dset_works.ModifySQL.Text:=Format(SQL_Work_Upd,[table_work]);
   dset_works.DeleteSQL.Text:=Format(SQL_Work_Del,[table_work]);

   dset_maters.SelectSQL.Text:=Format(SQL_mat_Sel,[table_mat]);
   dset_maters.RefreshSQL.Text:=Format(SQL_Mat_Ref,[table_mat]);
   dset_maters.InsertSQL.Text:=Format(SQL_Mat_Ins,[table_mat]);
   dset_maters.ModifySQL.Text:=Format(SQL_Mat_Upd,[table_mat]);
   dset_maters.DeleteSQL.Text:=Format(SQL_Mat_Del,[table_mat]);

end;

end.
