unit OptGreenSpring;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,DModule, BaseOptionForm, DB, StdCtrls, Mask, ToolEdit, RXDBCtrl,
  Buttons, DBCtrls, IBCustomDataSet;

type
  Tfrm_OptGreenSpring = class(Tfrm_BaseOption)
    dst: TIBDataSet;
    DataSource: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;
    btn_Ok: TBitBtn;
    btn_Cansel: TBitBtn;
    DBDateEdit1: TDBDateEdit;
    dstCURDATE: TDateField;
    dstCURYEAR: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_OptGreenSpring: Tfrm_OptGreenSpring;

implementation

{$R *.dfm}

end.
