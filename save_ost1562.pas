unit save_ost1562;

interface
uses BaseBefor,Classes, Controls, Variants,  SvodkaGikDModule, FR_Class,
     FR_DSet, SysUtils, ProgressForm, FrPreviewForm,
     Aligrid, DB, Graphics, DataExchInterfacesUnit,
     ObjListUnit, ExcelWorksForm, Grids,RXDBCtrl,RxMemDS,
      UniDataExchUnit,   GetOst1562_3;

type
 TSaveOst1562=class (tBasePrepared_Time)
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
  public
    F_DT:tDate;
//  procedure OnChangeProgressStatus(ProgLength, ProgPos: integer);
   function Excute:boolean;  override;
 end;

var  SaveOst1562:TSaveOst1562;

implementation


procedure TSaveOst1562.InitFields;
begin
 F_Dt:=Now();
end;

procedure TSaveOst1562.CreateForms;
begin
 f_Dm:=  Tdm_GetOst1562.Create(nil);
end;

function TSaveOst1562.Excute;
begin
  F_pind.Caption:='Остаток заявок 1562';
  try
   F_Pind.Show;
   (F_DM as Tdm_GetOst1562).prepareData;
  finally
   F_Pind.Hide;
  end;
end;

end.
