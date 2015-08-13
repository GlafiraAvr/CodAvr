unit SaveSTDISP;

interface
uses Classes, Controls, Variants,  SvodkaGikDModule, FR_Class,
     FR_DSet, SysUtils, ProgressForm, FrPreviewForm,
     Aligrid, DB, Graphics, DataExchInterfacesUnit,
     ObjListUnit, ExcelWorksForm, Grids,RXDBCtrl,RxMemDS, UniDataExchUnit, BaseBefor;


type
 TSaveSTDisp =class  (tBasePrepared_Time)
 private
//  F_DM: Tdm_SvodkaGik;
  procedure SaveDataForStDisp(_filename: string);
  protected

  procedure InitFields; override;
  procedure CreateForms; override;
 public

  F_DT:tDate;
//  procedure OnChangeProgressStatus(ProgLength, ProgPos: integer);
  function Excute:boolean;  override;
end;
 procedure SaveForStDispXML();
implementation

uses ApplicationSettings;

var   Save_StDisp:TSaveSTDisp;


procedure SaveForStDispXML();
begin
   Save_StDisp:=TSaveSTDisp.Create;
   try
    Save_StDisp.Excute;
   finally
    Save_StDisp.Free;
   end;
end;

procedure TSaveSTDisp.SaveDataForStDisp(_filename: string);
var
  _t: TUniDataExch;
  _vp: TNameValuePair;
  _enum: IEnumerator;
  _da: IDataAccess;
