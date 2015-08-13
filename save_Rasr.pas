unit save_Rasr;

interface
uses BaseBefor,Classes, Controls, Variants,  SvodkaGikDModule, FR_Class,
     FR_DSet, SysUtils, ProgressForm, FrPreviewForm,
     Aligrid, DB, Graphics, DataExchInterfacesUnit,
     ObjListUnit, ExcelWorksForm, Grids,RXDBCtrl,RxMemDS, UniDataExchUnit, DModuleSBlagRazr ;


type TSave_Ras=class(tBasePrepared_Time)
  protected

  procedure InitFields; override;
  procedure CreateForms; override;
  public

   F_DT:tDate;
//  procedure OnChangeProgressStatus(ProgLength, ProgPos: integer);
   function Excute:boolean;  override;
end;

var Save_Ras:TSave_Ras ;

procedure  Save_for_Ras();



implementation
procedure  Save_for_Ras();
begin
  Save_Ras:=TSave_Ras.Create;
   try
    Save_Ras.Excute;
   finally
    Save_Ras.Free;
   end;
end;

procedure TSave_Ras.InitFields;
begin
 F_DT:=now();
end;

procedure TSave_Ras.CreateForms;
begin
 F_DM:=Tdm_SBlagRazr.Create(nil);
end;

function TSave_Ras.Excute:boolean;
begin
 (F_DM as Tdm_SBlagRazr)._Dt:=Date();
  F_pind.Caption:='Данные для сводки разрытий';
  try
   F_Pind.Show;
   (F_DM as Tdm_SBlagRazr).preparedata;
  finally
   F_Pind.Hide;
  end;

end;





end.
