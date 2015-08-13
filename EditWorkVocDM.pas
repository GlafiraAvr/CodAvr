unit EditWorkVocDM;

interface

uses
  SysUtils, Classes, DModule, IBDatabase, DB, IBCustomDataSet;

type
  Tdm_EditWorkVoc = class(TDataModule)
    tran: TIBTransaction;
    dset_Works: TIBDataSet;
    dset_Diams: TIBDataSet;
    ds_Works: TDataSource;
    dset_WorksID: TIntegerField;
    dset_WorksNAME: TIBStringField;
    dset_WorksID_WORKKIND: TIntegerField;
    dset_WorksMEASUREMENT: TIBStringField;
    dset_WorksACTIVITY: TIBStringField;
    dset_DiamsID: TIntegerField;
    dset_DiamsDIAMETER: TIntegerField;
    dset_DiamsACTIVITY: TIBStringField;
    dset_DiamsNAME: TIBStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

{ Tdm_EditWorkVoc }

procedure Tdm_EditWorkVoc.DataModuleCreate(Sender: TObject);
begin
  tran.StartTransaction;
  dset_Works.Open;
  dset_Diams.Open;
end;

procedure Tdm_EditWorkVoc.DataModuleDestroy(Sender: TObject);
begin
  tran.Rollback;
end;

end.
