unit KolvoOtkazForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons, Mask, ToolEdit, IBDatabase,
  DB, IBCustomDataSet, DModule;

const
  DMG_PLACE_ID='1, 2, 10, 3, 11, 4';


type
  TArrType=(atDamagePlace, atRegions);
  TArrOfStr=array of string;
  TPArrOfStr=^TArrOfStr;


  Tfrm_KolvoOtkazOpt = class(Tfrm_BaseOption)
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    dp_date1: TDateEdit;
    dp_date2: TDateEdit;
    btn_Region: TBitBtn;
    btn_DamagePlace: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    dset_tmp: TIBDataSet;
    tran_tmp: TIBTransaction;
    procedure btn_okClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure btn_RegionClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_DamagePlaceClick(Sender: TObject);
  private
    procedure FillArreys(ArrType: TArrType);
  private
    F_Dt_begin, F_Dt_end: TDate;
    F_strRegions: string;
    F_strDamagePlace: string;
    F_RegionsID: string;
    F_DamagePlaceID: string;

    F_Arr_strDamagePlace, F_Arr_DamagePlaceID: TArrOfStr;
    F_Arr_strRegions, F_Arr_RegionsID: TArrOfStr;

    function GetArr_strDamagePlace(Index: integer): string;
    function GetArr_DamagePlaceID(Index: integer): string;
    function GetArr_DamagePlaceCount: integer;
    function GetArr_strRegions(Index: integer): string;
    function GetArr_RegionsID(Index: integer): string;
    function GetArr_RegionsCount: integer;
  public
    constructor Create(AOwner: TComponent; Title: string);
    property Dt_begin: TDate read F_Dt_begin;
    property Dt_end: TDate read F_Dt_end;
    property strRegions: string read F_strRegions;
    property strDamagePlace: string read F_strDamagePlace;
    property RegionsID: string read F_RegionsID;
    property DamagePlaceID: string read F_DamagePlaceID;
    property Arr_strDamagePlace[Index: integer]: string read GetArr_strDamagePlace;
    property Arr_DamagePlaceID[Index: integer]: string read GetArr_DamagePlaceID;
    property Arr_DamagePlaceCount: integer read GetArr_DamagePlaceCount;
    property Arr_strRegions[Index: integer]: string read GetArr_strRegions;
    property Arr_RegionsID[Index: integer]: string read GetArr_RegionsID;
    property Arr_RegionsCount: integer read GetArr_RegionsCount;
  end;


implementation

{$R *.dfm}

uses SelectItemForm, HelpFunctions, StringConsts;

function GetItemCount(ItemsID: string): integer;
var
  s: string;
  i: integer;
begin
  s:=trim(ItemsID);
  if length(s)=0 then
    Result:=0
  else
    Result:=1;

  for i:=1 to length(s)-1 do
    if s[i]=',' then inc(Result);
end;

procedure StrToStrArr(s: string; var StrArr: array of string);
var
  i, index: integer;
begin
  s:=trim(s);
  if length(s)=0 then exit;

  index:=0;
  for i:=1 to length(s) do
    if s[i]=',' then inc(index)
    else if (s[i]<>'(') and (s[i]<>')') then StrArr[index]:=StrArr[index]+s[i];

  for i:=0 to index do
    StrArr[i]:=trim(StrArr[i]);
end;

procedure StrToIntArr(s: string; var IntArr: array of integer);
var
  str_arr: array of string;
  i: integer;
begin
  SetLength(str_arr, high(IntArr)+1);
  StrToStrArr(s, str_arr);
  for i:=low(IntArr) to high(IntArr) do
    IntArr[i]:=StrToInt(trim(str_arr[i]));
end;


{ Tfrm_KolvoOtkazOpt }

constructor Tfrm_KolvoOtkazOpt.Create(AOwner: TComponent; Title: string);
begin
  inherited Create(AOwner);
  Caption:=Title;
end;

procedure Tfrm_KolvoOtkazOpt.btn_okClick(Sender: TObject);
begin
  {Даты}
  if (dp_date1.Date<>0) and (not IsDateCorrect(dp_date1.Text)) then
  begin
    Application.MessageBox('Дата начала введена неправильно, попробуйте еще раз.',
                              gc_strDispAVR, MB_OK+MB_ICONWARNING);
    exit;
  end;

  if dp_date2.Date=0 then dp_date2.Date:=Date;

  if not IsDateCorrect(dp_date2.Text) then
  begin
    Application.MessageBox('Дата окончания введена неправильно, попробуйте еще раз.',
                              gc_strDispAVR, MB_OK+MB_ICONWARNING);
    exit;
  end;

  F_dt_begin:=dp_date1.Date;
  F_dt_end:=dp_date2.Date;
  {/Даты}

  FillArreys(atDamagePlace);
  FillArreys(atRegions);

  ModalResult:=mrOk;
