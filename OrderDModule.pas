unit OrderDModule;

interface

uses
  SysUtils, Classes, DB, kbmMemTable,GlobalVocCacheDModule;

type
  Tdm_Order = class(TDataModule)
    mt_Order: TkbmMemTable;
    mt_OrderDateComing: TDateTimeField;
    mt_OrderShiftNumber: TIntegerField;
    mt_OrderShiftNumberClose: TIntegerField;
    mt_OrderRegionID: TIntegerField;
    mt_officials_open: TkbmMemTable;
    mt_street: TkbmMemTable;
    mt_regions: TkbmMemTable;
    mt_HouseType: TkbmMemTable;
    mt_street2: TkbmMemTable;
    mt_messagetype: TkbmMemTable;
    mt_DamageLocality: TkbmMemTable;
    mt_DamagePlace: TkbmMemTable;
    mt_Organisation: TkbmMemTable;
    mt_tubediametr: TkbmMemTable;
    md_tubemater: TkbmMemTable;
    mt_officials_close: TkbmMemTable;
    mt_soil: TkbmMemTable;
    mt_Damagetype: TkbmMemTable;
    mt_DamageLocality_2: TkbmMemTable;
    procedure DataModuleDestroy(Sender: TObject);
  private
    _ListAtt:TList;

  public
    function FieldByName( _FieldName: string ): TField;
    procedure Edit;
    procedure Post;
    function IsCanEditDateComing( _CurrShiftNum: integer; _CurrShiftDt: TDateTime ): boolean;
    procedure ResetFields;
    procedure OpenVoks;
  procedure SetDopFileterDL(order_type:integer);
end;


implementation

{$R *.dfm}

{ Tdm_Order }

procedure Tdm_Order.Edit;
begin
  mt_Order.Edit;
end;

function Tdm_Order.FieldByName(_FieldName: string): TField;
begin
  Result := mt_Order.FieldByName( _FieldName );
end;

function Tdm_Order.IsCanEditDateComing(_CurrShiftNum: integer;
  _CurrShiftDt: TDateTime): boolean;
var
  _dt: TDateTime;
  _shift: integer;
begin
  if mt_Order.FieldByName( 'DateComing' ).IsNull then
  begin
    Result := true;
  end else
  begin
    _dt := trunc( mt_Order.FieldByName( 'DateComing' ).AsDateTime );
    _shift := mt_order.FieldByName( 'ShiftNumber' ).AsInteger;

    Result := ( ( _shift = _CurrShiftNum ) and ( ( _dt = trunc(_CurrShiftDT) ) or ( _dt = trunc(_CurrShiftDt) + 1 ) ) )
  end;
end;

procedure Tdm_Order.Post;
begin
  mt_Order.Post;
end;

procedure Tdm_Order.ResetFields;
begin
  mt_Order.Close;
  mt_Order.Open;
  mt_Order.Insert;
  mt_Order.Post;
 end;

procedure Tdm_Order.SetDopFileterDL(order_type:integer);
begin
 if Order_type<>2 then
 begin
  mt_DamageLocality.Filter:='id <>4 and id<>2 and activity is null'    ;
      mt_DamageLocality.Filtered:=true;
 end
end;

procedure Tdm_Order.OpenVoks;
var
    i:integer;
begin
 _ListAtt:=TList.Create;
 _ListAtt.Add(mt_officials_open);
 _ListAtt.Add(mt_street);
 _ListAtt.Add(mt_regions);
 _ListAtt.Add(mt_HouseType);
 _ListAtt.Add(mt_street2);
 _ListAtt.Add(mt_messagetype);
 _ListAtt.Add(mt_DamageLocality);
 _ListAtt.Add(mt_DamagePlace);
 _ListAtt.Add(mt_Organisation);
 _ListAtt.Add(md_tubemater);
 _ListAtt.Add( mt_tubediametr);
 _ListAtt.Add(mt_officials_close);
 _ListAtt.Add(mt_soil);
 _ListAtt.Add( mt_Damagetype);
 _ListAtt.Add( mt_DamageLocality_2);

 mt_street.Filter:='activity is null';
 mt_street.Filtered:=true;
 DM_GlobalVocCache.CheckVocs( _ListAtt );
 mt_DamagePlace.Filter:='activity is null';
 mt_DamagePlace.Filtered:=true;
 mt_messagetype.Filter:='(S_MT_CATEGORY_ID = 1 or S_MT_CATEGORY_ID = 4)';
 mt_messagetype.Filtered:=true;
 mt_DamageLocality.Filter:='id <>4 and activity is null'    ;
 mt_DamageLocality_2.Filter:='(id <>4 and id<>2 and id<>9 and activity is null and classnumber<4) or id=-1 '    ;
 mt_DamageLocality.Filtered:=true;
 mt_DamageLocality_2.Filtered:=true;


_ListAtt.First;
 for i:=0 to _ListAtt.Count-1 do
      TDataSet( _ListAtt.Items[ i ] ).Open;

end;

procedure Tdm_Order.DataModuleDestroy(Sender: TObject);
 var i:integer;
begin
if assigned(_ListAtt) then
 for i:=0 to _ListAtt.Count-1 do
  TDataSet( _ListAtt.Items[ i ] ).Close;
_ListAtt.Free;


end;

end.
