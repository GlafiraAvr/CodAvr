unit TeamFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RxLookup, DModule, DB, IBDatabase, IBCustomDataSet,
  IBSQL, Buttons, ExtCtrls;

type
  TFrameTeamMode=(ftmVoc, ftmDep);

  Tframe_Team = class(TFrame)
    dbl_Brig: TRxDBLookupCombo;
    Label1: TLabel;
    lb_Src: TListBox;
    lb_Des: TListBox;
    dset_brig: TIBDataSet;
    dset_tmp: TIBDataSet;
    tran: TIBTransaction;
    ds_Brig: TDataSource;
    IBSQL: TIBSQL;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    btn_AddTeam: TBitBtn;
    procedure dbl_BrigChange(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_AddTeamClick(Sender: TObject);
  private
    F_IDBrig: integer;
    F_DepID: integer;
    F_OrderID: integer;
    F_Mode: TFrameTeamMode;
    F_IsReadOnly: boolean;
    F_Is_for_vds:boolean;
    F_Region_id:integer;
    F_PeopleCount:integer;
    procedure FillSrcList;
    procedure FillDesList;
    procedure FillDesListFromTeam;
    procedure FillDesListFromDep;
    procedure FillList(dset: TIBDataSet; lb: TListBox);
    procedure FixSrcList;
    procedure MoveItems(src, des: TListBox);
  public
    procedure Start;
    procedure Stop;
    procedure Save;
    constructor Create(AOwner: TComponent);
    property IDBrig: integer read F_IDBrig write F_IDBrig;
    property Mode: TFrameTeamMode read F_Mode write F_Mode;
    property OrderID: integer read F_OrderID write F_OrderID;
    property DepID: integer read F_DepID write F_DepID;
    property IsReadOnly: boolean read F_IsReadOnly write F_IsReadOnly;
    property Is_for_vds: boolean read F_Is_for_vds write F_Is_for_vds;
    property REgion_ID :integer read F_Region_id write F_Region_id ;
    property PeopleCount:integer read F_PeopleCount;
  end;

implementation

{$R *.dfm}

uses HelpFunctions;

{ Tframe_Team }

constructor Tframe_Team.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Is_for_vds:=false;
  F_IDBrig:=-1;
  F_Region_id:=0;
end;

procedure Tframe_Team.FillSrcList;
var add_str:string;
begin
if (F_Mode=ftmDep) and (F_Region_ID<>0)
then add_str:=Format(' and id_region=%d ',[F_Region_ID]);
  MyOpenIBDS(dset_tmp,
    ' select id, name, activity'+
    ' from workers'+
    ' where (id>0) and (activity is null)'+
     add_str+
    ' order by name');

  FillList(dset_tmp, lb_src);
end;

procedure Tframe_Team.Start;
begin
  if tran.InTransaction then
    tran.Rollback;
  tran.StartTransaction;

  dset_brig.Open;
  FixDBLValue(F_IDBrig, dbl_Brig);

  dbl_Brig.Enabled:=(F_Mode<>ftmDep);
  btn_AddTeam.Visible:=(F_Mode=ftmDep);

  if F_IsReadOnly then
  begin
    dbl_Brig.Enabled:=false;
    btn_Add.Enabled:=false;
    btn_Del.Enabled:=false;
    btn_AddTeam.Enabled:=false;
  end;
end;

procedure Tframe_Team.Stop;
begin
  if tran.InTransaction then
    tran.Commit;
end;

procedure Tframe_Team.dbl_BrigChange(Sender: TObject);
begin
  F_IDBrig:=dset_brig.FieldByName('ID').AsInteger;
  FillSrcList;
  FillDesList;
  FixSrcList;
end;

procedure Tframe_Team.FillDesList;
var
  dep_sql, team_sql: string;
begin
  case F_Mode of
    ftmVoc: FillDesListFromTeam;
    ftmDep: FillDesListFromDep;
  end;
end;

procedure Tframe_Team.FillList(dset: TIBDataSet; lb: TListBox);
begin
  lb.Clear;
  dset.First;
  while not dset.Eof do
  begin
    lb.AddItem(dset.FieldByName('name').AsString, ptr(dset.FieldByName('ID').AsInteger));
    dset.Next;
  end;
end;

procedure Tframe_Team.FixSrcList;
var
  i, j: integer;
begin
  i:=0;
  while i<lb_Src.Count do
  begin
    for j:=0 to lb_Des.Count-1 do
      if lb_Src.Items.Objects[i]=lb_Des.Items.Objects[j] then
        lb_Src.Items.Delete(i);
    inc(i);
  end;
end;

procedure Tframe_Team.MoveItems(src, des: TListBox);
var
  i: integer;
begin
  for i:=0 to src.Count-1 do
    if src.Selected[i] then
      des.AddItem(src.Items.Strings[i], src.Items.Objects[i]);
  src.DeleteSelected;
end;

procedure Tframe_Team.btn_AddClick(Sender: TObject);
begin
  MoveItems(lb_src, lb_des);
end;

procedure Tframe_Team.btn_DelClick(Sender: TObject);
begin
  MoveItems(lb_des, lb_src);
end;

procedure Tframe_Team.Save;
var
  i: integer;
begin
  if F_IsReadOnly then exit;

  case F_Mode of
    ftmVoc:
      begin
        MyExecIBSQL(IBSQL, Format('delete from WORKERTEAMS where FK_WTEAMS_BRIGADIER=%d',[F_IDBrig]));
        for i:=0 to lb_Des.Count-1 do
        begin
          MyExecIBSQL(IBSQL, Format(
          ' insert into WORKERTEAMS(FK_WTEAMS_BRIGADIER, FK_WTEAMS_WORKER)'+
          ' values(%d, %d)',[F_IDBrig, Integer(lb_Des.Items.Objects[i])]));
        end;
      end;
    ftmDep:
      begin
        case is_for_vds of
          true: MyExecIBSQL(IBSQL, Format('delete from DEPARTUREWORKERS_vds where FK_DEPWORKERS_DEPARTURE=%d',[F_DepID]));
          false:    MyExecIBSQL(IBSQL, Format('delete from DEPARTUREWORKERS where FK_DEPWORKERS_DEPARTURE=%d',[F_DepID]));
        end;
        for i:=0 to lb_Des.Count-1 do
        begin
        case is_for_vds of
          true:begin

            MyExecIBSQL(IBSQL, Format(
            ' insert into DEPARTUREWORKERS_vds(FK_DEPWORKERS_ORDERS, FK_DEPWORKERS_DEPARTURE, FK_DEPWORKERS_WORKERS)'+
            ' values(%d, %d, %d)',[F_OrderID, F_DepID, Integer(lb_Des.Items.Objects[i])]));

           end;
          false: begin

             MyExecIBSQL(IBSQL, Format(
           ' insert into DEPARTUREWORKERS(FK_DEPWORKERS_ORDER, FK_DEPWORKERS_DEPARTURE, FK_DEPWORKERS_WORKER)'+
           ' values(%d, %d, %d)',[F_OrderID, F_DepID, Integer(lb_Des.Items.Objects[i])]));
                 end;
         end;
        end;
        F_PeopleCount:=lb_Des.Count;
      end;
  end;
end;

procedure Tframe_Team.FillDesListFromTeam;
var
  sql: string;
begin
  sql:=Format(
    ' select w.id, w.name'+
    ' from workers w, workerteams t'+
    ' where (w.activity is null)'+
    ' and (w.id=t.fk_wteams_worker)'+
    ' and (t.fk_wteams_brigadier=%d)', [F_IDBrig]);

  MyOpenIBDS(dset_tmp, sql);
  FillList(dset_tmp, lb_Des);
end;

procedure Tframe_Team.FillDesListFromDep;
var
  sql: string;
  field,table :string;
  pr_ns_vds:integer;
begin
 case is_for_vds of
   true: begin   field:='fk_depworkers_workers';  table:='departureworkers_vds'; pr_ns_vds:=2;  end;
   false: begin  field:='fk_depworkers_worker'; table:='departureworkers';  pr_ns_vds:=1;  end;
 end;
  sql:=Format(
    ' select w.id, w.name'+
    ' from workers w, %s dw'+
    ' where (w.id=dw.%s)'+
    ' and (dw.fk_depworkers_departure=%d)'+
    ' and (w.id_region=%d)'+
    ' order by name', [table,field,F_DepID,F_Region_ID]);

  MyOpenIBDS(dset_tmp, sql);
  FillList(dset_tmp, lb_Des);
end;

procedure Tframe_Team.btn_AddTeamClick(Sender: TObject);
begin
  FillSrcList;
  FillDesListFromTeam;
  FixSrcList;
end;

end.
