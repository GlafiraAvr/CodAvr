object dm_ClientImage: Tdm_ClientImage
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 192
  Top = 151
  Height = 151
  Width = 215
  object IdTCPClient: TIdTCPClient
    MaxLineAction = maException
    ReadTimeout = 3000
    Host = '172.16.33.50'
    Port = 2000
    Left = 16
    Top = 16
  end
end
