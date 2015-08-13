unit RepGreenSpringDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, REpBlag4DModule, IBDatabase, IBCustomDataSet, FR_DSet, FR_DBSet,
  DB, kbmMemTable, FR_Class;

type
  Tdm_RepGreenSpring = class(Tdm_RepBlag4)
    mem_Itog: TkbmMemTable;
    frDBD_memItog: TfrDBDataSet;
    mem_ItogId_REgion: TIntegerField;
    mem_ItogRegion: TStringField;
    mem_Itogneed_asf_count: TIntegerField;
    mem_Itogneed_asf_sq: TFloatField;
    mem_Itogneed_gz_count: TIntegerField;
    mem_Itogneed_gz_sq: TFloatField;
    mem_Itogdo_asf_count: TIntegerField;
    mem_Itogdo_asf_sq: TFloatField;
    mem_Itogdo_gz_count: TIntegerField;
    mem_Itogdo_gr_sq: TFloatField;
    mem_Itogpercent_do_asf_count: TFloatField;
    mem_Itogpercent_do_asf_sq: TFloatField;
    mem_Itogpercent_do_gz_count: TFloatField;
    mem_Itogpercent_do_gz_sq: TFloatField;
  private
    { Private declarations }
      F_year:integer;
      procedure OpenSvod() ;  override;
      procedure CalcPartSvod(); override;
      procedure AddSvod(region_name:string; id_reg:integer); override;
      procedure PostSvod(); override;
      procedure CalAll();override;
      procedure SetSelStr(); override;
      function groupsel(id_region:integer):string; override;
      function LastMonthDayBlag():TDate; override;
   public
    { Public declarations }
    property  year:integer write  F_year;

  end;

var
  dm_RepGreenSpring: Tdm_RepGreenSpring;

implementation
uses HelpFunctions;

{$R *.dfm}
 procedure Tdm_RepGreenSpring.OpenSvod() ;
 begin
  if mem_Itog.Active then
    mem_Itog.Close;
  mem_Itog.Open;
 end;

 procedure Tdm_RepGreenSpring.CalcPartSvod();
 begin

  summfield(mem_Itog,'need_asf_count',asf_count);
  summfield(mem_Itog,'need_asf_sq',asf_sq);
  summfield(mem_Itog,'need_gz_count',zel_count);
  summfield(mem_Itog,'need_gz_sq',zel_sq);
  if resultDset.FieldByName('work_type_Z').AsString='ья'  then
               begin
                 summfield(mem_Itog,'do_gz_count',zel_count);
                 summfield(mem_Itog,'do_gz_sq',zel_sq);
               end;
  if resultDset.FieldByName('work_type').AsString='ью'  then
               begin
                 summfield(mem_Itog,'do_asf_count',asf_count);
                 summfield(mem_Itog,'do_asf_sq',asf_sq);
               end;
 end;

 procedure Tdm_RepGreenSpring.AddSvod(region_name:string;id_reg:integer);
 begin
  Add(mem_Itog,id_reg,region_name);
 end;

 procedure Tdm_RepGreenSpring.PostSvod();
  function mydiv(first,second:real):real;
  begin
    if first>0 then
     result:=first/second*100
    else
    result:=0;
  end;
 begin
  with mem_Itog do
  begin
    FieldByname('percent_do_asf_count').AsFloat:=mydiv(FieldByname('do_asf_count').AsFloat,FieldByname('need_asf_count').AsFloat);
    FieldByname('percent_do_asf_sq').AsFloat:=mydiv(FieldByname('do_asf_sq').AsFloat,FieldByname('need_asf_sq').AsFloat);
    FieldByname('percent_do_gz_count').AsFloat:=mydiv(FieldByname('do_gz_count').AsFloat,FieldByname('need_gz_count').AsFloat);
    FieldByname('percent_do_gz_sq').AsFloat:=mydiv(FieldByname('do_gz_sq').AsFloat,FieldByname('need_gz_sq').AsFloat);
   Post;
  end;

 end;

 procedure Tdm_RepGreenSpring.CalAll();
 begin
 end;

procedure Tdm_RepGreenSpring.SetSelStr();

    const SEL_Field='select gb.id_order,  gb.order_number, gb.adres,'+
                  '  gb.class1,  gb.class2, gb.id_dmgloc, '+
                  '  gb.raskop_dt,  gb.cheb_dt,        gb.blag_dt,'+
                  '  gb.r_sqw, gb.r_sqasf, gb.excw_sqasf,gb.excw_sq, '+
                  '  gb.num_form3, gb.num_form7,gb.excorder,'+
                  '  gb.dat_excorder, gb.confirm_blag , '+
                  '  gb.last_work ,gb.STREET_NAME, ADDITIONALADDRESS,HOUSENUM,STREET_TYP, '+
                  '  gb.SPLAN_DT, gb.DATE_READABILITY_DOCS, gb.DAT_CLOSEDORDER ,'+
                  '  gb.DTTM_PLANENDWORK ' +
                  '   from GET_BLAG_Green(%d,%d) gb  ';
         sel_order=' order  by  STREET_NAME';
begin
 SelStr:=SEL_Field+sel_order;
end;

function Tdm_RepGreenSpring.groupsel(id_region:integer):string;
begin
 result:=Format(SelStr,[id_region,F_year]);
end;

function Tdm_RepGreenSpring.LastMonthDayBlag():TDate;
begin
  result:=LastMonthDay(FinishEnd);
end;



end.
