unit DepPlanWorkManager;


interface

uses DepPlanWorMatDModule,FormDepPlanWorMat,EditWorkBuffForm,DModule,Forms,Controls,
Windows,GlobalData, AddWorkForm,EditMaterForm;

type
TDepPlanWorkManager=class
 dm_Plan:Tdm_DepPlanWorMat;
 frm_Dep:Tfrm_DepPlanWorkMat;
/// frm_work:Tfrm_EditWorkBuff;
 private
 F_IdOrder:integer;
 F_IdDep:integer;
 F_Change:integer;
 F_typ:integer; //1-ns 2-vds
  procedure OnChangeWorksHandler(action:TAction);
  procedure OnDelWorkHandler(Sender: TObject);
  procedure OnChangeMaterssHandler(action:TAction);
  procedure OnDelMatersHandler(Sender: TObject);
  procedure SetType(typ:integer);
 public
 F_IdDisp:integer;
 property _IDOrder:integer write F_IdOrder;
 property IdDep:integer write F_IdDep;
  Constructor Create();
  destructor Destroy(); override;
  procedure OnShow();
  property typ:integer write SetType;


end;

implementation

constructor   TDepPlanWorkManager.Create();
begin
F_Change:=0;
 dm_Plan:=Tdm_DepPlanWorMat.Create(nil);
 frm_Dep:=Tfrm_DepPlanWorkMat.Create(nil);
 frm_Dep.ds_works.DataSet:=dm_Plan.dset_works;
 frm_Dep.ds_maters.DataSet:=dm_Plan.dset_maters;
 frm_Dep.OnChangeWorks:=OnChangeWorksHandler;
 frm_Dep.OnDelWork:=OnDelWorkHandler;

 frm_Dep.OnChangeMaters:=OnChangeMaterssHandler;
 frm_Dep.OnDelMater:=OnDelMatersHandler;

end;

procedure  TDepPlanWorkManager.OnShow();
begin
 dm_Plan.StartTran;
 dm_Plan.OrderID:=F_IdOrder;
 dm_Plan.depID:=F_IdDep;
 dm_Plan.F_DefaultOfficPostIns:=dm_Main.GetIDOfficialPost(F_IdDisp);
 dm_Plan.Open;
 frm_Dep.ShowModal;
end;

procedure  TDepPlanWorkManager.OnChangeWorksHandler(action:TAction);
var
frm_work:Tfrm_AddWork;
_b:pointer;
i:integer;
begin
 try
  F_Change:=1;
  frm_work:=Tfrm_AddWork.Create(nil);

  frm_work.ds_Main.DataSet:=dm_Plan.dset_works;
  frm_work.ds_work.DataSet:=dm_Plan.mt_works;
  frm_work.ds_Diam.DataSet:=dm_Plan.mt_diametr;

  case action of
    Insert:dm_Plan.dset_works.Append;
    Edit:dm_Plan.dset_works.Edit;
  end;
  if frm_work.ShowModal=mrOk then
  begin
     i:= dm_Plan.dset_works.FieldByName('FK_DEPWORKS_DEPBWORK').AsInteger;
     i:= dm_Plan.dset_works.FieldByName('IDDIam').AsInteger;

      dm_Plan.dset_works.Post;
   end
  else
    dm_Plan.dset_works.Cancel;
  _b:=dm_Plan.dset_works.GetBookmark;
  dm_Plan.dset_works.Close;
  dm_Plan.dset_works.Open;
  dm_Plan.dset_works.BookmarkValid(_b);


  finally
  frm_work.Free;
  end;
end;

procedure TDepPlanWorkManager.OnDelWorkHandler(Sender: TObject);
begin
   F_Change:=1;
  if  not dm_Plan.dset_works.IsEmpty then
   if  ( Application.MessageBox( 'Вы уверены, что хотите удалить подработу?',
      'Внимание', MB_YESNO + MB_ICONQUESTION ) = ID_YES ) then
       dm_Plan.dset_works.Delete;
end;

destructor TDepPlanWorkManager.Destroy;
begin

  dm_Plan.Free;
  frm_Dep.Free;
   inherited Destroy;
end;

procedure TDepPlanWorkManager.OnChangeMaterssHandler(action:TAction);
var frm:Tfrm_EditMater;
   _b:pointer;
begin
try
 frm:=Tfrm_EditMater.Create(nil);
 frm.dbl_Mater.DataField:='fk_mater';
 frm.dbl_Diam.DataField:='fk_diameter';
 frm.ed_Quantity.DataField:='quantity';

 frm.ds_DiamAtt.DataSet:=dm_Plan.mt_diametr;
 frm.ds_Mater.DataSet:=dm_Plan.dset_maters;
 frm.ds_MaterAtt.DataSet:=dm_Plan.mt_maters;


 case action of
    Insert:dm_Plan.dset_maters.Append;
    Edit:dm_Plan.dset_maters.Edit;
  end;
  if frm.ShowModal=mrOk then
  begin

      dm_Plan.dset_maters.Post;
   end
  else
    dm_Plan.dset_maters.Cancel;
  _b:=dm_Plan.dset_maters.GetBookmark;
  dm_Plan.dset_maters.Close;
  dm_Plan.dset_maters.Open;
  dm_Plan.dset_maters.BookmarkValid(_b);

finally
 frm.Free;
end;


end;



procedure TDepPlanWorkManager.OnDelMatersHandler(Sender: TObject);
begin
    F_Change:=1;
  if  not dm_Plan.dset_maters.IsEmpty then
   if  ( Application.MessageBox( 'Вы уверены, что хотите удалить запись?',
      'Внимание', MB_YESNO + MB_ICONQUESTION ) = ID_YES ) then
       dm_Plan.dset_maters.Delete;
end;

procedure TDepPlanWorkManager.SetType(typ:integer);
begin
  f_typ:=typ;
  dm_plan.typ:=typ;
end;
end.
