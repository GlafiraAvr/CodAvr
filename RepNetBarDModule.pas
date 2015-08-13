unit RepNetBarDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class,
  IBDatabase, DB, IBCustomDataSet, DModule, FR_DSet, FR_DBSet;

type
  Tdm_RepNetBar = class(Tdm_NGReportBase)
    ResultDset: TIBDataSet;
    tran: TIBTransaction;
    frDBResult: TfrDBDataSet;
  private
    F_DateBeg,
    F_DateEnd: TDateTime;
    procedure FillResultDset;
  public
    property DateBeg: TDateTime read F_DateBeg write F_DateBeg;
    property DateEnd: TDateTime read F_DateEnd write F_DateEnd;
    procedure PrepareDset;
  end;


implementation

{$R *.dfm}

uses HelpFunctions, VocsValueConst;

{ Tdm_RepNetBar }

procedure Tdm_RepNetBar.FillResultDset;
begin
{
  with ResultDset do
  begin
    Close;
    ParamByName( 'pRaskopID' ).AsInteger := S_WORKS_RASKOP;
    ParamByName( 'pDtBeg' ).AsDate := F_DateBeg;
    ParamByName( 'pDtEnd' ).AsDate := F_DateEnd + 1;
    Open;
  end;
}
  MyOpenIBDS( ResultDset,
    ' select o.ordernumber, sr.name region_name,' +
    ' (select adres from Get_adres(o.fk_orders_housetypes, o.fk_orders_streets,' +
    '     o.housenum, o.additionaladdress)) adres,' +
    ' sw.name work_name, dw2.additionalinfo exc_info, std.diameter, o.datecoming' +
    ' from departureworks dw1' +
    '     left join departureworks dw2 on (dw2.fk_depworks_departure = dw1.fk_depworks_departure) and' +
    '                                     (dw2.fk_depworks_work = ' + IntToStr( S_WORKS_RASKOP ) + ')' +
    '     left join orders o on o.id = dw1.fk_depworks_order' +
    '     left join departures d on d.id = dw1.fk_depworks_departure' +
    '     left join s_works sw on sw.id = dw1.fk_depworks_work' +
    '     left join s_regions sr on sr.id = o.fk_orders_regions' +
    '     left join s_tubediameter std on std.id = dw1.fk_depworks_diameter' +
    ' where' +
    ' (sw.id_workkind = 1) and' +
    ' (dw1.FK_DEPWORKS_WORK <> ' + IntToStr( S_WORKS_RASKOP ) + ' ) and' +
    ' (d.depnumber = 1) and' +
    ' (o.DateComing >= ''' + DateToStr( F_DateBeg ) + ''') and' +
    ' (o.DateComing < ''' + DateToStr( F_DateEnd + 1 ) + ''')' +
    ' order by sr.name, o.datecoming, o.ordernumber' );
end;

procedure Tdm_RepNetBar.PrepareDset;
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
      raise Exception.Create( E.Message + '(Tdm_RepNetBar.PrepareDset)' );
    end;
  end;
end;

end.
