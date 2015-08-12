unit BWorkForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, RxLookup, Mask, DBCtrls, ComCtrls, IBSQL,
  DModule;

type
  TWorkInfo = (wiSubworks, wiMaters);

  Tfrm_VocBWork = class(Tfrm_BaseVoc)
    dset_MainVocID: TIntegerField;
    dset_MainVocNAME_: TIBStringField;
    dset_MainVocACTIVITY: TSmallintField;
    Label1: TLabel;
    pnl_Subwork: TPanel;
    ed_Name: TDBEdit;
    ds_Subwork: TDataSource;
    dset_Subwork: TIBDataSet;
    dset_SubworkNAME: TIBStringField;
    BitBtn1: TBitBtn;
    PageControl1: TPageControl;
    ts_Subworks: TTabSheet;
    ts_Maters: TTabSheet;
    dbg_Subwork: TDBGrid;
    Panel1: TPanel;
    sb_AddSubworks: TSpeedButton;
    sb_DelSubwork: TSpeedButton;
    tr_Exec: TIBTransaction;
    IBSQL: TIBSQL;
    BitBtn2: TBitBtn;
    dset_Maters: TIBDataSet;
    ds_Maters: TDataSource;
    dbg_Maters: TDBGrid;
    Panel2: TPanel;
    sb_AddMater: TSpeedButton;
    sb_DelMater: TSpeedButton;
    BitBtn3: TBitBtn;
    dset_MatersNAME: TIBStringField;
    dset_MatersMEASUREMENT: TIBStringField;
    dset_SubworkDIAMETER: TIntegerField;
    dset_SubworkID_WORK: TIntegerField;
    dset_SubworkID_DIAM: TIntegerField;
    dset_SubworkID: TIntegerField;
    dset_WorkTime: TIBDataSet;
    dset_WorkTimeID: TIntegerField;
    dset_WorkTimeID_WORK: TIntegerField;
    dset_WorkTimeID_DIAM: TIntegerField;
    dset_MatersID_MATER: TIntegerField;
    dset_MatersID: TIntegerField;
    dset_VocMater: TIBDataSet;
    dset_VocDiam: TIBDataSet;
    dset_MatersDIAMETER: TIntegerField;
    dset_MatersID_DIAM: TIntegerField;
    procedure sb_AddSubworksClick(Sender: TObject);
    procedure sb_DelSubworkClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure sb_AddMaterClick(Sender: TObject);
    procedure sb_DelMaterClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure dset_SubworkDIAMETERGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dset_MatersDIAMETERGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
  protected
    class function IsCurrentUserCanEdit: boolean; override;
  protected
    procedure EnableCtrls(value: boolean); override;
    procedure OpenDataset; override;
    procedure CloseDataset; override;
    procedure EnableChngBtns(value: boolean); override;
  private
    procedure AddSubworks;
    procedure AddMaters;
    procedure Delete( _WorkInfo: TWorkInfo );
  public
  end;


implementation

{$R *.dfm}

uses SelectItemForm, HelpFunctions, VocManager, VocBWorkAddMaterForm, AppGUIDS,
  RightsManagerDModule;

{ Tfrm_VocBWork }

procedure Tfrm_VocBWork.CloseDataset;
begin
  dset_Subwork.Close;
  dset_Maters.Close;
  dset_WorkTime.Close;
  dset_VocMater.Close;
  dset_VocDiam.Close;
  inherited;
end;

procedure Tfrm_VocBWork.Delete(_WorkInfo: TWorkInfo);
var
  _ExecSQL: string;
  _dset: TDataSet;
begin
  case _WorkInfo of
    wiSubworks:
      begin
        _dset := dset_Subwork;
        _ExecSQL :=
          ' delete from s_bwork_work' +
          ' where id = ' + dset_Subwork.FieldByName( 'id' ).AsString;
      end;
    wiMaters:
      begin
        _dset := dset_Maters;
        _ExecSQL :=
          ' delete from s_bwork_mater' +
          ' where id = ' + dset_Maters.FieldByName( 'id' ).AsString;
      end;
  end;

  if not _dset.IsEmpty then
  begin
    if tr_Exec.InTransaction then tr_Exec.Rollback;
    tr_Exec.StartTransaction;
    try
      MyExecIBSQL( IBSQL, _ExecSQL );
      tr_Exec.Commit;
    except
      on E: Exception do
      begin
        tr_Exec.Rollback;
        raise Exception.Create( E.Message + '(Tfrm_VocBWork.Delete)' );
      end;
    end;
    _dset.Close;
    _dset.Open;
  end;
