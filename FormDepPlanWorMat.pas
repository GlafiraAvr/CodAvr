unit FormDepPlanWorMat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGridEh, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  DepPlanWorMatDModule;

type

  TActivePage=(Pworks,Pmaters);
  TAction=(Insert,Edit);

  TChangeDsetEvent=procedure (action:TAction) of object;

  Tfrm_DepPlanWorkMat = class(TForm)
    PageControl: TPageControl;
    Works: TTabSheet;
    Maters: TTabSheet;
    pnl_EditWrkAndMat: TPanel;
    btn_AddDetail: TBitBtn;
    btn_EditDetail: TBitBtn;
    btn_DelDetail: TBitBtn;
    btn_Exit: TBitBtn;
    dbg_works: TDBGridEh;
    dbg_maters: TDBGridEh;
    ds_works: TDataSource;
    ds_maters: TDataSource;
    procedure btn_ExitClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure btn_AddDetailClick(Sender: TObject);
    procedure btn_EditDetailClick(Sender: TObject);
    procedure btn_DelDetailClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    F_OnChangeWorks:TChangeDsetEvent;
    F_OnChangeMaters:TChangeDsetEvent;
    F_ActPage:TActivePage;
    F_DelWork:TNotifyEvent;
    F_DelMater:TNotifyEvent;
    F_IsReadOnly:boolean;
    procedure  SetActPageWorks();
    procedure  SetActMaters();
    procedure SetReadOnly(RO:boolean);
  public

    { Public declarations }
    property OnChangeWorks:TChangeDsetEvent write F_OnChangeWorks;
    property OnChangeMaters:TChangeDsetEvent write F_OnChangeMaters;
    property OnDelWork:TNotifyEvent write F_DelWork;
    property OnDelMater:TNotifyEvent write F_DelMater;
    property IsReadOnly:boolean read F_IsReadOnly write SetREadOnly;



  end;

var
  frm_DepPlanWorkMat: Tfrm_DepPlanWorkMat;

implementation

{$R *.dfm}

procedure Tfrm_DepPlanWorkMat.btn_ExitClick(Sender: TObject);
begin
Close;
end;

procedure Tfrm_DepPlanWorkMat.PageControlChange(Sender: TObject);
begin
 case PageControl.ActivePageIndex of
  0: SetActPageWorks;
  1: SetActMaters;
 end;
end;

procedure Tfrm_DepPlanWorkMat.SetActPageWorks();
begin
   Caption:='Планируемые работы';
   F_ActPage:=Pworks;
end;

procedure Tfrm_DepPlanWorkMat.SetActMaters();
begin
   Caption:='Планируемые материалы';
   F_ActPage:=Pmaters;
end;

procedure Tfrm_DepPlanWorkMat.btn_AddDetailClick(Sender: TObject);
begin
case F_ActPage of
 PWorks:  if assigned(F_OnChangeWorks) then
           F_OnChangeWorks(Insert);
 Pmaters: if assigned(F_OnChangeMaters) then
           F_OnChangeMaters(Insert);
end;
end;

procedure Tfrm_DepPlanWorkMat.btn_EditDetailClick(Sender: TObject);
begin
  case F_ActPage of
   PWorks:  if assigned(F_OnChangeWorks) then
             F_OnChangeWorks(Edit);
   Pmaters: if assigned(F_OnChangeMaters) then
           F_OnChangeMaters(Edit);
  end;
end;

procedure Tfrm_DepPlanWorkMat.btn_DelDetailClick(Sender: TObject);
begin
   case F_ActPage of
    PWorks: if assigned(F_DelWork) then
              F_DelWork(Sender);
    Pmaters: if assigned(F_DelMater) then
           F_DelMater(Sender);
   end;
end;

procedure Tfrm_DepPlanWorkMat.FormShow(Sender: TObject);
begin
   case PageControl.ActivePageIndex of
  0: SetActPageWorks;
  1: SetActMaters;
 end;
end;

procedure Tfrm_DepPlanWorkMat.SetReadOnly(RO:boolean);
begin
 btn_AddDetail.Enabled:=not RO;
 btn_DelDetail.Enabled:=not RO;
 btn_EditDetail.Enabled:=not RO;
end;

end.
