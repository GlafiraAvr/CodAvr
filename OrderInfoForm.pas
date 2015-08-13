unit OrderInfoForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AddOrderInfoForm, ExtCtrls, StdCtrls, DModule, IBDatabase, DB,
  IBCustomDataSet, Grids, Aligrid;

type
  Tfrm_OrderInfo = class(Tfrm_AddOrderInfo)
    Panel1: TPanel;
    ed_OrderNumber: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ed_DateComing: TEdit;
    ed_TimeComing: TEdit;
    Label3: TLabel;
    ed_Official: TEdit;
    Label4: TLabel;
    ed_Region: TEdit;
    ed_Adres: TEdit;
    Label5: TLabel;
    ed_Brig: TEdit;
    Label6: TLabel;
    ed_MessageType: TEdit;
    Label7: TLabel;
    ed_DamageLocality: TEdit;
    Label8: TLabel;
    ed_DamagePlace: TEdit;
    Label9: TLabel;
    mem_WhatIsDone: TMemo;
    Label10: TLabel;
    mem_WhatIsDoneInFirstDep: TMemo;
    dset: TIBDataSet;
    tran: TIBTransaction;
    Label11: TLabel;
    Label12: TLabel;
    grd_Bolts: TStringAlignGrid;
    Label13: TLabel;
    procedure FormShow(Sender: TObject);
  private
    F_OrderID: integer;
    procedure FillForm;
    procedure FillOrderInfo;
    procedure FillBoltsInfo;
    procedure OnShowBrig(ShowValue: variant; var Res: string);
  public
    constructor Create(AOwner: TComponent; AOrderID: integer);
  end;


implementation

{$R *.dfm}

uses HelpFunctions, GridViewBuilder;

{ Tfrm_OrderInfo }

constructor Tfrm_OrderInfo.Create(AOwner: TComponent; AOrderID: integer);
begin
  inherited Create(AOwner);
  F_OrderID:=AOrderID;
end;

procedure Tfrm_OrderInfo.FillBoltsInfo;
var
  gvb: TGridViewBuilder;
begin
  MyOpenIBDS(dset,
    ' select cast(b.closedate as Date) CloseDate, cast(b.opendate as Date) OpenDate, b.ClosePlace,'+
    ' (select name from brigadiers where id=b.fk_closedbolts_brigadiersclose) BrigClose,'+
    ' (select name from brigadiers where id=b.fk_closedbolts_brigadieropen) BrigOpen,'+
    ' (select diameter from s_tubediameter where id=b.fk_closedbolts_tubediam) TubeDiam,'+
    ' (select adres from'+
    ' get_Adres(b.fk_closedbolts_housetype, b.fk_closedbolts_streets, b.housenum, b.additionaladdress)) as Adres'+
    ' from closedbolts b'+
    ' where b.fk_closedbolts_orders='+IntToStr(F_OrderID));

  if dset.Eof and dset.Bof then
    grd_Bolts.Visible:=false
  else
  begin
    grd_Bolts.Visible:=true;

    gvb:=TGridViewBuilder.Create(dset, grd_Bolts);
    try
      AddColToGVB(gvb, 'Adres', 'Адрес', alLeft);
      AddColToGVB(gvb, 'ClosePlace', 'Место', alLeft);
      AddColToGVB(gvb, 'TubeDiam', 'Диаметр', alCenter);
      AddColToGVB(gvb, 'CloseDate', 'Дата'+#13+'перекрытия', alCenter);
      AddColToGVB(gvb, 'BrigClose', 'Ответственный'+#13+'за перекрытие', alLeft, OnShowBrig);
      AddColToGVB(gvb, 'OpenDate', 'Дата'+#13+'открытия', alCenter);
      AddColToGVB(gvb, 'BrigOpen', 'Ответственный'+#13+'за открытие', alLeft, OnShowBrig);
      gvb.BuildGridView;
    finally
      gvb.Free;
    end;
  end;
end;

procedure Tfrm_OrderInfo.FillForm;
begin
  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
    FillOrderInfo;
    FillBoltsInfo;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(Tfrm_OrderInfo.FillForm)');
    end;
  end;
end;

procedure Tfrm_OrderInfo.FillOrderInfo;
begin
  MyOpenIBDS(dset,
    ' select o.OrderNumber, o.DateComing,'+
    ' (select orderworks from get_orderworks( o.id, 0, 1 )) whatisdone,' +
    ' (select orderworks from get_orderworks( o.id, 1, 0 )) What_Is_Done_In_First_Dep,'+
    ' (select name from s_Officials where id=o.fk_orders_officials) Official,'+
    ' (select name from s_Regions where id=o.fk_orders_regions) Region,'+
    ' (select name from brigadiers where id='+
    '     (select d.fk_departures_brigadiers from departures d'+
    '     where d.fk_departures_orders=o.id and d.depnumber=1)) Brig,'+
    ' (select MessageName from s_MessageTypes where id=o.fk_orders_messagetypes) MessageType,'+
    ' (select name from s_DamageLocality where id=o.fk_orders_DamageLocality) DamageLocality,'+
    ' (select name from s_DamagePlace where id=o.fk_orders_damageplace) DamagePlace,'+
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
    '     o.housenum, o.additionaladdress)) adres'+
    ' from orders o'+
    ' where id='+IntToStr(F_OrderID));

  if not(dset.Eof and dset.Bof) then
  begin
    ed_OrderNumber.Text:=trim(dset.FieldByName('OrderNumber').AsString);
    ed_DateComing.Text:=FormatDateTime('dd.mm.yy', dset.FieldByName('DateComing').AsDateTime);
    ed_TimeComing.Text:=FormatDateTime('hh:mm', dset.FieldByName('DateComing').AsDateTime);
    ed_Official.Text:=trim(dset.FieldByName('Official').AsString);
    ed_Region.Text:=trim(dset.FieldByName('Region').AsString);
    ed_Adres.Text:=trim(dset.FieldByName('Adres').AsString);
    ed_Brig.Text:=trim(dset.FieldByName('Brig').AsString);
    ed_MessageType.Text:=trim(dset.FieldByName('MessageType').AsString);
    ed_DamageLocality.Text:=trim(dset.FieldByName('DamageLocality').AsString);
    ed_DamagePlace.Text:=trim(dset.FieldByName('DamagePlace').AsString);
    mem_WhatIsDone.Text:=trim(dset.FieldByName('WhatIsDone').AsString);
    mem_WhatIsDoneInFirstDep.Text:=trim(dset.FieldByName('What_Is_Done_In_First_Dep').AsString);
  end;
end;

procedure Tfrm_OrderInfo.FormShow(Sender: TObject);
begin
  inherited;
  FillForm;
end;

procedure Tfrm_OrderInfo.OnShowBrig(ShowValue: variant; var Res: string);
begin
  if AnsiUpperCase(trim(Res))='БЕЗ ВЫЕЗДА' then
    Res:='';
end;

end.
