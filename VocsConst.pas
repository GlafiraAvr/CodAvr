unit VocsConst;

interface

const
  // Название поля которое отвечает за видимость строки для
  // текущего участка
  IS_VISIBLE_FOR_CUR_REC = 'is_visible_for_cur_district';

  //Справочник улиц
  STREETS_ID = 1;
  STREETS_SQL =
    ' select s.id,' +
    ' (select name from Get_FullStreetName(s.id)) as name,' +
    ' s.activity' +
    ' from s_streets s' +
    ' order by name';

  //Справочник о чем заявлено для подзаявок
  SUBORDERMSG_ID = 2;
  SUBORDERMSG_SQL =
    ' select id, name_ as name, activity' +
    ' from s_subordermsg' +
    ' order by name_';

  //Справочник абонентов для подзаявок
  SUBORDERABON_ID = 3;
  SUBORDERABON_SQL =
    ' select id, name_ name, activity' +
    ' from s_suborderabon' +
    ' order by name_';

  //Справочник бригадиров
  BRIGADIERS_ID = 4;
  BRIGADIERS_SQL =
    ' select id, name,  activity, fk_brigadiers_regions' +
    ' from brigadiers' +
    ' order by name';

  //Справочник диспетчеров
  OFFICIALS_ID = 5;
  OFFICIALS_SQL =
    ' select id, name,  activity, fk_offic_officpost' +
    ' from s_officials' +
    ' order by name';

  //Справочник районов
  REGIONS_ID = 6;
  REGIONS_SQL =
    ' select id, name, activity' +
    ' from s_regions' +
    ' order by name';

  //Справочник мест повреждений
  DAMAGEPLACE_ID = 7;
  DAMAGEPLACE_SQL =
    ' select id, name, activity, CHACK_DIAM' +
    ' from s_damageplace' +
    ' order by name';

  //Справочник длительности работ
  WORKTIME_ID = 8;
  WORKTIME_SQL =
    ' select wt.id, wt.id_work, wt.id_diam,' +
    ' wt.hour_summer, wt.hour_winter, wt.activity,' +
    ' w.name work_name, td.diameter diam,' +
    ' wt.measur_quantity' +
    ' from s_worktime wt' +
    ' left join s_works w on w.id = wt.id_work' +
    ' left join s_tubediameter td on td.id = wt.id_diam' +
    ' order by w.name, td.diameter';

  //Справочник большой работы
  BWORK_ID = 9;
  BWORK_SQL =
    ' select id, name_ name, activity' +
    ' from s_bwork' +
    ' order by name_';

  //Справочник малых работ
  WORKS_ID = 10;
  WORKS_SQL =
    ' select sw.id, sw.name, sw.id_workkind,' +
    ' sm.name measurement, sw.activity,sw.for_plan' +
    ' from s_works sw' +
    ' left join s_measurement sm on sm.id = sw.id_measurement' +
    ' order by sw.name';

  //Справочник диаметров
  TUBEDIAMETER_ID = 11;
  TUBEDIAMETER_SQL =
    ' select id, diameter, activity,' +
    ' (select strval from tochar(sd.diameter)) as name' +
    ' from s_tubediameter sd' +
    ' order by diameter';

  //Справочник материалов
  MATERIALS_ID = 12;
  MATERIALS_SQL =
    ' select id, name,  measurement, activity,' +
    ' rtrim(name)||'' (''||rtrim(measurement)||'')'' as full_name' +
    ' from materials' +
    ' order by name, measurement';

  //Справочник видов работ
  WORKTYPE_ID = 13;
  WORKTYPE_SQL =
    ' select id, name, activity' +
    ' from s_worktype' +
    ' order by name';

  //Справочник оборудования  
  EQUIPMENT_ID = 14;
  EQUIPMENT_SQL =
    ' select e.id, e.name, e.number, e.id_region, e.id_vocrectype, e.activity,e.gos_number,e.v_kovsh, e.shot_name,' +
    ' ( select is_visible from is_visible_for_cur_district( e.id_region,' +
    '     e.id_vocrectype) ) as is_visible_for_cur_district, ' +
    ' FK_EQUIP_TYP   as id_typ, '+
    ' (select full_name from get_equip_full_name(e.id)) as fl_FULL_NAME '+
    ' from equipment e' +
    ' where activity is null '+
    ' order by  e.gos_number,e.name,e.number ';

  //Справочник S_MESSAGETYPES
  MESSAGETYPES_ID = 15;
  MESSAGETYPES_SQL =
    ' select id, messagename as name, S_MT_CATEGORY_ID, activity ' +
    ' from S_MESSAGETYPES' +
    ' where activity is null'+
    ' order by messagename';

  //Справочник типов адресов S_HouseType
  HOUSETYPE_ID = 16;
  HOUSETYPE_SQL =
    ' select st.id, st.name, st.activity'+
    '  from s_housetype st'+
    '   order by id';

//  Справочник местности повреждения
  damagelocality_ID=17;
  damagelocality_SQL=
 ' select sd.id, sd.name,sd.classnumber, sd.activity '+
 ' from s_damagelocality sd '+
 ' where id<>4'+
 ' order by classnumber';

//Справочник материалов труб
 tubematerial_id=18;
 tubematerial_SQL=
  '  select sm.id, sm.name, sm.activity '+
  '   from s_tubematerial sm';

//Справочник s_organisation
 organisation_id=19;
 organisation_SQL=
 ' select so.id, so.name, so.phone, so.activity '+
 ' from s_organisations so '+
 ' where so.activity is null '+
 ' order by name';


//Справочник s_soil
 soil_ID=20;
 soil_SQL=
 ' select id, name, activity '+
 ' from s_soil '+
 ' order by name ';


//Справочник damagetype
 damagetype_id=21;
 damagetype_SQL=
 ' select id, name, activity '+
 ' from s_damagetype '+
 ' order by name ';


 //Справочник для ВДС
  Applicant_Vds_Id=100;
  Applicant_Vds_SQL=
  'select id, name, activity '+
   ' from s_Applicant_vds '+
   ' order by name ' ;

   //Справочник для ВДС
  MessageType_Vds_Id=101;
  MessageType_Vds_SQL=
  ' select id, messagename, messagename name, activity '+
  ' from s_messagetypes_vds '+
  '  order  by messagename';

  
   //Справочник для ВДС
  damagetype_vds_Id=102;
  damagetype_vds_SQL=
  '  select id, name, activity '+
  ' from s_damagetype_vds '+
  ' order by name';

   //Спарвочник районов с участками для выездов!!
   All_regions_id=22;
   All_regions_SQL ='select id, name, full_name from all_regions al '+
                    ' order by id';
implementation

end.
