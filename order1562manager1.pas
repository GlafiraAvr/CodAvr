unit order1562manager1;

interface


uses  Classes, Controls, Variants, NGBaseReport,  FR_Class,
     FR_DSet, SysUtils, ProgressForm, FrPreviewForm,
      Aligrid, DB, Graphics,
      UniDataExchUnit, DataExchInterfacesUnit,
     GridViewBuilder, UniSearchResultForm, DatesSelForm,
     ObjListUnit,
     Svodka062DModule,  DateSelForm,
      DateSelCBForm,
     Search1562Form, Search1562DModule, Search1562ResultForm, Search1562andOrdersResultForm
     , Order1562Form,
     Grids,RXDBCtrl,RxMemDS,Seachfor1562DModule,NGReports,UniversalSearch2DModule,HelpFunctions,orderform,
     orderform_vds,Forms,Windows,StringConsts;


type

  TSearchForOrdersFromOtherClasses2 = class(TUniversalSearch2)
  private
    F_DM: Tdm_Seachfor1562;
    {F_ResFrm: Tfrm_UniSearchResult;}
   { F_PreviewFrm: Tfrm_FrPreview;}
    F_GVB: TGridViewBuilder;
    F_Condition: string;
    F_ShowAll: boolean;
   // F_ResFrm: Tfrm_Search1562andOrdersResult;


    procedure BuildResultGridView;
    procedure OnGridFixedColClick(Sender: TObject; col: Integer);
    procedure Onbtn_SaveClick(Sender: TObject);
  //  procedure OnGridClick(Sender: TObject);
  //  procedure OnPrintClick(Sender: TObject);
    procedure OnNewOrderClick(Sender: TObject);
    procedure OnOrderClick(Sender: TObject);
    procedure PrepareResultFormGrid;
    procedure PrepareResultFormBtns;
    procedure PrepareResultFormAddInfo;
    procedure RefreshDset;
    procedure PrevNextOrder1562Click(Sender: TObject;inc:integer);
    procedure Otsoed(Sender: TObject);
    procedure NextOrder1562Click(Sender: TObject);
    procedure PreviosOrder1562Click(Sender: TObject);
    procedure init1562(_TRxM:TRxMemoryData);
  protected
    procedure CreateForms; override;
  public
    F_ResFrm:Tfrm_Order1562;
    MainGrid :TCustomControl; //18.11.2011
    property Condition: string read F_Condition write F_Condition;
    property ShowAll: boolean read F_ShowAll write F_ShowAll;
    property _result1562:TRxMemoryData write init1562;
    function Execute: boolean;
    procedure onOrder1562Click(Sender: TObject);
  end;
implementation

procedure TSearchForOrdersFromOtherClasses2.CreateForms;
  begin
//    F_ResFrm:=CreateResultForm(Tfrm_Search1562andOrdersResult, F_Name) as Tfrm_Search1562andOrdersResult;
    F_ResFrm:=Tfrm_Order1562.Create(nil, F_Name);
 //   F_ResFrm:=CreateResultForm(Tfrm_Search1562Result, F_Name) as Tfrm_Search1562Result;
    F_DM:=CreateDataModule(Tdm_Seachfor1562) as Tdm_Seachfor1562;
  ///  F_PreviewFrm:=Tfrm_FrPreview.Create(F_DM, F_DM.frReport);
  end;

procedure TSearchForOrdersFromOtherClasses2.BuildResultGridView;
var
  _ColorColNumber: integer;
begin
  F_GVB.BuildGridView;

  case F_DM.SortType of
    stOrderNumberAndDatecoming: _ColorColNumber:=2;
    stRegions: _ColorColNumber:=4;
    stAdres: _ColorColNumber:=5;
  end;
  F_ResFrm.Grid.ColorCell[_ColorColNumber, 0]:=clSkyBlue;
end;


procedure TSearchForOrdersFromOtherClasses2.PrepareResultFormGrid;
var
  _AomTypeOfAvarTitle: string;
