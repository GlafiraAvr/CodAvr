unit Spisok1562_FrameUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, Aligrid, DBGrids, RXDBCtrl, StdCtrls,
  Mask, ToolEdit, DB,DModule, IBDatabase, IBCustomDataSet, RxLookup,
 SelectItemForm, Buttons, ApplicationSettings;


type
  TSpisok1562_Frame = class(TFrame)
    p_MainPanel: TPanel;
    Grid: TRxDBGrid;
    p_BottomPanel: TPanel;
    dp_Coming1: TDateEdit;
    tp_Coming1: TMaskEdit;
    dp_Coming2: TDateEdit;
    tp_Coming2: TMaskEdit;
    lbl_DateComing2: TLabel;
    rb_InWorkAndNot: TRadioButton;
    rb_All: TRadioButton;
    Label1: TLabel;
    dset_region: TIBDataSet;
    tran_Voc: TIBTransaction;
    ds_region: TDataSource;
    dset_region2: TIBDataSet;
    ds_region2: TDataSource;
    rg_where: TRadioGroup;
    Regions: TButton;
    L_Regions: TLabel;
    rb_inworknot: TRadioButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DSET_UCHASTOK: TIBDataSet;
    procedure rb_InWorkAndNotClick(Sender: TObject);
    procedure rb_AllClick(Sender: TObject);
    procedure RegionsClick(Sender: TObject);
    procedure GridGetCellProps(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor);
    procedure GridDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure GridGetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; Highlight: Boolean);
    procedure GridTitleClick(Column: TColumn);


  private
    { Private declarations }

    F_ResultCondition: string;
    F_strStartDate: string;
    F_strFinishedDate: string;
    F_ID_Region:integer;
    F_APP:integer;
    F_RegionList:TStringList;
    F_regionNamelist:TStringList;
    F_isClosed:TstringList;
    f_SortColumn:tColumn;
    F_BufColumn:TColumn;
    F_Sort :boolean; //
   // F_ID_REGIOn2:integer;
    procedure AddSubConstraint(var Res: string;  Constraint: string);
    function RBFilterResult: string;
    procedure OpenVoc;
    procedure set_State(value:integer);
    function Get_State:integer;
  public
    { Public declarations }
    Coming1,Coming2:TDateTime;
    property strStartDate: string read F_strStartDate;
    property strFinishedDate: string read F_strFinishedDate;
    property ResultCondition: string read F_ResultCondition;
    property ID_Region:integer read F_ID_Region;
    property RegionList:TstringList read F_RegionList write F_RegionList;

    property APP:integer read F_APP write F_APP;
    property isclosed:TstringList read F_isclosed write F_isclosed;
   // property ID_Region2:integer read F_ID_Region2;

    procedure InitFilter;
    procedure GetFilter;
    Procedure CloseVoc;
    procedure SaveSettings();
    procedure LoadSettings();
    procedure SaveColumn();
    procedure LoadColumn();
  end;

implementation

{$R *.dfm}


procedure TSpisok1562_Frame.AddSubConstraint(var Res: string;
  Constraint: string);
begin
  if trim(Constraint)<>'' then
    Res:=Res+' and '+Constraint;
end;


procedure TSpisok1562_Frame.GetFilter;
   var str:string;
       str_app,str_regions,str_state,str_dt1,str_dt2:string;
       i:integer;
