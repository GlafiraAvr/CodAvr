unit RepSvodVedDModulePer_vds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RepSvodVedDModule_vds, xmldom, XMLIntf, msxmldom, XMLDoc, DB,
  FR_DSet, FR_DBSet, IBCustomDataSet, IBDatabase, RxMemDS, FR_Class, ADODB;

type
  Tdm_RepSvodVedPer_vds = class(Tdm_RepSvodVed_vds)
    md_CountByRegSum: TRxMemoryData;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    FloatField1: TFloatField;
    IntegerField10: TIntegerField;
  private
    { Private declarations }
    F_Sum_062: boolean;
    F_Sum_Peoples: boolean;
    F_Sum_ODS: boolean;
    F_DtBeg: TDate;
    F_DtEnd: TDate;
    F_RegionsID: string;
    F_BEG_YEAR: string;
//    F_SnapShotMgr: Tdm_SnapShotManager;
    procedure InitCountByReg(ds_Init : TDataSet);
    procedure SnapSum(ds_From, ds_To: TDataSet);
    procedure CalcVsego;
    procedure MyFillSnapList(var list: TStringList);
  public
    { Public declarations }
    procedure FrMemoManage;
    function PrepareDsets: boolean; override;
    property Sum_062: boolean read F_Sum_062 write F_Sum_062;
    property Sum_Peoples: boolean read F_Sum_Peoples write F_Sum_Peoples;
    property Sum_ODS: boolean read F_Sum_ODS write F_Sum_ODS;
    property DtBeg: TDate read F_DtBeg write F_DtBeg;
    property DtEnd: TDate read F_DtEnd write F_DtEnd;
    property RegionsID: string read F_RegionsID write F_RegionsID;
  end;

var
  dm_RepSvodVedPer_vds: Tdm_RepSvodVedPer_vds;

implementation

{$R *.dfm}
uses HelpFunctions, DateUtils;

function Tdm_RepSvodVedPer_vds.PrepareDsets: boolean;
var _cdate: TDate;
    _list: TStringList;
    _ind :integer;
begin
  Result:=false;

  ResetProgressFields;

  F_BEG_YEAR:='01.01.'+IntToStr(YearOf(F_DtBeg));

//  if not PrepareCountByRegPer(F_DtBeg, F_DtEnd) then exit;


    md_CountByReg.Close;
    md_CountByReg.Open;
    md_CountByRegSum.Close;
    md_CountByRegSum.Open;


    InitCountByReg(md_CountByReg);
    InitCountByReg(md_CountByRegSum);

    _cDate := F_dtBeg;
 try
    _list := TStringList.Create;
    MyFillSnapList(_list);
   for _ind := 0 to _list.Count-1 do
    begin
//      LoadSnapShot(strtodate(_list.ValueFromIndex[_ind]));
      LoadSnapShot(strtodate(_list.Strings[_ind]));
      SnapSum(md_CountByReg , md_CountByRegSum);
    end;


{
    while _cDate <= F_dtEnd do
      begin
        if _list.Find(DateToStr(_cDate), _ind) then
        begin
          LoadSnapShot(_cDate);
          SnapSum(md_CountByReg , md_CountByRegSum);
        end;
        _cDate := _cDate + 1;
      end;
      }
  finally
  _list.Free;
  end;
    md_CountByReg.Close;
    md_CountByReg.Open;
  InitCountByReg(md_CountByReg);
  SnapSum(md_CountByRegSum, md_CountByReg); // обратный переброс
  CalcVsego;
  Result:=true;

  // FrMemoManage;
end;


procedure Tdm_RepSvodVedPer_vds.MyFillSnapList(var list: TStringList);
var
  _sql : string;
  _sItem : string;
