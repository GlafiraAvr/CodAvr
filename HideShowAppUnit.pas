unit HideShowAppUnit;

{
  модуль содержит класс, который может прятать/показывать полностью приложение
  со всеми окнами. Имя приложения задается именем исполняемого файла.
}

interface

uses Classes, Windows, TlHelp32, SysUtils;

type

  THideShowAppUnit = class
  private
    FFileName: string;
    FVisible: boolean;
    procedure FillListOfWindowsOfRunningThread( _file_name: string; _enum_only_visible: integer );
    function ProcessExists(const FileName: string; var _out_process_id: cardinal ): THandle;
    function GetThreadIDByParentProcessID( const _parent_process_id: cardinal ): cardinal;
    procedure _ShowHide( _show, _force: boolean );
  protected
  public
    constructor Create;
    destructor Destroy; override;
    //
    { собирает информацию о приложении и его окнах на текущий момент }
    procedure CollectInfo( _file_name: string );
    //
    procedure Show(_force: boolean);
    procedure Hide;
    //
    property Visible: boolean read FVisible; 
  end;

implementation

var
  _ListWindowsOfThread: TList;

function _EnumThreadWndProc(Window: HWnd; Data: Longint): Bool; stdcall;
begin
  if {(Window <> TaskActiveWindow) and }(IsWindowVisible(Window) or (Data=0)) {and
    IsWindowEnabled(Window)} then
  begin
    _ListWindowsOfThread.Add( pointer(window) );
  end;
  Result := True;
end;
  
{ THideShowAppUnit }

function THideShowAppUnit.GetThreadIDByParentProcessID( const _parent_process_id: cardinal ): cardinal;
var
 _h: THandle;
 _te: THREADENTRY32;
begin
  Result := 0;
  _h := CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0);
  if (_h<>0) then
    try
      _te.dwSize := SizeOf(_te);
      if Thread32First (_h, _te) then
      repeat
      if (_parent_process_id = _te.th32OwnerProcessID) then
      begin
        Result := _te.th32ThreadID;
        Break;
      end;
      until not Thread32Next(_h,_te);
    finally
     CloseHandle(_h);
    end;
end;

procedure THideShowAppUnit._ShowHide( _show, _force: boolean );
var
  _i: integer;
  _h, _app_h: THandle;
begin
    if ( _ListWindowsOfThread.Count>0 ) and ((FVisible<>_show) or (_force)) then
    begin
      FVisible := _show;
      //
      if _show then
      begin
        for _i := _ListWindowsOfThread.Count-1 downto 0 do
        begin
          _h := cardinal(_ListWindowsOfThread[_i]);
          ShowWindow( _h, SW_SHOW );
        end;
      end
        else
      begin
        for _i := 0 to _ListWindowsOfThread.Count-1 do
        begin
          _h := cardinal(_ListWindowsOfThread[_i]);
          ShowWindow( _h, SW_HIDE );
        end;
      end;
      //
      if _show then
      begin
        { сделаем активным апликешен }
        //_app_h := GetWindow(THandle(_ListWindowsOfThread[_ListWindowsOfThread.Count-1]), GW_OWNER);
        _app_h := THandle(_ListWindowsOfThread[_ListWindowsOfThread.Count-1]);
        SetActiveWindow( _app_h );
        { выбросим наверх аппликейшен всё }
        SetForegroundWindow( _app_h  );
        SetActiveWindow( _app_h );
        { выбросим наверх и сделаем активной самую младшенькую формочку }
        _h := THandle(_ListWindowsOfThread[0]);
        SetForegroundWindow( _h  );
        SetActiveWindow( _h );
      end;
    end;
end;
  
function THideShowAppUnit.ProcessExists(const FileName: string; var _out_process_id: cardinal ): THandle;
var
 h: THandle;
 pe: PROCESSENTRY32;
 s:string;
begin
 Result := 0;
 h := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
 if h<>0 then
 try
   pe.dwSize := SizeOf(pe);
   if Process32First(h, pe) then
   repeat
     s:=ExtractFileName(pe.szExeFile);
     if StrIComp(PChar(s), PChar(FileName)) = 0 then
     begin
       Result := OpenProcess(PROCESS_ALL_ACCESS, true, pe.th32ProcessID);
       _out_process_id := pe.th32ProcessID;
       Break;
     end;
   until not Process32Next(h,pe);
 finally
   CloseHandle(h);
 end;
end;

procedure THideShowAppUnit.FillListOfWindowsOfRunningThread( _file_name: string; _enum_only_visible: integer );
var
//  _i: integer;
//  _window_handle: THandle;
  _thread_id, _parent_process_id: cardinal;
//  _enum_ok: boolean;
begin
  _ListWindowsOfThread.Clear;
  if (ProcessExists( _file_name, _parent_process_id )<>0) then
  begin
    _thread_id := GetThreadIDByParentProcessID( _parent_process_id );
    if (_thread_id<>0) then
    begin
      {_enum_ok := }EnumThreadWindows( _thread_id, @_EnumThreadWndProc, _enum_only_visible );
    end;
  end;    
end;

procedure THideShowAppUnit.CollectInfo( _file_name: string );
begin
  FillListOfWindowsOfRunningThread( _file_name, 1 );
end;

procedure THideShowAppUnit.Show( _force: boolean );
begin
  _ShowHide( TRUE, _force )
end;

procedure THideShowAppUnit.Hide;
begin
  _ShowHide( FALSE, FALSE );
end;

constructor THideShowAppUnit.Create;
begin
  FFileName := '';
  { будем считать, что, на момент создания - жертва уже существует }
  FVisible := TRUE;
  _ListWindowsOfThread := TList.Create;
end;

destructor THideShowAppUnit.Destroy;
begin
  CollectInfo( FFileName );
  Show( TRUE );
  _ListWindowsOfThread.Clear;
  _ListWindowsOfThread.Free;
  inherited;
end;

end.