end;

procedure Tfrm_KolvoOtkazOpt.btn_cancelClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_KolvoOtkazOpt.btn_RegionClick(Sender: TObject);
var
  SQL: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_regions'+
        ' where id<>-1 and activity is null'+
        ' order by name';

  ShowSelectItemsDlg(SQL, 'Район', F_RegionsID, F_strRegions);
end;

procedure Tfrm_KolvoOtkazOpt.FormShow(Sender: TObject);
begin
  F_RegionsID:='';
  F_DamagePlaceID:='';

  F_strRegions:='Все';
  F_strDamagePlace:='Все';
end;

procedure Tfrm_KolvoOtkazOpt.btn_DamagePlaceClick(Sender: TObject);
var
  SQL: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_damageplace'+
        ' where id in('+DMG_PLACE_ID+') and activity is null'+
        ' order by name';
  ShowSelectItemsDlg(SQL, 'Место повреждения', F_DamagePlaceID, F_strDamagePlace);
end;

function Tfrm_KolvoOtkazOpt.GetArr_DamagePlaceCount: integer;
begin
  Result:=High(F_Arr_DamagePlaceID)+1;
end;

function Tfrm_KolvoOtkazOpt.GetArr_strDamagePlace(Index: integer): string;
begin
  Result:=F_Arr_strDamagePlace[Index];
end;

function Tfrm_KolvoOtkazOpt.GetArr_DamagePlaceID(Index: integer): string;
begin
  Result:=F_Arr_DamagePlaceID[Index];
end;

procedure Tfrm_KolvoOtkazOpt.FillArreys(ArrType: TArrType);
var
  item_count, i: integer;
  pArr_id, pArr_name: TPArrOfStr;
  sel_sql, str_id, str_name: string;
begin
  if ArrType=atDamagePlace then
  begin
    pArr_id:=@F_Arr_DamagePlaceID;
    pArr_name:=@F_Arr_strDamagePlace;
    str_id:=F_DamagePlaceID;
    str_name:=F_strDamagePlace;
    sel_sql:='select id, name from s_DamagePlace where id in('+DMG_PLACE_ID+') and activity is null';
  end else
  begin
    pArr_id:=@F_Arr_RegionsID;
    pArr_name:=@F_Arr_strRegions;
    str_id:=F_RegionsID;
    str_name:=F_strRegions;
    sel_sql:='select id, name from s_Regions where id>0  and activity is null';
  end;

  SetLength(pArr_id^, 0);
  SetLength(pArr_name^, 0);

  if trim(str_id)='' then
  begin
    if dset_tmp.Transaction.InTransaction then
      dset_tmp.Transaction.Rollback;
    dset_tmp.Transaction.StartTransaction;
    try
      MyOpenIBDS(dset_tmp, sel_sql);
      dset_tmp.Last;
      dset_tmp.First;
      item_count:=dset_tmp.RecordCount;
      SetLength(pArr_id^, item_count);
      SetLength(pArr_name^, item_count);
      for i:=low(pArr_id^) to high(pArr_id^) do
      begin
        pArr_id^[i]:=dset_tmp.FieldByName('id').AsString;
        pArr_name^[i]:=trim(dset_tmp.FieldByName('name').AsString);
        dset_tmp.Next;
      end;
      dset_tmp.Transaction.Commit;
    except
      dset_tmp.Transaction.Rollback;
      raise;
    end
  end else
  begin
    item_count:=GetItemCount(str_id);
    if item_count>0 then
    begin
      SetLength(pArr_id^, item_count);
      SetLength(pArr_name^, item_count);
      StrToStrArr(str_id, pArr_id^);
      StrToStrArr(str_name, pArr_name^);
    end;
  end;
end;

function Tfrm_KolvoOtkazOpt.GetArr_strRegions(Index: integer): string;
begin
  Result:=F_Arr_strRegions[Index];
end;

function Tfrm_KolvoOtkazOpt.GetArr_RegionsID(Index: integer): string;
begin
  Result:=F_Arr_RegionsID[Index];
end;

function Tfrm_KolvoOtkazOpt.GetArr_RegionsCount: integer;
begin
  Result:=High(F_Arr_RegionsID)+1;
end;

end.
