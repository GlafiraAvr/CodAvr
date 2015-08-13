unit Search1562Form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseOptionForm, StdCtrls, Buttons, Mask, ToolEdit;

type
  Tfrm_Search1562 = class(Tfrm_BaseOption)
    btn_ok: TBitBtn;
    lbl_DateComing1: TLabel;
    dp_Coming1: TDateEdit;
    tp_Coming1: TMaskEdit;
    lbl_DateComing2: TLabel;
    dp_Coming2: TDateEdit;
    tp_Coming2: TMaskEdit;
    btn_cancel: TBitBtn;
    btn_Regions: TBitBtn;
    procedure BT_OKClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure btn_RegionsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    F_Regions: string;
    F_ResultCondition: string;
    F_RegionList:TStringList;

    F_strRegions: string;
    F_strStartDate: string;
    F_strFinishedDate: string;
   
    F_ShortTableName: string;
    procedure AddSubConstraint(var Res: string;  Constraint: string);
  public

    property ResultCondition: string read F_ResultCondition;
    property strRegions: string read F_strRegions;
    property strStartDate: string read F_strStartDate;
    property strFinishedDate: string read F_strFinishedDate;
    property ShortTableName: string write F_ShortTableName;
    property RegionList:TStringList read   F_RegionList  ;
  end;

var
  frm_Search1562: Tfrm_Search1562;

implementation

{$R *.dfm}

uses SelectItemForm, HelpFunctions;

procedure Tfrm_Search1562.BT_OKClick(Sender: TObject);
var reg_con:string;
begin
 // F_ResultCondition:=' where 1=1';
  if dp_Coming1.Date<>0 then
    begin
   //   F_ResultCondition:=F_ResultCondition+Format(' and %sDatatime>=''%s '+ tp_Coming1.text + ''' ', [F_ShortTableName, DateToStr(dp_Coming1.Date)]);
      F_strStartDate:=formatDatetime('mm/dd/yyyy',dp_Coming1.Date)+tp_Coming1.Text; //DateToStr(dp_Coming1.Date);
    end;
  if dp_Coming2.Date<>0 then
    begin
     // F_ResultCondition:=F_ResultCondition+Format(' and %sDatatime<=''%s '+ tp_Coming2.text + ''' ', [F_ShortTableName, DateToStr(dp_Coming2.Date)]);
      F_strFinishedDate:=formatDatetime('mm/dd/yyyy',dp_Coming2.Date)+' '+tp_Coming2.Text;
    end;
   if  F_Regions<>'' then
   reg_con:=' and id_rayon in '+F_Regions
   else
   reg_con:='';

//  AddSubConstraint(F_ResultCondition, F_Regions);}
  F_ResultCondition:=Format('select * from DateTime_KhNew_Select_vw  where'+
                            ' DateOurRequest>=''%s %s'' and DateOurRequest<=''%s %s'''+
                            reg_con,
                              [formatDatetime('mm/dd/yyyy', dp_Coming1.Date ),
                               tp_Coming1.Text,
                               formatDatetime('mm/dd/yyyy', dp_Coming2.Date ),
                               tp_Coming2.Text]);
  ModalResult:=mrOk;
end;

procedure Tfrm_Search1562.AddSubConstraint(var Res: string;
  Constraint: string);
begin
  if trim(Constraint)<>'' then
    Res:=Res+' and '+Constraint;
end;


procedure Tfrm_Search1562.btn_cancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure Tfrm_Search1562.btn_RegionsClick(Sender: TObject);
var
  SQL, ItemsID, ItemsName: string;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_regions'+
        ' where id<>-1 and activity is null'+
        ' order by name';
  F_RegionList:=TStringList.create;
  ShowSelectItemsDlg(SQL,'Район',F_Regions,ItemsName);
//  ShowSelectItemsDlg(SQL, 'Район', F_Regions);
 { if ItemsID<>'' then
  begin
   // F_Regions:=Format('%sFK_SPISOK1562_RAYON in %s', [F_ShortTableName, ItemsID]);
   // F_strRegions:=ItemsName;
  end;}
end;

procedure Tfrm_Search1562.FormCreate(Sender: TObject);
begin
  F_ShortTableName:='';
  dp_Coming1.Date:=Date()-10;
   dp_Coming2.Date:=Date();
  tp_Coming1.Text := '00:00';
  tp_Coming2.Text := '23:59';

end;

procedure Tfrm_Search1562.FormShow(Sender: TObject);
begin
  F_RegionList:=TStringList.create;
  F_Regions:='';

  F_strRegions:='Все';
  F_strStartDate:='';
  F_strFinishedDate:='';
  dp_coming1.Date:=Now()-5;
  dp_coming2.Date:=Now();
  tp_Coming1.Text:='00:00';
  tp_Coming1.Text:='23:59';
  if (F_ShortTableName<>'') and (pos('.',F_ShortTableName)=0)  then
    F_ShortTableName:=F_ShortTableName+'.';

 // OpenDataSets;

end;

end.
