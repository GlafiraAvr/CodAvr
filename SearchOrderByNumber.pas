unit SearchOrderByNumber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, DB, IBCustomDataSet, DateUtils,
  Buttons, ExtCtrls, IBDatabase, RxLookup;

type
  Tfrm_SearchOrderByNumber = class(TForm)
    sp_Year: TSpinEdit;
    sp_OrderNumber: TSpinEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    dset_tmp: TIBDataSet;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    VDS_NS_Group: TRadioGroup;
    dbl_District: TRxDBLookupCombo;
    tran: TIBTransaction;
    dset_district: TIBDataSet;
    ds_district: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure VDS_NS_GroupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses DModule, OrderForm, StringConsts,OrderForm_vds;

{$R *.dfm}

procedure Tfrm_SearchOrderByNumber.FormShow(Sender: TObject);
begin
  sp_OrderNumber.Text:='1';
  sp_Year.Text:=IntToStr(YearOf(Date));
  FocusControl(sp_OrderNumber);
  VDS_NS_Group.ItemIndex:=0;
  sp_orderNumber.Width:=sp_Year.Width;
  dbl_District.Visible:=false;
   dbl_District.Value:='1';
  dset_district.Open;


end;

procedure Tfrm_SearchOrderByNumber.btn_okClick(Sender: TObject);
var
  frm_Order: Tfrm_order;

  frm_order_vds:Tfrm_order_vds;

  OrderNumber, OrderID: integer;
  _BegDt, _EndDt: TDateTime;
  SQL: string;
begin
  try
    _BegDt := StrToDate( '01.01.'+trim( sp_Year.Text ) ) ;
    _EndDt := StrToDate( '31.12.'+trim( sp_Year.Text ) );
  except
    Application.MessageBox( 'Ќеверно задан год!', gc_strDispAVR, MB_OK + MB_ICONERROR );
    exit;
  end;

  OrderNumber:=StrToInt(sp_OrderNumber.Text);

  if dset_tmp.Transaction.InTransaction then
    dset_tmp.Transaction.Rollback;
  dset_tmp.Transaction.StartTransaction;

  if VDS_NS_Group.ItemIndex=0 then
  begin
   try
     MyOpenSQL(dset_tmp,
       Format( ' select ID from orders' +
               ' where cast(DateComing as Date)>= ''%s'' and DateComing <= ''%s''' +
               ' and OrderNumber =%d ',[ DateToStr( _BegDt ), DateToStr( _EndDt + 1),
                OrderNumber] ) );

     if dset_tmp.Eof and dset_tmp.Bof then
     begin
       Application.MessageBox('Ќар€д с указанным номером и годом не существует',
                              gc_strDispAVR, MB_OK+MB_ICONERROR);
       sp_OrderNumber.Text:='1';
       ActiveControl:=sp_OrderNumber;
       exit;
     end;

     OrderID:=dset_tmp.FieldByName('ID').AsInteger;
   finally
    dset_tmp.Transaction.Commit;
   end;

   frm_Order:=Tfrm_Order.Create(self, OrderID);
   try
     frm_Order.ShowModal;
   finally
     frm_Order.Free;
   end;
  end
  else
  begin
   try

     MyOpenSQL(dset_tmp,
       Format( ' select ID from orders_vds' +
               ' where cast(DateComing as Date)>= ''%s'' and DateComing <= ''%s''' +
               ' and OrderNumber =%d '+
               'and fk_orders_district=%d',[ DateToStr( _BegDt ), DateToStr( _EndDt + 1),
                OrderNumber,dset_district.FieldByName('id').AsInteger] ) );

     if dset_tmp.Eof and dset_tmp.Bof then
     begin
       Application.MessageBox('Ќар€д с указанным номером и годом не существует',
                              gc_strDispAVR, MB_OK+MB_ICONERROR);
       sp_OrderNumber.Text:='1';
       ActiveControl:=sp_OrderNumber;
       exit;
     end;

     OrderID:=dset_tmp.FieldByName('ID').AsInteger;
   finally
    dset_tmp.Transaction.Commit;
   end;

   frm_Order_vds:=Tfrm_Order_vds.Create(self, OrderID);
   try
     frm_Order_vds.ShowModal;
   finally
     frm_Order_vds.Free;
   end;

  end;
  sp_OrderNumber.Text:='1';
  ActiveControl:=sp_OrderNumber;
end;

procedure Tfrm_SearchOrderByNumber.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_SearchOrderByNumber.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then
  begin
    SelectNext(ActiveControl, true, true);
  end;
end;

procedure Tfrm_SearchOrderByNumber.VDS_NS_GroupClick(Sender: TObject);
begin
if  VDS_NS_Group.ItemIndex=0 then
 begin
     sp_orderNumber.Width:=sp_Year.Width;
     dbl_District.Visible:=false;
  end
else
     sp_orderNumber.Width:=81;
     dbl_District.Visible:=true;

end;

end.

