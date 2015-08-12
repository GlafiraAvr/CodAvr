object dm_AvrUserManager: Tdm_AvrUserManager
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Left = 359
  Top = 323
  Height = 212
  Width = 287
  object IBDB: TIBDatabase
    DatabaseName = 'E:\work\avrs\avr_khar_ib\Data\avr_kh_new.gdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    Left = 16
    Top = 16
  end
end