begin
// Доделать время!!!!2011

  {F_ResultCondition:=' where (1=1) ' ;
  if dp_Coming1.Date<>0 then
    begin
      F_ResultCondition:=F_ResultCondition+Format(' and (sp.datatime>=''%s '+ tp_Coming1.text + ''') ', [DateToStr(dp_Coming1.Date)]);
      F_strStartDate:=DateToStr(dp_Coming1.Date);
    end;
  if dp_Coming2.Date<>0 then
    begin
      F_ResultCondition:=F_ResultCondition+Format(' and (sp.datatime<=''%s '+ tp_Coming2.text + ''') ', [DateToStr(dp_Coming2.Date)]);
      F_strFinishedDate:=DateToStr(dp_Coming2.Date);
    end;
  AddSubConstraint(F_ResultCondition, RBFilterResult); }
 {*if rb_InWorkAndNot.Checked then
 begin
   F_ResultCondition:='EXEC spNEW_KhNEW_SELECT';

 end
  else
  begin}
  str_regions:='';
  str_app:='';

  if F_RegionList<>nil then
  if   F_RegionList.Count>0 then
   begin
   str_regions:=' and id_rayon in (';
   for i:=0 to   F_RegionList.Count-1 do
    str_regions:=str_regions+F_RegionList.Strings[i]+',';
   delete(str_regions,length(str_regions),1);
   str_regions:=str_regions+') ';
   end;

   if  rg_where.ItemIndex<2 then
    str_app:=' and Appurtenance='+IntToStr(rg_where.ItemIndex+2);

    if F_isclosed=nil then F_isclosed:=TstringList.Create
    else
      F_isclosed.Clear;
   str_state:='';
   if rb_InWorkAndNot.Checked then
   begin
    str_state:=' and state=0';
    F_isclosed.Add('0');
   end;
   if  rb_inworknot.Checked then
   begin
     str_state:=' and state<=1';
     F_isclosed.Add('0');
     F_isclosed.Add('1');
   end;
   if rb_All.Checked then
    begin
     F_isclosed.Add('0');
     F_isclosed.Add('1');
     F_isclosed.Add('3');
     str_dt1:=formatDatetime('mm/dd/yyyy', dp_Coming1.Date )+' '+tp_Coming1.Text;
     str_dt2:=formatDatetime('mm/dd/yyyy', dp_Coming2.Date )+' '+tp_Coming2.Text;
     str_dt1:=' DateOurRequest>='''+str_dt1+'''  and DateOurRequest<='''+str_dt2+''' ';
     F_strStartDate:=dp_Coming1.Text+' '+tp_Coming1.Text;
     F_strFinishedDate:=dp_Coming2.Text+' '+tp_Coming2.Text;
    end
    else
    begin
      str_dt1:=formatDatetime('mm/dd/yyyy', dp_Coming1.Date )+' '+tp_Coming1.Text;
     str_dt2:=formatDatetime('mm/dd/yyyy', dp_Coming2.Date )+' '+tp_Coming2.Text;
     str_dt1:=' DateOurRequest>='''+str_dt1+'''  and DateOurRequest<='''+str_dt2+''' ';
     F_strStartDate:=dp_Coming1.Text+' '+tp_Coming1.Text;
     F_strFinishedDate:=dp_Coming2.Text+' '+tp_Coming2.Text;
    end;

   {F_ResultCondition:=Format('exec spDateTime_KhNew_Select ''%s %s'', ''%s %s''',
                              [formatDatetime('mm/dd/yyyy', dp_Coming1.Date ),
                               tp_Coming1.Text,
                               formatDatetime('mm/dd/yyyy', dp_Coming2.Date ),
                               tp_Coming2.Text]);}

  {end; }
  F_ResultCondition:=Format('select * from DateTime_KhNew_Select_vw  where '+
                     str_dt1+
                     str_regions+
                     str_app+
                     str_state,[formatDatetime('mm/dd/yyyy', dp_Coming1.Date ),
                               tp_Coming1.Text,
                               formatDatetime('mm/dd/yyyy', dp_Coming2.Date ),
                               tp_Coming2.Text]);
  if F_SortColumn<> nil then
   if F_Sort then
     F_ResultCondition:= F_ResultCondition+' order by '+ F_SortColumn.FieldName+' desc'
    else
     F_ResultCondition:= F_ResultCondition+' order by '+ F_SortColumn.FieldName+' asc';
  F_ID_REGIOn:=dset_region.FieldByName('ID').AsInteger;
