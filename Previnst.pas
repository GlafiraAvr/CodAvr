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
  hMutex := CreateMutex(nil, TRUE, 'disp_avr_ib'); // ������� �������
  if GetLastError <> 0 then
    IsRun := true; // ������ ������� ��� ������
  ReleaseMutex(hMutex);
end.

