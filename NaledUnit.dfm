�
 TFRM_NALED 0�  TPF0�
Tfrm_Naled	frm_NaledLeftATopWidth.Height%Caption   0;54LOldCreateOrder	OnCreate
FormCreateOnShowFormShowPixelsPerInch`
TextHeight TLabell_SquareLeftTop?WidthCHeightCaption   Площадь, м2  TLabell_VolumeLeftTopWWidth7HeightCaption   Объём, м3  TLabell_OpenLeftTopWidth=HeightCaption#   Наледь 
обнаружена  TLabell_CloseLeftTopsWidthNHeightCaption(   Наледь
ликвидирована  TLabelLabel1LeftTop� WidthCHeightCaption   A?>;=8B5;L  TButtonBT_OKLeftTop� WidthKHeightCaption   0?8A0BLTabOrderOnClick
BT_OKClick  TButton	BT_CancelLeft� Top� WidthKHeightCaption   B<5=0TabOrder	OnClickBT_CancelClick  TRxDBLookupComboDBL_OpenLefthTopWidth� HeightDropDownCount	DataFieldFK_NALED_OFFICIALOPEN
DataSourcedsourceLookupFieldIDLookupDisplayNAMELookupSourceds_openTabOrderOnChangede_OpenChange  TRxDBLookupCombo	DBL_CloseLeftfTop� Width� HeightDropDownCount	DataFieldFK_NALED_OFFICIALCLOSED
DataSourcedsourceLookupFieldIDLookupDisplayNAMELookupSourceds_closeTabOrderOnChangede_OpenChange  TDBDateTimeEditEhte_OpenLeft� TopWidthAHeight	DataField	DTTM_OPEN
DataSourcedsourceEditButton.StyleebsUpDownEhKind	dtkTimeEhTabOrderOnChangede_OpenChange  TDBDateTimeEditEhde_OpenLefthTopWidthYHeight	DataField	DTTM_OPEN
DataSourcedsourceKind	dtkDateEhTabOrder OnChangede_OpenChange  TDBDateTimeEditEhde_CloseLefteToprWidthXHeight	DataFieldDTTM_CLOSED
DataSourcedsourceKind	dtkDateEhTabOrderOnChangede_OpenChange  TDBDateTimeEditEhte_CloseLeft� ToprWidthAHeight	DataFieldDTTM_CLOSED
DataSourcedsourceEditButton.StyleebsUpDownEhKind	dtkTimeEhTabOrderOnChangede_OpenChange  TRxDBCalcEdit	ce_SquareLeftgTop@WidthOHeight	DataFieldSQUARE
DataSourcedsource	NumGlyphsTabOrderOnChangede_OpenChange  TRxDBCalcEdit	ce_VolumeLeftgTopXWidthOHeight	DataFieldVOLUME
DataSourcedsource	NumGlyphsTabOrderOnChangede_OpenChange  TRxDBLookupComboDBL_AsfcompanyLeftfTop� Width� HeightDropDownCount	DataFieldFK_NALED_ASFCOMPANY
DataSourcedsourceLookupFieldIDLookupDisplayNAMELookupSourceds_asfcompanyTabOrder
OnChangede_OpenChange  
TIBDataSetdsetDatabaseDM_Main.IBDatabaseTransactiontranSelectSQL.Stringsselect     ID, FK_NALED_ORDERS
,  SQUARE 	,  VOLUME,  FK_NALED_OFFICIALOPEN,  DTTM_OPEN,  FK_NALED_OFFICIALCLOSED,  FK_NALED_ASFCOMPANY,  DTTM_CLOSEDfrom NALED  GeneratorField.FieldIDGeneratorField.GeneratorGEN_NALED_IDLeftHTop�   TDataSourcedsourceDataSetdsetLeft(Top�   TDataSourceds_openDataSet	dset_openLeft� Top  
TIBDataSet	dset_openDatabaseDM_Main.IBDatabaseTransactionDM_Main.Tr_RCommitedSelectSQL.Stringsselect id, name, activityfrom S_OFFICIALSwhere name is not nullorder by name Left� Top TIntegerFielddset_openID	FieldNameIDOrigin"S_OFFICIALS"."ID"ProviderFlags
pfInUpdate	pfInWherepfInKey Required	  TIBStringFielddset_openNAME	FieldNameNAMEOrigin"S_OFFICIALS"."NAME"	FixedChar	Size@  TIBStringFielddset_openACTIVITY	FieldNameACTIVITYOrigin"S_OFFICIALS"."ACTIVITY"	FixedChar	Size   
TIBDataSet
dset_closeDatabaseDM_Main.IBDatabaseTransactionDM_Main.Tr_RCommitedSelectSQL.Stringsselect id, name, activityfrom s_officialswhere name is not nullorder by name Left� Top�  TIntegerFielddset_closeID	FieldNameIDOrigin"S_OFFICIALS"."ID"ProviderFlags
pfInUpdate	pfInWherepfInKey Required	  TIBStringFielddset_closeNAME	FieldNameNAMEOrigin"S_OFFICIALS"."NAME"	FixedChar	Size@  TIBStringFielddset_closeACTIVITY	FieldNameACTIVITYOrigin"S_OFFICIALS"."ACTIVITY"	FixedChar	Size   TDataSourceds_closeDataSet
dset_closeLeft� Top�   TIBTransactiontranDefaultDatabaseDM_Main.IBDatabaseLeftxTop�   TDataSourceds_asfcompanyDataSetdset_asfcompanyLeft� Top�   
TIBDataSetdset_asfcompanyDatabaseDM_Main.IBDatabaseTransactionDM_Main.Tr_RCommitedSelectSQL.Stringsselect id, namefrom s_asfcompany
where id>0order by name Left� Top�  TIntegerFieldIntegerField1	FieldNameIDOrigin"S_OFFICIALS"."ID"ProviderFlags
pfInUpdate	pfInWherepfInKey Required	  TIBStringFieldIBStringField1	FieldNameNAMEOrigin"S_OFFICIALS"."NAME"	FixedChar	Size@    