//  F_ID_REGIOn2:=dset_region2.FieldByName('ID').AsInteger;
  F_app:=rg_where.ItemIndex+1;


end;


procedure TSpisok1562_Frame.InitFilter;
begin
  if tp_Coming1.Text='  :  ' then
  begin
  tp_Coming1.Text := '01:00';
  tp_Coming2.Text := '23:59';
  dp_Coming1.Text := DateToStr(Now-5);
  dp_Coming2.Text := DateToStr(Now);
  end;
  OpenVoc;
  F_Sort:=true;
end;

function TSpisok1562_Frame.RBFilterResult: string;
begin
  if rb_InWorkAndNot.Checked then result := ' ((cw.is_closed is null) or (cw.is_closed = 0 )) '
  else Result := '';
end;

procedure TSpisok1562_Frame.rb_InWorkAndNotClick(Sender: TObject);
begin
{dp_Coming1.Enabled:=false;
dp_Coming2.Enabled:=false;
tp_Coming1.Enabled:=false;
tp_Coming2.Enabled:=false;}
end;

procedure TSpisok1562_Frame.rb_AllClick(Sender: TObject);
begin
{dp_Coming1.Enabled:=true;
dp_Coming2.Enabled:=true;
tp_Coming1.Enabled:=true;
tp_Coming2.Enabled:=true;}

end;

procedure TSpisok1562_Frame.OpenVoc;
begin
 if  not tran_voc.InTransaction then
  tran_voc.StartTransaction;
 if  not dset_region.Active then
   dset_region.Open;
 if  not dset_region2.Active then
   dset_region2.Open;
end;

procedure TSpisok1562_Frame.CloseVoc;
begin
if  dset_region.Active then
  dset_region.Close;
if  dset_region2.Active then
  dset_region2.Close;

if   tran_voc.InTransaction then
  tran_voc.Commit;
end;


procedure TSpisok1562_Frame.RegionsClick(Sender: TObject);
var i:integer;
    SQL:string;
    Res:boolean;
    F_LIST:TStringList;
begin
  SQL:= ' select id ItemID, name ItemName'+
        ' from s_regions'+
        ' where id<>-1 and activity is null'+
        ' order by name';
  //F_RegionList:=TStringList.create;
 F_LIST:= TStringList.create;
 if  F_RegionList<>nil   then
   if  F_RegionList.Count>0 then
    for i:=0 to F_RegionList.Count-1 do
     F_list.Add(F_regionList[i]);

  F_RegionNameList:=TstringList.Create;
  ShowSelectItemsDlg1(SQL, 'Район', F_LIST,Res,F_RegionNameList);
 if res then begin
 F_regionList.Free;
  F_regionList:=F_LISt;
  L_Regions.Caption:='';
   for i:=0 to  F_RegionNameList.Count-1 do
    L_Regions.Caption:= L_Regions.Caption+F_RegionNameList.Strings[i]+' ';
 end;   
end;

procedure TSpisok1562_Frame.GridGetCellProps(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor);
  {var _rus, _lat, _avar: string;
    _notchecked : boolean;
    _is_closed:integer;

  procedure MarkNew;
  begin
      //
       // (AFont as TFont).Style := [fsBold];
//        Background := clCream;
        Background := TColor($BBCCFF);
  end;

  procedure Marknotclosed;
  begin
      //
     // Background := TColor($8080FF);
     (AFont as TFont).Style := [fsBold];
  end;
  procedure MarkAvar;
  begin
      //
     // Background := TColor($8080FF);

     (AFont as TFont).Color := clRed;
  end;

  procedure MarkNormal;
  begin
      //
     // Background := TColor($8080FF);


  end;
  }
