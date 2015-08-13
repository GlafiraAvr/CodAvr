unit VocBWorkAddMaterForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, RxLookup, ExtCtrls, DB;

type
  Tfrm_VocBWorkAddMater = class(TForm)
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    dbl_Mater: TRxDBLookupCombo;
    dbl_Diam: TRxDBLookupCombo;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    ds_Mater: TDataSource;
    ds_Diam: TDataSource;
    procedure btn_exitClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
  end;

  
implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tfrm_VocBWorkAddMater.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_VocBWorkAddMater.btn_okClick(Sender: TObject);
begin
  if IsDblEmpty( dbl_Mater ) then
  begin
    Application.MessageBox( 'Выберите необходимое значение материала из списка!',
      'Внимание', MB_OK +MB_ICONWARNING );
  end else
    ModalResult := mrOk;
end;

procedure Tfrm_VocBWorkAddMater.FormShow(Sender: TObject);
begin
  ResetDBL( dbl_Mater );
  ResetDBL( dbl_Diam );
end;

end.
