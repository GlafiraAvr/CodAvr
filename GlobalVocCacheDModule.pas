unit GlobalVocCacheDModule;

interface

{
  Давно хотел сделать такую вещь как
  глобальный кеш справочников. По идее
  должно способствовать увелечению скорости работы
  приложения. Т.к. справочники обновляются
  довольно редко. Кроме того использовать кеш очень удобно
  и бысто. А главное (!!!) теперь  будет более
  рационально расходоваться память (никакого дуближа :)
  и сетевой трафик)
}

uses
  SysUtils, Classes, DB, kbmMemTable, DModule, IBDatabase, IBCustomDataSet,
  IniFiles, kbmMemCSVStreamFormat, kbmMemBinaryStreamFormat;


const
  VOC_CACHE_DIR = 'VocCache';
  VOCS = 'VOCS';

type
  FillMemTableRecordEvent = procedure(_MemTable: TkbmMemTable; _SrcDset: TDataSet) of object;

  TVoc = class
  private
    F_ID: integer;
    F_MemTable: TkbmMemTable;
    F_SQL: string;
    F_LocalVersionID: integer;
    F_OnFillMemTableRecord: FillMemTableRecordEvent;
    procedure SetID(Value: integer);
    procedure SetMemTable(Value: TkbmMemTable);
  public
    property MemTable: TkbmMemTable read F_MemTable write SetMemTable;
    property SQL: string read F_SQL write F_SQL;
    property ID: integer read F_ID write SetID;
    property LocalVersionID: integer read F_LocalVersionID write F_LocalVersionID;
    property OnFillMemTableRecord: FillMemTableRecordEvent read F_OnFillMemTableRecord
      write F_OnFillMemTableRecord;
    constructor Create;
  end;

  TVocList = class
  private
    F_Vocs: TList;
    function GetVocByID( VocID: integer ): TVoc;
    function GetVocByIndex( Index: integer ): TVoc;
  public
    function AddNewVoc: TVoc;
    function Count: integer;
    property VocByID[ VocID: integer ]: TVoc read GetVocByID;
    property VocByIndex[ Index: integer ]: TVoc read GetVocByIndex;
    constructor Create;
    destructor Destroy; override;
  end;

  TLocalVocVersion=class
  private
    F_VerList: TStringList;
    F_VerFileName: string;
    function GetVersionIdByVocId( VocID: integer ): integer;
  public
    constructor Create( _VerFileName: string );
    destructor Destroy; override;
    property VerFileName: string read F_VerFileName;
    property VersionIdByVocId[ VocID: integer ]: integer
      read GetVersionIdByVocId;
    property VerList: TStringList read F_VerList write F_VerList;
    procedure ReadLocalVersionsFromFile;
    procedure WriteLocalVersionsToFile;
  end;

  Tdm_GlobalVocCache = class(TDataModule)
    mt_s_streets: TkbmMemTable;
    mt_s_streetsid: TIntegerField;
    mt_s_streetsname: TStringField;
    mt_s_streetsactivity: TSmallintField;
    dset_Voc: TIBDataSet;
    tran: TIBTransaction;
    mt_s_subordermsg: TkbmMemTable;
    mt_s_subordermsgid: TIntegerField;
    mt_s_subordermsgname: TStringField;
    mt_s_subordermsgactivity: TSmallintField;
    kbmCSVStreamFormat1: TkbmCSVStreamFormat;
    dset_Ver: TIBDataSet;
    kbmBinaryStreamFormat1: TkbmBinaryStreamFormat;
    mt_s_suborderabon: TkbmMemTable;
    mt_s_suborderabonid: TIntegerField;
    mt_s_suborderabonname: TStringField;
    mt_s_suborderabonactivity: TSmallintField;
    mt_brigadiers: TkbmMemTable;
    mt_brigadiersid: TIntegerField;
    mt_brigadiersname: TStringField;
    mt_brigadiersactivity: TStringField;
    mt_brigadiersfk_brigadiers_regions: TIntegerField;
    mt_s_officials: TkbmMemTable;
    mt_s_officialsid: TIntegerField;
    mt_s_officialsname: TStringField;
    mt_s_officialsactivity: TStringField;
    mt_s_officialsfk_offic_officpost: TIntegerField;
    mt_s_regions: TkbmMemTable;
    mt_s_regionsid: TIntegerField;
    mt_s_regionsname: TStringField;
    mt_s_regionsactivity: TStringField;
    mt_s_damageplace: TkbmMemTable;
    mt_s_damageplaceid: TIntegerField;
    mt_s_damageplacename: TStringField;
    mt_s_damageplaceactivity: TStringField;
    mt_s_worktime: TkbmMemTable;
    mt_s_worktimeid: TIntegerField;
    mt_s_worktimeid_work: TIntegerField;
    mt_s_worktimeid_diam: TIntegerField;
    mt_s_worktimehour_summer: TFloatField;
    mt_s_worktimehour_winter: TFloatField;
    mt_s_worktimeactivity: TSmallintField;
    mt_s_worktimediam: TIntegerField;
    mt_s_worktimework_name: TStringField;
    mt_s_bwork: TkbmMemTable;
    mt_s_bworkid: TIntegerField;
    mt_s_bworkname: TStringField;
    mt_s_bworkactivity: TSmallintField;
    mt_s_works: TkbmMemTable;
    mt_s_worksid: TIntegerField;
    mt_s_worksname: TStringField;
    mt_s_worksactivity: TStringField;
    mt_s_tubediameter: TkbmMemTable;
    mt_s_tubediameterid: TIntegerField;
    mt_s_tubediameterdiameter: TIntegerField;
    mt_s_tubediameteractivity: TStringField;
    mt_materials: TkbmMemTable;
    mt_materialsid: TIntegerField;
    mt_materialsname: TStringField;
    mt_materialsmeasurement: TStringField;
    mt_materialsfull_name: TStringField;
    mt_materialsactivity: TStringField;
    mt_s_worktype: TkbmMemTable;
    mt_s_worktypeid: TIntegerField;
    mt_s_worktypename: TStringField;
    mt_s_worktypeactivity: TSmallintField;
    mt_s_worktimemeasur_quantity: TFloatField;
    mt_s_worksmeasurement: TStringField;
    mt_s_tubediametername: TStringField;
    mt_s_worksid_workkind: TIntegerField;
    mt_Equipment: TkbmMemTable;
    mt_Equipmentid: TIntegerField;
    mt_Equipmentname: TStringField;
    mt_Equipmentnumber: TIntegerField;
    mt_Equipmentid_region: TIntegerField;
    mt_Equipmentid_vocrectype: TIntegerField;
    mt_Equipmentactivity: TStringField;
    mt_Equipmentis_visible_for_cur_district: TSmallintField;
    mt_Equipmentfl_FULL_NAME: TStringField;
    mt_s_messagetypes: TkbmMemTable;
    mt_s_messagetypesid: TIntegerField;
    mt_s_messagetypesname: TStringField;
    mt_s_messagetypesS_MT_CATEGORY_ID: TSmallintField;
    mt_HouseType: TkbmMemTable;
    mt_Equipmentv_kovsh: TFloatField;
    mt_Equipmentgos_number: TStringField;
    mt_damagelocality: TkbmMemTable;
    mt_tubematerial: TkbmMemTable;
    mt_HouseTypeid: TIntegerField;
    mt_HouseTypename: TStringField;
    mt_HouseTypeactivity: TSmallintField;
    mt_damagelocalityid: TIntegerField;
    mt_damagelocalityname: TStringField;
    mt_damagelocalityactivity: TSmallintField;
    mt_tubematerialid: TIntegerField;
    mt_tubematerialname: TStringField;
    mt_tubematerialactivity: TSmallintField;
    mt_organisation: TkbmMemTable;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    SmallintField1: TSmallintField;
    mt_organisationphone: TStringField;
    mt_s_soil: TkbmMemTable;
    mt_s_soilid: TIntegerField;
    mt_s_soilname: TStringField;
    mt_s_Damagetype: TkbmMemTable;
    IntegerField2: TIntegerField;
    StringField2: TStringField;
    mt_s_soilactivity: TSmallintField;
    mt_s_Damagetypeactivity: TSmallintField;
    mt_S_Applicant_vds: TkbmMemTable;
    IntegerField3: TIntegerField;
    StringField3: TStringField;
    SmallintField2: TSmallintField;
    mt_S_Message_vDS: TkbmMemTable;
    IntegerField4: TIntegerField;
    StringField4: TStringField;
    SmallintField3: TSmallintField;
    mt_S_Message_vDSmessagename: TStringField;
    mt_demagetype_vds: TkbmMemTable;
    mt_demagetype_vdsid: TIntegerField;
    mt_demagetype_vdsname: TStringField;
    mt_demagetype_vdsactivity: TSmallintField;
    mt_Equipmentshot_name: TStringField;
    mt_Equipmentid_typ: TIntegerField;
    mt_s_worksfor_plan: TIntegerField;
    mt_damagelocalityclassnumber: TStringField;
    mt_s_damageplaceCHACK_DIAM: TStringField;
    mt_S_all_regions: TkbmMemTable;
    IntegerField5: TIntegerField;
    StringField5: TStringField;
    mt_S_all_regionsfull_name: TStringField;
    mt_s_messagetypesactivity: TSmallintField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private
    procedure Equipment_OnFillRecHandler(_MemTable: TkbmMemTable; _SrcDset: TDataSet);
    procedure DamageLocality_OnFillRecHandler(_MemTable: TkbmMemTable; _SrcDset: TDataSet);
  private
    F_VocList: TVocList;
    F_VocCachePath: string;
    F_LocalVocVer: TLocalVocVersion;
    procedure InitVocList;
    procedure WriteVocCacheToDisk;
    procedure LoadVocFromBase( _Voc: TVoc; _NewVersionID: integer );
    function LoadVocFromFile( _Voc: TVoc ): boolean;
    function GetVocCacheFileName( _Voc: TVoc ): string;
    procedure _CheckVocs( VocsID: array of integer );
  public
    procedure CheckVocs( _AttachedMemTableList: TList );
    procedure CheckVoc( _AttachedMemTable: TkbmMemTable );
  end;

