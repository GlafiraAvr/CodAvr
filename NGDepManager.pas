unit NGDepManager;

interface

uses NGDepDModule, SysUtils;

type
  TExecuteType = ( etCDP, etREG );

  TNGDepManager=class
  private
    F_DepData: Tdm_NGDep;
    F_Name_Reg:string;

  private
    procedure ExecuteCDP( _IsReadOnly: boolean; _RegionID: integer;VisoutOrder:boolean );
    procedure ExecuteREG( _IsReadOnly: boolean; _RegionID: integer; VisoutOrder:boolean );
  public
    property DepData: Tdm_NGDep read F_DepData write F_DepData;
    constructor Create;
    destructor Destroy; override;
    procedure Execute( _ExecuteType: TExecuteType; _IsReadOnly: boolean;
      _RegionID: integer; VisoutOrder:boolean=false );
    property  Name_Reg:string write F_Name_Reg;
  end;

implementation

{ TNGDepManager }

uses DepREGForm, DepCDPForm,HelpFunctions;

constructor TNGDepManager.Create;
begin
  inherited Create;
  F_DepData := Tdm_NGDep.Create( nil );
end;

destructor TNGDepManager.Destroy;
begin
  F_DepData.Free;
  inherited Destroy;
end;

procedure TNGDepManager.Execute( _ExecuteType: TExecuteType; _IsReadOnly: boolean;
  _RegionID: integer; VisoutOrder:boolean=false );
begin
  F_DepData.WithoutOrder:=VisoutOrder;
  case _ExecuteType of
    etCDP: ExecuteCDP( _IsReadOnly, _RegionID, VisoutOrder );
    etREG: ExecuteREG( _IsReadOnly, _RegionID, VisoutOrder );
  end;
end;

procedure TNGDepManager.ExecuteCDP( _IsReadOnly: boolean; _RegionID: integer;VisoutOrder:boolean );
var
  _frm: Tfrm_DepCDP;
begin
  _frm := Tfrm_DepCDP.Create( nil, F_DepData );
  try
    F_DepData.StartTran( _IsReadOnly, _RegionID, false );
    try
      _frm.ShowModal;

      F_DepData.CommitTran;
    except
      on E: Exception do
      begin
        F_DepData.RollbackTran;
        raise Exception.Create( E.Message + '(TNGDepManager.ExecuteCDP)' );
      end;
    end;
  finally
  _frm.Free;
  end;
end;

procedure TNGDepManager.ExecuteREG( _IsReadOnly: boolean; _RegionID: integer; VisoutOrder:boolean );
var
  _frm: Tfrm_DepREG;
begin
  _frm := Tfrm_DepREG.Create( nil, F_DepData );
  try
    F_DepData.StartTran( _IsReadOnly, _RegionID, true );
    try
      _frm.btn_Adress.Visible:= VisoutOrder;
      _frm.Pnl_year.Visible:= VisoutOrder;
      _frm.spe_year.Value:=GetYear(Now());


      if VisoutOrder then begin
       _frm.Caption:= _frm.Caption+' נאימם '+F_Name_reg;
       _frm.frame_Dep.dbl_Region_brig.Visible:=false;
      end;
      _frm.ShowModal;

      F_DepData.CommitTran;
    except
      on E: Exception do
      begin
        F_DepData.RollbackTran;
        raise Exception.Create( E.Message + '(TNGDepManager.ExecuteREG)' );
      end;
    end;
  finally
    _frm.Free;
  end;
end;

end.
