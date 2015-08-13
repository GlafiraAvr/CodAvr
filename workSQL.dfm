object dm_workSQL: Tdm_workSQL
  OldCreateOrder = False
  Left = 537
  Top = 362
  Height = 186
  Width = 686
  object ADOQuery1562: TADOQuery
    Connection = DM_Main.ADOConn_1562
    Parameters = <>
    Left = 56
    Top = 32
  end
  object ADOSP_RallBack1562: TADOStoredProc
    Connection = DM_Main.ADOConn_1562
    ProcedureName = 'sp_new_RollbackRequestKhNew;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@ID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@inSystemRollback'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@fk_disp'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@id_order'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@number_order'
        Attributes = [paNullable]
        DataType = ftString
        Size = 10
        Value = Null
      end
      item
        Name = '@order_createdate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@error_number'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@error_message'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 2048
        Value = Null
      end>
    Left = 288
    Top = 32
  end
  object ADOSP_Import_Denied: TADOStoredProc
    Connection = DM_Main.ADOConn_1562
    ProcedureName = 'spImportKhNewToRequest_Denied;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@id'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@FK_ID_DISPATCHER'
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@transfer'
        Attributes = [paNullable]
        DataType = ftString
        Size = 31
        Value = Null
      end
      item
        Name = '@cause_failure'
        Attributes = [paNullable]
        DataType = ftString
        Size = 480
        Value = Null
      end
      item
        Name = '@error_number'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@error_message'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 200
        Value = Null
      end>
    Left = 408
    Top = 32
  end
  object ADOSP_DirTelRequestInOch: TADOStoredProc
    Connection = DM_Main.ADOConn_1562
    ProcedureName = 'spDirectionTelRequestInOchistvod;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@id'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@fk_disp'
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@system_direction'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@error_number'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@error_message'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 2048
        Value = Null
      end>
    Left = 544
    Top = 32
  end
  object ADOSP_Resived1562: TADOStoredProc
    Connection = DM_Main.ADOConn_1562
    ProcedureName = 'spRead_Kh_New;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@ID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@id_order'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@number_order'
        Attributes = [paNullable]
        DataType = ftString
        Size = 10
        Value = Null
      end
      item
        Name = '@order_createdate'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@error_number'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@error_message'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 200
        Value = Null
      end>
    Left = 160
    Top = 88
  end
end
