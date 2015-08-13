unit Order1562Manager;

interface
uses OrderNG1562Form, OrderNG1562DModule, Controls, GridViewBuilder;

type

  TOrder1562Manager=class
  private
    F_OrderDM: Tdm_OrderNG1562;
    F_OrderForm: Tfrm_OrderNG1562;
    F_GVB: TGridViewBuilder;
    //

    procedure InterceptFormHandler;
    procedure PrepareResForm;
  private
    procedure OnBtnSaveClick(Sender: TObject);
    procedure OnBtnLinkClick(Sender: TObject);
    procedure OnBtnInWorkClick(Sender: TObject);
    procedure OnBtnCancelClick(Sender: TObject);
    procedure OnBtn_OrderClick(Sender: TObject);
    procedure OnBtn_NewOrderClick(Sender: TObject);
    procedure FillOrderGrid;
    procedure EmptyProc(Sender: TObject);
    procedure OnCtrlChange(Sender: TObject);
    procedure RefreshAVROrders;

    procedure BuildResultGridView;
    procedure PrepareResultFormGrid;
    procedure OnDamageTypeCellShow(ShowValue: variant; var Res: string);
    procedure OnDiamCellShow(ShowValue: variant; var Res: string);
  public
    constructor Create;
    destructor Destroy; override;

    procedure ShowOrder(_OrderID: integer);
  end;

implementation

uses NGReports, OrderForm, Forms, Graphics, HelpFunctions, Aligrid, SysUtils;

{ TOrderManager }

constructor TOrder1562Manager.Create;
begin
  inherited Create;
  //
  F_OrderDM := Tdm_OrderNG1562.Create(nil);
  F_OrderForm := Tfrm_OrderNG1562.Create(Application);
  //
  InterceptFormHandler;
end;

procedure TOrder1562Manager.PrepareResForm;
begin
//

end;

destructor TOrder1562Manager.Destroy;
begin
  F_OrderForm.Free;
  F_OrderDM.Free;

  inherited Destroy;
end;

procedure TOrder1562Manager.InterceptFormHandler;
begin
  F_OrderForm.btn_Save.OnClick := OnBtnSaveClick;
  F_OrderForm.btn_NewOrder.OnClick := OnBtn_NewOrderClick;
  F_OrderForm.btn_Order.OnClick := OnBtn_OrderClick;
  F_OrderForm.btnCancel.OnClick := OnBtnCancelClick;
  F_OrderForm.btnLink.OnClick := OnBtnLinkClick;
  F_OrderForm.btnInWork.OnClick := OnBtnInWorkClick;


end;

procedure TOrder1562Manager.OnBtnSaveClick(Sender: TObject);
begin
  if F_OrderDM.SaveAll then F_OrderForm.AfterSave;
end;

procedure TOrder1562Manager.OnBtnLinkClick(Sender: TObject);
begin
 F_OrderDM.LinkOrder;
end;

procedure TOrder1562Manager.OnBtnInWorkClick(Sender: TObject);
begin
 F_OrderDM.InWorkOrder;
end;

procedure TOrder1562Manager.OnBtnCancelClick(Sender: TObject);
begin
 F_OrderDM.CancelAll;
end;

procedure TOrder1562Manager.OnBtn_OrderClick(Sender: TObject);
var
  _OrderID: integer;
  _frm_Order: Tfrm_Order;
begin
  with F_OrderForm do
  begin
    try
      if Assigned( Grid.Objects[0, Grid.Row] ) then
      begin
        _OrderID := integer(Grid.Objects[0, Grid.Row]);
        _frm_Order := Tfrm_Order.Create( nil, _OrderID );
        try
          _frm_Order.ShowModal;
          if _frm_Order.IsCtrlChange then
            Grid.RowFont[ Grid.Row ].Color := clRed;
        finally
          _frm_Order.Free;
        end;
      end;
    except
      raise;
    end;
  end;
end;

procedure TOrder1562Manager.OnBtn_NewOrderClick(Sender: TObject);
var
  frm_Order: Tfrm_Order;
begin
    frm_Order:=Tfrm_Order.Create(Application); //Новый наряд
    try
      frm_Order.ShowModal;
    finally
      frm_Order.Free;
    end;
   RefreshAVROrders;
end;

