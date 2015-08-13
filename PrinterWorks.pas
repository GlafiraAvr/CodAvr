unit PrinterWorks;

interface

uses Grids, DBGrids, Chart, Forms,Printers, Windows, DBGridEh, DB, SysUtils;


type TPrintWorks = class(TObject)
private
    class function GenCellString(count:integer; cellval:AnsiSTring):AnsiString;
public

    class procedure PrintChartData(Chart:TChart; frm:TForm);
end;

implementation

uses PrintPreviewChartForm;


//печатает данные грида, выведя перед этим строку
class function TPrintWorks.GenCellString(count:integer; cellval:AnsiSTring):AnsiString;
var str:AnsiSTring;
    hcount:integer;
    k:integer;
begin
      count := count - Length(cellval);

      str:= '|';
      hcount := trunc(count/2);
      if hcount > 0 then
      for k:= 1 to hcount do
      begin
        str := str + ' ';
      end;

      str := str + cellval;

      if count >= hcount +1 then
      for k:= hcount + 1 to count do
      begin
        str := str + ' ';
      end;
      str := str + '|';

      GenCellString := str;
end;



class procedure TPrintWorks.PrintChartData(Chart:TChart; frm:TForm);
var
  PrintPreviewChartFrm: TPrintPreviewChartFrm;
begin
  PrintPreviewChartFrm := TPrintPreviewChartFrm.Create(frm);
  PrintPreviewChartFrm.Chart := chart;
  PrintPreviewChartFrm.ShowModal();
  PrintPreviewChartFrm.Free();
end;


end.
