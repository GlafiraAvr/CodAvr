unit OrderNGForm;

{
  ����� ����� ����� ������ ( NG-new generation :) ).
  ����� ������� ��� �� ��� ����� (������, �������������, ������).
  ����� ����, ���� ��������� ����� ����������� ����� ������ � �������
  �� ��, ��� ��� ����������� �������� �����������(�������� � ������
  � ������������� ������� ����� �������).
  ���� �� ���� ����� �� ������������, ���������� ������ �� OrderManager.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ControlFrame, InputFrame, RxDBLookupComboFrame,
  OutputFrame, LabelFrame, OrderVocCacheDModule, AddressFrame, DB,
  DateEditFrame, TimeMaskFrame, Buttons, EditFrame,
  ComboBoxFrame, RxSpinEditFrame, CheckBoxFrame, SecurityBaseForm, ExtCtrls;

type
  Tfrm_OrderNG = class(Tfrm_SecurityBase)
    gb_Top: TGroupBox;
    gb_Center: TGroupBox;
    gb_Bottom: TGroupBox;
    ButtonPanel: TPanel;
    btn_Save: TBitBtn;
  private
  public
  end;


implementation

{$R *.dfm}


end.
