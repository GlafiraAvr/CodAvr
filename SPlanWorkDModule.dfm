inherited dm_SPlanWork: Tdm_SPlanWork
  Left = 876
  Top = 244
  inherited frReport: TfrReport
    ShowProgress = False
    ReportForm = {19000000}
  end
  object dset: TIBDataSet
    Left = 24
    Top = 152
  end
  object dset_main: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      
        ' select dd.id, o.ordernumber, br.name brigadier, dd.planstartdat' +
        'e stratdate  ,dd.planenddate endDate,'
      
        '( select ADRES from get_adres(o.fk_orders_housetypes, o.fk_order' +
        's_streets,o.housenum,o.additionaladdress)) adress,'
      '   sd.name locality ,'
      
        '( select ADRES from get_adres(dd.fk_deparure_housetypes,dd.fk_de' +
        'parure_id_street,dd.housenum,dd.addadres)) adress_dep,'
      'sd1.name  locality_dep'
      
        '  from departures dd left join orders o on o.id=dd.fk_departures' +
        '_orders'
      '  left join brigadiers br on br.id=dd.fk_departures_brigadiers'
      
        '  left join s_damagelocality sd on sd.id=o.fk_orders_damagelocal' +
        'ity'
      
        '  left join s_damagelocality sd1 on sd1.id=dd.fk_departures_dama' +
        'gelocality'
      ' where dd.planstartdate>:d1 and dd.planstartdate<:d1+1 ')
    Left = 16
    Top = 88
  end
  object tran: TIBTransaction
    DefaultDatabase = DM_Main.IBDatabase
    Left = 216
    Top = 32
  end
  object dset_workers: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      
        ' select w.name from departureworkers dw left join workers w on d' +
        'w.fk_depworkers_worker=w.id'
      ' where dw.fk_depworkers_departure=:dep_Id')
    Left = 96
    Top = 96
  end
  object dset_equipment: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      'select (select FULL_NAME from get_equip_full_name(e.id)) name,'
      
        '(select se.name from s_equipment_typ se where se.id=ed.fk_id_equ' +
        'iptyp)||ASCII_CHAR(13) typ_name'
      ' from equip_paln_departure ed left join equipment e'
      
        ' on e.id =ed.fk_id_equipment    where ed.fk_id_departures=:dep_i' +
        'd')
    Left = 176
    Top = 96
  end
  object dset_planworks: TIBDataSet
    Database = DM_Main.IBDatabase
    Transaction = tran
    SelectSQL.Strings = (
      
        ' select sw.name, st.diameter  diameter  from plan_dep_works  pw ' +
        'left join s_works sw on sw.id=pw.fk_depworks_work'
      ' left join s_tubediameter st  on st.id=pw.fk_depworks_diameter'
      ' where pw.fk_depworks_departure=:dep_id')
    Left = 192
    Top = 168
  end
  object md_table: TRxMemoryData
    FieldDefs = <>
    Left = 152
    Top = 16
    object md_tableordernumber: TIntegerField
      FieldName = 'ordernumber'
    end
    object md_tableBrig: TStringField
      FieldName = 'Brig'
      Size = 30
    end
    object md_tableWorkkers: TStringField
      FieldName = 'Workkers'
      Size = 2000
    end
    object md_tablestart: TDateTimeField
      FieldName = 'start'
    end
    object md_tableend: TDateTimeField
      FieldName = 'end'
    end
    object md_tableequipments: TStringField
      FieldName = 'equipments'
      Size = 2000
    end
    object md_tableadress: TStringField
      FieldName = 'adress'
      Size = 100
    end
    object md_tableLocality: TStringField
      FieldName = 'Locality'
      Size = 30
    end
    object md_tablePlanWorks: TStringField
      FieldName = 'PlanWorks'
      Size = 2000
    end
    object md_tableREgion: TStringField
      FieldName = 'REgion'
      Size = 15
    end
    object md_tableadditionalinfo: TStringField
      FieldName = 'additionalinfo'
      Size = 1000
    end
    object md_tablefact_end: TStringField
      DisplayWidth = 20
      FieldName = 'fact_end'
    end
  end
  object frDBDataSet: TfrDBDataSet
    DataSet = md_table
    Left = 88
    Top = 16
  end
end
