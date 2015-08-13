unit FloodingEditDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseEditDModule, IBDatabase, DB, IBCustomDataSet;

type
  Tdm_Flooding = class(Tdm_BaseEdit)
    dset_MainFK_ID_ORDER: TIntegerField;
    dset_MainABOUT: TIBStringField;
    dset_MainID: TIntegerField;
    procedure dset_MainAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
    F_order_id:integer;
  public
    { Public declarations }
    procedure OpenDset;
    property Order_id:integer write F_order_id;
    procedure Change();
    procedure Post;
  end;

var
  dm_Flooding: Tdm_Flooding;

implementation

{$R *.dfm}

procedure Tdm_Flooding.OpenDset;
begin
  inherited;
  dset_Main.ParamByName('id_order').AsInteger := F_order_id;
  dset_Main.Open;
end;



procedure Tdm_Flooding.dset_MainAfterInsert(DataSet: TDataSet);
begin
  inherited;
   dset_Main.FieldByName('FK_ID_ORDER').AsInteger:= F_order_id;
end;

procedure Tdm_Flooding.Change();
begin
 if DSet_main.State=dsBrowse then
  if F_LastRecordID>0 then
   dset_main.Edit
  else
   dset_main.Append;
end;


procedure Tdm_Flooding.Post;
begin
 if dset_main.State <>dsBrowse then
  if length(trim(dset_main.FieldByName('About').AsString))>0 then
   dset_main.Post
  else
   dset_main.Cancel;
end;




end.