end;

procedure Tfrm_VocBWork.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls(value);
  pnl_EditFields.Visible := value;
end;

procedure Tfrm_VocBWork.OpenDataset;
begin
  inherited;
  dset_Subwork.Open;
  dset_Maters.Open;
  dset_WorkTime.Open;
  dset_VocMater.Open;
  dset_VocDiam.Open;
end;

procedure Tfrm_VocBWork.sb_AddSubworksClick(Sender: TObject);
begin
  AddSubworks;
end;

procedure Tfrm_VocBWork.sb_DelSubworkClick(Sender: TObject);
begin
  Delete( wiSubworks );
end;

procedure Tfrm_VocBWork.BitBtn2Click(Sender: TObject);
var
  VocMgr: TVocManager;
begin
  VocMgr:=TVocManager.Create;
  try
    VocMgr.ShowVoc( vnVocWorkTime, false );
  finally
    VocMgr.Free;
  end;

  dset_Subwork.Close;
  dset_Subwork.Open;
end;

procedure Tfrm_VocBWork.EnableChngBtns(value: boolean);
begin
  inherited EnableChngBtns( value );
  sb_AddSubworks.Enabled := value;
  sb_DelSubwork.Enabled := value;
  sb_AddMater.Enabled := value;
  sb_DelMater.Enabled := value;
end;

procedure Tfrm_VocBWork.sb_AddMaterClick(Sender: TObject);
begin
  AddMaters;
end;

procedure Tfrm_VocBWork.sb_DelMaterClick(Sender: TObject);
begin
  Delete( wiMaters );
end;

procedure Tfrm_VocBWork.BitBtn3Click(Sender: TObject);
var
  VocMgr: TVocManager;
begin
  VocMgr:=TVocManager.Create;
  try
    VocMgr.ShowVoc( vnVocMaterials, false );
  finally
    VocMgr.Free;
  end;

  dset_Maters.Close;
  dset_Maters.Open;
end;

procedure Tfrm_VocBWork.AddSubworks;
var
  _SelSQL, _cond: string;
  _ItemList: TStringList;
  i: integer;
begin
  {Condition}
  with dset_Subwork do
  begin
    DisableControls;
    try
      _cond := '';
      First;
      while not Eof do
      begin
        _cond := _cond + Format( 'or ( wt.id_work = %d and wt.id_diam = %d )',
          [ FieldByName( 'id_work' ).AsInteger, FieldByName( 'id_diam' ).AsInteger ] );
        Next;
      end;
    finally
      EnableControls;
    end;
  end;
  System.Delete( _cond, 1, 2);
  if trim( _cond ) <> '' then _cond := ' and not(' + _cond + ')';
  {/Condition}


  _SelSQL :=
    ' select wt.id ItemID,' +
    ' rtrim(w.name)||'' (d=''||d.diameter||'')'' ItemName' +
    ' from s_worktime wt' +
    ' left join s_works w on w.id = wt.id_work' +
    ' left join s_tubediameter d on d.id = wt.id_diam' +
    ' where (w.activity is null) and (d.activity is null)' +
    _cond +
    ' order by w.name, d.diameter';

  _ItemList := TStringList.Create;
  try
    ShowSelectItemsDlg( _SelSQL, 'Привязать к работе', _ItemList );
    if _ItemList.Count > 0 then
    begin
      if tr_Exec.InTransaction then tr_Exec.Rollback;
      tr_Exec.StartTransaction;
      try
        for i:=0 to _ItemList.Count-1 do
          if dset_WorkTime.Locate( 'id', Integer( _ItemList.Objects[i] ), [] ) then
            MyExecIBSQL( IBSQL,
              ' insert into s_bwork_work(id_bwork, id_work, id_diam)' +
              ' values(' +
              dset_MainVoc.FieldByName( 'ID' ).AsString + ',' +
              dset_WorkTime.FieldByName( 'id_work' ).AsString + ',' +
              dset_WorkTime.FieldByName( 'id_diam' ).AsString + ')' );

        tr_Exec.Commit;
      except
        on E: Exception do
        begin
          tr_exec.Rollback;
          raise Exception.Create( E.Message + '(Tfrm_VocBWork.AddSubworks)' );
        end;
      end;
    end;
  finally
    _ItemList.Free;
  end;

  dset_Subwork.Close;
  dset_Subwork.Open;
