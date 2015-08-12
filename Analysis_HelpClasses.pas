unit Analysis_HelpClasses;

interface

type
  TLeakDays_Reg=record
    RegName: string;
    DmgCount: array of integer;
    TotalDmgCount: integer;
  end;

  TPLeakDays_Reg=^TLeakDays_Reg;

  TShortAdres=record
    id_housetype: integer;
    id_street: integer;
    HouseNum: string[10];
  end;

  TPShortAdres=^TShortAdres;

implementation

end.
