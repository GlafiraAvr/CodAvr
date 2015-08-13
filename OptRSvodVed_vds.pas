unit OptRSvodVed_vds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OptRSvodVed, Buttons, StdCtrls, ExtCtrls, SelRegionFrame,
  SelDateTimePeriodFrame , SelectItemForm,DModule, DB, IBCustomDataSet,
  HelpFunctions;

type
  Tfrm_OptRSvod_vds = class(Tfrm_OptRSvod)
    btn_about: TButton;
    cb_leak: TCheckBox;
    dset: TIBDataSet;
    procedure btn_aboutClick(Sender: TObject);
    procedure cb_leakClick(Sender: TObject);
  private
    { Private declarations }
    AddLeakMessage:string;
    function getLeak:boolean;

    procedure setLeakMessage();
  public
    { Public declarations }
    property isLeak :boolean read getLeak;
  end;

var
  frm_OptRSvod_vds: Tfrm_OptRSvod_vds;

implementation

{$R *.dfm}

procedure Tfrm_OptRSvod_vds.btn_aboutClick(Sender: TObject);
var sql:string;
begin
  inherited;
   SQL:='  select id ItemID, MESSAGENAME ItemName, activity from S_MESSAGETYPES_VDS '+
 ' where id>0 and  activity is  null and MESSAGENAME is not null order by MESSAGENAME';
  ShowSelectItemsDlg(SQL, 'О чем заявлено', F_DamagePlace_ID, F_DamagePlace_Name);


end;

function Tfrm_OptRSvod_vds.getLeak:boolean;
var sQl:string;
begin
  Result :=  cb_leak.Checked;


end;

procedure Tfrm_OptRSvod_vds.setLeakMessage();
var SQL:string;
begin
 if AddLeakMessage='' then
 begin
 SQL := ' select id ItemID, MESSAGENAME ItemName, activity from S_MESSAGETYPES_VDS'+
                         ' where group_message =1 and  activity is  null and MESSAGENAME is not null ';
 try
  MyOpenIBDS(dset,sQl);
  try
  F_DamagePlace_ID:='';
  dset.First;
  while  not dset.Eof do
  begin
    F_DamagePlace_ID:= F_DamagePlace_ID +','+ dset.fieldbyname( 'ItemID').AsString;
    dset.Next;
  end;
  delete(F_DamagePlace_ID,1,1);
  F_DamagePlace_ID:='('+F_DamagePlace_ID+')';
  AddLeakMessage:=F_DamagePlace_ID;
  finally
   dset.Close;
  end;
  except

   begin
    Application.MessageBox('Ошибка чтения из базы!! ', 'Авр jib,rf',MB_OK+MB_ICONERROR);
   end;
  end
  end
  else
   F_DamagePlace_ID:=AddLeakMessage;

end;



procedure Tfrm_OptRSvod_vds.cb_leakClick(Sender: TObject);
begin
  inherited;
   if cb_leak.Checked then
   begin
    setLeakMessage();
    btn_about.Enabled:=false;
   end
   else
   begin
     F_DamagePlace_ID:='';
     btn_about.Enabled:=true;
   end
end;

end.