function GetFullWorkName( _work, _measurement: string ): string;

var
  dm_GlobalVocCache: Tdm_GlobalVocCache;

implementation

{$R *.dfm}

uses HelpFunctions, VocsConst;


function GetFullWorkName( _work, _measurement: string ): string;
begin
  Result := trim( _work );
  if trim( _measurement ) <> '' then
    Result := Result + ' (' + trim( _measurement ) + ')';
end;

{ TVocList }

function TVocList.AddNewVoc: TVoc;
begin
  Result := TVoc.Create;
  F_Vocs.Add( Result );
end;

function TVocList.Count: integer;
begin
  Result := F_Vocs.Count;
end;

constructor TVocList.Create;
var
  i: integer;
begin
  inherited Create;
  F_Vocs := TList.Create;
end;

destructor TVocList.Destroy;
var
  i: integer;
begin
  for i:=0 to F_Vocs.Count-1 do
    TVoc(F_Vocs.Items[i]).Free;
  F_Vocs.Free;

  inherited Destroy;
end;

procedure Tdm_GlobalVocCache.CheckVoc( _AttachedMemTable: TkbmMemTable);
var
  _VocsIDArr: array of integer;
begin
  SetLength( _VocsIDArr, 1 );
  _VocsIDArr[ 0 ] := _AttachedMemTable.AttachedTo.Tag;
  _CheckVocs( _VocsIDArr );
