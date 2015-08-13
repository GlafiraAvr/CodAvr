unit EquipPlannedForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DB, IBSQL, IBCustomDataSet,
  DModule, IBDatabase, SecurityBaseForm;

type
  Tfrm_EquipPlanned = class(Tfrm_SecurityBase)
    grid_Equip: TStringGrid;
    btn_Save: TBitBtn;
    btn_Close: TBitBtn;
    btn_Insert: TBitBtn;
    sql_tmp: TIBSQL;
    dset_tmp: TIBDataSet;
    dset_Regions: TIBDataSet;
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_InsertClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  protected
    class function GetGUID: string; override;
  private
    F_IsReadOnly: boolean;
    F_ShiftDate: TDate;
  public
    constructor Create(AOwner: TComponent);
  end;

  

implementation

uses GlobalData, HelpFunctions, AppGUIDS, shiftnumform;

{$R *.dfm}

procedure Tfrm_EquipPlanned.btn_CloseClick(Sender: TObject);
begin
  Close();
end;

procedure Tfrm_EquipPlanned.btn_InsertClick(Sender: TObject);
begin
  grid_Equip.RowCount := grid_Equip.RowCount + 1;
end;

procedure Tfrm_EquipPlanned.FormShow(Sender: TObject);
const
  SelectSQL=' SELECT ep.*, e.id as EqID, e.number as EqNumber'+
            ' from (EquipPlanned ep LEFT JOIN EQUIPMENT e'+
            ' ON ep.FK_EQUIPPLANNED_EQUIP = e.id)'+
            ' WHERE EQDATE =''%s'' AND'+
            ' FK_EQUIPPLANNED_REGIONS =%s ORDER BY ep.ID';
var
  i,j:integer;
begin
  dset_Regions.Transaction.StartTransaction;
  dset_Regions.Open;
  dset_Regions.First;
  i:=0;
  while not dset_Regions.Eof do
  begin
    if grid_Equip.ColCount<i+1 then
      grid_Equip.ColCount:=i+1;

    grid_Equip.ColWidths[i]:=105;
    grid_Equip.Cells[i,0]:=dset_Regions.FieldByName('Name').AsString;

    MyOpenSQL(dset_tmp, Format(SelectSQL,[DateToStr(F_ShiftDate)+' 18:00', dset_Regions.FieldByName('ID').AsString]));
    dset_tmp.First;
    j:=1;
    while not dset_tmp.Eof do
    begin
      if grid_Equip.RowCount<j+1 then
        grid_Equip.RowCount:=j+1;

      grid_Equip.Cells[i,j]:=dset_tmp.FieldByName('EqNumber').AsString;

      dset_tmp.Next;
      inc(j);
    end;
    dset_tmp.Close;

    dset_Regions.Next;
    inc(i);
  end;

  if F_IsReadOnly then
  begin
    btn_Insert.Enabled:=false;
    btn_Save.Enabled:=false;
    grid_Equip.Options:=grid_Equip.Options-[goEditing];
    Caption:=Caption+'- (у Вас нет прав на редактирование)';
  end;
end;

procedure Tfrm_EquipPlanned.btn_SaveClick(Sender: TObject);
const
  InsertSQL = ' INSERT INTO EquipPlanned(EQDATE, FK_EQUIPPLANNED_REGIONS,'+
              ' FK_EQUIPPLANNED_EQUIP) VALUES (''%s'', %s,'+
              ' (SELECT ID FROM EQUIPMENT WHERE number=%s))';
  DeleteSQL = ' DELETE FROM EquipPlanned WHERE CAST(EQDATE AS DATE)=''%s''';
var
  strNum:string;
  i,j:integer;
begin
  {Проверка ввода}
  for i:=0 to grid_Equip.ColCount-1 do
    for j:=1 to grid_Equip.RowCount-1 do
    begin
      strNum:=trim(grid_Equip.Cells[i,j]);
      if strNum<>'' then
      begin
        if not IsStringContainsInteger(strNum) then
          Exit;
        //'select id from equipment where Number =' + strNum);
        MyOpenSQL(dset_tmp,
          ' select e.id' +
          ' from equipment e' +
          ' inner join db_consts const on ( 1 = 1 )' +
          ' inner join db_districtvoc dv on ( dv.id_district = const.id_district )' +
          '     and (dv.id_region = e.id_region)' +
          '     and (dv.id_vocrectype = e.id_vocrectype )' +
          ' where (e.activity is null)' +
          ' and (Number =' + strNum + ')' );

        if dset_tmp.FieldByName('id').IsNull then
        begin
          MessageDlg('Оборудования с номером '+strNum +' нет в справочнике.',mtError,[mbOK],0);
          dset_tmp.Close;
          exit;
        end;
        dset_tmp.Close;
      end;
    end;
  {/Проверка ввода}

  {Ввод}
  if sql_tmp.Transaction.InTransaction then
    sql_tmp.Transaction.Rollback;

  sql_tmp.Transaction.StartTransaction;
  try
    MyExecSQL(sql_tmp, Format(DeleteSQL,[DateToStr(F_ShiftDate)]));
    dset_Regions.First;
    i:=0;
    while not dset_Regions.Eof do
    begin
      for j:=1 to grid_Equip.RowCount-1 do
      begin
        strNum:=trim(grid_Equip.Cells[i,j]);
        if strNum<>'' then
          MyExecSQL(sql_tmp, Format(InsertSQL,[DateToStr(F_ShiftDate)+' 18:00',
                    dset_Regions.FieldByName('ID').AsString,strNum]));
      end;
      dset_Regions.Next;
      inc(i);
    end;
  except
    sql_tmp.Transaction.Rollback;
    Raise;
  end;
  sql_tmp.Transaction.Commit;
  {/Ввод}
end;

procedure Tfrm_EquipPlanned.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dset_Regions.Transaction.Commit;
end;

constructor Tfrm_EquipPlanned.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  F_IsReadOnly:=not IsCurrentUserCanEdit
end;

class function Tfrm_EquipPlanned.GetGUID: string;
begin
  Result:=EQUIPPLANNEDFORMGUID;
end;

procedure Tfrm_EquipPlanned.FormCreate(Sender: TObject);
var
  _ShiftNum: integer;
begin
  GetShiftsNumAndDate(_ShiftNum, F_ShiftDate);
end;

end.
