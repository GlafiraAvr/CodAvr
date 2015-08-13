unit VocItemSelFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VocItemSelBaseFrame, ItemSelecter, kbmMemTable, StdCtrls,
  Buttons, DB;

type
  Tframe_VocItemSel = class(Tframe_VocItemSelBase)
    btn_sel: TBitBtn;
    mt_VocAttach: TkbmMemTable;
    procedure btn_selClick(Sender: TObject);
  private
    F_ItemSelecter: TItemSelecter;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ItemSelecter: TItemSelecter read F_ItemSelecter;
    procedure Reset; override;
  end;

implementation

uses GlobalVocCacheDModule;

{$R *.dfm}

{ Tframe_VocItemSel }

constructor Tframe_VocItemSel.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  F_ItemSelecter := TItemSelecter.Create;
  F_ItemSelecter.VocMemTable := mt_VocAttach;
end;

destructor Tframe_VocItemSel.Destroy;
begin
  F_ItemSelecter.Free;
  inherited Destroy;
end;

procedure Tframe_VocItemSel.btn_selClick(Sender: TObject);
begin
  F_ItemSelecter.ShowSelectForm;
  if Assigned(F_OnSelChange) then
    F_OnSelChange( self );
end;

procedure Tframe_VocItemSel.Reset;
begin
  F_ItemSelecter.Reset;
end;

end.
