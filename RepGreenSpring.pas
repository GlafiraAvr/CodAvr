unit RepGreenSpring;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class,DModule, FR_DSet, FR_DBSet,
  RxMemDS, DB, IBCustomDataSet;
const sql_sel='select id_order,class1,raskop_dt, blag_dt,R_SQW,R_SQASF,EXCW_SQASF, splan_dt from Get_Blag4(%d,''%s'',''%s'',''%s'')';
type
  Tdm_RepGreenSpring = class(Tdm_NGReportBase)
    dset: TIBDataSet;
    FrResult: TRxMemoryData;
    frDBDResult: TfrDBDataSet;
    FrResultid_region: TIntegerField;
    FrResultRegion: TStringField;
    FrResultneed_zel_count: TIntegerField;
    FrResultneed_asf_count: TIntegerField;
    FrResultdo_zel_count: TIntegerField;
    FrResultdo_asf_count: TIntegerField;
    FrResultneed_zel_sqw: TFloatField;
    FrResultneed_asf_sqw: TFloatField;
    FrResultdo_zel_sqw: TFloatField;
    FrResultdo_asf_sqw: TFloatField;
  private
    { Private declarations }
    F_BegRDt,F_EndRDt:TDate;
    F_BegDoDt,F_EndDoDt:TDate;
    F_regionsId:string;
    _progress_shag:integer;
    percent:integer;
    procedure OpenDset;
    function AddResions():boolean;
  public
    { Public declarations }
    function PrepareDset():boolean;
    property BegRDt:TDate write  F_BegRDt;
    property EndRDt:TDate write F_EndRDt;
    property BegDoDt:TDate write F_BegDoDt;
    property EndDoDt:TDate write F_EndDoDt;
    property regionsId:string write  F_regionsId;
  end;

var
  dm_RepGreenSpring: Tdm_RepGreenSpring;

implementation

{$R *.dfm}
procedure Tdm_RepGreenSpring.OpenDset;
begin
 if FrResult.Active then
   FrResult.Close;
 FrResult.Append;
end;

function Tdm_RepGreenSpring.AddResions:boolean;
  procedure Clearfield();
   var i:integer;
  begin
    with frResult do begin
      for i:=2 to FieldCount-1 do
        frResult.Fields[i].AsInteger:=0;
    end;
  end;
begin
 result:=false;
 try
  dset.SelectSQL.Text:='select id,name from s_resiotns';
  if F_regionsId<>'' then
   dset.SelectSQL.Text:=dset.SelectSQL.Text+' where id in '+F_regionsId;
  dset.Open;
 _progress_shag := GetProgressShagLength( percent, dset.RecordCount );
  while dset.Eof do
  begin
   frResult.Append;
   frResult.FieldByName('id_Region').AsInteger:=dset.fieldbyname('id').AsInteger;
   frResult.FieldByName('Region').asstring:=dset.fieldbyname('name').asstring;
   frResult.Post;
   dset.Next;
  end;
 except
  result:=false;
 end;
end;

function Tdm_RepGreenSpring.PrepareDset():boolean;
var str_beg, str_end,str_grant:string;
   procedure AddCount();
   var sq_green,sq_asf:real;
   begin
    if dset.FieldByName('raskop_dt').AsDateTime>F_BegRDt then
     if dset.FieldByName('raskop_dt').AsDateTime<=F_EndRDt+1 then
      begin
       sq_asf:=dset.fieldbyname('R_SQASF').asfloat;
       if dset.FieldByName('EXCW_SQASF').AsFloat>sq_asf then
        sq_asf:=dset.FieldByName('EXCW_SQASF').AsFloat;
       sq_green:=dset.fieldbyname('R_SQW').AsFloat-sq_asf;
       if sq_green<0 then sq_green:=0;
       if ( dset.FieldByName('splan_dt').IsNull ) or(dset.FieldByName('splan_dt').AsDateTime>F_BegDoDt) then
        begin
         if sq_green > 0 then
         begin
         frResult.FieldByName('need_zel_count').AsInteger:=frResult.FieldByName('need_zel_count').AsInteger+1;
         frResult.FieldByName('need_zel_sqw').AsFloat:=frResult.FieldByName('need_zel_sqw').AsInteger+sq_green;
         end;
        end;
       if dset.FieldByName('class1').AsInteger<4 then
       begin
         if sq_asf>0 then
         begin
           if (dset.FieldByName('blag_dt').IsNull) or (dset.FieldByName('blag_dt').AsDateTime>F_BegDoDt) then
             begin
              frResult.FieldByName('need_asf_count').AsInteger:=frResult.FieldByName('need_asf_count').AsInteger+1;
              frResult.FieldByName('need_asf_sqw').AsFloat:=frResult.FieldByName('need_asf_sqw').AsInteger+sq_asf;
             end;
         end;
       end;
       if (dset.FieldByName('splan_dt').AsDateTime>F_BegDoDt) and (dset.FieldByName('splat_dt').AsDateTime<F_EndDoDt+1) then
         begin
           frResult.FieldByName('do_green_count').AsInteger:=frResult.FieldByName('do_green_count').AsInteger+1;
           frResult.FieldByName('do_green_sqw').AsFloat:=frResult.FieldByName('do_geen_sqw').AsInteger+sq_green;
         end;
       if (dset.FieldByName('blag_dt').AsDateTime>F_BegDoDt) and (dset.FieldByName('blag_dt').AsDateTime<F_EndDoDt+1) then
         begin
           frResult.FieldByName('do_asf_count').AsInteger:=frResult.FieldByName('do_asf_count').AsInteger+1;
           frResult.FieldByName('do_asf_sqw').AsFloat:=frResult.FieldByName('do_asf_sqw').AsInteger+sq_asf;
         end;
      end;

   end;
begin
 str_beg:=DateToStr(F_BegRDt);
 str_end:=DateToStr(F_EndRDt);
 str_grant:=DateToStr(F_BegRDt-360);
 OpenDset;
 result:=false;
 if AddResions then

 try
   frResult.First;
   while  not frResult.Eof do
   begin
   frResult.Edit;
   dset.SelectSQL.Text:=Format(sql_sel,[frResult.FieldByName('id_region').AsInteger,str_grant,str_beg, str_end]) ;
   dset.Open;
   dset.First;
   while dset.Eof do
   begin
     AddCount();
     dset.Next;
   end;
   frResult.Post;
   end;
   result:=true;
 except
  result:=false;
 end
 else
 result:=false;
end;

end.
