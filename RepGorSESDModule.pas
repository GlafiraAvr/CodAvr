unit RepGorSESDModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NGReportBaseDModule, FR_Class, DB, RxMemDS, DModule,
  IBCustomDataSet, IBDatabase, FR_DSet, FR_DBSet;

type
  Tdm_RepGorSES = class(Tdm_NGReportBase)
    ResultDset: TRxMemoryData;
    ResultDsetreg_id: TIntegerField;
    ResultDsetreg_name: TStringField;
    ResultDsetdmg_count: TIntegerField;
    tran: TIBTransaction;
    dset: TIBDataSet;
    frDSResult: TfrDBDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    F_DateBegin,
    F_DateEnd: TDateTime;
    procedure InitResultDset;
    function FillResultDset: boolean;
  public
    property DateBegin: TDateTime read F_DateBegin write F_DateBegin;
    property DateEnd: TDateTime read F_DateEnd write F_DateEnd;
    function PrepareDset: boolean;
  end;


implementation

{$R *.dfm}

uses HelpFunctions;

{ Tdm_RepGorSES }

procedure Tdm_RepGorSES.InitResultDset;
  procedure _InitReg( _reg_id: integer; _reg_name: string );
  begin
    ResultDset.Append;
    ResultDset.FieldByName( 'reg_id' ).AsInteger := _reg_id;
    ResultDset.FieldByName( 'reg_name' ).AsString := _reg_name;
    ResultDset.Post;
  end;
begin
  ResultDset.Close;
  ResultDset.Open;

  _InitReg( 1, '�����������' );
  _InitReg( 2, '��������' );
  _InitReg( 5, '����������' );
  _InitReg( 7, '�����������������' );
  _InitReg( 8, '�����������' );
  _InitReg( 3, '���������������' );
  _InitReg( 9, '����������������' );
  _InitReg( 6, '�����������' );
  _InitReg( 4, '���������' );
end;

function Tdm_RepGorSES.PrepareDset: boolean;
begin
{
  ��� ��� ������ ����� ���� ������� ����� ��������,
  �� ��� ��������, ����� ��� ������������ �������
  ������� � �����������(� �������)
}
  ResetProgressFields;

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    Result := FillResultDset;
    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_RepGorSES.PrepareDset)' );
    end;
  end;
end;

procedure Tdm_RepGorSES.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InitResultDset;
end;

function Tdm_RepGorSES.FillResultDset: boolean;
  function _GetDmgCount( _reg_id: integer ): integer;
  begin
    MyOpenIBDS( dset,
      ' select count(*) dmg_count' +
      ' from orders' +
      ' where fk_orders_damageplace in (1,2)' +
      ' and DateClosed > ''' + DateToStr( F_DateBegin ) + '''' +
      ' and DateClosed <= ''' + DateToStr( F_DateEnd + 1 ) + '''' +
      ' and fk_orders_regions=' + IntToStr( _reg_id ) );

    Result := dset.FieldByName( 'dmg_count' ).AsInteger;
  end;
var
  i, _RegID: integer;
  _ProgressShag: integer;
begin
  Result := true;

  ResultDset.Last;
  _ProgressShag := self.GetProgressShagLength( 100, ResultDset.RecordCount );

  ResultDset.First;
  for i:=1 to ResultDset.RecordCount do
  begin
    if IsStopProgress then
    begin
      Result := false;
      break;
    end;

    _RegID := ResultDset.FieldByName( 'reg_id' ).AsInteger;
    ResultDset.Edit;
    ResultDset.FieldByName( 'dmg_count' ).AsInteger := _GetDmgCount( _RegID );
    ResultDset.Post;
    ResultDset.Next;
    IncProgressStatus( _ProgressShag );
  end;
end;

end.
