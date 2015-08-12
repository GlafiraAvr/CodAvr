unit BaseOptionForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,DModule;

type
  Tfrm_BaseOption = class(TForm)
    procedure FormShow(Sender: TObject);
  private
  public
    constructor Create(AOwner: TComponent; Title: string='');
    function TestConnection:boolean;
  end;


implementation

{$R *.dfm}

{ Tfrm_BaseOption }

constructor Tfrm_BaseOption.Create(AOwner: TComponent; Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;

end;

function Tfrm_BaseOption.TestConnection:boolean;
begin
 result:=true;
 if not dm_Main.IBDatabase.TestConnected then
 begin
  try
   if  not dm_Main.ReconnectAll then
   begin
     result:=false;
   end
   except
     result:=false;
   end;
 end;

end;

procedure Tfrm_BaseOption.FormShow(Sender: TObject);
begin
  if not TestConnection then
  begin
   ShowMessage('Связь с базой потеряна!');


  end;
end;

end.
