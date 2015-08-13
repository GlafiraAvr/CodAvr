unit VocWorkTimeForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, RxLookup;

type
  Tfrm_VocWorkTime = class(Tfrm_BaseVoc)
    dset_MainVocID: TIntegerField;
    dset_MainVocID_WORK: TIntegerField;
    dset_MainVocACTIVITY: TSmallintField;
    dset_Work: TIBDataSet;
    dset_Diam: TIBDataSet;
    ds_Work: TDataSource;
    ds_Diam: TDataSource;
    dbl_Work: TRxDBLookupCombo;
    dbl_Diam: TRxDBLookupCombo;
    ed_HourSummer: TDBEdit;
    ed_HourWinter: TDBEdit;
    lbl_Work: TLabel;
    lbl_Diam: TLabel;
    lbl_HourSummer: TLabel;
    lbl_HourWinter: TLabel;
    dset_MainVocHOUR_SUMMER: TIBBCDField;
    dset_MainVocHOUR_WINTER: TIBBCDField;
    dset_MainVocID_DIAM: TIntegerField;
    dset_DiamID: TIntegerField;
    dset_DiamNAME_: TIBStringField;
    dset_tmp: TIBDataSet;
    Label1: TLabel;
    ed_MeasurQuantity: TDBEdit;
    dset_MainVocMEASUR_QUANTITY: TIBBCDField;
    dset_MainVocDIAMETER: TIntegerField;
    dset_MainVocMEASUREMENT: TIBStringField;
    dset_MainVocWORK_NAME: TIBStringField;
    dset_MainVocclcFULL_WORK_NAME: TStringField;
    dset_WorkID: TIntegerField;
    dset_WorkWORK_NAME: TIBStringField;
    dset_WorkMEASUREMENT: TIBStringField;
    dset_WorkclcFULL_WORK_NAME: TStringField;
    procedure btn_InsertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dset_MainVocID_WORKChange(Sender: TField);
    procedure btn_PostClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure dset_MainVocCalcFields(DataSet: TDataSet);
  protected
    class function IsCurrentUserCanEdit: boolean; override;
  private
    F_IsWorkOrDiamChange: boolean;
  protected
    procedure EnableCtrls(value: boolean); override;
    procedure OpenDataset; override;
    procedure CloseDataset; override;
    function IsDataFieldsCorrect: boolean; override;
  public
  end;


implementation

{$R *.dfm}

uses HelpFunctions, AppGUIDS, RightsManagerDModule;

{ Tfrm_VocWorkTime }

procedure Tfrm_VocWorkTime.CloseDataset;
begin
  dset_Work.Close;
  dset_Diam.Close;
  inherited;
end;

procedure Tfrm_VocWorkTime.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);
  pnl_EditFields.Visible := value;
  {
  lbl_Work.Visible := value;
  lbl_Diam.Visible := value;
  lbl_HourSummer.Visible := value;
  lbl_HourWinter.Visible := value;

  dbl_Work.Visible := value;
  dbl_Diam.Visible := value;
  ed_HourSummer.Visible := value;
  ed_HourWinter.Visible := value;
  }
end;

procedure Tfrm_VocWorkTime.OpenDataset;
begin
  inherited;
  dset_Work.Open;
  dset_Diam.Open;
end;

procedure Tfrm_VocWorkTime.btn_InsertClick(Sender: TObject);
begin
  inherited;
  dset_MainVoc.FieldByName( 'id_Work' ).AsInteger := -1;
  dset_MainVoc.FieldByName( 'id_Diam' ).AsInteger := -1;
  dset_MainVoc.FieldByName( 'measur_quantity' ).AsFloat := 1;
end;

function Tfrm_VocWorkTime.IsDataFieldsCorrect: boolean;
begin
  MyOpenIBDS( dset_tmp,
    ' select id' +
    ' from s_worktime' +
    ' where id_work = ' + dset_Work.FieldByName( 'id' ).AsString +
    ' and id_diam = ' + dset_Diam.FieldByName( 'id' ).AsString );

  if not dset_tmp.IsEmpty and F_IsWorkOrDiamChange then
  begin
    Result := false;
    Application.MessageBox( 'Запись с такой работай и диаметром уже существует!',
      'Внимание', MB_OK + MB_ICONWARNING );
  end else
  if trim( ed_HourSummer.Text ) = '' then
  begin
    Result := false;
    Application.MessageBox( 'Не заполнено поле "Чел./часов (лето)"!',
      'Внимание', MB_OK + MB_ICONWARNING );
  end else
  if trim( ed_HourWinter.Text ) = '' then
  begin
    Result := false;
    Application.MessageBox( 'Не заполнено поле "Чел./часов (зима)"!',
      'Внимание', MB_OK + MB_ICONWARNING );
  end else
  if ( trim( ed_MeasurQuantity.Text ) = '' ) or ( StrToFloat( ed_MeasurQuantity.Text ) < 0.01 ) then
  begin
    Result := false;
    Application.MessageBox( 'Значение в поле "Количество" должно быть больше нуля!',
      'Внимание', MB_OK + MB_ICONWARNING );
  end else Result := true;
end;

procedure Tfrm_VocWorkTime.FormCreate(Sender: TObject);
begin
  inherited;
  F_IsWorkOrDiamChange := false;
end;

procedure Tfrm_VocWorkTime.dset_MainVocID_WORKChange(Sender: TField);
begin
  F_IsWorkOrDiamChange := true;
end;

procedure Tfrm_VocWorkTime.btn_PostClick(Sender: TObject);
begin
  if Post then F_IsWorkOrDiamChange := false;
end;

procedure Tfrm_VocWorkTime.btn_CancelClick(Sender: TObject);
begin
  inherited;
  F_IsWorkOrDiamChange := false;
end;

class function Tfrm_VocWorkTime.IsCurrentUserCanEdit: boolean;
begin
  Result := ( DM_RightsManager.IsCurrentUserCanEditForm(  ALLVOCFORMGUID ) or
              DM_RightsManager.IsCurrentUserCanEditForm(  DEP_VOC ) );
end;

procedure Tfrm_VocWorkTime.dset_MainVocCalcFields(DataSet: TDataSet);
var
  _measur, _wrk: string;
begin
  with DataSet do
  begin
    _wrk := trim( FieldByName( 'work_name' ).AsString );
    _measur := trim( FieldByName( 'measurement' ).AsString );
    if _measur <> '' then
      _wrk := _wrk + ' (' + _measur + ')';
    FieldByName( 'clcFULL_WORK_NAME' ).AsString := _wrk;
  end;
end;

end.
