unit NaledUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SecurityBaseForm , Dmodule, DB, IBCustomDataSet, RXSpin,
  StdCtrls, Mask, ToolEdit, DBCtrlsEh, DBLookupEh, IBDatabase, IBSQL,
  RxLookup, RXDBCtrl, CurrEdit;

type
  Tfrm_Naled = class(Tfrm_SecurityBase)
    dset: TIBDataSet;
    l_Square: TLabel;
    l_Volume: TLabel;
    l_Open: TLabel;
    l_Close: TLabel;
    dsource: TDataSource;
    BT_OK: TButton;
    BT_Cancel: TButton;
    ds_open: TDataSource;
    dset_open: TIBDataSet;
    dset_close: TIBDataSet;
    ds_close: TDataSource;
    tran: TIBTransaction;
    dset_openID: TIntegerField;
    dset_openNAME: TIBStringField;
    dset_openACTIVITY: TIBStringField;
    dset_closeID: TIntegerField;
    dset_closeNAME: TIBStringField;
    dset_closeACTIVITY: TIBStringField;
    DBL_Open: TRxDBLookupCombo;
    DBL_Close: TRxDBLookupCombo;
    te_Open: TDBDateTimeEditEh;
    de_Open: TDBDateTimeEditEh;
    de_Close: TDBDateTimeEditEh;
    te_Close: TDBDateTimeEditEh;
    ce_Square: TRxDBCalcEdit;
    ce_Volume: TRxDBCalcEdit;
    DBL_Asfcompany: TRxDBLookupCombo;
    Label1: TLabel;
    ds_asfcompany: TDataSource;
    dset_asfcompany: TIBDataSet;
    IntegerField1: TIntegerField;
    IBStringField1: TIBStringField;
    procedure FormCreate(Sender: TObject);
    procedure BT_OKClick(Sender: TObject);
    procedure BT_CancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure de_OpenChange(Sender: TObject);
  private
    { Private declarations }
    F_OrderID: integer;
    F_OpenDTTM: TDateTime;
    F_Changed: boolean;
    F_isReadOnly: boolean;
    procedure OpenVocs;
    procedure InitDset;
    procedure InitControls;

  public
    { Public declarations }
    property OrderID: integer write F_OrderID;
    property OpenDTTM: TDateTime write F_OpenDTTM;
    property isReadOnly: boolean write F_isReadOnly;
  end;

var
  frm_Naled: Tfrm_Naled;

implementation

{$R *.dfm}

procedure Tfrm_Naled.FormCreate(Sender: TObject);
begin
  inherited;
 //

  OpenVocs;
  //InitDset;
  F_Changed := false;
end;

procedure Tfrm_Naled.OpenVocs;
begin
 if not dset_open.Active then
        dset_open.Open;
 if not dset_close.Active then
        dset_close.Open;

 if not dset_asfcompany.Active then
        dset_asfcompany.Open;

end;


procedure Tfrm_Naled.InitDset;
var _SQL : string;
begin
   //
   _SQL := 'select ID, FK_NALED_ORDERS,  SQUARE,  VOLUME,  FK_NALED_OFFICIALOPEN'+
    ',  DTTM_OPEN,  FK_NALED_OFFICIALCLOSED,  DTTM_CLOSED, FK_NALED_ASFCOMPANY from NALED '+
    ' where FK_NALED_ORDERS = ' + inttostr( F_OrderID );

    dset.SelectSQL.Text := _SQL;

  _SQL := ' insert into NALED '+
  '(FK_NALED_ORDERS, SQUARE, VOLUME, FK_NALED_OFFICIALOPEN '+
    ', DTTM_OPEN, FK_NALED_OFFICIALCLOSED, DTTM_CLOSED, FK_NALED_ASFCOMPANY )  '+
   ' values '+
    '(:FK_NALED_ORDERS, :SQUARE, :VOLUME, :FK_NALED_OFFICIALOPEN '+
    ', :DTTM_OPEN, :FK_NALED_OFFICIALCLOSED, :DTTM_CLOSED, :FK_NALED_ASFCOMPANY )  ';

    dset.InsertSQL.Text := _SQL;

    _SQL := ' update NALED set '+
      ' FK_NALED_ORDERS = :FK_NALED_ORDERS '+
      ', SQUARE = :SQUARE '+
      ', VOLUME = :VOLUME '+
      ', FK_NALED_OFFICIALOPEN = :FK_NALED_OFFICIALOPEN '+
      ', DTTM_OPEN = :DTTM_OPEN '+
      ', FK_NALED_OFFICIALCLOSED = :FK_NALED_OFFICIALCLOSED '+
      ', FK_NALED_ASFCOMPANY = :FK_NALED_ASFCOMPANY '+
      ', DTTM_CLOSED = :DTTM_CLOSED'+
      ' where ID = :ID ';

    dset.ModifySQL.Text := _SQL;

    if not dset.Active then dset.Open;

    dset.First;
    if dset.Eof then dset.Append else dset.Edit;
    dset.FieldByName('FK_NALED_ORDERS').AsInteger := F_OrderID;

end;

procedure Tfrm_Naled.BT_OKClick(Sender: TObject);
var _SQL: string;
begin
//
  if F_Changed then
   begin
    //dset.FieldByName('SQUARE').AsFloat := sp_Square.Value ;
    //dset.FieldByName('VOLUME').AsFloat := sp_Volume.Value ;
    dset.Post;
    tran.Commit;
   end;

  Close;
end;


procedure Tfrm_Naled.BT_CancelClick(Sender: TObject);
begin
  inherited;
 //
 dset.Cancel;
 tran.Rollback;
 close;
end;

procedure Tfrm_Naled.FormShow(Sender: TObject);
begin
  inherited;
  InitDset;
  InitControls;
end;

procedure Tfrm_Naled.de_OpenChange(Sender: TObject);
begin
  inherited;
  F_Changed := true;
end;

procedure Tfrm_Naled.InitControls;
var _val : boolean;
begin
    //
  _val := (not F_isReadOnly);

  de_Open.Enabled := _val;
  te_Open.Enabled := _val;
  DBL_Open.Enabled := _val;

  de_Close.Enabled := _val;
  te_Close.Enabled := _val;
  DBL_Close.Enabled := _val;

  ce_Square.Enabled := _val;
  ce_Volume.Enabled := _val;

  DBL_Asfcompany.Enabled := _val;
  BT_OK.Enabled := _val;

end;

end.