begin
  _t := TUniDataExch.Create;
  _da := _t;
  _enum := _t.Buf;
  try
    _da.SetFileName(_filename);

    _enum.Clear;
    //
    with (F_DM as Tdm_SvodkaGik).DataForStDisp do
    begin
      _vp.name := 'VodoSetiVsego'; _vp.value := IntToStr(VodoSetiVsego); _enum.Add(_vp);
      _vp.name := 'VvodyVsego'; _vp.value := IntToStr(VvodyVsego); _enum.Add(_vp);
      _vp.name := 'KolodtsyVsego'; _vp.value := IntToStr(KolodtsyVsego); _enum.Add(_vp);
      _vp.name := 'KolonkiVsego'; _vp.value := IntToStr(KolonkiVsego); _enum.Add(_vp);
      _vp.name := 'LikvidNaVodoSetyax'; _vp.value := IntToStr(LikvidNaVodoSetyax); _enum.Add(_vp);

      _vp.name := 'LikvidNaVvodax'; _vp.value := IntToStr(LikvidNaVvodax); _enum.Add(_vp);
      _vp.name := 'UstanLukov'; _vp.value := IntToStr(UstanLukov); _enum.Add(_vp);
      _vp.name := 'PostupNaVodoSetyax'; _vp.value := IntToStr(PostupNaVodoSetyax); _enum.Add(_vp);
      _vp.name := 'PostupNaVvodax'; _vp.value := IntToStr(PostupNaVvodax); _enum.Add(_vp);
      //
      _vp.name := 'More_TechejIzZemli'; _vp.value := IntToStr(TechejIzZemli); _enum.Add(_vp);

      _vp.name := 'More_TecheyIzKolodtsev'; _vp.value := IntToStr(TecheyIzKolodtsev); _enum.Add(_vp);
      _vp.name := 'More_NeispravnyxKolonok'; _vp.value := IntToStr(NeispravnyxKolonok); _enum.Add(_vp);
      //
      _vp.name := 'More_Likvidirovano'; _vp.value := IntToStr(Likvidirovano); _enum.Add(_vp);
      _vp.name := 'More_IzNihZasypano'; _vp.value := IntToStr(IzNihZasypano); _enum.Add(_vp);
      _vp.name := 'More_IzNihNeZasypano'; _vp.value := IntToStr(IzNihNeZasypano); _enum.Add(_vp);

      _vp.name := 'More_Postupilo'; _vp.value := IntToStr(Postupilo); _enum.Add(_vp);
      _vp.name := 'More_NeZasypanoPoGorodu_Vsego'; _vp.value := IntToStr(NeZasypanoPoGorodu_Vsego); _enum.Add(_vp);
      _vp.name := 'More_NeZasypanoPoGorodu_Dzerzh'; _vp.value := IntToStr(NeZasypanoPoGorodu_Dzerzh); _enum.Add(_vp);
      _vp.name := 'More_NeZasypanoPoGorodu_Komintern'; _vp.value := IntToStr(NeZasypanoPoGorodu_Komintern); _enum.Add(_vp);
      _vp.name := 'More_NeZasypanoPoGorodu_Ordzhon'; _vp.value := IntToStr(NeZasypanoPoGorodu_Ordzhon); _enum.Add(_vp);

      _vp.name := 'More_NeZasypanoPoGorodu_Kiev'; _vp.value := IntToStr(NeZasypanoPoGorodu_Kiev); _enum.Add(_vp);
      _vp.name := 'More_NeZasypanoPoGorodu_Moskov'; _vp.value := IntToStr(NeZasypanoPoGorodu_Moskov); _enum.Add(_vp);
      _vp.name := 'More_NeZasypanoPoGorodu_Frunz'; _vp.value := IntToStr(NeZasypanoPoGorodu_Frunz); _enum.Add(_vp);
      _vp.name := 'More_NeZasypanoPoGorodu_Lenin'; _vp.value := IntToStr(NeZasypanoPoGorodu_Lenin); _enum.Add(_vp);
      _vp.name := 'More_NeZasypanoPoGorodu_Oktjabr'; _vp.value := IntToStr(NeZasypanoPoGorodu_Oktjabr); _enum.Add(_vp);

      _vp.name := 'More_NeZasypanoPoGorodu_Chervon'; _vp.value := IntToStr(NeZasypanoPoGorodu_Chervon); _enum.Add(_vp);
      //
      _vp.name := 'More_UstanovlenoLukov'; _vp.value := IntToStr(UstanovlenoLukov); _enum.Add(_vp);
      _vp.name := 'More_UstanovlenoGidrantov'; _vp.value := IntToStr(UstanovlenoGidrantov); _enum.Add(_vp);
      _vp.name := 'More_CountGet062'; _vp.value := IntToStr(CountGet062); _enum.Add(_vp);
      _vp.name := 'More_CountClose062'; _vp.value := IntToStr(CountClose062); _enum.Add(_vp);

      _vp.name := 'More_CountLeft062'; _vp.value := IntToStr(CountLeft062); _enum.Add(_vp);
    end;
      _vp.name := 'OrderComingCount'; _vp.value := IntToStr((F_DM as Tdm_SvodkaGik).OrderComingCount); _enum.Add(_vp);
      _vp.name := 'ClosedOrderCount'; _vp.value := IntToStr((F_DM as Tdm_SvodkaGik).ClosedOrderCount); _enum.Add(_vp);
     // _vp.name := 'NotClosedOrderCount'; _vp.value := '0'; _enum.Add(_vp);

    //
    _da.Write(_enum, 'dt_' + DateToStr(F_DT-1));
    _da := nil;
    _enum := nil;
  except
    on E:Exception do
      raise Exception.Create('Ошибка при сохранении в файл '#13 + _filename +#13 +
        ' для программы "Старший сменный"' + #13 + E.Message);
  end;
end;




procedure TSaveSTDisp.CreateForms;
begin
  F_DM:= Tdm_SvodkaGik.Create(nil);
  //F_PreviewFrm.PreviewButtons:=F_PreviewFrm.PreviewButtons+[pbText];
end;

procedure TSaveSTDisp.InitFields;
begin
 F_DT:=NOW();
end;

function TSaveSTDisp.Excute:boolean;
var f:boolean;
begin
 Result:=false;
 (F_DM as Tdm_SvodkaGik).IsForGen := false;
 begin
      F_Pind.Caption:='Данные для сводной ведомости';
      F_Pind.Show;

      (F_DM as Tdm_SvodkaGik).Dt := Date()-1;
      (F_DM as Tdm_SvodkaGik).IsEquipPrint := false;
      (F_DM as Tdm_SvodkaGik).IsShiftNumberUchit := false;
      (F_DM as Tdm_SvodkaGik).IsForGen := false;
      try
        f:=(F_DM as Tdm_SvodkaGik).Simple_PrepareDsets;
      finally
        F_Pind.Hide;
       end;
      //Сохраним данные для программы старший сменный
      if f then
      SaveDataForStDisp(AppSettings.Get_GIK_Path+'st-disp.xml');
  end;

  Result:=true;

end;



end.
