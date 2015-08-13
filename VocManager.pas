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
    vnVocStreets:        Result := Tfrm_VocStreets.Create( nil, AIsReadOnly );              //����
    vnVocOfficials:      Result := Tfrm_VocOfficials.Create( nil, AIsReadOnly );            //����������� ���
    vnVocBrigadiers:     Result := Tfrm_VocBrigadiers.Create( nil, AIsReadOnly );           //����������
    vnVocTubeMaterial:   Result := Tfrm_VocTubeMaterial.Create( nil, AIsReadOnly );         //���������� ����
    vnVocTubeDiameter:   Result := Tfrm_VocTubeDiameter.Create( nil, AIsReadOnly );         //���������
    vnVocDamageLocality: Result := Tfrm_VocDamageLocality.Create( nil, AIsReadOnly );       //��������� �����������
    vnVocDamagePlace:    Result := Tfrm_VocDamagePlace.Create( nil, AIsReadOnly );          //���� �����������
    vnVocProfWorks:      Result := Tfrm_VocProfWorks.Create( nil, AIsReadOnly );            //����� ���������
    vnVocMessageTypes:   Result := Tfrm_VocMessageTypes.Create( nil, AIsReadOnly );         //����� ������
    vnVocRegions:        Result := Tfrm_VocRegions.Create( nil, AIsReadOnly );              //���������������� �������
    vnVocMaterials:      Result := Tfrm_VocMaterials.Create( nil, AIsReadOnly );            //����������
    vnVocEquipment:      Result := Tfrm_VocEquipment.Create( nil, AIsReadOnly );            //������������
    vnVocOrganizations:  Result := Tfrm_VocOrganizations.Create( nil, AIsReadOnly );        //�������������� �����������
    vnVocAbonents:       Result := Tfrm_VocAbonents.Create( nil, AIsReadOnly );             //���������
    vnVocWorkers:        Result := Tfrm_VocWorkers.Create( nil, AIsReadOnly );              //��������
    vnVocTeams:          Result := Tfrm_VocTeams.Create( nil, AIsReadOnly );                //������
    vnVocWorks:          Result := Tfrm_VocWorks.Create( nil, AIsReadOnly );                //�����
   // vnVocSubOrderMsg:    Result := Tfrm_VocSOMsg.Create( nil, AIsReadOnly );                //0-62(� ��� ��������) �� ������������ ���������� ����
    vnVocSubOrderAbon:   Result := Tfrm_VocSOAbon.Create( nil, AIsReadOnly );               //0-62(��������� ��)
    vnVocWorkerPost:     Result := Tfrm_VocWorkerPost.Create( nil, AIsReadOnly );           //��������� ��������
    vnVocWorkTime:       Result := Tfrm_VocWorkTime.Create( nil, AIsReadOnly );             //������������ �����
    vnVocBWork:          Result := Tfrm_VocBWork.Create( nil, AIsReadOnly );                //�����(�������)
    vnVocWorkType:       Result := Tfrm_VocWorkType.Create( nil, AIsReadOnly );             //����� �����
    vnVocMeasurement:    Result := Tfrm_VocMeasurement.Create( nil, AIsReadOnly );          //������ ���������
    vnVocAsfCompanyType: Result := Tfrm_VocAsfcompany.Create( nil, AIsReadOnly );          //����������� �������������
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