end;

procedure Tfrm_VocBWork.AddMaters;
var
  {
  _SelSQL, _cond: string;
  i: integer;
  _ItemList: TStringList;
  }
  _frm: Tfrm_VocBWorkAddMater;
begin
  {
  with dset_Maters do
  begin
    _cond := '-1';
    DisableControls;
    try
      First;
      while not Eof do
      begin
        _cond := _cond + ',' + FieldByName( 'id_mater' ).AsString;
        Next;
      end;
    finally
      EnableControls;
    end;
  end;


  _SelSQL :=
    ' select id ItemID, rtrim(name)||'' (''||rtrim(measurement)||'')'' as ItemName' +
    ' from materials' +
    ' where activity is null' +
    ' and not(id in ( ' + _cond + ' ))' +
    ' order by name';

  _ItemList := TStringList.Create;
  try
    ShowSelectItemsDlg( _SelSQL, 'Привязать к работе', _ItemList );
    if _ItemList.Count > 0  then
    begin
      if tr_Exec.InTransaction then tr_Exec.Rollback;
      tr_Exec.StartTransaction;
      try
        for i:=0 to _ItemList.Count-1 do
          MyExecIBSQL( IBSQL,
            ' insert into s_bwork_mater(id_bwork, id_mater)' +
            ' values(' +
            dset_MainVoc.FieldByName( 'ID' ).AsString + ',' +
            IntToStr( Integer( _ItemList.Objects[i] ) ) + ')' );

        tr_Exec.Commit;
      except
        on E: Exception do
        begin
          tr_Exec.Rollback;
          raise Exception.Create( E.Message + '(Tfrm_VocBWork.AddMaters)' );
        end;
      end;
    end;
  finally
    _ItemList.Free;
  end;
  }
  _frm := Tfrm_VocBWorkAddMater.Create( nil );
  try
    _frm.ds_Mater.DataSet := dset_VocMater;
    _frm.ds_Diam.DataSet := dset_VocDiam;

    if _frm.ShowModal = mrOk then
    begin
      if tr_Exec.InTransaction then tr_Exec.Rollback;
      tr_Exec.StartTransaction;
      try
        MyExecIBSQL( IBSQL,
          ' insert into s_bwork_mater(id_bwork, id_mater, id_diam)' +
          ' values(' +
          dset_MainVoc.FieldByName( 'ID' ).AsString + ',' +
          dset_VocMater.FieldByName( 'ID' ).AsString + ',' +
          dset_VocDiam.FieldByName( 'ID' ).AsString + ')' );

        tr_Exec.Commit;
      except
        on E: Exception do
        begin
          tr_Exec.Rollback;
          raise Exception.Create( E.Message + '(Tfrm_VocBWork.AddMaters)' );
        end;
      end;
    end;
  finally
    _frm.Free;
  end;

  dset_Maters.Close;
  dset_Maters.Open;
end;

procedure Tfrm_VocBWork.dset_SubworkDIAMETERGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if dset_Subwork.FieldByName( 'id_diam' ).AsInteger <> -1 then
    Text := Sender.AsString
  else
    Text := '';
end;

procedure Tfrm_VocBWork.dset_MatersDIAMETERGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if dset_Maters.FieldByName( 'id_diam' ).AsInteger <> -1 then
    Text := Sender.AsString
  else
    Text := '';
end;

class function Tfrm_VocBWork.IsCurrentUserCanEdit: boolean;
begin
  Result := ( DM_RightsManager.IsCurrentUserCanEditForm(  ALLVOCFORMGUID ) or
              DM_RightsManager.IsCurrentUserCanEditForm(  DEP_VOC ) );
end;

end.