begin
  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;
  try
   list.Clear;
    _sql :='select id, dt from SNSHOT_SNAPSHOTS_vds where (id_type=1) and (dt>= '''+ DateToStr(F_DtBeg) +
    ''') and (dt<= '''+ DateToStr(F_DtEnd) +''') order by dt';
    MyOpenIBDS(dset_tmp , _sql);
    dset_tmp.First;
    while not dset_tmp.Eof do
    begin
      _sItem := dset_tmp.FieldByName('dt').AsString;
     // list.
      list.Add( _sItem );
      dset_tmp.Next;
    end;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create(E.Message+'(Tdm_RepSvodVedPer.MyFillSnapList)');
    end;
  end;
end;



procedure Tdm_RepSvodVedPer_vds.FrMemoManage;
var   _c, _n1, _n2 :integer;
begin
     _c := 3;
     _n1 := 0;
     _n2 := 0;

     if not F_Sum_062 then
      begin
       _c := _c - 1;
       frReport.FindObject('Memo7').Visible := false;
       frReport.FindObject('Memo17').Visible := false;
       frReport.FindObject('Memo11').Visible := false;
       frReport.FindObject('Memo21').Visible := false;

       _n1 := 2;
       _n2 := 3;
      end;

     if not F_Sum_Peoples then
      begin
       _c := _c - 1;
       frReport.FindObject('Memo8').Visible := false;
       frReport.FindObject('Memo18').Visible := false;
       frReport.FindObject('Memo12').Visible := false;
       frReport.FindObject('Memo22').Visible := false;

       if _c = 1 then
         _n1 := 3
          else
         begin
           _n1 := 1;
           _n2 := 3;
         end;
      end;

     if not F_Sum_ODS then
      begin
       _c := _c - 1;
       frReport.FindObject('Memo9').Visible := false;
       frReport.FindObject('Memo19').Visible := false;
       frReport.FindObject('Memo13').Visible := false;
       frReport.FindObject('Memo23').Visible := false;

       if _c = 2 then
         begin
           _n1 := 1;
           _n2 := 2;
         end;
      end;


     frVariables['COL_MEMO']:= inttostr(_c);
     frVariables['NUMMEMO1']:= inttostr(_n1);
     frVariables['NUMMEMO2']:= inttostr(_n2);

end;


procedure Tdm_RepSvodVedPer_vds.SnapSum(ds_From, ds_To: TDataSet);
    procedure MyCopySumField(sField: string);
     var _old_val, _new_val, _sum_val: integer;
    begin
        ds_From.First;
        ds_To.First;

        while  (not ds_From.Eof) do
         begin
            //if ds_To.
            _old_val := ds_To.FieldByName(sField).AsInteger;
            _new_val := ds_From.FieldByName(sField).AsInteger;
            _sum_val := _old_val + _new_val;
//            if ds_To.State
            ds_To.Edit;
             if ds_To.State = dsEdit then
             begin
              ds_To.FieldByName(sField).AsInteger := _sum_val;
              ds_To.Post;
            end;
             ds_From.Next;
             ds_To.Next;
         end;
    end;

begin
 //
//  for i = 0 to (md_CountByReg.FieldCount-1) do
//  begin
//    md_CountByReg.First;
//    md_CountByRegSum.First;
    if F_Sum_062 then
     begin
       MyCopySumField( 'o62_prin');
       MyCopySumField( 'o62_vip');
     end;
    if F_Sum_Peoples then
     begin
       MyCopySumField( 'zhitel_prin');
       MyCopySumField( 'zhitel_vip');
     end;
    if F_Sum_ODS then
     begin
       MyCopySumField( 'ods_prin');
       MyCopySumField( 'ods_vip');
     end;

//  end;
end;


procedure Tdm_RepSvodVedPer_vds.CalcVsego;
  procedure SumByField(f_name: string);
  var
    sum: integer;
  begin
    sum:=0;
    md_CountByReg.First;
    while not md_CountByReg.Eof do
    begin
      if md_CountByReg.FieldByName('id_reg').AsInteger>0 then
        sum:=sum+md_CountByReg.FieldByName(f_name).AsInteger;
      md_CountByReg.Next;
    end;
    if (md_CountByReg.Locate('id_reg', -1, [])) and (sum<>0) then
    begin
      md_CountByReg.Edit;
      md_CountByReg.FieldByName(f_name).AsInteger:=sum;
      md_CountByReg.Post;
    end;
  end;

  procedure SumOstRecalc;
   var _ost, _prin, _vip:integer;
  begin
      //
     _ost := 0;
     _prin := 0;
     _vip := 0;
     md_CountByReg.First;
     while (not md_CountByReg.Eof) and (md_CountByReg.RecNo < 11) do
      begin
  //      if F_ArrLastOst[md_CountByReg.RecNo-1] > 0 then
        if md_CountByReg.FieldByName('sum_prin').IsNull then _prin := 0
          else _prin := md_CountByReg.FieldByName('sum_prin').AsInteger;
        if md_CountByReg.FieldByName('sum_vip').IsNull then _vip := 0
          else _vip := md_CountByReg.FieldByName('sum_vip').AsInteger;
        _ost := _prin - _vip;
        md_CountByReg.Edit;
        md_CountByReg.FieldByName('ostalos').AsInteger:= _ost;
        md_CountByReg.Post;
        md_CountByReg.Next;
      end;
  end;

const
  arr_field: array [0..3] of string=('o62','ods','zhitel','sum');
  arr_type: array[0..1] of string=('_prin', '_vip');
var
  i, j, _sump, _sum_ost: integer;
  bmark: string;
begin
  md_CountByReg.DisableControls;
  bmark:=md_CountByReg.Bookmark;

  for i:=low(arr_type) to high(arr_type) do
    for j:=low(arr_field) to high(arr_field) do
      SumByField(arr_field[j]+arr_type[i]);
  SumByField('ostalos');
  {$IFDEF FROMSNAPSHOT}
    SumOstRecalc;


    if (md_CountByReg.Locate('id_reg', -1, [])) then
    begin
      _sump := md_CountByReg.FieldByName('sum_prin').AsInteger;
      _sum_ost := md_CountByReg.FieldByName('ostalos').AsInteger;

      md_CountByReg.Next;
      md_CountByReg.Edit;
//      md_CountByReg.FieldByName('sum_prin').AsInteger := F_tmpSumPrinSnap + _sump;
//      md_CountByReg.FieldByName('sum_vip').AsInteger := F_tmpSumPrinSnap + _sump - _sum_ost;
      md_CountByReg.FieldByName('sum_prin').AsInteger := _sump;
      md_CountByReg.FieldByName('sum_vip').AsInteger := _sump - _sum_ost;

      md_CountByReg.Post;
    end;
  {$ENDIF}
  md_CountByReg.Bookmark:=bmark;
  md_CountByReg.EnableControls;
end;




procedure Tdm_RepSvodVedPer_vds.InitCountByReg(ds_Init : TDataSet);
var
  reg_cond: string;
begin
  if trim(F_RegionsID)<>'' then
    reg_cond:=' and (id in'+F_RegionsID+')'
  else
    reg_cond:='';

  MyOpenIBDS(dset_tmp,
    ' select id, name'+
    ' from s_Regions'+
    ' where (id>0)'+
    reg_cond+
    ' order by name');

  dset_tmp.First;
  while not dset_tmp.Eof do
  begin
    ds_Init.Append;
    ds_Init.FieldByName('id_reg').AsInteger:=dset_tmp.FieldByName('id').AsInteger;
    ds_Init.FieldByName('region').AsString:=NameCase(dset_tmp.FieldByName('name').AsString);
    ds_Init.Post;
    dset_tmp.Next;
  end;

  ds_Init.Append;
  ds_Init.FieldByName('id_reg').AsInteger:=-1;
  ds_Init.FieldByName('region').AsString:='Итого ';
  ds_Init.Post;
  {$IFDEF FROMSNAPSHOT}
  ds_Init.Append;
  ds_Init.FieldByName('id_reg').AsInteger:=-2;
  ds_Init.FieldByName('region').AsString:='С '+F_BEG_YEAR;
  ds_Init.Post;
  {$ENDIF}
end;

end.