end;

procedure Tdm_GlobalVocCache._CheckVocs(VocsID: array of integer);
var
  i, _id, _ver: integer;
  _strVocsID: string;
  _Voc: TVoc;
begin
  if Length( VocsID ) <=0 then exit;

  _strVocsID := '';
  for i:=low( VocsID ) to high( VocsID ) do
    _strVocsID := _strVocsID + ',' + IntToStr( VocsID[i] );
  Delete( _strVocsID, 1, 1);

  if tran.InTransaction then tran.Rollback;
  tran.StartTransaction;
  try
    MyOpenIBDS( dset_Ver,
      ' select id, table_name, version_id'+
      ' from vc_vocs'+
      ' where id in (' + _strVocsID + ')' );
    dset_Ver.First;
    while not dset_Ver.Eof do
    begin
      _id := dset_Ver.FieldByName( 'id' ).AsInteger;
      _ver := dset_Ver.FieldByName( 'version_id' ).AsInteger;

      _Voc := F_VocList.VocByID[ _id ];
      if _Voc.LocalVersionID <> _ver then
        LoadVocFromBase( _Voc, _ver )
      else
        if _Voc.MemTable.IsEmpty then
          if not LoadVocFromFile( _Voc ) then
            LoadVocFromBase( _Voc, _ver );

      dset_Ver.Next;
    end;

    tran.Commit;
  except
    on E: Exception do
    begin
      tran.Rollback;
      raise Exception.Create( E.Message + '(Tdm_GlobalVocCache.CheckVocs)' );
    end;
  end;