begin
if Field.Name='is_closed' then
 AFont.Style:=[fsbold];
 { _rus := 'А';//в русской раскладке
 _lat := 'A';//в латинской, по идее там всегда в латинской, но на всякий случай
             // еще и русскую проверяем
 _avar := trim(Field.DataSet.FieldByName('AVAR').AsString);
 if (_avar=_rus)or(_avar=_lat) then MarkAvar;
// _avar := trim(Field.DataSet.FieldByName('AVAR').AsString);
 _notchecked := ( Field.DataSet.FieldByName('NumOrder').IsNull );
 if not  Field.DataSet.FieldByName('is_closed').IsNull then
   _is_closed:=Field.DataSet.FieldByName('is_closed').AsInteger
  else
    _is_closed:=0;

   if ( not Highlight ) then
     begin

      if ( _notchecked ) then MarkNew;
      if ( _notchecked )and((_avar=_rus)or(_avar=_lat))  then Marknotclosed;
      if (_is_closed=0) and ( not  _notchecked)
       then Marknotclosed;
     // if (_is_closed=0)and ( (_avar=_rus)or(_avar=_lat)) then   Marknotclosed;

     end;
}
end;

procedure TSpisok1562_Frame.GridDrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
begin
  if Field.Name='is_closed' then
    Grid.Canvas.TextRect(Rect,1,1,Field.Value);
end;

procedure TSpisok1562_Frame.GridGetCellParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor; Highlight: Boolean);
  var _rus, _lat, _avar: string;
    _notchecked : boolean;
    _is_closed:integer;
      state:integer;
  procedure MarkNew;
  begin
      //
       // (AFont as TFont).Style := [fsBold];
//        Background := clCream;
        Background := TColor($BBCCFF);
  end;

  procedure Marknotclosed;
  begin
      //
     // Background := TColor($8080FF);
     (AFont as TFont).Style := [fsBold];
  end;
  procedure MarkAvar;
  begin
      //
     // Background := TColor($8080FF);

     (AFont as TFont).Color := clRed;
  end;

  procedure MarkNormal;
  begin
      //
     // Background := TColor($8080FF);


  end;
begin
_rus := 'А';//в русской раскладке
 _lat := 'A';//в латинской, по идее там всегда в латинской, но на всякий случай
             // еще и русскую проверяем
 _avar := trim(Field.DataSet.FieldByName('AVAR').AsString);
 if (_avar=_rus)or(_avar=_lat) then MarkAvar;
// _avar := trim(Field.DataSet.FieldByName('AVAR').AsString);
state:= Field.DataSet.FieldByName('state').AsInteger;
 if not  Field.DataSet.FieldByName('is_closed').IsNull then
   _is_closed:=Field.DataSet.FieldByName('is_closed').AsInteger
  else
    _is_closed:=0;

   if ( not Highlight ) then
     begin

      if ( state=0 ) then MarkNew;
      if ( state=0 )and((_avar=_rus)or(_avar=_lat))  then Marknotclosed;
      if (state=1)  
       then Marknotclosed;
     // if (_is_closed=0)and ( (_avar=_rus)or(_avar=_lat)) then   Marknotclosed;

     end;
end;

procedure TSpisok1562_Frame.SaveSettings();
var REgions:string;
    ID_REgions:string;
    i,State,Appurtenance:integer;
