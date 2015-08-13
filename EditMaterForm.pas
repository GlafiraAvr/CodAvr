unit EditMaterForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, RxLookup;

type
  Tfrm_EditMater = class(TForm)
    dbl_Mater: TRxDBLookupCombo;
    ed_Quantity: TDBEdit;
    dbl_Diam: TRxDBLookupCombo;
    Bevel1: TBevel;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    ds_DiamAtt: TDataSource;
    ds_Mater: TDataSource;
    ds_MaterAtt: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure btn_okClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

uses HelpFunctions;

procedure Tfrm_EditMater.btn_okClick(Sender: TObject);
begin
  if IsDblEmpty( dbl_Mater ) then
    Application.MessageBox( 'Выберите материал из списка', 'Внимание', MB_OK + MB_ICONWARNING )
  else
    if ed_Quantity.Text='' then
       Application.MessageBox( 'Введите количество', 'Внимание', MB_OK + MB_ICONWARNING )
    else
       ModalResult := mrOk;
end;

procedure Tfrm_EditMater.btn_exitClick(Sender: TObject);
begin
  Close;
end;



end.
