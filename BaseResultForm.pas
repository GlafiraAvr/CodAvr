unit BaseResultForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  Tfrm_BaseResult = class(TForm)
  private
  public
    constructor Create(AOwner: TComponent; Title: string='');
    procedure StartWait; virtual;
    procedure StopWait; virtual;
  end;


implementation

{$R *.dfm}

{ Tfrm_BaseResult }

constructor Tfrm_BaseResult.Create(AOwner: TComponent; Title: string='');
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_BaseResult.StartWait;
begin
//
end;

procedure Tfrm_BaseResult.StopWait;
begin
//
end;

end.
