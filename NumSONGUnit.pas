unit NumSONGUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Spisok1562_FrameUnit, DB, StdCtrls, NGReports, dm_NumSONGUnit,
  RxLookup, IBCustomDataSet;

type
  TNumSONGForm = class(TForm)
    BottomPanel: TPanel;
    MainPanel: TPanel;
    Spisok1562_Frame1: TSpisok1562_Frame;
    ds_Main: TDataSource;
    BtOK: TButton;
    L_Isp1562: TLabel;
    DBL_Officials1562: TRxDBLookupCombo;
    mem_officials: TMemo;
    L_Job1562: TLabel;
    DBL_Job1562: TRxDBLookupCombo;
    mem_job: TMemo;
    dset_Officials1562: TIBDataSet;
    ds_Officials1562: TDataSource;
    dset_Job1562: TIBDataSet;
    ds_Job1562: TDataSource;
  private
    { Private declarations }
    F_OrderID: integer;
    F_Show1562: boolean;
    F_DM1562: Tdm_NumSONG;
    procedure Refresh1562;
  public
    { Public declarations }
    property OrderID: integer read F_OrderID write F_OrderID;
    procedure Show1562;

  end;

var
  NumSONGForm: TNumSONGForm;

implementation

{$R *.dfm}



procedure TNumSONGForm.Show1562;
//var _OnClickGrid1562: Event
//  _SOMgr: TSuborderManager;


    procedure AddToGrid( _field: string; _Title: string; _len: integer);
    begin
        //
      with Spisok1562_Frame1.Grid do
       begin
        Columns.Add;
        Columns[Columns.Count-1].FieldName := _field;
        Columns[Columns.Count-1].Title.Caption := _Title;
        Columns[Columns.Count-1].Width := _len;
       // Columns[Columns.Count-1].WordWrap := true;
       // Columns[Columns.Count-1].AutoFitColWidth := true;
       end;



    end;

    procedure FillTitles;
    begin
      AddToGrid( 'NUM1562', '№ заявки 1562', 64);
      AddToGrid( 'DATATIME', 'Дата'+#13+'поступления', 104);
      AddToGrid( 'Region', 'Район', 54);
      AddToGrid( 'street_name', 'Улица',94);
      AddToGrid( 'house', 'Дом', 54);
      AddToGrid( 'appartment', 'Квартира',74);
      AddToGrid( 'about', 'О чём заявлено',114);
      AddToGrid( 'AVAR', 'Авария', 54);
      AddToGrid( 'status', 'Статус',74);
      AddToGrid( 'ordernumber', '№ наряда',74);
    end;


begin
  //
  //if not F_Show1562 then exit;
  Spisok1562_Frame1.InitFilter;
  FillTitles;
  //Spisok1562_Frame1.Grid.OnCellClick := OnClickGrid1562;


  Refresh1562;

end;

procedure  TNumSONGForm.Refresh1562;
begin
 if not Assigned(F_DM1562) then
    F_DM1562 := Tdm_NumSONG.Create( nil );

  F_DM1562.StartTransaction;
  try


    Spisok1562_Frame1.GetFilter;
    F_DM1562.Condition := ' where (1=1) and cw.fk_id_avr_order = '+ IntToStr(F_OrderID);
    //Spisok1562_Frame1.ResultCondition; //тут будет выборка + сортировка
    F_DM1562.PrepareDset;

//    F_DM.CommitTransaction;
  except
    on E: Exception do
    begin
      F_DM1562.RollBackTransaction;
      raise Exception.Create( E.Message + 'Tfrm_Main.Show1562' );
    end;
  end;


end;


end.
