unit NotePadForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, DB, IBDatabase, IBCustomDataSet, DBCtrls, DModule,
  ExtCtrls;

type
  Tfrm_NotePad = class(TForm)
    mem_Page: TDBMemo;
    dset_NotePad: TIBDataSet;
    tran_NotePad: TIBTransaction;
    ds_NotePad: TDataSource;
    dset_NotePadNOTEPAD: TMemoField;
    pnl: TPanel;
    sp_Now: TSpeedButton;
    btn_exit: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_exitClick(Sender: TObject);
    procedure sp_NowClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

procedure Tfrm_NotePad.FormCreate(Sender: TObject);
begin
  if tran_NotePad.InTransaction then
    tran_NotePad.Rollback;
  tran_NotePad.StartTransaction;
  dset_NotePad.Open;
end;

procedure Tfrm_NotePad.FormDestroy(Sender: TObject);
begin
  dset_NotePad.Close;
  if tran_NotePad.InTransaction then
    tran_NotePad.Commit;
end;

procedure Tfrm_NotePad.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if dset_NotePad.State in [dsInsert, dsEdit] then
    dset_NotePad.Post;
end;

procedure Tfrm_NotePad.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_NotePad.sp_NowClick(Sender: TObject);
begin
  mem_Page.Lines.Add('');
  mem_Page.Lines.Add(DateTimeToStr(Now));
end;

end.