end;

procedure Tdm_GlobalVocCache.CheckVocs(_AttachedMemTableList: TList);
var
  _VocIDArr: array of integer;
  i: integer;
begin
  SetLength( _VocIDArr, _AttachedMemTableList.Count );
  for i:=0 to _AttachedMemTableList.Count-1 do
    _VocIDArr[i] := TkbmMemTable( _AttachedMemTableList.Items[i] ).AttachedTo.Tag;
  _CheckVocs( _VocIDArr );
end;

procedure Tdm_GlobalVocCache.DataModuleCreate(Sender: TObject);
begin
  F_VocCachePath := ExtractFilePath( ParamStr( 0 ) ) + VOC_CACHE_DIR;
  if not DirectoryExists( F_VocCachePath ) then CreateDir( F_VocCachePath );

  F_LocalVocVer := TLocalVocVersion.Create( F_VocCachePath + '\VocCacheVersions.ini'  );
  F_LocalVocVer.ReadLocalVersionsFromFile;

  F_VocList := TVocList.Create;
  InitVocList;
end;

procedure Tdm_GlobalVocCache.DataModuleDestroy(Sender: TObject);
begin
  WriteVocCacheToDisk;

  F_LocalVocVer.Free;
  F_VocList.Free;
end;

function Tdm_GlobalVocCache.GetVocCacheFileName(_Voc: TVoc): string;
begin
  Result := F_VocCachePath + '\' + _Voc.MemTable.Name + '.vc';
end;

procedure Tdm_GlobalVocCache.InitVocList;
  procedure _InitVoc( _MemTable: TkbmMemTable; _ID: integer; _SQL: string;
    _FillMemTableRecordEvent: FillMemTableRecordEvent = nil);
  begin
    with F_VocList.AddNewVoc do
    begin
      MemTable := _MemTable;
      ID := _ID;
      SQL := _SQL;
      LocalVersionID := F_LocalVocVer.VersionIdByVocId[ _ID ];
      OnFillMemTableRecord := _FillMemTableRecordEvent;
    end;
  end;
begin
  _InitVoc( mt_s_streets,          STREETS_ID,          STREETS_SQL                                     );   //Справочник улиц
  _InitVoc( mt_s_subordermsg,      SUBORDERMSG_ID,      SUBORDERMSG_SQL                                 );
  _InitVoc( mt_s_suborderabon,     SUBORDERABON_ID,     SUBORDERABON_SQL                                );
  _InitVoc( mt_brigadiers,         BRIGADIERS_ID,       BRIGADIERS_SQL                                  );   //Справочник бригадиров
  _InitVoc( mt_s_officials,        OFFICIALS_ID,        OFFICIALS_SQL                                   );   //Справочник диспетчеров
  _InitVoc( mt_s_regions,          REGIONS_ID,          REGIONS_SQL                                     );   //Справочник районов
  _InitVoc( mt_s_damageplace,      DAMAGEPLACE_ID,      DAMAGEPLACE_SQL                                 );   //Справочник мест повреждений
  _InitVoc( mt_s_worktime,         WORKTIME_ID,         WORKTIME_SQL                                    );   //Справочник длительности работ
  _InitVoc( mt_s_bwork,            BWORK_ID,            BWORK_SQL                                       );   //Справочник больших работ
  _InitVoc( mt_s_works,            WORKS_ID,            WORKS_SQL                                       );   //Справочник малых работ
  _InitVoc( mt_s_tubediameter,     TUBEDIAMETER_ID,     TUBEDIAMETER_SQL                                );   //Справочник диаметров
  _InitVoc( mt_materials,          MATERIALS_ID,        MATERIALS_SQL                                   );   //Справочник материалов
  _InitVoc( mt_s_worktype,         WORKTYPE_ID,         WORKTYPE_SQL                                    );   //Справочник видов работ
  _InitVoc( mt_Equipment,          EQUIPMENT_ID,        EQUIPMENT_SQL,       Equipment_OnFillRecHandler );   //Справочник оборудования
  _InitVoc( mt_s_messagetypes,     MESSAGETYPES_ID,     MESSAGETYPES_SQL                                );   //Справочник S_MESSAGETYPES

  _InitVoc( mt_HouseType,          HOUSETYPE_ID,        HOUSETYPE_SQL                                   );   ///Справочник типов адресов
  _InitVoc( mt_damagelocality,     damagelocality_ID,   damagelocality_SQL,DamageLocality_OnFillRecHandler );   ///местности повреждения
  _InitVoc( mt_tubematerial,       tubematerial_id,     tubematerial_SQL                                );   ///Справочник материалов труб
  _InitVoc( mt_organisation,       organisation_id,     organisation_SQL                                );  ///Справочник s_organisation
  _InitVoc( mt_s_soil,             soil_id,             soil_sql                                        );
  _initVoc( mt_s_Damagetype,       Damagetype_id,       Damagetype_SQL                                  );

  _InitVoc( mt_S_Applicant_vds,    Applicant_Vds_Id,    Applicant_Vds_SQL                               ); ///Справочник  Applicant VDS
  _InitVoc( mt_S_Message_vDS,      MessageType_Vds_Id,  MessageType_Vds_SQL                             ); ///Справочник  S_MESSAGETYPES_VDS
  _InitVoc( mt_demagetype_vds,     damagetype_vds_Id,   damagetype_vds_SQL                              ); ///Справочник  S_damagetype_VDS
  _InitVoc( mt_S_all_regions,      All_regions_id,      All_regions_SQL                                 );//Справочник районов с участками для выездов
  end;

