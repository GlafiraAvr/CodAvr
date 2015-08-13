unit DepMatersFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DepChargeBaseFrame, DB, Grids, DBGridEh, MatersVocCacheDModule,
  StdCtrls, Mask, DBCtrls, RxLookup, DepMatersDModule, ExtCtrls;

type
  Tframe_DepMaters = class(Tframe_DepChargeBase)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbl_Maters: TRxDBLookupCombo;
    dbl_Diam: TRxDBLookupCombo;
    ed_Quantity: TDBEdit;
    ds_Maters: TDataSource;
    ds_Diam: TDataSource;
  private
  public
    function IsFieldsCorrect: boolean; override;
    procedure EnableFields( _value: boolean ); override;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tframe_DepMaters }

procedure Tframe_DepMaters.EnableFields(_value: boolean);
begin
  dbl_Maters.Enabled := _value;
  dbl_Diam.Enabled := _value;
  ed_Quantity.Enabled := _value;
  pnl_Fields.Visible := _value;
end;

function Tframe_DepMaters.IsFieldsCorrect: boolean;
begin
  Result := false;

  //if IsDBLEmpty( dbl_Maters ) then
  if trim( dbl_Maters.Text ) = '' then
  begin
    ShowMsg( 'Введите наименование материала' );
    dbl_Maters.SetFocus;
    exit;
  end;

  Result := true;
end;

end.
