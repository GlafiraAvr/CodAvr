unit ItemSelecter;

interface

uses Classes, SelItemForm, Controls, SysUtils, kbmMemTable;

type
  TSelItem=class
  private
    F_ID: integer;
    F_Name: string;
  public
    property ID: integer read F_ID write F_ID;
    property Name: string read F_Name write F_Name;
  end;

  TSelItemList=class
  private
    F_ItemList: TList;
    F_IsChanged: boolean;
    F_ItemsID,
    F_ItemsName: string;
    function GetSelItem(Index: integer): TSelItem;
    procedure SetItemsIDAndName;
    function GetItemsID: string;
    function GetItemsName: string;
  public
    property Items[Index: integer]: TSelItem read GetSelItem;
    procedure AddItem( _ID: integer; _Name: string );
    property ItemsID: string read GetItemsID;
    property ItemsName: string read GetItemsName;
    procedure Clear;
    function Count: integer;
    constructor Create;
    destructor Destroy; override;
  end;


  TItemSelecter=class
  private
    F_IsSelected: boolean;
    F_SelItemList: TSelItemList;
    F_FormCaption: string;
    F_IsMakeFullSelectIfNotShow: boolean;
    F_VocMemTable: TkbmMemTable;
    procedure FillFullSelItemList;
    function GetSelItemList: TSelItemList;
  public
    constructor Create;
    destructor Destroy; override;
    property FormCaption: string read F_FormCaption write F_FormCaption;
    property IsMakeFullSelectIfNotShow: boolean read F_IsMakeFullSelectIfNotShow
      write F_IsMakeFullSelectIfNotShow;
    property SelItemList: TSelItemList read GetSelItemList;
    procedure Reset;
    property VocMemTable: TkbmMemTable read F_VocMemTable write F_VocMemTable;
    procedure ShowSelectForm;
  end;

implementation

uses GlobalVocCacheDModule;

{ TItemSelecter }

constructor TItemSelecter.Create;
begin
  inherited Create;
  F_SelItemList := TSelItemList.Create;
  F_FormCaption := '';
  F_IsMakeFullSelectIfNotShow := false;
  Reset;
end;

destructor TItemSelecter.Destroy;
begin
  F_SelItemList.Free;
  inherited Destroy;
end;


procedure TItemSelecter.FillFullSelItemList;
begin
  F_SelItemList.Clear;
  F_VocMemTable.First;
  while not Eof do
  begin
    if F_VocMemTable.FieldByName( 'id' ).AsInteger > 0 then
      F_SelItemList.AddItem( F_VocMemTable.FieldByName( 'id' ).AsInteger,
                            trim( F_VocMemTable.FieldByName( 'name' ).AsString ) );
    F_VocMemTable.Next;
  end;

  F_IsSelected := true;
end;

function TItemSelecter.GetSelItemList: TSelItemList;
begin
  if ( not F_IsSelected ) and ( F_IsMakeFullSelectIfNotShow ) then
    FillFullSelItemList;
  Result := F_SelItemList;
end;

procedure TItemSelecter.Reset;
begin
  F_IsSelected := false;
  F_SelItemList.Clear;
end;

procedure TItemSelecter.ShowSelectForm;
var
  _frm: Tfrm_SelItem;
  _name: string;
  _id, i: integer;
begin
  F_SelItemList.Clear;
  dm_GlobalVocCache.CheckVoc( F_VocMemTable );
  if not F_VocMemTable.Active then F_VocMemTable.Open;

  _frm := Tfrm_SelItem.Create( F_FormCaption );
  try
    _frm.ds_Items.DataSet := F_VocMemTable;
    F_VocMemTable.First;
    while not F_VocMemTable.Eof do
    begin
      _name := F_VocMemTable.FieldByName( 'name' ).AsString;
      _id := F_VocMemTable.FieldByName( 'id' ).AsInteger;
      if F_VocMemTable.FieldByName( 'id' ).AsInteger > 0 then
        _frm.chlb_Items.Items.AddObject( _name, ptr( _id ) );
      F_VocMemTable.Next;
    end;

    if ( _frm.ShowModal = mrOk ) and _frm.IsHasChecked then
    begin
      F_IsSelected := true;
      for i:=0 to _frm.chlb_Items.Count-1 do
        if _frm.chlb_Items.Checked[i] then
        begin
          _name := trim( _frm.chlb_Items.Items[i] );
          _id := Integer( _frm.chlb_Items.Items.Objects[i] );
          F_SelItemList.AddItem( _id, _name );
        end;
    end else F_IsSelected := false;
  finally
    _frm.Free;
  end;
end;

{ TSelItemList }

procedure TSelItemList.AddItem(_ID: integer; _Name: string);
var
  _SelItem: TSelItem;
begin
  _SelItem := TSelItem.Create;
  _SelItem.ID := _ID;
  _SelItem.Name := _Name;
  F_ItemList.Add( _SelItem );

  F_IsChanged := true;
end;

procedure TSelItemList.Clear;
var
  i: integer;
begin
  for i:=0 to F_ItemList.Count-1 do
    TSelItem(F_ItemList.Items[i]).Free;
  F_ItemList.Clear;

  F_IsChanged := true;
end;

function TSelItemList.Count: integer;
begin
  Result := F_ItemList.Count;
end;

constructor TSelItemList.Create;
begin
  inherited Create;
  F_ItemList := TList.Create;
  F_IsChanged := false;
end;

destructor TSelItemList.Destroy;
var
  i: integer;
begin
  Clear;
  F_ItemList.Free;
  inherited Destroy;
end;

function TSelItemList.GetItemsID: string;
begin
  if F_IsChanged then SetItemsIDAndName;
  Result := F_ItemsID;
end;

function TSelItemList.GetItemsName: string;
begin
  if F_IsChanged then SetItemsIDAndName;
  Result := F_ItemsName;
end;

function TSelItemList.GetSelItem(Index: integer): TSelItem;
begin
  Result := TSelItem( F_ItemList.Items[Index] );
end;

procedure TSelItemList.SetItemsIDAndName;
var
  i: integer;
begin
  F_ItemsID := '';
  F_ItemsName := '';

  if F_ItemList.Count > 0 then
  begin
    for i:=0 to F_ItemList.Count-1 do
    begin
      F_ItemsID := F_ItemsID + ', ' + IntToStr( TSelItem( F_ItemList.Items[i] ).ID );
      F_ItemsName := F_ItemsName + ', ' + trim( TSelItem( F_ItemList.Items[i] ).Name );
    end;

    Delete( F_ItemsID, 1, 2);
    Delete( F_ItemsName, 1, 2);
  end else F_ItemsName := 'бяе';

  F_IsChanged := false;
end;

end.
