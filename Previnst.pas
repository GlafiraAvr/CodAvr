unit Previnst;

interface

uses Windows;

var
  IsRun: boolean;

implementation

var
  hMutex: integer;
begin
  IsRun := false;
  hMutex := CreateMutex(nil, TRUE, 'disp_avr_ib'); // Создаем семафор
  if GetLastError <> 0 then
    IsRun := true; // Ошибка семафор уже создан
  ReleaseMutex(hMutex);
end.