begin
  with F_GVB do
  begin
    IDFieldName:='ID';
    HelpIDFieldName:='PTR_ADD_INFO';
    IsNumberRecord:=true;

 {   if DM_AomComCLient.IsMapWork then
      _AomTypeOfAvarTitle:='Вид'+#13+'на карте'
    else
      _AomTypeOfAvarTitle:='';}

  //  AddColToGVB(F_GVB, 'AomTypeOfAvar', _AomTypeOfAvarTitle, alLeft, OnAomTypeOfAvarCellShow);
    AddColToGVB(F_GVB, 'OrderNumber', '^ №'+#13+'наряда', alCenter);
    AddColToGVB(F_GVB, 'DateComing', 'Дата'+#13+'поступления', alCenter);
    AddColToGVB(F_GVB, 'Regions', '^Район', alLeft);
    AddColToGVB(F_GVB, 'Adres', '^Адрес', alLeft);
    AddColToGVB(F_GVB, 'DamageType', 'Вид'+#13+'повреждения', alLeft{, OnDamageTypeCellShow});
    AddColToGVB(F_GVB, 'DamagePlace', 'Место'+#13+'повреждения', alLeft);
 //   AddColToGVB(F_GVB, 'Diameter', 'Диаметер', alCenter, OnDiamCellShow);
//    AddColToGVB(F_GVB, 'FlowSpeed', 'Утечка в час,'+#13+'м3', alCenter, OnFlowSpeedCellShow);
//    AddColToGVB(F_GVB, 'Leak', 'Утечка,'+#13+'м3', alCenter, OnDiamCellShow);
    AddColToGVB(F_GVB, 'DateClosed', 'Дата'+#13+'закрытия', alCenter);
  end;

  BuildResultGridView;
  F_GVB.BuildGridView;
end;


procedure TSearchForOrdersFromOtherClasses2.PrepareResultFormBtns;
begin
 // F_ResFrm.Grid.OnFixedColClick:=OnGridFixedColClick;
 // F_ResFrm.Grid.OnClick:=OnGridClick;
  F_ResFrm.btn_Order.OnClick:=OnOrderClick;
 // F_ResFrm.btn_Print.OnClick:=OnPrintClick;
  F_ResFrm.btn_NewOrder.OnClick:=OnNewOrderClick;
  F_ResFrm.btnnext.OnClick:=NextOrder1562Click;
  F_ResFrm.btn_Previos.OnClick:=PreviosOrder1562Click;
 // F_ResFrm.Otvaz.OnClick:=Otsoed;
end;

procedure TSearchForOrdersFromOtherClasses2.PrepareResultFormAddInfo;
begin
    // Надо придумать как заполнить данные на 1562
//    F_ResFrm.vle_Order1562
{    for i:=0 to dset.FieldCount-1 do
      ResultDset.FieldByName(dset.Fields[i].FieldName).Value:=dset.Fields[i].Value;
    F_DM.res ResultDset.Post;
 }

end;


procedure TSearchForOrdersFromOtherClasses2.OnOrderClick(Sender : TObject);
var
  _OrderID,_row: integer;
  _frm_Order: Tfrm_Order;
  _frm_order_vds: Tfrm_Order_vds;
  is_close:boolean;
begin
  with F_ResFrm do
  begin
   if F_ResFrm.IsLinkedChange then
    Application.MessageBox('Сохраните изменения!','АРМ АВР Сохранение изменеий',MB_OK)
    else
    try
      if Assigned( Grid.Objects[0, Grid.Row] ) then
      begin
        _OrderID := integer(Grid.Objects[0, Grid.Row]);
        case _App of
           2:   _frm_Order := Tfrm_Order.Create( nil, _OrderID );
           3:   _frm_order_vds:=Tfrm_Order_vds.Create( nil, _OrderID );
        end;
        try
          case _App of
          2:begin
               _frm_Order.ShowModal;
               if _frm_Order.IsCtrlChange then
                  Grid.RowFont[ Grid.Row ].Color := clRed;
               is_close:= _frm_Order.Is_closed;
            end;
          3:begin
                _frm_order_vds.ShowModal;
                is_close:= _frm_Order_vds.F_Is_closed;
            end;
           end;
         {      if DM_AomComClient.IsMapWork then
                    Grid.Cells[ 1, Grid.Row ] := NameCase( DM_AomComClient.ConvertTypeOfAvarToStr( _frm_Order.AomTypeOfAvar ) );}
               if   _OrderID=ID_ORDER  then          //glasha 23.1.2012
                 begin
                   vle_Order1562.FindRow('наряд', _row);
                   vle_Order1562.DeleteRow(_row);

                   if  is_close then
                    vle_Order1562.InsertRow( 'наряд' , 'закрыт' ,true)
                   else
                    vle_Order1562.InsertRow( 'наряд' , 'открыт' ,true);//glasha 23.1.2012
                 end;

        finally
         case  _App of
             2:   _frm_Order.Free;
             3:  _frm_order_vds.Free;
         end;
        end;
      end;
    except
      raise;
    end;
  end;
end;

procedure TSearchForOrdersFromOtherClasses2.OnNewOrderClick(Sender: TObject);
var
  frm_Order: Tfrm_Order;
  frm_order_vds:Tfrm_Order_vds;

  nh:string;
  i:integer;
  id_o:integer;
begin
 case F_ResFrm._app of
 2:  frm_Order:=Tfrm_Order.Create(Application); //Новый наряд
 3:  frm_order_vds:=Tfrm_Order_vds.Create(Application);
end;
    try
     case F_ResFrm._app of
     2:  begin
             FixDBLValue(F_ResFrm.id_Region,frm_Order.dbl_Regions);
             FixDBLValue(F_ResFrm.id_Street,frm_order.dbl_Street);
             nh:= F_ResFrm.vle_Order1562.Values['Дом'];
             frm_Order.ed_Housenum.Text:=F_ResFrm.vle_Order1562.Values['Дом'];
          //   frm_Order.e
           ///  ['Кватира']'
             frm_Order.NUM1562:=F_ResFrm.ID1562;
             frm_Order.ShowModal;
             id_o:=frm_Order.OrderID;
        end;
     3:  begin
              //F_OrderRegionID := FieldByName('FK_ORDERS_REGIONS').AsInteger;
              FixDBLValue(F_ResFrm.id_Region,frm_Order_vds.dbl_Regions); //Район
              FixDBLValue(F_ResFrm.id_Street,frm_order_vds.dbl_Street); //Улица
              frm_order_vds.ed_Housenum.Text:=F_ResFrm.vle_Order1562.Values['Дом']; //Номер дома
              frm_order_vds.ed_ApartmentNum.Text:=F_ResFrm.vle_Order1562.Values['Кватира'];
              frm_Order_vds.NUM1562:=F_ResFrm.ID1562;
              frm_order_vds.showModal;
              id_o:=frm_order_vds.orderid;

        end;
     end;

    finally
    case F_ResFrm._app of
      2:frm_Order.Free;
      3: frm_Order_vds.Free;
    end;
    end;
   RefreshDset;
   if     id_o>0 then
   begin
     {for i := 1 to F_ResFrm.Grid.RowCount do
      if integer(F_ResFrm.Grid.Objects[0, i])=F_ResFrm.ID_ORDER then
        F_ResFrm.grid.ColorRow[i] := clMoneyGreen;
   F_ResFrm.IsLinked:=true;
   }
   for i:=1 to   F_ResFrm.Grid.RowCount-1 do
   begin
     if Assigned(F_ResFrm.Grid.Objects[0, i] ) then
       if integer(F_ResFrm.Grid.Objects[0, i])=id_o then
         begin
            F_ResFrm.Grid.Row:=i;
            F_ResFrm.Grid.RowFont[F_ResFrm.Grid.Row ].Color := clRed;
         end;
   end;
    F_ResFrm.btn_PrepareClick(nil);
    F_ResFrm.btn_Prepare.Enabled:=false;
    F_ResFrm.btn_NewOrder.Enabled:=false;
  end;
end;

procedure TSearchForOrdersFromOtherClasses2.RefreshDset;
begin
    F_DM.StopTransaction;
    F_DM.StartTransaction;
    F_DM.PrepareDset;

    F_GVB.Free;
    F_GVB:=TGridViewBuilder.Create(F_DM.ResultDset, F_ResFrm.Grid);
    PrepareResultFormGrid;
end;

procedure TSearchForOrdersFromOtherClasses2.OnGridFixedColClick(Sender: TObject; col: Integer);
  begin
       //
  end;

procedure TSearchForOrdersFromOtherClasses2.Onbtn_SaveClick(Sender: TObject);
begin

    //

end;

procedure TSearchForOrdersFromOtherClasses2.NextOrder1562Click(Sender: TObject);
begin
PrevNextOrder1562Click(Sender,1);
end;

procedure TSearchForOrdersFromOtherClasses2.PreviosOrder1562Click(Sender: TObject);
begin
PrevNextOrder1562Click(Sender,-1);
end;

procedure TSearchForOrdersFromOtherClasses2.Otsoed(Sender: TObject);
var _Datatime1,_Datatime:tdatetime;
  _row:integer;
begin
//if (F_ResFrm.IsLinked) and (F_ResFrm.IsLinkedChange)  then
 ///  Application.MessageBox('С')
   F_ResFrm.ID_ORDER := -1;
   F_ResFrm.IsLinked := false;
   F_ResFrm.IsLinkedChange:=false;

   with F_ResFrm do begin
    vle_Order1562.FindRow('№наряда', _row);
    vle_Order1562.DeleteRow(_row);
    vle_Order1562.InsertRow( '№наряда' , '' ,true);
    vle_Order1562.FindRow('наряд', _row);
    vle_Order1562.DeleteRow(_row);
    vle_Order1562.InsertRow( 'наряд' , 'открыт' ,true);
    Otvaz.Enabled:=false;
    btn_Prepare.Enabled:=true;
   end;

    _Datatime:= F_DM.Result1562.FieldByName('DateOurRequest').AsDateTime;
    ShowAll := true;
    _Datatime1:=_Datatime-120;
    F_DM.Condition := ' where datecoming >= ''' +
                      DateTimeToStr(_Datatime1)+'''  and datecoming < '''+ ///15.12.2011 отладка
                      DateTimeToStr(_Datatime + 30)+''''+'and isclosed=0';
   if F_DM.tran.InTransaction then
   F_DM.StopTransaction;
   F_DM.StartTransaction;
   F_DM.FillResultDset;
   F_GVB.BuildGridView;
end;

procedure TSearchForOrdersFromOtherClasses2.init1562(_TRxM:TRxMemoryData);
begin
  F_DM.result1562:=_TRxM;
end;

procedure TSearchForOrdersFromOtherClasses2.onOrder1562Click(Sender: TObject);

function FixSpaces(_s: string): string;
     var _i: integer;
     begin
      for _i := 0 to (Length(_s)-1) do
          if (_s[_i] in ['^', #$D]) then _s[_i] := ' ';
      Result := _s;
     end;

var
 _RegionID, _ID1562, Order_ID, i, _row: integer;
  _Datatime,_Datatime1: TDate;
  str:string;
  order_num:string;
  is_closed:integer;
begin

    if MainGrid.ClassName='TStringAlignGrid' then
    begin
     _row:=(MainGrid as TStringAlignGrid).Row;
     _ID1562 := integer((MainGrid as TStringAlignGrid).Objects[0, (MainGrid as TStringAlignGrid).Row]);
   end
   else
   begin
   _row:=(MainGrid as TRxDBGrid).Row;
   _ID1562 := StrToInt((MainGrid as TRxDBGrid).Fields[0].AsString);
  end ;
    F_DM.Result1562.Locate('ID',_ID1562,[]);
    _Datatime:= F_DM.Result1562.FieldByName('DateOurRequest').AsDateTime;
    ShowAll := true;
    _Datatime1:=_Datatime-120;
   { Condition := ' where datecoming >= ''' +
                      DateTimeToStr(_Datatime1)+'''  and datecoming < '''+ ///15.12.2011 отладка
                      DateTimeToStr(_Datatime + 30)+'''';//+'and isclosed=0';
    }
     //F_SearchOrders.F_ResFrm.vle_Order1562.Values
   if MainGrid.ClassName='TStringAlignGrid' then
    for i:=1 to (MainGrid as TStringAlignGrid).ColCount-1 do
     if (F_ResFrm.vle_Order1562.RowCount>i)and (i>1) then
      F_ResFrm.vle_Order1562.Cells[2,i]:=(MainGrid as TStringAlignGrid).Cells[i,_row]
     else
      F_ResFrm.vle_Order1562.InsertRow(FixSpaces((MainGrid as TStringAlignGrid).Cells[i, 0]),(MainGrid as TStringAlignGrid).Cells[i, (MainGrid as TStringAlignGrid).Row], true)
   else
     for i:=1 to (MainGrid as TRxDBGrid).Columns.Count-1 do
      if i=11 then F_ResFrm.Memo1.Lines.Text:=(MainGrid as TRxDBGrid).Fields[i].AsString
      else
      if ((F_ResFrm.vle_Order1562.RowCount>i+1)and (i<11)) or ((i>11) and (F_ResFrm.vle_Order1562.RowCount>i))  then
       if i>11 then
            F_ResFrm.vle_Order1562.Cells[2,i-1]:=(MainGrid as TRxDBGrid).Fields[i].AsString
       else
        F_ResFrm.vle_Order1562.Cells[2,i]:=(MainGrid as TRxDBGrid).Fields[i].AsString
      else
         F_ResFrm.vle_Order1562.InsertRow(FixSpaces((MainGrid as TRxDBGrid).Columns[i].Title.Caption),(MainGrid as TRxDBGrid).Fields[i].AsString, true);

   F_DM._APP:=F_DM.Result1562.FieldByName('Appurtenance').asinteger;
    f_DM.GetOrderNumber( F_DM.Result1562.FieldByName('ID').AsInteger,Order_ID,is_closed,order_num);
  //  Order_ID:= F_DM.Result1562.FieldByName('ID_ORDER').AsInteger;


     if Order_ID>0 then
     begin
     if is_closed=1 then
       str:='закрыт'
      else
        str:='открыт';

     F_DM.Condition:= 'where id='+IntToStr(Order_ID);
     end
     else  begin
       str:='';
       F_DM.Condition:=F_Condition+'and isclosed=0';
     end;
  //   F_DM.Condition:=F_Condition;




   if  F_ResFrm.vle_Order1562.RowCount>=i  then
   begin
           F_ResFrm.vle_Order1562.Cells[2,i-1]:=str
   end
   else
    F_ResFrm.vle_Order1562.InsertRow(FixSpaces('Наряд'),str, true);

//    F_ResFrm.SPIS_ID := F_DM.Result1562.FieldByName('NUM1562').AsInteger;
    if F_DM.Result1562.FieldByName('ID').IsNull then
       F_ResFrm.ID1562:=-1
    else
       F_ResFrm.ID1562 := F_DM.Result1562.FieldByName('ID').AsInteger;
    F_ResFrm.ID_ORDER := F_DM.Result1562.FieldByName('ID_ORDER').AsInteger;
    F_ResFrm.IsLinked := not (F_DM.Result1562.FieldByName('ID_ORDER').AsInteger = -1);
    F_ResFrm.IsClosed := (F_DM.Result1562.FieldByName('Is_Closed').AsInteger = 1 );
    if not    F_DM.Result1562.FieldByName('NumOrder').IsNull then
               F_ResFrm.ORDERNUMBER :=F_DM.Result1562.FieldByName('NumOrder').AsString
             else
                F_ResFrm.ORDERNUMBER:='';
   // F_ResFrm.ID_MessHist := F_DM.Result1562.FieldByName('MHID').AsInteger;

    F_resFrm.OurNumber:=F_DM.Result1562.FieldByName('NumberOurRequest').asinteger;
    F_resFrm.RecivedNumber:=F_DM.Result1562.FieldByName('NumberReceivedRequest').AsInteger;
    F_resFrm.Date_Rec:=F_DM.Result1562.FieldByName('DateReceivedRequest').AsDateTime;
    F_resfrm.Date_Our:=F_DM.Result1562.FieldByName('DateOurRequest').AsDateTime;
    F_ResFrm.id_Region:=F_DM.Result1562.FieldByName('id_rayon').AsInteger;
    F_ResFrm.id_street:=F_DM.Result1562.FieldByName('id_street').AsInteger;
    F_ResFrm.btn_Prepare.Enabled:=(Order_ID<=0);
    F_ResFrm.btn_NewOrder.Enabled:=(Order_ID<=0);
    F_ResFrm._app:=F_DM.Result1562.FieldByName('Appurtenance').asinteger;
   


end;

procedure TSearchForOrdersFromOtherClasses2.PrevNextOrder1562Click(Sender: TObject;inc:integer);   //17.11.2011
var
  _RegionID, _ID1562, Order_ID, i, _row: integer;
  _Datatime: TDate;
  str:string;
  cond:boolean;
begin
if F_ResFrm.IsLinkedChange then
 if Application.MessageBox(' Сохранить изменеия?',
        gc_strDispAVR,MB_YESNO+MB_ICONQUESTION)=IDYES then
     begin
         F_ResFrm.ActiveControl:=F_ResFrm.btn_Save;
        exit;
     end;
 if  MainGrid.ClassName='TStringAlignGrid' then
 cond := ((MainGrid as TCustomDrawGrid).Row+inc<(MainGrid as TStringAlignGrid).RowCount) and  ((MainGrid as TCustomDrawGrid).Row+inc>0 )
 else
  cond:=({(MainGrid as TRxDBGrid).f.Row+inc<(MainGrid as TRxDBGrid).r.RowCount) and } (MainGrid as TRxDBGrid).Row+inc>0 );
  if cond
 then
 begin
 // if  F_DM.Result1562.FindNext then
 // begin

    if  MainGrid.ClassName='TStringAlignGrid' then
    (MainGrid as TStringAlignGrid).Row:=(MainGrid as TStringAlignGrid).Row+inc
    else
     if inc>0 then
     F_DM.Result1562.Next
     else
      F_DM.Result1562.Prior;
     //(MainGrid as TRxDBGrid).
    onOrder1562Click(Sender);
    if F_DM.tran.InTransaction then
     F_DM.StopTransaction;
    F_DM.StartTransaction;
    F_DM.PrepareDset;
    F_GVB.SelFieldVal:=F_ResFrm.ORDERNUMBER;
    F_GVB.BuildGridView;
//    if  not F_ResFrm.IsLinked then     F_ResFrm.Grid.ColorRow[1]:=clLime;    //06.04.2012
   { _row:=MainGrid.Row;
       _ID1562 := integer(MainGrid.Objects[0, MainGrid.Row]);
    F_DM.Result1562.Locate('ID',_ID1562,[]);
    _Datatime:= F_DM.Result1562.FieldByName('Datatime').AsDateTime;
    ShowAll := true;
    Condition := ' where datecoming >= ''' +
                      DateTimeToStr(_Datatime)+''' and datecoming < '''+
                      DateTimeToStr(_Datatime + 1)+'''';
     F_DM.Condition:=F_Condition;
     //F_SearchOrders.F_ResFrm.vle_Order1562.Values
    for i:=1 to F_ResFrm.vle_Order1562.RowCount-1 do
     F_ResFrm.vle_Order1562.Cells[2,i]:=MainGrid.Cells[i,_row];

    Order_ID:= F_DM.Result1562.FieldByName('ID_ORDER').AsInteger;
    F_ResFrm.SPIS_ID := F_DM.Result1562.FieldByName('ID').AsInteger;
    F_ResFrm.ID1562 := F_DM.Result1562.FieldByName('NUM1562').AsInteger;
    F_ResFrm.ID_ORDER := F_DM.Result1562.FieldByName('ID_ORDER').AsInteger;
    F_ResFrm.IsLinked := not (F_DM.Result1562.FieldByName('ID_ORDER').AsString = '');
    F_ResFrm.IsClosed := (F_DM.Result1562.FieldByName('Is_Closed').AsInteger = 1 );
    F_ResFrm.ORDERNUMBER :=F_DM.Result1562.FieldByName('ORDERNUMBER').AsInteger;
    F_ResFrm.ID_MessHist := F_DM.Result1562.FieldByName('MHID').AsInteger;

    if F_DM.tran.InTransaction then
     F_DM.StopTransaction;
    F_DM.StartTransaction;
    F_DM.FillResultDset;
    F_GVB.BuildGridView;  }
   //BuildResultGridView;

 end;
end;

function TSearchForOrdersFromOtherClasses2.Execute:boolean ;
var
  rec_count: integer;
begin
  Result:=false;

//  if F_OptFrm.ShowModal<>mrOk then exit;

//  F_DM.strStartDate:=F_OptFrm.strStartDate;
//  F_DM.strFinishedDate:=F_OptFrm.strFinishedDate;
 // F_DM.Condition:=F_Condition;
  F_DM.SortType:=stRegions;
  F_DM.IsAscSort:=true;

  F_DM.StartTransaction;
  try
    rec_count:=F_DM.GetRecordCount;
    if (not(F_ShowAll) and (rec_count<=0)) then
    begin
      Application.MessageBox('Записей удовлетворяющих запросу не найдено',
                            'Произвольный поиск', MB_OK+MB_ICONINFORMATION);
    end else
    begin
      if (F_ShowAll or (Application.MessageBox(PChar('Найдено '+IntToStr(rec_count)+' записей. Показать?'),
                              'Произвольный поиск', MB_YESNO+MB_ICONQUESTION)=ID_YES)) then
      begin
        F_Pind.Show;
        //F_GVB:=TGridViewBuilder.Create(F_DM.ResultDset, F_ResFrm.Grid);
        F_GVB:=TGridViewBuilder.Create(F_DM.ResultDset, F_ResFrm.Grid, 1, F_ResFrm.ORDERNUMBER, true, clskyblue);
        F_GVB.BuildGridView;
        try
          F_DM.PrepareDset;
          PrepareResultFormBtns;
          PrepareResultFormGrid;
          //if  not F_ResFrm.IsLinked then     F_ResFrm.Grid.ColorRow[1]:=clLime;    //06.04.2012
          //PrepareResultFormAddInfo;
          F_ResFrm.ShowModal;
        finally
          F_GVB.Free;
        end;
        F_Pind.Hide;
      end;
    end;
  finally
    F_DM.StopTransaction;
  end;
  Result:=true;
 end;


end.
 