begin
   Regions:='';
   State:=Get_State;
   Appurtenance:=rg_where.ItemIndex;
   for i:=0 to F_RegionList.Count-1 do begin
    ID_Regions:=ID_Regions+F_RegionList.Strings[i]+',';
   end;
    Regions:=L_REgions.Caption;
   try
    AppSettings.Set_Regions(ID_REgions,Regions);
    AppSettings.Set_State(State);
    AppSettings.Set_Appurtenance(Appurtenance);
    AppSettings.Set_DateTime(dp_Coming1.Text+' '+tp_coming1.Text,dp_Coming2.Text+' '+tp_coming2.Text)

   except on e:exception
     do begin
       raise Exception.Create( E.Message +#13+ 'Не получилось записать ini файл');
     end;
   end;

end;


procedure TSpisok1562_Frame.set_State(value:integer);
begin
   case value of
   0: rb_InWorkAndNot.Checked:=true;
   1: rb_inworknot.Checked:=true;
   2: rb_All.Checked:=true;
   else
     rb_InWorkAndNot.Checked:=true;
  end;
end;

function TSpisok1562_Frame.get_State:integer;
begin
Result:=-1;
 if rb_InWorkAndNot.Checked then
  Result:=0;
 if rb_inworknot.Checked then
  Result:=1;
 if rb_All.Checked then
  Result:=2;
end;

procedure TSpisok1562_Frame.LoadSettings();
var REgions:string;
    ID_REgions:string;
    i,State,Appurtenance, p,n:integer;
    str:string;
    d1,d2,dt1,dt2:string;
    old_dateform:string;
begin
    old_dateform:=LongTimeFormat;
     LongTimeFormat:='hh:mm';
    F_REgionList:=TStringList.Create;
    try
     State:=AppSettings.Get_Sate;
     Appurtenance:=AppSettings.Get_Appurtenance;
     AppSettings.Get_Regions(ID_Regions,Regions);
     if AppSettings.Get_DateTime(dt1,dt2) then
      begin
        p:=pos(' ',dt1);
        d1:=copy(dt1,1,p-1);
        delete(dt1,1,p);
        try
         tp_Coming1.Text:=timeToStr(StrToTime(dt1));
        except
         tp_Coming1.Text:='00:00';
        end;
        p:=pos(' ',dt2);
        str:=copy(dt2,1,p-1);
        try
        begin
         dp_Coming1.Date:=StrToDate(d1);
         dp_Coming2.Date:=StrToDate(str);
         if StrToDate(str)<Date then
          begin
           dp_Coming1.Date:=StrToDate(d1)+(Date-StrToDate(str));
           dp_Coming2.Date:=Date;
          end
         else
          begin
           dp_Coming1.Date:=StrToDate(d1);
           dp_Coming2.Date:=StrToDate(str);
          end;
        end;
        except
        begin
          dp_Coming1.Date:=Date-7;
          dp_Coming2.Date:=Date;
        end;
        end;
        delete(dt2,1,p);
        try
        tp_Coming2.Text:=timeToStr(StrToTime(dt2));
        except
        tp_Coming2.Text:='23:59';
        end;
      end;
   try
    while Pos(',',ID_REgions)>0 do
    begin
      p:=Pos(',',ID_REgions);
      str:=Copy(ID_REGIONS,1,p-1);
      n:=StrToInt(str);
       if (n<0) or (n>9) then
       begin
        F_REgionList.Clear;
        Regions:='';
        break;
       end;
      F_REgionList.Add(str);
      delete(ID_REGIONS,1,p);
    end;
  except
   begin
    F_REgionList.Clear;
    Regions:='';
   end;
  end;
      L_Regions.Caption:=Regions;
    except on e:exception do
      raise Exception.Create( E.Message +#13+ 'Не получилось прочесть ini файл');
    end;
    rg_where.ItemIndex:=Appurtenance;

    Set_state(State);
 LongTimeFormat:=old_dateform;
end;


procedure TSpisok1562_Frame.SaveColumn;
begin
 F_BufColumn:=F_SortColumn;
 F_SortColumn:=nil;
end;

procedure TSpisok1562_Frame.LoadColumn;
begin

 F_SortColumn:= F_BufColumn;
end;



procedure TSpisok1562_Frame.GridTitleClick(Column: TColumn);
begin
if F_SortColumn<>nil then
 F_SortColumn.Title.Color:=Color;
if  F_SortColumn=Column then
 F_Sort:=not f_Sort
else
 F_Sort:=true;
if Column.FieldName<>'appuartenan_str' then
begin
F_SortColumn:=Column;
Column.Title.Color:=clSkyBlue;

end;
end;

end.
