unit BaseFrameOptionForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, VocItemSelBaseFrame;

type
  Tfrm_BaseFrameOption = class(Tfrm_BaseOption)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  protected
    F_SelFrameList: TList;
    procedure ResetSelFrames;
    procedure OnSelFrameChange(Sender: TObject); virtual;
  public
  end;

implementation

{$R *.dfm}

procedure Tfrm_BaseFrameOption.FormCreate(Sender: TObject);
var
  i: integer;
  _frame: Tframe_VocItemSelBase;
begin
  inherited;
  F_SelFrameList := TList.Create;
  for i:=0 to ControlCount-1 do
    if Controls[i] is Tframe_VocItemSelBase then
    begin
      _frame := Controls[i] as Tframe_VocItemSelBase;
      _frame.OnSelChange := OnSelFrameChange;
      F_SelFrameList.Add( _frame );
    end;
end;

procedure Tfrm_BaseFrameOption.FormDestroy(Sender: TObject);
begin
  inherited;
  F_SelFrameList.Free;
end;

procedure Tfrm_BaseFrameOption.OnSelFrameChange(Sender: TObject);
begin
//
end;

procedure Tfrm_BaseFrameOption.ResetSelFrames;
var
  i: integer;
begin
  for i:=0 to F_SelFrameList.Count-1 do
    Tframe_VocItemSelBase( F_SelFrameList.Items[i] ).Reset;
end;

end.