procedure TOrder1562Manager.EmptyProc(Sender: TObject);
begin
    // это пустая процедура-заглушка :)
end;

procedure TOrder1562Manager.OnCtrlChange(Sender: TObject);
begin
    //
   F_OrderDM.OnChangeManualy((Sender as TControl).Tag);
   F_OrderForm.btn_Save.Enabled := true;
end;

procedure TOrder1562Manager.ShowOrder(_OrderID: integer);
begin
 try
  F_GVB:=TGridViewBuilder.Create(F_OrderDM.AVROrdersDset, F_OrderForm.Grid);
  F_OrderForm.OnCtrlChange:= EmptyProc;
  F_OrderDM.InitDataRec( _OrderID );

  PrepareResultFormGrid;
//  FillOrderGrid;

  F_OrderForm.OnCtrlChange:= OnCtrlChange;
  F_OrderForm.ShowModal;
  finally
    F_GVB.Free;
  end;
end;

procedure TOrder1562Manager.RefreshAVROrders;
begin
    // надо добавить условия выборки нарядов в зависимости от контролов формы

    F_OrderDM.FillAVROrders;

end;

procedure TOrder1562Manager.FillOrderGrid;
var
  _RegionID, _ID1562, Order_ID, i, _row: integer;
  _IsExecuteOk: boolean;
  F_SearchOrders: TSearchForOrdersFromOtherClasses;
begin
    try
     { if Assigned( Grid.Objects[0, Grid.Row] ) then
      begin
        _ID1562 := integer(Grid.Objects[0, Grid.Row]);
        _Datatime:= Grid.CellsAsDate[2, Grid.Row];
        F_SearchOrders := TSearchForOrdersFromOtherClasses.Create;
        F_SearchOrders.ShowAll := true;
        F_SearchOrders.Condition := ' where datecoming >= ''' +
                      DateTimeToStr(_Datatime)+''' and datecoming < '''+
                      DateTimeToStr(_Datatime + 1)+'''';
      }
        try
           _IsExecuteOk:= F_SearchOrders.Execute;
        finally
          F_SearchOrders.Free;
        end;
      //end;
    except
      raise;
    end;
end;

procedure TOrder1562Manager.BuildResultGridView;
var
  _ColorColNumber: integer;
begin
  F_GVB.BuildGridView;

  case F_OrderDM.SortType of
    stOrderNumberAndDatecoming: _ColorColNumber:=2;
    stRegions: _ColorColNumber:=4;
    stAdres: _ColorColNumber:=5;
  end;
  F_OrderForm.Grid.ColorCell[_ColorColNumber, 0]:=clwhite;
end;


procedure TOrder1562Manager.PrepareResultFormGrid;
begin
  with F_GVB do
  begin
    IDFieldName:='ID';
    HelpIDFieldName:='PTR_ADD_INFO';
    IsNumberRecord:=true;

    AddColToGVB(F_GVB, 'OrderNumber', '^ №'+#13+'наряда', alCenter);
    AddColToGVB(F_GVB, 'DateComing', 'Дата'+#13+'поступления', alCenter);
    AddColToGVB(F_GVB, 'Regions', '^Район', alLeft);
    AddColToGVB(F_GVB, 'Adres', '^Адрес', alLeft);
    AddColToGVB(F_GVB, 'DamageType', 'Вид'+#13+'повреждения', alLeft, OnDamageTypeCellShow);
    AddColToGVB(F_GVB, 'DamagePlace', 'Место'+#13+'повреждения', alLeft);
    AddColToGVB(F_GVB, 'Diameter', 'Диаметер', alCenter, OnDiamCellShow);
//    AddColToGVB(F_GVB, 'FlowSpeed', 'Утечка в час,'+#13+'м3', alCenter, OnFlowSpeedCellShow);
    AddColToGVB(F_GVB, 'DateClosed', 'Дата'+#13+'закрытия', alCenter);
  end;

  BuildResultGridView;
end;


procedure TOrder1562Manager.OnDamageTypeCellShow(ShowValue: variant;
  var Res: string);
begin
  if trim(AnsiUpperCase(VarToString(ShowValue)))='<ПУСТО>' then
    Res:='';
end;

procedure TOrder1562Manager.OnDiamCellShow(ShowValue: variant;
  var Res: string);
begin
  if VarToFloat(ShowValue)=0 then
    Res:='';
end;


end.
