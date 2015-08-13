unit VocManager;

interface

uses BaseVocForm;

type
  TVocName=(vnVocStreets, vnVocOfficials, vnVocBrigadiers, vnVocTubeMaterial,
            vnVocTubeDiameter, vnVocDamageLocality, vnVocDamagePlace, vnVocProfWorks,
            vnVocMessageTypes, vnVocRegions, vnVocMaterials, vnVocEquipment,
            vnVocOrganizations, vnVocAbonents, vnVocWorkers, vnVocTeams, vnVocWorks,
            vnVocSubOrderAbon, vnVocWorkerPost, vnVocWorkTime,
            vnVocBWork, vnVocWorkType, vnVocMeasurement, vnVocAsfCompanyType);

  TVocManager=class
  private
    function CreateVocFrm(AVocName: TVocName; AIsReadOnly: boolean): Tfrm_BaseVoc;
  public
    procedure ShowVoc(AVocName: TVocName; AIsReadOnly: boolean);
  end;

implementation

uses VocStreetsForm, VocOfficialsForm, VocBrigadiersForm, VocTubeMaterialForm,
      VocTubeDiameterForm, VocDamageLocalityForm, VocDamagePlaceForm, VocProfWorksForm,
      VocMessageTypesForm, VocRegionsForm, VocMaterialsForm, VocEquipmentForm,
      VocOrganizationsForm, VocAbonentsForm, VocWorkersForm, VocTeamsForm, VocWorksForm,
       VocSOAbon, VocWorkerPostForm, VocWorkTimeForm, BWorkForm,
      VocWorkTypeForm, VocMeasurementForm, VocAsfcompanyForm;

{ TVocManager }

function TVocManager.CreateVocFrm(AVocName: TVocName; AIsReadOnly: boolean): Tfrm_BaseVoc;
begin
  case AVocName of
    vnVocStreets:        Result := Tfrm_VocStreets.Create( nil, AIsReadOnly );              //Улиц
    vnVocOfficials:      Result := Tfrm_VocOfficials.Create( nil, AIsReadOnly );            //Должностных лиц
    vnVocBrigadiers:     Result := Tfrm_VocBrigadiers.Create( nil, AIsReadOnly );           //Бригадиров
    vnVocTubeMaterial:   Result := Tfrm_VocTubeMaterial.Create( nil, AIsReadOnly );         //Материалов труб
    vnVocTubeDiameter:   Result := Tfrm_VocTubeDiameter.Create( nil, AIsReadOnly );         //Диаметров
    vnVocDamageLocality: Result := Tfrm_VocDamageLocality.Create( nil, AIsReadOnly );       //Местность повреждения
    vnVocDamagePlace:    Result := Tfrm_VocDamagePlace.Create( nil, AIsReadOnly );          //Мест повреждений
    vnVocProfWorks:      Result := Tfrm_VocProfWorks.Create( nil, AIsReadOnly );            //Видов профработ
    vnVocMessageTypes:   Result := Tfrm_VocMessageTypes.Create( nil, AIsReadOnly );         //Видов заявок
    vnVocRegions:        Result := Tfrm_VocRegions.Create( nil, AIsReadOnly );              //Административных районов
    vnVocMaterials:      Result := Tfrm_VocMaterials.Create( nil, AIsReadOnly );            //Материалов
    vnVocEquipment:      Result := Tfrm_VocEquipment.Create( nil, AIsReadOnly );            //Оборудования
    vnVocOrganizations:  Result := Tfrm_VocOrganizations.Create( nil, AIsReadOnly );        //Контролирующих организаций
    vnVocAbonents:       Result := Tfrm_VocAbonents.Create( nil, AIsReadOnly );             //Абонентов
    vnVocWorkers:        Result := Tfrm_VocWorkers.Create( nil, AIsReadOnly );              //Слесарей
    vnVocTeams:          Result := Tfrm_VocTeams.Create( nil, AIsReadOnly );                //Бригад
    vnVocWorks:          Result := Tfrm_VocWorks.Create( nil, AIsReadOnly );                //Работ
   // vnVocSubOrderMsg:    Result := Tfrm_VocSOMsg.Create( nil, AIsReadOnly );                //0-62(О чем заявлено) НЕ используеься справочник пуст
    vnVocSubOrderAbon:   Result := Tfrm_VocSOAbon.Create( nil, AIsReadOnly );               //0-62(Поступило от)
    vnVocWorkerPost:     Result := Tfrm_VocWorkerPost.Create( nil, AIsReadOnly );           //Категорий слесарей
    vnVocWorkTime:       Result := Tfrm_VocWorkTime.Create( nil, AIsReadOnly );             //Длительности работ
    vnVocBWork:          Result := Tfrm_VocBWork.Create( nil, AIsReadOnly );                //Работ(больших)
    vnVocWorkType:       Result := Tfrm_VocWorkType.Create( nil, AIsReadOnly );             //Видов работ
    vnVocMeasurement:    Result := Tfrm_VocMeasurement.Create( nil, AIsReadOnly );          //Единиц измерений
    vnVocAsfCompanyType: Result := Tfrm_VocAsfcompany.Create( nil, AIsReadOnly );          //Предприятий асфальтировки
  end;
end;

procedure TVocManager.ShowVoc(AVocName: TVocName; AIsReadOnly: boolean);
var
  frm_Voc: Tfrm_BaseVoc;
begin
  frm_Voc:=CreateVocFrm(AVocName, AIsReadOnly);
  try
    frm_Voc.ShowModal;
  finally
    frm_Voc.Free;
  end;
end;

end.
