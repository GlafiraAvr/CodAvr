unit UseEquipDModule; //Использования механизмов при благоустройстве

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class,
  IBDatabase, DB, IBCustomDataSet, DModule, FR_DSet, FR_DBSet;

type
  Tdm_UseEquip = class(Tdm_NGReportBase)
    tran: TIBTransaction;
    ResultDset: TIBDataSet;
    frDBResult: TfrDBDataSet;
  private
    { Private declarations }
    F_DtBeg: TDateTime;
    F_DtEnd: TDateTime;
    procedure FillResultDset;
  public
    { Public declarations }
    property DtBeg: TDateTime read F_DtBeg write F_DtBeg;
    property DtEnd: TDateTime read F_DtEnd write F_DtEnd;
    function PrepareDset: boolean;
  end;

var
  dm_UseEquip: Tdm_UseEquip;

implementation

{$R *.dfm}

uses HelpFunctions;

function Tdm_UseEquip.PrepareDset: boolean;
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

procedure Tdm_UseEquip.FillResultDset;
begin
{
select o.ordernumber, o.datecoming
   , (select name from s_Regions where id=o.fk_orders_regions) Regions
   , (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,  o.housenum, o.additionaladdress)) adres
   , (select (select strval from tochar(eq.number))
            from equipment eq where id=e.fk_excavations_equipment) Equip
   , e.dtime
   , (select WorkName from s_ExcavationWorkTypes where id=e.fk_excavations_excwt) ExcWt
 from excavations e,  orders o
 where ( e.fk_excavations_orders = o.id )
    and ( e.dtime >='01.01.2009' ) and ( e.dtime <'03.01.2009' )
 order by o.datecoming
}
  MyOpenIBDS( ResultDset,
    ' select ''1'' MainGr,o.id, o.ordernumber, o.datecoming' +
    ' , (select name from s_Regions where id=o.fk_orders_regions) Regions' +
    ' , (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,  o.housenum, o.additionaladdress)) adres' +
    ' , (select (select strval from tocharuns(eq.number)) from equipment eq where id=e.fk_excavations_equipment) Equip'+
    ' , e.dtime '+
    ' , (select WorkName from s_ExcavationWorkTypes where id=e.fk_excavations_excwt) ExcWt '+
    '  from excavations e,  orders o '+
    ' where ( e.fk_excavations_orders = o.id ) ' +
    ' and ( e.dtime < ''' + DateToStr( F_DtEnd + 1 ) + ''' )' +
    ' and ( e.dtime >= ''' + DateToStr( F_DtBeg ) + ''' )' +
    ' order by 5,8' );
end;

end.
