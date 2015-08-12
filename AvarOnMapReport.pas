unit AvarOnMapReport;

interface

uses SysUtils, Forms, Windows, NGBaseReport, AvarOnMapReportDModule;

type
  TAvarOnMapReport=class(TNGBaseReport)
  private
    F_DM: Tdm_AvarOnMapReport;
  private
    F_OrderID: integer;
    F_SSPath_1, F_SSPath_2: string;
    F_IsNeedScreenShots: boolean;
    procedure MakeScreenShotFromMap;
    procedure BuildScreenShotPathes;
    procedure SetOrderID(const Value: integer);
  protected
    procedure InitFields; override;
    procedure CreateForms; override;
    procedure PrepareFastReport; override;
  public
    property OrderID: integer read F_OrderID write SetOrderID;
    property IsNeedScreenShots: boolean read F_IsNeedScreenShots
      write F_IsNeedScreenShots;
    function Execute: boolean; override;
  end;


implementation

uses AomComClientDModule, FR_Class;

{ TAvarOnMapReport }

procedure TAvarOnMapReport.BuildScreenShotPathes;
var
  _s: string;
begin
  _s := ExtractFilePath( ParamStr( 0 ) ) + 'TEMP\';
  if not DirectoryExists( _s ) then CreateDir( _s );
  _s := _s + IntToStr( F_OrderID ) + '%s.bmp';

  F_SSPath_1 := Format( _s, ['_'] );
  F_SSPath_2 := Format(_s, ['_more']);
end;

procedure TAvarOnMapReport.CreateForms;
begin
  F_DM:=CreateDataModule(Tdm_AvarOnMapReport) as Tdm_AvarOnMapReport;
end;

function TAvarOnMapReport.Execute: boolean;
begin
  F_DM.StartTransaction;
  try
    F_DM.PrepareDsets;

    {Если нужно - делаем скриншот}
    if F_IsNeedScreenShots then
    begin
      BuildScreenShotPathes;
      if FileExists( F_SSPath_1 ) and FileExists( F_SSPath_2 ) then
      begin
        if Application.MessageBox(PChar('Отчет для печати уже был сформирован ранее.'#13+
          'Использовать его? Если нет - отчет сформируется заново'),'Печать наряда',
          MB_YESNO or MB_ICONQUESTION) <> ID_YES then
          MakeScreenShotFromMap;
      end else MakeScreenShotFromMap;
    end;
    {/Если нужно - делаем скриншот}

    PrepareAndPrintFR( F_DM.frReport );
  finally
    F_DM.StopTransaction;
  end;
end;

procedure TAvarOnMapReport.InitFields;
begin
  F_Name:='Аварии на карте';
  F_ReportFileName:='AvarOnMapReport.frf';
  F_IsNeedScreenShots := false;
end;

procedure TAvarOnMapReport.MakeScreenShotFromMap;
begin
  with dm_AomComClient.ScreenShotParamsRec do
  begin
    id_avar := F_DM.AvarOnMapID;


    show_StreetName := TRUE;
    {show_kolodZadv := FALSE;
    show_povrezhdUchast := FALSE;
    show_perekrytUchast := FALSE;
    show_oporozhnUchast := FALSE;
    }

    screenshot_count := 2;

    screenShotSaveParams[0].scale := 400;
    screenShotSaveParams[0].width := 700;
    screenShotSaveParams[0].height := 425;
    screenShotSaveParams[0].pathToFileName := F_SSPath_1;
    //
    screenShotSaveParams[1].scale := 5000;
    screenShotSaveParams[1].width := 700;
    screenShotSaveParams[1].height := 425;
    screenShotSaveParams[1].pathToFileName := F_SSPath_2;
  end;
  dm_AomComClient.ScreenShotFromMap;
end;

procedure TAvarOnMapReport.PrepareFastReport;
var
  _frPic1, _frPic2: TfrPictureView;
begin
  {Если нужно - загружаем картинки}
  if F_IsNeedScreenShots then
  begin
    _frPic1 := ( F_DM.frReport.FindObject( 'Picture1' ) as  TfrPictureView );
    _frPic2 := ( F_DM.frReport.FindObject( 'Picture3' ) as  TfrPictureView );
    try
      _frPic1.Picture.LoadFromFile( F_SSPath_1 );
      _frPic2.Picture.LoadFromFile( F_SSPath_2 );
    except
      //
    end;
  end;
  {/Если нужно - загружаем картинки}

  frVariables['Works'] := F_DM.Works;
  frVariables['CDP_Bolts'] := F_DM.CDPBolts;
  frVariables['BeginWork'] := F_DM.BeginWork;
  frVariables['EndWork'] := F_DM.EndWork;
  frVariables['LastBrig'] := F_DM.LastBrig;
end;

procedure TAvarOnMapReport.SetOrderID(const Value: integer);
begin
  F_OrderID := Value;
  F_DM.OrderID := Value;
end;

end.
