unit SysInfo;

interface

uses
  Windows, SysUtils, Classes{, Controls, ComCtrls};

const
  MAX_ADAPTER_NAME_LENGTH        = 256;
  MAX_ADAPTER_DESCRIPTION_LENGTH = 128;
  MAX_ADAPTER_ADDRESS_LENGTH     = 8;
  IPHelper = 'iphlpapi.dll';

  // Типы адаптеров
  MIB_IF_TYPE_OTHER     = 1;
  MIB_IF_TYPE_ETHERNET  = 6;
  MIB_IF_TYPE_TOKENRING = 9;
  MIB_IF_TYPE_FDDI      = 15;
  MIB_IF_TYPE_PPP       = 23;
  MIB_IF_TYPE_LOOPBACK  = 24;
  MIB_IF_TYPE_SLIP      = 28;

type
  // Структуры для выполнения GetAdaptersInfo
  time_t = Longint;

  IP_ADDRESS_STRING = record
    S: array [0..15] of Char;
  end;
  IP_MASK_STRING = IP_ADDRESS_STRING;
  PIP_MASK_STRING = ^IP_MASK_STRING;

  PIP_ADDR_STRING = ^IP_ADDR_STRING;
  IP_ADDR_STRING = record
    Next: PIP_ADDR_STRING;
    IpAddress: IP_ADDRESS_STRING;
    IpMask: IP_MASK_STRING;
    Context: DWORD;
  end;

  PIP_ADAPTER_INFO = ^IP_ADAPTER_INFO;
  IP_ADAPTER_INFO = record
    Next: PIP_ADAPTER_INFO;
    ComboIndex: DWORD;
    AdapterName: array [0..MAX_ADAPTER_NAME_LENGTH + 3] of Char;
    Description: array [0..MAX_ADAPTER_DESCRIPTION_LENGTH + 3] of Char;
    AddressLength: UINT;
    Address: array [0..MAX_ADAPTER_ADDRESS_LENGTH - 1] of BYTE;
    Index: DWORD;
    Type_: UINT;
    DhcpEnabled: UINT;
    CurrentIpAddress: PIP_ADDR_STRING;
    IpAddressList: IP_ADDR_STRING;
    GatewayList: IP_ADDR_STRING;
    DhcpServer: IP_ADDR_STRING;
    HaveWins: BOOL;
    PrimaryWinsServer: IP_ADDR_STRING;
    SecondaryWinsServer: IP_ADDR_STRING;
    LeaseObtained: time_t;
    LeaseExpires: time_t;
  end;

  function  MACToStr(Addr: array of Byte; Len: Integer): String;
  function  TimeToDateTimeStr(Value: Integer): String;
  procedure getfindmac(var ListMac:TStringList; var ListIP:TStringList);

  // При помощи данной функции мы определим наличие сетевых интерфейсов
  // на локальном компьютере и информацию о них
  function GetAdaptersInfo(pAdapterInfo: PIP_ADAPTER_INFO;
    var pOutBufLen: ULONG): DWORD; stdcall; external IPHelper;

implementation

function MACToStr(Addr: array of Byte; Len: Integer): String;
var
  I: Integer;
begin
  if Len = 0 then Result := '00-00-00-00-00-00' else
  begin
    Result := '';
    for I := 0 to Len - 2 do
      Result := Result + IntToHex(Addr[I], 2) + '-';
    Result := Result + IntToHex(Addr[Len - 1], 2);
  end;
  Result :=AnsiUpperCase(Result);
end;

function TimeToDateTimeStr(Value: Integer): String;
const
  UnixDateDelta = 25569; // количество дней между 12.31.1899 и 1.1.1970
  MinPerDay = 24 * 60;
  SecPerDay = 24 * 60 * 60;
var
  Data: TDateTime;
  TimeZoneInformation: TTimeZoneInformation;
  AResult: DWORD;
begin
  Result := '';
  if Value = 0 then Exit;

  // Формат Unix-ового TIME_T кол-во секунд от 1.1.1970
  Data := UnixDateDelta + (Value / SecPerDay);
  AResult := GetTimeZoneInformation(TimeZoneInformation);
  case AResult of
    TIME_ZONE_ID_INVALID: RaiseLastOSError;
    TIME_ZONE_ID_STANDARD:
    begin
      Data := Data - ((TimeZoneInformation.Bias +
        TimeZoneInformation.StandardBias) / MinPerDay);
      Result := DateTimeToStr(Data) + ' ' +
        WideCharToString(TimeZoneInformation.StandardName);
    end;
  else
    Data := Data - ((TimeZoneInformation.Bias +
      TimeZoneInformation.DaylightBias) / MinPerDay);
    Result := DateTimeToStr(Data) + ' ' +
      WideCharToString(TimeZoneInformation.DaylightName);
  end;
end;

procedure getfindmac(var ListMac:TStringList; var ListIP:TStringList);
var
  InterfaceInfo, TmpPointer: PIP_ADAPTER_INFO;
  Len: ULONG;
begin
  // Смотрим сколько памяти нам требуется?
  if GetAdaptersInfo(nil, Len) = ERROR_BUFFER_OVERFLOW then
  begin
    // Берем нужное кол-во
    GetMem(InterfaceInfo, Len);
    try
      if GetAdaptersInfo(InterfaceInfo, Len) = ERROR_SUCCESS then
      begin
        // Перечисляем все сетевые интерфейсы
        TmpPointer := InterfaceInfo;
        repeat
          if TmpPointer^.Type_=MIB_IF_TYPE_ETHERNET then
          begin
            ListMac.Add(MACToStr(TmpPointer^.Address, TmpPointer^.AddressLength));
            ListIP.Add(TmpPointer^.IpAddressList.IpAddress.S);
          end;
          // Переходим к следующему сетевому адаптеру
          TmpPointer:=TmpPointer.Next;
        until TmpPointer = nil;
      end;
    finally
      // Освобождаем занятую память
      FreeMem(InterfaceInfo);
    end;
  end;
end;

end.
