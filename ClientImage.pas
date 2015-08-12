unit ClientImage;

interface

uses
  SysUtils, Classes, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient ,Helpfunctions,HelpClasses, ApplicationSettings;

 const normal_ready=1;
       normal_finish=2;
       file_not_found=0;
       Other_error=-1;
      Str_net_Error='Сетевая ошибка в процессе соединения: ' ;
      Str_netInProc_Error='Сервис был отключен, когда была попытка соединения:';
      Str_other_error='Неизвесная ошибка в процессе соединения: ';

type

  Tdm_ClientImage = class(TDataModule)
    IdTCPClient: TIdTCPClient;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
     F_Connected:boolean;
     ShowMessage:TProce;
    procedure ReadIni();
  public
    { Public declarations }
   property P_ShowMessage:TProce write ShowMessage;
   function Connect():boolean;
   function LoadPicter(filename: string; year,order_number :integer; fname:string; var i_code:integer):boolean;
   function SavePicture(filename: string; year,order_number:integer; var fname:string):boolean;
   function DelPicter(year,order_number:integer;fname:string):boolean;
   property Connected :boolean read F_Connected;
     end;

var
  dm_ClientImage: Tdm_ClientImage;

implementation

{$R *.dfm}
uses  HTTPApp, IdException;
procedure Tdm_ClientImage.ReadIni;
var port:integer;
    host:string;
begin
try
  AppSettings.Get_ImageClient( port,host);
 IdTCPClient.Port:=port;
 IdTCPClient.Host:=host;
 except
  raise;
 end;
end;

procedure Tdm_ClientImage.DataModuleCreate(Sender: TObject);
begin
 F_Connected:=false;

end;


function Tdm_ClientImage.Connect():boolean;
begin
result:=false;
 try
   readIni;
   IdTCPClient.Connect();
   F_Connected:=true;
   result:=true;
 except
 on E: EIdConnClosedGracefully  do begin
  ShowMessage(Str_netInProc_Error + E.Message);
  F_Connected:=false;
 end;
 on E: EIdException do begin
  ShowMessage(Str_net_Error + E.Message);
  F_Connected:=false;
 end;
  on E: Exception do begin
    ShowMessage( Str_other_error+ E.Message);
  end;
 end;
end;

function Tdm_ClientImage.LoadPicter(filename :string;year,order_number :integer; fname:string; var i_code:integer):boolean;
var stream:TStream;
    Fstream:TfileStream;

begin
result:=false;
filename:=filename;
 try
  if not  F_Connected then
     Connect;
  except
  exit;
  end;
if F_connected then
begin
  try
    IdTCPClient.WriteLn('GetImage'+#32+IntToStr(year)+#32+IntToStr(order_number)+#32+fname);
    i_code:=IdTCPClient.ReadInteger;//([-1,0,1,2]);
    stream:=TmemoryStream.Create;
    try
    if   i_code=normal_ready then
    begin
      IdTCPClient.ReadStream(stream);
      i_code:=IdTCPClient.ReadInteger;//([-1,0,1,2]);
      if i_code=normal_finish then
      begin
      fstream:=TFileStream.Create(filename,fmCreate);
      try
       stream.Position:=0;
       fstream.CopyFrom(stream,stream.size);
       result:=true;
      finally
       fstream.Free;
      end;
     end;
    end
    else
     result:=false;
    finally
      stream.Free;
    end;
  except
  on E: EIdConnClosedGracefully do begin
    ShowMessage(Str_netInProc_error + E.Message);
    F_Connected:=false;
 end;
  on E: EIdException do begin
      ShowMessage(Str_net_Error+ E.Message);
      F_Connected:=false;
  end;
  on E: Exception do begin
      ShowMessage(Str_other_error + E.Message);
  end;
  end;
end;
end;

function Tdm_ClientImage.SavePicture(filename: string; year,order_number:integer; var fname:string):boolean;
var
    Fstream:TFileStream;
    i_code:integer;
begin
  result:=false;
  try
  if not  F_Connected then
     Connect;
  except
  exit;
  end;
  if F_Connected then
  begin
    FStream:=TFileStream.Create(filename,fmOpenRead);
    try
    try
     IdTCPClient.writeln('SaveImage'+#32+IntTostr(year)+#32+IntTOStr(order_number));
     i_code:=IdTCPClient.ReadInteger;{.GetResponseReadInteger;//([-1,0,1,2]);}

     if  i_code=normal_ready then
      begin
       FStream.Position:=0;
       IdTCPClient.WriteStream(Fstream,true,true,FStream.Size);
       fname:=IdTCPClient.ReadLn;
       i_code:=IdTCPClient.ReadInteger;//.GetResponse([-1,0,1,2]);
       if i_code=normal_finish then
        result:=true;
      end
    except
    on  E: EIdConnClosedGracefully do begin
      ShowMessage(Str_netInProc_Error + E.Message);
      F_Connected:=false;
    end;
    on E: EIdException do begin
      ShowMessage(Str_net_Error + E.Message);
      F_Connected:=false;
    end;
    on E: Exception do begin
      ShowMessage(Str_Other_error + E.Message);
    end
   end;
   finally
     FStream.Free;
   end;
  end;
end;


function Tdm_ClientImage.DelPicter(year,order_number:integer;fname:string):boolean;
  var i_code:integer;
begin
  result:=false;
  try
  if not  F_Connected then
     Connect;
  except
  exit;
  end;
  if F_Connected then
  begin
    try
       IdTCPClient.WriteLn('DelImage'+#32+InttOStr(year)+#32+IntToStr(order_number)+#32+fname);
       i_code:=IdTCPClient.ReadInteger;//([-1,0,1,2]);
        if i_code=normal_finish then
          result:=true;



    except
    on  E: EIdConnClosedGracefully do begin
      ShowMessage(Str_netInProc_error+ E.Message);
      F_Connected:=false;
    end;
    on E: EIdException do begin
      ShowMessage(Str_net_error + E.Message);
      F_Connected:=false;
    end;
    on E: Exception do begin
      ShowMessage(Str_other_error + E.Message);
    end
    end;
  end;
end;

end.
