unit SelectItemForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, DModule, StdCtrls, CheckLst, Buttons,
  RxLookup, IBDatabase;

type
  TWordCase=(wcDefault, wcUpper, wcLower, wcName);

  Tfrm_SelectItem = class(TForm)
    dset_Items: TIBDataSet;
    chlb_Items: TCheckListBox;
    btn_Ok: TBitBtn;
    btn_exit: TBitBtn;
    RxDBLookupCombo1: TRxDBLookupCombo;
    ds_Items: TDataSource;
    tran_Items: TIBTransaction;
    Cheked_all: TBitBtn;
    cansel_all: TBitBtn;
    procedure btn_exitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure RxDBLookupCombo1Change(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
    procedure Cheked_allClick(Sender: TObject);
    procedure cansel_allClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    F_ResultID: string;
    F_ResultName: string;
    F_ResultNameCase: TWordCase;
    F_ResultIDList: TStringList;
    F_ResultList:TstringList ;
    F_SelectedList:TstringList;
  public
    property ResultID: string read F_ResultID;
    property ResultName: string read F_ResultName;
    property ResultNameCase: TWordCase read F_ResultNameCase write F_ResultNameCase;
    property ResultIDList: TStringList read F_ResultIDList write F_ResultIDList;
    property ResultList: TStringList read F_ResultList write F_ResultList;
  end;

procedure ShowSelectItemsDlg(SQL, Title: string; var ItemsID: string;
              var ItemsName: string; ItemsNameCase: TWordCase=wcDefault); overload;


procedure ShowSelectItemsDlg(SQL, Title: string; var ItemsIDList: TStringList;
            ItemsNameCase: TWordCase=wcDefault); overload;

procedure ShowSelectItemsDlg1(SQL, Title: string; var ItemsIDList: TStringList; var Res :boolean; ItemsNameList:TstringList=nil;
             ItemsNameCase: TWordCase=wcDefault); overload;
procedure ShowSelectItemsDlg2(SQL, Title: string; var ItemsIDList: TStringList;
           var ItemsID: string );


implementation

{$R *.dfm}

uses HelpFunctions;

procedure ShowSelectItemsDlg(SQL, Title: string; var ItemsID: string;
             var ItemsName:string; ItemsNameCase: TWordCase=wcDefault);
var
  frm_SelectItem: Tfrm_SelectItem;
begin
  frm_SelectItem:=Tfrm_SelectItem.Create(nil);
  try
    frm_SelectItem.Caption:=Title;
    frm_SelectItem.dset_Items.SelectSQL.Add(SQL);
    frm_SelectItem.ResultNameCase:=ItemsNameCase;
    if frm_SelectItem.ShowModal=mrOk then
    begin
      ItemsID:=frm_SelectItem.ResultID;
      ItemsName:=frm_SelectItem.ResultName;
    end else
    begin
      ItemsID:='';
      ItemsName:='';
    end;
  finally
    frm_SelectItem.Free;
  end;
end;

procedure ShowSelectItemsDlg(SQL, Title: string; var ItemsIDList: TStringList;
            ItemsNameCase: TWordCase=wcDefault);
var
  frm_SelectItem: Tfrm_SelectItem;
begin
  ItemsIDList.Clear;

  frm_SelectItem:=Tfrm_SelectItem.Create(nil);
  try
    frm_SelectItem.Caption:=Title;
    frm_SelectItem.dset_Items.SelectSQL.Add(SQL);
    frm_SelectItem.ResultNameCase:=ItemsNameCase;
    frm_SelectItem.ResultIDList := ItemsIDList;
    frm_SelectItem.ShowModal;
  finally
    frm_SelectItem.Free;
  end;
end;

procedure ShowSelectItemsDlg2(SQL, Title: string; var ItemsIDList: TStringList;
            var ItemsID: string);
var
  frm_SelectItem: Tfrm_SelectItem;
  i:integer;
begin

  frm_SelectItem:=Tfrm_SelectItem.Create(nil);
 frm_SelectItem.F_SelectedList   :=ItemsIDList;

  try
    frm_SelectItem.Caption:=Title;
    frm_SelectItem.dset_Items.SelectSQL.Add(SQL);
//    frm_SelectItem.ResultNameCase:=ItemsNameCase;
    frm_SelectItem.ResultList := ItemsIDList;
  // ItemsIDList.Clear;
   if frm_SelectItem.ShowModal=mrOk then
       ItemsID:=frm_SelectItem.ResultID
   else
     ItemsID:='';
  finally
    frm_SelectItem.Free;
  end;
end;

procedure ShowSelectItemsDlg1(SQL, Title: string; var ItemsIDList: TStringList; var  Res: boolean; ItemsNameList:TstringList=nil;
           ItemsNameCase: TWordCase=wcDefault );
var
  frm_SelectItem: Tfrm_SelectItem;
begin

  REs:=false;
  frm_SelectItem:=Tfrm_SelectItem.Create(nil);
  try
    frm_SelectItem.Caption:=Title;
    frm_SelectItem.dset_Items.SelectSQL.Add(SQL);
    frm_SelectItem.ResultNameCase:=ItemsNameCase;
    frm_SelectItem.ResultList := ItemsIDList;
 //   ItemsIDList.Clear;
    if   ItemsNameList<>nil then frm_SelectItem.ResultIDList:=ItemsNameList;
    frm_SelectItem.F_SelectedList:=ItemsIDList;
    if frm_SelectItem.ShowModal=mrOK then
     REs:=true;;
  finally
    frm_SelectItem.Free;
  end;
end;


procedure Tfrm_SelectItem.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_SelectItem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if dset_Items.Transaction.InTransaction then
    dset_Items.Transaction.Commit;
end;

procedure Tfrm_SelectItem.FormShow(Sender: TObject);
  function DoCaseWord(Word: string; WordCase: TWordCase): string;
  begin
    case WordCase of
      wcDefault: Result:=Word;
      wcUpper: Result:=AnsiUpperCase(Word);
      wcLower: Result:=AnsiLowerCase(Word);
      wcName: Result:=NameCase(Word);
    end;
  end;
var
  ItemName: string;
  ItemID,i,ind: integer;
begin
  dset_Items.Transaction.StartTransaction;
  dset_Items.Open;
  dset_Items.First;
  while not dset_Items.Eof do
  begin
    ItemName:=DoCaseWord(dset_Items.FieldByName('ItemName').AsString, F_ResultNameCase);
    ItemID:=dset_Items.FieldByName('ItemID').AsInteger;
    if ItemID=-1 then  ItemID:=0;
    chlb_Items.Items.AddObject(ItemName, ptr(ItemID));
    dset_Items.Next;
  end;

  if F_SelectedList<>nil then
  if assigned(F_SelectedList) then
   if F_SelectedList.Count>0 then
    for i:=0 to F_SelectedList.Count-1 do
    begin
     ind:=chlb_Items.Items.IndexOfObject(ptr(StrToInt(F_SelectedList.Strings[i])));
     chlb_Items.Checked[ind]:=true;
    end;

end;

procedure Tfrm_SelectItem.RxDBLookupCombo1Change(Sender: TObject);
begin
  chlb_Items.ItemIndex:=dset_Items.RecNo-1;
end;

procedure Tfrm_SelectItem.btn_OkClick(Sender: TObject);
var
  i: integer;
begin
  if Assigned( F_ResultIDList ) then F_ResultIDList.Clear;
  if Assigned( F_ResultList) then F_ResultList.Clear;
  F_ResultID:='';
  F_ResultName:='';
  for i:=0 to chlb_Items.Count-1 do
    if chlb_Items.Checked[i] then
    begin
      if Assigned( F_ResultIDList ) then
        F_ResultIDList.AddObject( trim(chlb_Items.Items[i]), ptr( Integer(chlb_Items.Items.Objects[i]) ) );
      if Assigned( F_ResultList ) then
        F_ResultList.Add(IntToStr(Integer(chlb_Items.Items.Objects[i])));
      if  Integer(chlb_Items.Items.Objects[i])=0 then
        F_ResultID:=F_ResultID+',-1 '
      else
        F_ResultID:=F_ResultID+', '+IntToStr(Integer(chlb_Items.Items.Objects[i]));
      F_ResultName:=F_ResultName+', '+trim(chlb_Items.Items[i]);
    end;

  Delete(F_ResultID, 1, 2);
  Delete(F_ResultName, 1, 2);

  if F_ResultID<>'' then
    F_ResultID:='('+F_ResultID+')';

  ModalResult:=mrOk;
end;

procedure Tfrm_SelectItem.Cheked_allClick(Sender: TObject);
var i:integer;
begin
  for i:=0  to chlb_Items.Count-1 do
    chlb_Items.Checked[i]:=true;
end;

procedure Tfrm_SelectItem.cansel_allClick(Sender: TObject);
var i:integer;
begin
  for i:=0  to chlb_Items.Count-1 do
    chlb_Items.Checked[i]:=false;
end;

procedure Tfrm_SelectItem.FormCreate(Sender: TObject);
var i:integer;
begin

end;

end.
