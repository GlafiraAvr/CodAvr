unit GlobalData;


interface

uses Graphics;

const
  g_ShiftStartTime = '08:00:00'; //вермя, начиная с которого необходима пересменка
  Old_Col = clWindow;
  New_Col = clLime;
  LatKeyboardLayout = $4090409;
  CyrKeyboardLayot = $4190419;
  DISP_CDP_POST_ID = 1;
  WORKKIND_RASKOP_ID = 1;

  WithoutExcav='Без земляных работ';
  startstrDateCreateReportrs='6:00:01';
  endrtstrDateCreateReportrs='06:40:00';
  RigionsMatchArray :array [1..9,1..2] of integer = ((8,1),(7,2),(1,3),(2,4),(5,5),(4,6),(6,7),(9,8),(3,9));
var
  g_IDOfficial:integer;

implementation

end.
