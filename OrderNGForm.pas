unit OrderNGForm;

{
  Новая форма ввода наряда ( NG-new generation :) ).
  Решил разбить все на три части (логика, представление, данные).
  Кроме того, весь интерфейс решил реализовать через Фреймы в надежде
  на то, что это кардинально увеличит наглядность(возможно я наивен
  и использование фреймов явный перебор).
  Сама по себе форма не используется, вызывается только из OrderManager.
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