function TVocList.GetVocByID(VocID: integer): TVoc;
var
  i: integer;
  _IsFind: boolean;
begin
  _IsFind := false;
  for i:=0 to F_Vocs.Count-1 do
    if TVoc( F_Vocs.Items[i] ).ID = VocID then
    begin
      Result := TVoc( F_Vocs.Items[i] );
      _IsFind := true;
      break;
    end;

  if not _IsFind then Exception.Create( 'Справочник ID=' + IntToStr( VocID ) +
    ' не найден (TVocList.GetVocByID)' );
end;

function TVocList.GetVocByIndex(Index: integer): TVoc;
begin
  Result := TVoc( F_Vocs.Items[Index] );
end;

{ TVoc }

constructor TVoc.Create;
begin
  inherited Create;
  F_ID := -1;
  F_LocalVersionID := -1;
  F_MemTable := nil;
end;

procedure TVoc.SetID(Value: integer);
begin
  F_ID := Value;
  if Assigned( F_MemTable ) then
    F_MemTable.Tag := F_ID;
end;

procedure TVoc.SetMemTable(Value: TkbmMemTable);
begin
  F_MemTable := Value;
  if F_ID <> -1 then
    F_MemTable.Tag := F_ID;
end;

{ TLocalVocVersion }

constructor TLocalVocVersion.Create( _VerFileName: string );
begin
  inherited Create;
  F_VerList := TStringList.Create;
  F_VerFileName := _VerFileName;
end;

destructor TLocalVocVersion.Destroy;
begin
  F_VerList.Free;
  inherited Destroy;
end;

function TLocalVocVersion.GetVersionIdByVocId(
  VocID: integer): integer;
var
  _s: string;
begin
  _s := trim( F_VerList.Values[ IntToStr( VocID ) ] );
  try
    if _s <> '' then
      Result := StrToInt( _s )
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

procedure TLocalVocVersion.ReadLocalVersionsFromFile;
var
  _IniF: TIniFile;
begin
  _IniF := TIniFile.Create( F_VerFileName );
  try
    F_VerList.Clear;
    _IniF.ReadSectionValues( VOCS, F_VerList );
  finally
    _IniF.Free;
  end;
end;

procedure TLocalVocVersion.WriteLocalVersionsToFile;
var
  _IniF: TIniFile;
  i: integer;
begin
  _IniF := TIniFile.Create( F_VerFileName );
  try
    for i:=0 to F_VerList.Count-1 do
      _IniF.WriteString( VOCS, F_VerList.Names[i], F_VerList.ValueFromIndex[i]);
  finally
    _IniF.Free;
  end;
end;

procedure Tdm_GlobalVocCache.LoadVocFromBase(_Voc: TVoc; _NewVersionID: integer);
var
  i: integer;
