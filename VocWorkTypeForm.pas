unit VocWorkTypeForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseVocForm, DB, IBCustomDataSet, IBDatabase, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, IBSQL, DModule;

type
  Tfrm_VocWorkType = class(Tfrm_BaseVoc)
    pnl_Works: TPanel;
    ed_WorkType: TDBEdit;
    Label1: TLabel;
    dset_MainVocID: TIntegerField;
    dset_MainVocNAME: TIBStringField;
    dset_MainVocACTIVITY: TSmallintField;
    dbg_Work: TDBGrid;
    btn_AddWorks: TBitBtn;
    btn_DelWorks: TBitBtn;
    dset_Work: TIBDataSet;
    ds_Work: TDataSource;
    dset_WorkID: TIntegerField;
    dset_WorkID_WORKTYPE: TIntegerField;
    dset_WorkID_WORK: TIntegerField;
    dset_WorkWORK_NAME: TIBStringField;
    IBSQL: TIBSQL;
    tr_Exec: TIBTransaction;
    procedure btn_AddWorksClick(Sender: TObject);
    procedure btn_DelWorksClick(Sender: TObject);
  protected
    class function IsCurrentUserCanEdit: boolean; override;
  protected
    procedure EnableCtrls(value: boolean); override;
    procedure OpenDataset; override;
    procedure CloseDataset; override;
    procedure EnableChngBtns(value: boolean); override;
  private
    procedure AddWorks;
    procedure DeleteWork;
  public

  end;

implementation

{$R *.dfm}

uses HelpFunctions, SelectItemForm, RightsManagerDModule, AppGUIDS;

procedure Tfrm_VocWorkType.AddWorks;
var
  _SelSQL, _cond: string;
  _ItemList: TStringList;
  i: integer;
begin
  {Condition}
  with dset_work do
  begin
    DisableControls;
    try
      _cond := '';
      First;
      while not Eof do
      begin
        _cond := _cond + ',' + FieldByName( 'id_work' ).AsString;
        Next;
      end;
    finally
      EnableControls;
    end;
  end;
  System.Delete( _cond, 1, 1);
  if trim( _cond ) <> '' then _cond := ' and not( id in(' + _cond + ') )';
  {/Condition}


  _SelSQL :=
    ' select id ItemID, name ItemName' +
    ' from s_works' +
    ' where (id > 0)' +
    ' and (activity is null)' +
    _cond +
    ' order by name';

  _ItemList := TStringList.Create;
  try
    ShowSelectItemsDlg( _SelSQL, 'Привязать к виду работы', _ItemList );
    if _ItemList.Count > 0 then
    begin
      if tr_Exec.InTransaction then tr_Exec.Rollback;
      tr_Exec.StartTransaction;
      try
        for i:=0 to _ItemList.Count-1 do
          MyExecIBSQL( IBSQL,
            ' insert into s_worktype_work(id_worktype, id_work)' +
            ' values(' +
            dset_MainVoc.FieldByName( 'id' ).AsString + ',' +
            IntToStr( Integer( _ItemList.Objects[i] ) ) + ')' );

        tr_Exec.Commit;
      except
        on E: Exception do
        begin
          tr_exec.Rollback;
          raise Exception.Create( E.Message + '(Tfrm_VocWorkType.AddWorks)' );
        end;
      end;
    end;
  finally
    _ItemList.Free;
  end;

  dset_work.Close;
  dset_work.Open;
end;

procedure Tfrm_VocWorkType.CloseDataset;
begin
  inherited CloseDataset;
  dset_Work.Close;
end;

procedure Tfrm_VocWorkType.EnableChngBtns(value: boolean);
begin
  inherited EnableChngBtns( value );
  btn_AddWorks.Enabled := value;
  btn_DelWorks.Enabled := value;
end;

procedure Tfrm_VocWorkType.EnableCtrls(value: boolean);
begin
  inherited EnableCtrls( value );
  pnl_EditFields.Visible := value;
end;

procedure Tfrm_VocWorkType.OpenDataset;
begin
  inherited OpenDataset;
  dset_Work.Open;
end;

procedure Tfrm_VocWorkType.btn_AddWorksClick(Sender: TObject);
begin
  AddWorks;
end;

procedure Tfrm_VocWorkType.DeleteWork;
var
  _ExecSQL: string;
begin
  _ExecSQL :=
    ' delete from s_worktype_work' +
    ' where id = ' + dset_Work.FieldByName( 'id' ).AsString;

  if not dset_Work.IsEmpty then
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
        raise Exception.Create( E.Message + '(Tfrm_VocWorkType.DeleteWork)' );
      end;
    end;
    dset_Work.Close;
    dset_Work.Open;
  end;
end;

procedure Tfrm_VocWorkType.btn_DelWorksClick(Sender: TObject);
begin
  DeleteWork;
end;

class function Tfrm_VocWorkType.IsCurrentUserCanEdit: boolean;
begin
  Result := ( DM_RightsManager.IsCurrentUserCanEditForm(  ALLVOCFORMGUID ) or
              DM_RightsManager.IsCurrentUserCanEditForm(  DEP_VOC ) );
end;

end.
