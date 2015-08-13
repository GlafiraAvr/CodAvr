unit EditWorkForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, DBCtrls, RxLookup, Buttons, DB, DepPlanWorMatDModule;


const dlgrinzone=3;
type
  Tfrm_EditWork = class(TForm)
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    dbl_work: TRxDBLookupCombo;
    Label1: TLabel;
    Bevel1: TBevel;
    Label4: TLabel;
    ds_WorkAtt: TDataSource;
    ds_DiamAtt: TDataSource;
    ds_Work: TDataSource;
    dbt_Info: TDBText;
    ed_AddInfo: TDBEdit;
    Label5: TLabel;
    pnl_Exc: TPanel;
    pnl_Other: TPanel;
    Label2: TLabel;
    dbl_diam: TRxDBLookupCombo;
    Label3: TLabel;
    ed_quantity: TDBEdit;
    ed_Width: TDBEdit;
    ed_Depth: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ed_Length: TDBEdit;
    Label9: TLabel;
    ed_SQIARE_ASF: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    procedure btn_okClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbl_workChange(Sender: TObject);
    procedure dbl_workContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure dbl_workDropDown(Sender: TObject);
    procedure dbl_workCloseUp(Sender: TObject);
  private
    F_DamageLoc:integer;
    function IsFieldsCorrect: boolean;
    procedure AddPnlVisibleBuild;


  public
    property _DamageLoc:integer write F_DamageLoc;
  end;


implementation

{$R *.dfm}

uses GlobalData;

procedure Tfrm_EditWork.btn_okClick(Sender: TObject);
begin
  if IsFieldsCorrect then
    ModalResult := mrOk;
end;

procedure Tfrm_EditWork.btn_exitClick(Sender: TObject);
begin
  Close;
end;

function Tfrm_EditWork.IsFieldsCorrect: boolean;
var
  _s: string;
begin
  Result := false;
 {
  if ( not pnl_Exc.Visible ) and ( ds_Work.DataSet.FieldByName( 'clcWORKTIME' ).IsNull ) then
  begin
    _s :=
      'Невозможно сохранить данную запись, т.к. для' + #10#13 +
      'заданных значений работы и диаметра не найдено' + #10#13 +
      'соответствующего значения трудозатрат. Внесите' + #10#13 +
      'необходимое значение в справочник трудозатрат.';
    Application.MessageBox( PChar( _s ), 'Ошибка при сохранении', MB_OK + MB_ICONWARNING );
    dbl_Diam.SetFocus;
    exit;
  end;
  } // Пока что отключим нафиг проверку трудозатрат // by Vadim 10.06.2010
  Result := true;
  if  ds_WorkAtt.DataSet.FieldByName( 'id_workkind' ).AsInteger = WORKKIND_RASKOP_ID then
  begin
      if ds_work.DataSet.FieldByName('EXC_WIDTH').AsFloat=0 then
        begin
          _s:='Укажите ширину области раскопки!!';
          Application.MessageBox( PChar( _s ), 'Ошибка при сохранении', MB_OK + MB_ICONWARNING );
          ed_Width.SetFocus;
          result:=false;
        end
        else
        if ds_work.DataSet.FieldByName('EXC_LENGTH').AsFloat=0 then
         begin
          _s:='Укажите длинну области раскопки!!';
          Application.MessageBox( PChar( _s ), 'Ошибка при сохранении', MB_OK + MB_ICONWARNING );
          ed_Length.SetFocus;
          result:=false;
        end
   end



end;

procedure Tfrm_EditWork.AddPnlVisibleBuild;
  procedure _VisibPnls( _exc, _other: boolean );
  begin
    pnl_Exc.Visible := _exc;
   { if  F_DamageLoc=dlgrinzone then
     begin
      ed_SQIARE_ASF.Visible:=false;
      Label9.Visible:=false;
     end
     else
      begin
      ed_SQIARE_ASF.Visible:=true;
      Label9.Visible:=true;
     end  }

    pnl_Other.Visible := _other;
  end;
begin
  if ds_WorkAtt.DataSet.FieldByName( 'id_workkind' ).AsInteger = WORKKIND_RASKOP_ID then
    _VisibPnls( true, false )
  else
    _VisibPnls( false, true );
end;

procedure Tfrm_EditWork.FormShow(Sender: TObject);
begin
  AddPnlVisibleBuild;
end;

procedure Tfrm_EditWork.dbl_workChange(Sender: TObject);
begin
  AddPnlVisibleBuild;
end;

procedure Tfrm_EditWork.dbl_workContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
  var a:integer;
begin
a:=MousePos.Y;
end;

procedure Tfrm_EditWork.dbl_workDropDown(Sender: TObject);
begin
  btn_ok.Enabled:=false;
end;

procedure Tfrm_EditWork.dbl_workCloseUp(Sender: TObject);
begin
   btn_ok.Enabled:=true;
end;

end.
