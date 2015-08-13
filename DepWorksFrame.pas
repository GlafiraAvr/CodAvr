unit DepWorksFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DepChargeBaseFrame, WorksVocCacheDModule, StdCtrls, Mask,
  DBCtrls, RxLookup, DB, Grids, DBGridEh, ExtCtrls;

type
  Tframe_DepWorks = class(Tframe_DepChargeBase)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbl_Work: TRxDBLookupCombo;
    dbl_Diam: TRxDBLookupCombo;
    ed_Quantity: TDBEdit;
    ds_Works: TDataSource;
    ds_Diams: TDataSource;
    dbt_WorkTime: TDBText;
    Label4: TLabel;
  private
  public
    function IsFieldsCorrect: boolean; override;
    procedure EnableFields( _value: boolean ); override;
  end;

implementation

{$R *.dfm}

uses HelpFunctions;

{ Tframe_DepWorks }

procedure Tframe_DepWorks.EnableFields(_value: boolean);
begin
  dbl_Work.Enabled := _value;
  dbl_Diam.Enabled := _value;
  ed_Quantity.Enabled := _value;
  pnl_Fields.Visible := _value;
end;


function Tframe_DepWorks.IsFieldsCorrect: boolean;
var
  _s: string;
begin
  Result := false;

  //if IsDBLEmpty( dbl_Work ) then
  if trim( dbl_Work.Text ) = '' then
  begin
    ShowMsg( 'Введите наименование работы' );
    dbl_Work.SetFocus;
    exit;
  end;

  if ds_Main.DataSet.FieldByName( 'clcWORKTIME' ).AsFloat < 0 then
  begin
    _s :=
      'Невозможно сохранить данную запись, т.к. для' + #10#13 +
      'заданных значений работы и диаметра не найдено' + #10#13 +
      'соответствующего значения трудозатрат. Внесите' + #10#13 +
      'необходимое значение в справочник "Длительности работ".';
    Application.MessageBox( PChar( _s ), 'Ошибка при сохранении', MB_OK + MB_ICONWARNING );
    dbl_Diam.SetFocus;
    exit;
  end;


  Result := true;
end;

end.
