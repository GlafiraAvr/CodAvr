unit OrderManager;

interface
{
  Модуль служит для связи формы наряда, модуля данных и кеша справочников
  между собой. Содание объекта OrderManager эквивалентно созданию рабочего
  потока. В рамках которого единожды создается новый (актуальный на текущий момент)
  кеш справочников, который и используется для всех нарядов в рамках данного
  рабочего потока. Такая организация объясняется особенностью ввода нарядов
  и необходимостью увелечения производительности.
}
uses OrderNGForm, OrderNGDModule, OrderVocCacheDModule;

type
  TOrderManager=class
  private
    F_OrderDM: Tdm_OrderNG;
    F_VocCache: Tdm_OrderVocCache;
    F_OrderForm: Tfrm_OrderNG;
    //
    procedure InterceptFormHandler;
  private
    procedure OnBtnSaveClick(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;
    procedure ShowOrder(_OrderID: integer);
  end;

implementation

{ TOrderManager }

constructor TOrderManager.Create;
begin
  inherited Create;
  //
  F_VocCache := Tdm_OrderVocCache.Create(nil);
  F_OrderDM := Tdm_OrderNG.Create(nil);
  F_OrderForm := Tfrm_OrderNG.Create(nil);
  //
  F_VocCache.ReopenVocDsets;
  InterceptFormHandler;
end;

destructor TOrderManager.Destroy;
begin
  F_OrderForm.Free;
  F_OrderDM.Free;
  F_VocCache.Free;

  inherited Destroy;
end;

procedure TOrderManager.InterceptFormHandler;
begin
  F_OrderForm.btn_Save.OnClick := OnBtnSaveClick;
end;

procedure TOrderManager.OnBtnSaveClick(Sender: TObject);
begin
end;

procedure TOrderManager.ShowOrder(_OrderID: integer);
begin
  F_OrderForm.ShowModal;
end;

end.
