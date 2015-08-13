unit ListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  Tfrm_List = class(TForm)
    ListBox: TListBox;
    btn_ok: TBitBtn;
    btn_exit: TBitBtn;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
  private
    F_SelectedValue: string;
    procedure Apply;
    procedure SetListTitle(const Value: string);
  public
    List: TStringList;
    property ListTitle:string write SetListTitle;
    property SelectedValue: string read F_SelectedValue;
    constructor Create(AOwner: TComponent; ACaption: string);
    destructor Destroy; override;
  end;

var
  frm_List: Tfrm_List;

implementation

{$R *.dfm}

{ Tfrm_List }

constructor Tfrm_List.Create(AOwner: TComponent; ACaption: string);
begin
  inherited Create(AOwner);
  Caption:=ACaption;
  List:=TStringList.Create;
end;

destructor Tfrm_List.Destroy;
begin
  List.Free;
  inherited Destroy;
end;

procedure Tfrm_List.SetListTitle(const Value: string);
begin
//
end;

procedure Tfrm_List.FormShow(Sender: TObject);
begin
  ListBox.Items.AddStrings(List);
end;

procedure Tfrm_List.btn_exitClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_List.btn_okClick(Sender: TObject);
begin
  Apply;
end;

procedure Tfrm_List.Apply;
var
  index: integer;
begin
  index:=ListBox.ItemIndex;
  if index<0 then
  begin
    Application.MessageBox('Выберите значение из списка',
                            'Внимание', MB_OK+MB_ICONWARNING);
    exit;
  end;

  F_SelectedValue:=ListBox.Items.Strings[index];

  ModalResult:=mrOk;
end;

end.
