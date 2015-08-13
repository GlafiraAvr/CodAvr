unit RepPovrRegionDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class,
  IBDatabase, DB, IBCustomDataSet, DModule, FR_DSet, FR_DBSet;

type
  Tdm_RepPovrRegion = class(Tdm_NGReportBase)
    dset_tmp: TIBDataSet;
    tran: TIBTransaction;
    frDBResult: TfrDBDataSet;
    dset_tmp2: TIBDataSet;
    frDBDataSet2: TfrDBDataSet;
  private
    F_DateBeg,
    F_DateEnd: TDateTime;
    F_DisconCount: integer;
    procedure FillResultDset;

  public
    property DateBeg: TDateTime read F_DateBeg write F_DateBeg;
    property DateEnd: TDateTime read F_DateEnd write F_DateEnd;
    property DisconCount: integer read F_DisconCount write F_DisconCount;    
    procedure PrepareDset;
  end;


implementation

{$R *.dfm}

uses HelpFunctions, VocsValueConst;

{ Tdm_RepNetBar }

procedure Tdm_RepPovrRegion.FillResultDset;
var  SelSQL, SelSQL_Discon, addSQL, addSQL_Discon : string;
     idReg: byte;
begin
 idReg := 6; // ќкт€брьский

 addSQL :=' where '+
          'o.fk_orders_regions = '+ inttostr(idReg) + ' and '+
          ' o.fk_orders_damageplace in (1,2,3,7) ' +   // магистрали, вводы, колодцы, раб.абон.
          ' and IsClosed=0 ';

 addSQL_Discon := ' and ((select dttm_con from get_disconnections_now(o.id, 0)) is null) and'+
          ' id in'+
          ' (select fk_closedbolts_orders from closedbolts'+
          ' where fk_closedbolts_orders=o.id and'+
          ' ((fk_closedbolts_brigadieropen=-1) or (fk_closedbolts_brigadieropen is null)))';


 SelSQL :=' select id, OrderNumber, cast(DateComing as Date) DateComing, '+
           ' fk_orders_damageplace, '+
           ' (select name from s_DamageLocality where id=o.fk_orders_DamageLocality) DamageLocality,'+
           ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
           '  o.housenum, o.additionaladdress)) adres '+
           ' from orders o '+ addSQL +
           ' order by 4,6';

 SelSQL_Discon:=' select id, OrderNumber, DateComing,  fk_orders_regions, '+
          ' (select disconadress from get_disconnections_now(o.id, 0)) Disconnections, '+
          ' (select name from s_Regions where id=o.fk_orders_regions) Regions,'+
          ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,'+
          '  o.housenum, o.additionaladdress)) adres '+
          ' from orders o'+ addSQL + addSQL_Discon +
          ' order by 6,3';

  MyOpenIBDS( dset_tmp, SelSQL );
  MyOpenIBDS( dset_tmp2, SelSQL_Discon );
  F_DisconCount := dset_tmp2.RecordCount;

end;

procedure Tdm_RepPovrRegion.PrepareDset;
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
      raise Exception.Create( E.Message + '(Tdm_RepPovrRegion.PrepareDset)' );
    end;
  end;
end;

end.