begin
  _Voc.MemTable.Close;
  _Voc.MemTable.Open;
  MyOpenIBDS( dset_Voc, _Voc.SQL);
  dset_Voc.First;
  while not dset_Voc.Eof do
  begin
    _Voc.MemTable.Append;
    for i := 0 to dset_Voc.FieldCount - 1 do
      _Voc.MemTable.FieldByName( dset_Voc.Fields[i].FieldName ).Value := dset_Voc.Fields[i].Value;
    if Assigned( _Voc.OnFillMemTableRecord ) then
      _Voc.OnFillMemTableRecord( _Voc.MemTable, dset_Voc );
    _Voc.MemTable.Post;
    dset_Voc.Next;
  end;
  _Voc.LocalVersionID := _NewVersionID;
end;

function Tdm_GlobalVocCache.LoadVocFromFile(_Voc: TVoc): boolean;
var
  _fn: string;
begin
  _fn := GetVocCacheFileName( _Voc );
  if FileExists( _fn ) then
  begin
    _Voc.MemTable.LoadFromFile( _fn );
    Result := true;
  end else Result := false;
end;

procedure Tdm_GlobalVocCache.WriteVocCacheToDisk;
var
  i, _old_ver: integer;
  _Voc: TVoc;
  _fn: string;
  _NewVerList: TStringList;
begin
  _NewVerList := TStringList.Create;
  try
    for i:=0 to F_VocList.Count-1 do
    begin
      _Voc := F_VocList.VocByIndex[i];
      _fn := GetVocCacheFileName( _Voc );
      _old_ver := F_LocalVocVer.VersionIdByVocId[ _Voc.ID ];
      //
      if ( (_Voc.LocalVersionID <> _old_ver) or not FileExists( _fn ) ) and
        ( _Voc.MemTable.Active )
      then
      begin
        _Voc.MemTable.SaveToFile( _fn );
      end;
      //
      if not _Voc.MemTable.IsEmpty then
        _NewVerList.Values[ IntToStr( _Voc.ID ) ] := IntToStr( _Voc.LocalVersionID )
      else
        _NewVerList.Values[ IntToStr( _Voc.ID ) ] := IntToStr( _old_ver );
    end;
    F_LocalVocVer.VerList.Clear;
    F_LocalVocVer.VerList.AddStrings( _NewVerList );
    F_LocalVocVer.WriteLocalVersionsToFile;
  finally
    _NewVerList.Free;
  end;
end;

procedure Tdm_GlobalVocCache.Equipment_OnFillRecHandler(
  _MemTable: TkbmMemTable; _SrcDset: TDataSet);
var
  _s: string;
begin
 {_s:= _SrcDset.FieldByName( 'id_typ' ).AsString   ;
  _s := trim( _SrcDset.FieldByName( 'shot_name' ).AsString );
  if not _SrcDset.FieldByName( 'name').IsNull  then
   _s:=_s+' '+trim(_SrcDset.FieldByName( 'name' ).AsString);
  if not _SrcDset.FieldByName( 'gos_number' ).IsNull  then
  _s:=_s+' '+trim(_SrcDset.FieldByName( 'gos_number' ).AsString);
  if not _SrcDset.FieldByName( 'number' ).IsNull then
    _s := _s + ' - (' + _SrcDset.FieldByName( 'number' ).AsString+') ';
  if not _SrcDset.FieldByName( 'v_kovsh' ).IsNull then
  _s:=_s+' - '+_SrcDset.FieldByName( 'v_kovsh' ).AsString;
///    _s := ' №'+trim( _SrcDset.FieldByName( 'gos_number' ).AsString)+'('+_SrcDset.FieldByName( 'number' ).AsString+')-'+_SrcDset.FieldByName( 'v_kovsh' ).AsString;
  _MemTable.FieldByName( 'fl_FULL_NAME' ).AsString := _s;}

end;

procedure TDm_GlobalVocCache.DamageLocality_OnFillRecHandler(
      _MemTable: TkbmMemTable; _SrcDset: TDataSet);
var _s:string;
    l,i:integer;
begin
  _s:=_SrcDset.fieldByname('classnumber').AsString+' '+trim(_SrcDset.fieldByname('name').AsString);
  _MemTable.FieldByName( 'name' ).AsString := _s


end;




end.

