VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ACBrCodigoMunicipioNFSe"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public Sub AdicionarItemComboBox(cmb As ComboBox, descricao As String, valor As String)
    cmbCidadeEmitente.AddItem descricao
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = valor
End Sub

Public Sub NenhumCidade(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Nenhuma Cidade Selecionada"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 0
End Sub

Public Sub Rondonia(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Alta Floresta D Oeste - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100015
    cmbCidadeEmitente.AddItem "Alto Alegre dos Parecis - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100379
    cmbCidadeEmitente.AddItem "Alto Paraiso - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100403
    cmbCidadeEmitente.AddItem "Alvorada D Oeste - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100346
    cmbCidadeEmitente.AddItem "Ariquemes - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100023
    cmbCidadeEmitente.AddItem "Buritis - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100452
    cmbCidadeEmitente.AddItem "Cabixi - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100031
    cmbCidadeEmitente.AddItem "Cacaulandia - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100601
    cmbCidadeEmitente.AddItem "Cacoal - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100049
    cmbCidadeEmitente.AddItem "Campo Novo de Rondonia - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100700
    cmbCidadeEmitente.AddItem "Candeias do Jamari - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100809
    cmbCidadeEmitente.AddItem "Castanheiras - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100908
    cmbCidadeEmitente.AddItem "Cerejeiras - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100056
    cmbCidadeEmitente.AddItem "Chupinguaia - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100924
    cmbCidadeEmitente.AddItem "Colorado do Oeste - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100064
    cmbCidadeEmitente.AddItem "Corumbiara - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100072
    cmbCidadeEmitente.AddItem "Costa Marques - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100080
    cmbCidadeEmitente.AddItem "Cujubim - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100940
    cmbCidadeEmitente.AddItem "Espigao D Oeste - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100098
    cmbCidadeEmitente.AddItem "Governador Jorge Teixeira - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1101005
    cmbCidadeEmitente.AddItem "Guajara-Mirim - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100106
    cmbCidadeEmitente.AddItem "Itapuã do Oeste - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1101104
    cmbCidadeEmitente.AddItem "Jaru - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100114
    cmbCidadeEmitente.AddItem "Ji-Parana - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100122
    cmbCidadeEmitente.AddItem "Machadinho do Oeste - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100130
    cmbCidadeEmitente.AddItem "Ministro Andreazza - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1101203
    cmbCidadeEmitente.AddItem "Mirante da Serra - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1101302
    cmbCidadeEmitente.AddItem "Monte Negro - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1101401
    cmbCidadeEmitente.AddItem "Nova Brasilandia D Oeste - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100148
    cmbCidadeEmitente.AddItem "Nova Mamore - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100338
    cmbCidadeEmitente.AddItem "Nova Uniao - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1101435
    cmbCidadeEmitente.AddItem "Novo Horizonte do Oeste - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100502
    cmbCidadeEmitente.AddItem "Ouro Preto do Oeste - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100155
    cmbCidadeEmitente.AddItem "Parecis - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1101450
    cmbCidadeEmitente.AddItem "Pimenta Bueno - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100189
    cmbCidadeEmitente.AddItem "Pimenteiras do Oeste - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1101468
    cmbCidadeEmitente.AddItem "Porto Velho - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100205
    cmbCidadeEmitente.AddItem "Presidente Medici - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100254
    cmbCidadeEmitente.AddItem "Primavera de Rondonia - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1101476
    cmbCidadeEmitente.AddItem "Rio Crespo - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100262
    cmbCidadeEmitente.AddItem "Rolim de Moura - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100288
    cmbCidadeEmitente.AddItem "Santa Luzia D Oeste - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100296
    cmbCidadeEmitente.AddItem "Sao Felipe D Oeste - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1101484
    cmbCidadeEmitente.AddItem "Sao Francisco do Guapore - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1101492
    cmbCidadeEmitente.AddItem "Sao Miguel do Guapore - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100320
    cmbCidadeEmitente.AddItem "Seringueiras - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1101500
    cmbCidadeEmitente.AddItem "Teixeiropolis - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1101559
    cmbCidadeEmitente.AddItem "Theobroma - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1101609
    cmbCidadeEmitente.AddItem "Urupa - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1101708
    cmbCidadeEmitente.AddItem "Vale do Anari - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1101757
    cmbCidadeEmitente.AddItem "Vale do Paraiso - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1101807
    cmbCidadeEmitente.AddItem "Vilhena - RO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1100304
End Sub

Public Sub Acre(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Acrelandia - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200013
    cmbCidadeEmitente.AddItem "Assis Brasil - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200054
    cmbCidadeEmitente.AddItem "Brasileia - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200104
    cmbCidadeEmitente.AddItem "Bujari - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200138
    cmbCidadeEmitente.AddItem "Capixaba - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200179
    cmbCidadeEmitente.AddItem "Cruzeiro do Sul - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200203
    cmbCidadeEmitente.AddItem "Epitaciolandia - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200252
    cmbCidadeEmitente.AddItem "Feijo - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200302
    cmbCidadeEmitente.AddItem "Jordao - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200328
    cmbCidadeEmitente.AddItem "Mancio Lima - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200336
    cmbCidadeEmitente.AddItem "Manoel Urbano - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200344
    cmbCidadeEmitente.AddItem "Marechal Thaumaturgo - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200351
    cmbCidadeEmitente.AddItem "Placido de Castro - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200385
    cmbCidadeEmitente.AddItem "Porto Acre - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200807
    cmbCidadeEmitente.AddItem "Porto Walter - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200393
    cmbCidadeEmitente.AddItem "Rio Branco - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200401
    cmbCidadeEmitente.AddItem "Rodrigues Alves - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200427
    cmbCidadeEmitente.AddItem "Santa Rosa do Purus - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200435
    cmbCidadeEmitente.AddItem "Sena Madureira - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200500
    cmbCidadeEmitente.AddItem "Senador Guiomard - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200450
    cmbCidadeEmitente.AddItem "Tarauaca - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200609
    cmbCidadeEmitente.AddItem "Xapuri - AC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1200708
End Sub

Public Sub Amazonas(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Alvaraes - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1300029
    cmbCidadeEmitente.AddItem "Amatura - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1300060
    cmbCidadeEmitente.AddItem "Anama - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1300086
    cmbCidadeEmitente.AddItem "Anori - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1300102
    cmbCidadeEmitente.AddItem "Apui - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1300144
    cmbCidadeEmitente.AddItem "Atalaia do Norte - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1300201
    cmbCidadeEmitente.AddItem "Autazes - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1300300
    cmbCidadeEmitente.AddItem "Barcelos - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1300409
    cmbCidadeEmitente.AddItem "Barreirinha - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1300508
    cmbCidadeEmitente.AddItem "Benjamin Constant - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1300607
    cmbCidadeEmitente.AddItem "Beruri - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1300631
    cmbCidadeEmitente.AddItem "Boa Vista do Ramos - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1300680
    cmbCidadeEmitente.AddItem "Boca do Acre - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1300706
    cmbCidadeEmitente.AddItem "Borba - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1300805
    cmbCidadeEmitente.AddItem "Caapiranga - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1300839
    cmbCidadeEmitente.AddItem "Canutama - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1300904
    cmbCidadeEmitente.AddItem "Carauari - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1301001
    cmbCidadeEmitente.AddItem "Careiro - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1301100
    cmbCidadeEmitente.AddItem "Careiro da Varzea - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1301159
    cmbCidadeEmitente.AddItem "Coari - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1301209
    cmbCidadeEmitente.AddItem "Codajas - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1301308
    cmbCidadeEmitente.AddItem "Eirunepe - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1301407
    cmbCidadeEmitente.AddItem "Envira - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1301506
    cmbCidadeEmitente.AddItem "Fonte Boa - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1301605
    cmbCidadeEmitente.AddItem "Guajara - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1301654
    cmbCidadeEmitente.AddItem "Humaita - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1301704
    cmbCidadeEmitente.AddItem "Ipixuna - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1301803
    cmbCidadeEmitente.AddItem "Iranduba - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1301852
    cmbCidadeEmitente.AddItem "Itacoatiara - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1301902
    cmbCidadeEmitente.AddItem "Itamarati - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1301951
    cmbCidadeEmitente.AddItem "Itapiranga - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1302009
    cmbCidadeEmitente.AddItem "Japura - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1302108
    cmbCidadeEmitente.AddItem "Jurua - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1302207
    cmbCidadeEmitente.AddItem "Jutai - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1302306
    cmbCidadeEmitente.AddItem "Labrea - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1302405
    cmbCidadeEmitente.AddItem "Manacapuru - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1302504
    cmbCidadeEmitente.AddItem "Manaquiri - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1302553
    cmbCidadeEmitente.AddItem "Manaus - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1302603
    cmbCidadeEmitente.AddItem "Manicore - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1302702
    cmbCidadeEmitente.AddItem "Maraa - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1302801
    cmbCidadeEmitente.AddItem "Maues - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1302900
    cmbCidadeEmitente.AddItem "Nhamunda - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1303007
    cmbCidadeEmitente.AddItem "Nova Olinda do Norte - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1303106
    cmbCidadeEmitente.AddItem "Novo Airao - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1303205
    cmbCidadeEmitente.AddItem "Novo Aripuana - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1303304
    cmbCidadeEmitente.AddItem "Parintins - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1303403
    cmbCidadeEmitente.AddItem "Pauini - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1303502
    cmbCidadeEmitente.AddItem "Presidente Figueiredo - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1303536
    cmbCidadeEmitente.AddItem "Rio Preto da Eva - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1303569
    cmbCidadeEmitente.AddItem "Santa Isabel do Rio Negro - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1303601
    cmbCidadeEmitente.AddItem "Santo Antonio do Ica - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1303700
    cmbCidadeEmitente.AddItem "Sao Gabriel da Cachoeira - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1303809
    cmbCidadeEmitente.AddItem "Sao Paulo de Olivenca - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1303908
    cmbCidadeEmitente.AddItem "Sao Sebastiao do Uatuma - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1303957
    cmbCidadeEmitente.AddItem "Silves - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1304005
    cmbCidadeEmitente.AddItem "Tabatinga - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1304062
    cmbCidadeEmitente.AddItem "Tapaua - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1304104
    cmbCidadeEmitente.AddItem "Tefe - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1304203
    cmbCidadeEmitente.AddItem "Tonantins - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1304237
    cmbCidadeEmitente.AddItem "Uarini - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1304260
    cmbCidadeEmitente.AddItem "Urucara - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1304302
    cmbCidadeEmitente.AddItem "Urucurituba - AM"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1304401
End Sub

Public Sub Roraima(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Alto Alegre - RR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1400050
    cmbCidadeEmitente.AddItem "Amajari - RR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1400027
    cmbCidadeEmitente.AddItem "Boa Vista - RR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1400100
    cmbCidadeEmitente.AddItem "Bonfim - RR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1400159
    cmbCidadeEmitente.AddItem "Canta - RR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1400175
    cmbCidadeEmitente.AddItem "Caracarai - RR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1400209
    cmbCidadeEmitente.AddItem "Caroebe - RR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1400233
    cmbCidadeEmitente.AddItem "Iracema - RR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1400282
    cmbCidadeEmitente.AddItem "Mucajai - RR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1400308
    cmbCidadeEmitente.AddItem "Normandia - RR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1400407
    cmbCidadeEmitente.AddItem "Pacaraima - RR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1400456
    cmbCidadeEmitente.AddItem "Rorainopolis - RR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1400472
    cmbCidadeEmitente.AddItem "Sao Joao da Baliza - RR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1400506
    cmbCidadeEmitente.AddItem "Sao Luiz - RR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1400605
    cmbCidadeEmitente.AddItem "Uiramuta - RR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1400704
End Sub

Public Sub Para(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Abaetetuba - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1500107
    cmbCidadeEmitente.AddItem "Abel Figueiredo - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1500131
    cmbCidadeEmitente.AddItem "Acara - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1500206
    cmbCidadeEmitente.AddItem "Afua - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1500305
    cmbCidadeEmitente.AddItem "Agua Azul do Norte - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1500347
    cmbCidadeEmitente.AddItem "Alenquer - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1500404
    cmbCidadeEmitente.AddItem "Almeirim - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1500503
    cmbCidadeEmitente.AddItem "Altamira - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1500602
    cmbCidadeEmitente.AddItem "Anajas - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1500701
    cmbCidadeEmitente.AddItem "Ananindeua - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1500800
    cmbCidadeEmitente.AddItem "Anapu - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1500859
    cmbCidadeEmitente.AddItem "Augusto Correa - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1500909
    cmbCidadeEmitente.AddItem "Aurora do Para - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1500958
    cmbCidadeEmitente.AddItem "Aveiro - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1501006
    cmbCidadeEmitente.AddItem "Bagre - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1501105
    cmbCidadeEmitente.AddItem "Baiao - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1501204
    cmbCidadeEmitente.AddItem "Bannach - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1501253
    cmbCidadeEmitente.AddItem "Barcarena - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1501303
    cmbCidadeEmitente.AddItem "Belem - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1501402
    cmbCidadeEmitente.AddItem "Belterra - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1501451
    cmbCidadeEmitente.AddItem "Benevides - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1501501
    cmbCidadeEmitente.AddItem "Bom Jesus do Tocantins - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1501576
    cmbCidadeEmitente.AddItem "Bonito - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1501600
    cmbCidadeEmitente.AddItem "Braganca - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1501709
    cmbCidadeEmitente.AddItem "Brasil Novo - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1501725
    cmbCidadeEmitente.AddItem "Brejo Grande do Araguaia - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1501758
    cmbCidadeEmitente.AddItem "Breu Branco - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1501782
    cmbCidadeEmitente.AddItem "Breves - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1501808
    cmbCidadeEmitente.AddItem "Bujaru - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1501907
    cmbCidadeEmitente.AddItem "Cachoeira do Arari - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1502004
    cmbCidadeEmitente.AddItem "Cachoeira do Piria - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1501956
    cmbCidadeEmitente.AddItem "Cameta - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1502103
    cmbCidadeEmitente.AddItem "Canaa dos Carajas - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1502152
    cmbCidadeEmitente.AddItem "Capanema - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1502202
    cmbCidadeEmitente.AddItem "Capitao Poco - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1502301
    cmbCidadeEmitente.AddItem "Castanhal - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1502400
    cmbCidadeEmitente.AddItem "Chaves - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1502509
    cmbCidadeEmitente.AddItem "Colares - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1502608
    cmbCidadeEmitente.AddItem "Conceicao do Araguaia - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1502707
    cmbCidadeEmitente.AddItem "Concordia do Para - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1502756
    cmbCidadeEmitente.AddItem "Cumaru do Norte - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1502764
    cmbCidadeEmitente.AddItem "Curionopolis - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1502772
    cmbCidadeEmitente.AddItem "Curralinho - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1502806
    cmbCidadeEmitente.AddItem "Curua - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1502855
    cmbCidadeEmitente.AddItem "Curuca - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1502905
    cmbCidadeEmitente.AddItem "Dom Eliseu - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1502939
    cmbCidadeEmitente.AddItem "Eldorado dos Carajas - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1502954
    cmbCidadeEmitente.AddItem "Faro - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1503002
    cmbCidadeEmitente.AddItem "Floresta do Araguaia - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1503044
    cmbCidadeEmitente.AddItem "Garrafao do Norte - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1503077
    cmbCidadeEmitente.AddItem "Goianesia do Para - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1503093
    cmbCidadeEmitente.AddItem "Gurupa - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1503101
    cmbCidadeEmitente.AddItem "Igarape-Acu - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1503200
    cmbCidadeEmitente.AddItem "Igarape-Miri - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1503309
    cmbCidadeEmitente.AddItem "Inhangapi - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1503408
    cmbCidadeEmitente.AddItem "Ipixuna do Para - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1503457
    cmbCidadeEmitente.AddItem "Irituia - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1503507
    cmbCidadeEmitente.AddItem "Itaituba - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1503606
    cmbCidadeEmitente.AddItem "Itupiranga - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1503705
    cmbCidadeEmitente.AddItem "Jacareacanga - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1503754
    cmbCidadeEmitente.AddItem "Jacunda - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1503804
    cmbCidadeEmitente.AddItem "Juruti - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1503903
    cmbCidadeEmitente.AddItem "Limoeiro do Ajuru - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1504000
    cmbCidadeEmitente.AddItem "Mae do Rio - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1504059
    cmbCidadeEmitente.AddItem "Magalhaes Barata - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1504109
    cmbCidadeEmitente.AddItem "Maraba - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1504208
    cmbCidadeEmitente.AddItem "Maracana - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1504307
    cmbCidadeEmitente.AddItem "Marapanim - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1504406
    cmbCidadeEmitente.AddItem "Marituba - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1504422
    cmbCidadeEmitente.AddItem "Medicilandia - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1504455
    cmbCidadeEmitente.AddItem "Melgaco - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1504505
    cmbCidadeEmitente.AddItem "Mocajuba - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1504604
    cmbCidadeEmitente.AddItem "Moju - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1504703
    cmbCidadeEmitente.AddItem "Mojui dos Campos - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1504752
    cmbCidadeEmitente.AddItem "Monte Alegre - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1504802
    cmbCidadeEmitente.AddItem "Muana - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1504901
    cmbCidadeEmitente.AddItem "Nova Esperanca do Piria - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1504950
    cmbCidadeEmitente.AddItem "Nova Ipixuna - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1504976
    cmbCidadeEmitente.AddItem "Nova Timboteua - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1505007
    cmbCidadeEmitente.AddItem "Novo Progresso - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1505031
    cmbCidadeEmitente.AddItem "Novo Repartimento - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1505064
    cmbCidadeEmitente.AddItem "Obidos - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1505106
    cmbCidadeEmitente.AddItem "Oeiras do Para - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1505205
    cmbCidadeEmitente.AddItem "Oriximina - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1505304
    cmbCidadeEmitente.AddItem "Ourem - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1505403
    cmbCidadeEmitente.AddItem "Ourilandia do Norte - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1505437
    cmbCidadeEmitente.AddItem "Pacaja - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1505486
    cmbCidadeEmitente.AddItem "Palestina do Para - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1505494
    cmbCidadeEmitente.AddItem "Paragominas - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1505502
    cmbCidadeEmitente.AddItem "Parauapebas - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1505536
    cmbCidadeEmitente.AddItem "Pau D Arco - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1505551
    cmbCidadeEmitente.AddItem "Peixe-Boi - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1505601
    cmbCidadeEmitente.AddItem "Picarra - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1505635
    cmbCidadeEmitente.AddItem "Placas - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1505650
    cmbCidadeEmitente.AddItem "Ponta de Pedras - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1505700
    cmbCidadeEmitente.AddItem "Portel - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1505809
    cmbCidadeEmitente.AddItem "Porto de Moz - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1505908
    cmbCidadeEmitente.AddItem "Prainha - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1506005
    cmbCidadeEmitente.AddItem "Primavera - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1506104
    cmbCidadeEmitente.AddItem "Quatipuru - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1506112
    cmbCidadeEmitente.AddItem "Redencao - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1506138
    cmbCidadeEmitente.AddItem "Rio Maria - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1506161
    cmbCidadeEmitente.AddItem "Rondon do Para - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1506187
    cmbCidadeEmitente.AddItem "Ruropolis - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1506195
    cmbCidadeEmitente.AddItem "Salinopolis - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1506203
    cmbCidadeEmitente.AddItem "Salvaterra - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1506302
    cmbCidadeEmitente.AddItem "Santa Barbara do Para - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1506351
    cmbCidadeEmitente.AddItem "Santa Cruz do Arari - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1506401
    cmbCidadeEmitente.AddItem "Santa Izabel do Para - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1506500
    cmbCidadeEmitente.AddItem "Santa Luzia do Para - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1506559
    cmbCidadeEmitente.AddItem "Santa Maria das Barreiras - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1506583
    cmbCidadeEmitente.AddItem "Santa Maria do Para - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1506609
    cmbCidadeEmitente.AddItem "Santana do Araguaia - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1506708
    cmbCidadeEmitente.AddItem "Santarem - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1506807
    cmbCidadeEmitente.AddItem "Santarem Novo - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1506906
    cmbCidadeEmitente.AddItem "Santo Antonio do Taua - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1507003
    cmbCidadeEmitente.AddItem "Sao Caetano de Odivelas - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1507102
    cmbCidadeEmitente.AddItem "Sao Domingos do Araguaia - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1507151
    cmbCidadeEmitente.AddItem "Sao Domingos do Capim - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1507201
    cmbCidadeEmitente.AddItem "Sao Felix do Xingu - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1507300
    cmbCidadeEmitente.AddItem "Sao Francisco do Para - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1507409
    cmbCidadeEmitente.AddItem "Sao Geraldo do Araguaia - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1507458
    cmbCidadeEmitente.AddItem "Sao Joao da Ponta - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1507466
    cmbCidadeEmitente.AddItem "Sao Joao de Pirabas - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1507474
    cmbCidadeEmitente.AddItem "Sao Joao do Araguaia - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1507508
    cmbCidadeEmitente.AddItem "Sao Miguel do Guama - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1507607
    cmbCidadeEmitente.AddItem "Sao Sebastiao da Boa Vista - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1507706
    cmbCidadeEmitente.AddItem "Sapucaia - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1507755
    cmbCidadeEmitente.AddItem "Senador Jose Porfirio - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1507805
    cmbCidadeEmitente.AddItem "Soure - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1507904
    cmbCidadeEmitente.AddItem "Tailandia - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1507953
    cmbCidadeEmitente.AddItem "Terra Alta - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1507961
    cmbCidadeEmitente.AddItem "Terra Santa - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1507979
    cmbCidadeEmitente.AddItem "Tome-Acu - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1508001
    cmbCidadeEmitente.AddItem "Tracuateua - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1508035
    cmbCidadeEmitente.AddItem "Trairao - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1508050
    cmbCidadeEmitente.AddItem "Tucuma - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1508084
    cmbCidadeEmitente.AddItem "Tucurui - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1508100
    cmbCidadeEmitente.AddItem "Ulianopolis - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1508126
    cmbCidadeEmitente.AddItem "Uruara - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1508159
    cmbCidadeEmitente.AddItem "Vigia - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1508209
    cmbCidadeEmitente.AddItem "Viseu - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1508308
    cmbCidadeEmitente.AddItem "Vitoria do Xingu - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1508357
    cmbCidadeEmitente.AddItem "Xinguara - PA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1508407
End Sub

Public Sub Amapa(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Amapa - AP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1600105
    cmbCidadeEmitente.AddItem "Calcoene - AP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1600204
    cmbCidadeEmitente.AddItem "Cutias - AP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1600212
    cmbCidadeEmitente.AddItem "Ferreira Gomes - AP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1600238
    cmbCidadeEmitente.AddItem "Itaubal - AP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1600253
    cmbCidadeEmitente.AddItem "Laranjal do Jari - AP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1600279
    cmbCidadeEmitente.AddItem "Macapa - AP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1600303
    cmbCidadeEmitente.AddItem "Mazagao - AP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1600402
    cmbCidadeEmitente.AddItem "Oiapoque - AP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1600501
    cmbCidadeEmitente.AddItem "Pedra Branca do Amapari - AP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1600154
    cmbCidadeEmitente.AddItem "Porto Grande - AP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1600535
    cmbCidadeEmitente.AddItem "Pracuuba - AP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1600550
    cmbCidadeEmitente.AddItem "Santana - AP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1600600
    cmbCidadeEmitente.AddItem "Serra do Navio - AP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1600055
    cmbCidadeEmitente.AddItem "Tartarugalzinho - AP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1600709
    cmbCidadeEmitente.AddItem "Vitoria do Jari - AP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1600808
End Sub

Public Sub Tocantins(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Abreulandia - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1700251
    cmbCidadeEmitente.AddItem "Aguiarnopolis - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1700301
    cmbCidadeEmitente.AddItem "Alianca do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1700350
    cmbCidadeEmitente.AddItem "Almas - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1700400
    cmbCidadeEmitente.AddItem "Alvorada - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1700707
    cmbCidadeEmitente.AddItem "Ananas - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1701002
    cmbCidadeEmitente.AddItem "Angico - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1701051
    cmbCidadeEmitente.AddItem "Aparecida do Rio Negro - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1701101
    cmbCidadeEmitente.AddItem "Aragominas - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1701309
    cmbCidadeEmitente.AddItem "Araguacema - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1701903
    cmbCidadeEmitente.AddItem "Araguacu - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1702000
    cmbCidadeEmitente.AddItem "Araguaina - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1702109
    cmbCidadeEmitente.AddItem "Araguana - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1702158
    cmbCidadeEmitente.AddItem "Araguatins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1702208
    cmbCidadeEmitente.AddItem "Arapoema - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1702307
    cmbCidadeEmitente.AddItem "Arraias - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1702406
    cmbCidadeEmitente.AddItem "Augustinopolis - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1702554
    cmbCidadeEmitente.AddItem "Aurora do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1702703
    cmbCidadeEmitente.AddItem "Axixa do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1702901
    cmbCidadeEmitente.AddItem "Babaculandia - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1703008
    cmbCidadeEmitente.AddItem "Bandeirantes do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1703057
    cmbCidadeEmitente.AddItem "Barra do Ouro - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1703073
    cmbCidadeEmitente.AddItem "Barrolandia - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1703107
    cmbCidadeEmitente.AddItem "Bernardo Sayao - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1703206
    cmbCidadeEmitente.AddItem "Bom Jesus do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1703305
    cmbCidadeEmitente.AddItem "Brasilandia do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1703602
    cmbCidadeEmitente.AddItem "Brejinho de Nazare - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1703701
    cmbCidadeEmitente.AddItem "Buriti do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1703800
    cmbCidadeEmitente.AddItem "Cachoeirinha - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1703826
    cmbCidadeEmitente.AddItem "Campos Lindos - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1703842
    cmbCidadeEmitente.AddItem "Cariri do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1703867
    cmbCidadeEmitente.AddItem "Carmolandia - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1703883
    cmbCidadeEmitente.AddItem "Carrasco Bonito - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1703891
    cmbCidadeEmitente.AddItem "Caseara - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1703909
    cmbCidadeEmitente.AddItem "Centenario - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1704105
    cmbCidadeEmitente.AddItem "Chapada da Natividade - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1705102
    cmbCidadeEmitente.AddItem "Chapada de Areia - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1704600
    cmbCidadeEmitente.AddItem "Colinas do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1705508
    cmbCidadeEmitente.AddItem "Colmeia - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1716703
    cmbCidadeEmitente.AddItem "Combinado - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1705557
    cmbCidadeEmitente.AddItem "Conceicao do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1705607
    cmbCidadeEmitente.AddItem "Couto Magalhaes - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1706001
    cmbCidadeEmitente.AddItem "Cristalandia - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1706100
    cmbCidadeEmitente.AddItem "Crixas do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1706258
    cmbCidadeEmitente.AddItem "Darcinopolis - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1706506
    cmbCidadeEmitente.AddItem "Dianopolis - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1707009
    cmbCidadeEmitente.AddItem "Divinopolis do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1707108
    cmbCidadeEmitente.AddItem "Dois Irmaos do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1707207
    cmbCidadeEmitente.AddItem "Duere - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1707306
    cmbCidadeEmitente.AddItem "Esperantina - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1707405
    cmbCidadeEmitente.AddItem "Fatima - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1707553
    cmbCidadeEmitente.AddItem "Figueiropolis - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1707652
    cmbCidadeEmitente.AddItem "Filadelfia - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1707702
    cmbCidadeEmitente.AddItem "Formoso do Araguaia - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1708205
    cmbCidadeEmitente.AddItem "Fortaleza do Tabocao - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1708254
    cmbCidadeEmitente.AddItem "Goianorte - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1708304
    cmbCidadeEmitente.AddItem "Goiatins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1709005
    cmbCidadeEmitente.AddItem "Guarai - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1709302
    cmbCidadeEmitente.AddItem "Gurupi - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1709500
    cmbCidadeEmitente.AddItem "Ipueiras - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1709807
    cmbCidadeEmitente.AddItem "Itacaja - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1710508
    cmbCidadeEmitente.AddItem "Itaguatins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1710706
    cmbCidadeEmitente.AddItem "Itapiratins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1710904
    cmbCidadeEmitente.AddItem "Itapora do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1711100
    cmbCidadeEmitente.AddItem "Jau do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1711506
    cmbCidadeEmitente.AddItem "Juarina - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1711803
    cmbCidadeEmitente.AddItem "Lagoa da Confusao - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1711902
    cmbCidadeEmitente.AddItem "Lagoa do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1711951
    cmbCidadeEmitente.AddItem "Lajeado - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1712009
    cmbCidadeEmitente.AddItem "Lavandeira - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1712157
    cmbCidadeEmitente.AddItem "Lizarda - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1712405
    cmbCidadeEmitente.AddItem "Luzinopolis - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1712454
    cmbCidadeEmitente.AddItem "Marianopolis do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1712504
    cmbCidadeEmitente.AddItem "Mateiros - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1712702
    cmbCidadeEmitente.AddItem "Maurilandia do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1712801
    cmbCidadeEmitente.AddItem "Miracema do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1713205
    cmbCidadeEmitente.AddItem "Miranorte - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1713304
    cmbCidadeEmitente.AddItem "Monte do Carmo - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1713601
    cmbCidadeEmitente.AddItem "Monte Santo do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1713700
    cmbCidadeEmitente.AddItem "Muricilandia - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1713957
    cmbCidadeEmitente.AddItem "Natividade - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1714203
    cmbCidadeEmitente.AddItem "Nazare - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1714302
    cmbCidadeEmitente.AddItem "Nova Olinda - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1714880
    cmbCidadeEmitente.AddItem "Nova Rosalandia - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1715002
    cmbCidadeEmitente.AddItem "Novo Acordo - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1715101
    cmbCidadeEmitente.AddItem "Novo Alegre - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1715150
    cmbCidadeEmitente.AddItem "Novo Jardim - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1715259
    cmbCidadeEmitente.AddItem "Oliveira de Fatima - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1715507
    cmbCidadeEmitente.AddItem "Palmas - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1721000
    cmbCidadeEmitente.AddItem "Palmeirante - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1715705
    cmbCidadeEmitente.AddItem "Palmeiras do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1713809
    cmbCidadeEmitente.AddItem "Palmeiropolis - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1715754
    cmbCidadeEmitente.AddItem "Paraiso do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1716109
    cmbCidadeEmitente.AddItem "Parana - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1716208
    cmbCidadeEmitente.AddItem "Pau D Arco - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1716307
    cmbCidadeEmitente.AddItem "Pedro Afonso - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1716505
    cmbCidadeEmitente.AddItem "Peixe - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1716604
    cmbCidadeEmitente.AddItem "Pequizeiro - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1716653
    cmbCidadeEmitente.AddItem "Pindorama do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1717008
    cmbCidadeEmitente.AddItem "Piraque - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1717206
    cmbCidadeEmitente.AddItem "Pium - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1717503
    cmbCidadeEmitente.AddItem "Ponte Alta do Bom Jesus - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1717800
    cmbCidadeEmitente.AddItem "Ponte Alta do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1717909
    cmbCidadeEmitente.AddItem "Porto Alegre do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1718006
    cmbCidadeEmitente.AddItem "Porto Nacional - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1718204
    cmbCidadeEmitente.AddItem "Praia Norte - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1718303
    cmbCidadeEmitente.AddItem "Presidente Kennedy - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1718402
    cmbCidadeEmitente.AddItem "Pugmil - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1718451
    cmbCidadeEmitente.AddItem "Recursolandia - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1718501
    cmbCidadeEmitente.AddItem "Riachinho - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1718550
    cmbCidadeEmitente.AddItem "Rio da Conceicao - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1718659
    cmbCidadeEmitente.AddItem "Rio dos Bois - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1718709
    cmbCidadeEmitente.AddItem "Rio Sono - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1718758
    cmbCidadeEmitente.AddItem "Sampaio - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1718808
    cmbCidadeEmitente.AddItem "Sandolandia - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1718840
    cmbCidadeEmitente.AddItem "Santa Fe do Araguaia - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1718865
    cmbCidadeEmitente.AddItem "Santa Maria do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1718881
    cmbCidadeEmitente.AddItem "Santa Rita do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1718899
    cmbCidadeEmitente.AddItem "Santa Rosa do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1718907
    cmbCidadeEmitente.AddItem "Santa Tereza do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1719004
    cmbCidadeEmitente.AddItem "Santa Terezinha do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1720002
    cmbCidadeEmitente.AddItem "Sao Bento do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1720101
    cmbCidadeEmitente.AddItem "Sao Felix do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1720150
    cmbCidadeEmitente.AddItem "Sao Miguel do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1720200
    cmbCidadeEmitente.AddItem "Sao Salvador do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1720259
    cmbCidadeEmitente.AddItem "Sao Sebastiao do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1720309
    cmbCidadeEmitente.AddItem "Sao Valerio da Natividade - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1720499
    cmbCidadeEmitente.AddItem "Silvanopolis - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1720655
    cmbCidadeEmitente.AddItem "Sitio Novo do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1720804
    cmbCidadeEmitente.AddItem "Sucupira - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1720853
    cmbCidadeEmitente.AddItem "Taguatinga - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1720903
    cmbCidadeEmitente.AddItem "Taipas do Tocantins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1720937
    cmbCidadeEmitente.AddItem "Talisma - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1720978
    cmbCidadeEmitente.AddItem "Tocantinia - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1721109
    cmbCidadeEmitente.AddItem "Tocantinopolis - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1721208
    cmbCidadeEmitente.AddItem "Tupirama - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1721257
    cmbCidadeEmitente.AddItem "Tupiratins - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1721307
    cmbCidadeEmitente.AddItem "Wanderlandia - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1722081
    cmbCidadeEmitente.AddItem "Xambioa - TO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 1722107
End Sub

Public Sub Maranhao(ByRef cmbCidadeEmitente As ComboBox)
    Maranhao1 cmbCidadeEmitente
    Maranhao2 cmbCidadeEmitente
End Sub

Private Sub Maranhao1(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Açailandia - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2100055
    cmbCidadeEmitente.AddItem "Afonso Cunha - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2100105
    cmbCidadeEmitente.AddItem "Agua Doce do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2100154
    cmbCidadeEmitente.AddItem "Alcantara - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2100204
    cmbCidadeEmitente.AddItem "Aldeias Altas - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2100303
    cmbCidadeEmitente.AddItem "Altamira do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2100402
    cmbCidadeEmitente.AddItem "Alto Alegre do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2100436
    cmbCidadeEmitente.AddItem "Alto Alegre do Pindare - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2100477
    cmbCidadeEmitente.AddItem "Alto Parnaiba - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2100501
    cmbCidadeEmitente.AddItem "Amapa do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2100550
    cmbCidadeEmitente.AddItem "Amarante do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2100600
    cmbCidadeEmitente.AddItem "Anajatuba - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2100709
    cmbCidadeEmitente.AddItem "Anapurus - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2100808
    cmbCidadeEmitente.AddItem "Apicum-Acu - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2100832
    cmbCidadeEmitente.AddItem "Araguana - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2100873
    cmbCidadeEmitente.AddItem "Araioses - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2100907
    cmbCidadeEmitente.AddItem "Arame - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2100956
    cmbCidadeEmitente.AddItem "Arari - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2101004
    cmbCidadeEmitente.AddItem "Axixa - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2101103
    cmbCidadeEmitente.AddItem "Bacabal - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2101202
    cmbCidadeEmitente.AddItem "Bacabeira - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2101251
    cmbCidadeEmitente.AddItem "Bacuri - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2101301
    cmbCidadeEmitente.AddItem "Bacurituba - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2101350
    cmbCidadeEmitente.AddItem "Balsas - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2101400
    cmbCidadeEmitente.AddItem "Barao de Grajau - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2101509
    cmbCidadeEmitente.AddItem "Barra do Corda - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2101608
    cmbCidadeEmitente.AddItem "Barreirinhas - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2101707
    cmbCidadeEmitente.AddItem "Bela Vista do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2101772
    cmbCidadeEmitente.AddItem "Belagua - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2101731
    cmbCidadeEmitente.AddItem "Benedito Leite - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2101806
    cmbCidadeEmitente.AddItem "Bequimao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2101905
    cmbCidadeEmitente.AddItem "Bernardo do Mearim - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2101939
    cmbCidadeEmitente.AddItem "Boa Vista do Gurupi - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2101970
    cmbCidadeEmitente.AddItem "Bom Jardim - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2102002
    cmbCidadeEmitente.AddItem "Bom Jesus das Selvas - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2102036
    cmbCidadeEmitente.AddItem "Bom Lugar - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2102077
    cmbCidadeEmitente.AddItem "Brejo - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2102101
    cmbCidadeEmitente.AddItem "Brejo de Areia - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2102150
    cmbCidadeEmitente.AddItem "Buriti - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2102200
    cmbCidadeEmitente.AddItem "Buriti Bravo - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2102309
    cmbCidadeEmitente.AddItem "Buriticupu - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2102325
    cmbCidadeEmitente.AddItem "Buritirana - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2102358
    cmbCidadeEmitente.AddItem "Cachoeira Grande - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2102374
    cmbCidadeEmitente.AddItem "Cajapio - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2102408
    cmbCidadeEmitente.AddItem "Cajari - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2102507
    cmbCidadeEmitente.AddItem "Campestre do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2102556
    cmbCidadeEmitente.AddItem "Candido Mendes - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2102606
    cmbCidadeEmitente.AddItem "Cantanhede - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2102705
    cmbCidadeEmitente.AddItem "Capinzal do Norte - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2102754
    cmbCidadeEmitente.AddItem "Carolina - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2102804
    cmbCidadeEmitente.AddItem "Carutapera - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2102903
    cmbCidadeEmitente.AddItem "Caxias - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2103000
    cmbCidadeEmitente.AddItem "Cedral - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2103109
    cmbCidadeEmitente.AddItem "Central do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2103125
    cmbCidadeEmitente.AddItem "Centro do Guilherme - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2103158
    cmbCidadeEmitente.AddItem "Centro Novo do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2103174
    cmbCidadeEmitente.AddItem "Chapadinha - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2103208
    cmbCidadeEmitente.AddItem "Cidelandia - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2103257
    cmbCidadeEmitente.AddItem "Codo - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2103307
    cmbCidadeEmitente.AddItem "Coelho Neto - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2103406
    cmbCidadeEmitente.AddItem "Colinas - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2103505
    cmbCidadeEmitente.AddItem "Conceicao do Lago-Acu - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2103554
    cmbCidadeEmitente.AddItem "Coroata - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2103604
    cmbCidadeEmitente.AddItem "Cururupu - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2103703
    cmbCidadeEmitente.AddItem "Davinopolis - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2103752
    cmbCidadeEmitente.AddItem "Dom Pedro - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2103802
    cmbCidadeEmitente.AddItem "Duque Bacelar - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2103901
    cmbCidadeEmitente.AddItem "Esperantinopolis - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2104008
    cmbCidadeEmitente.AddItem "Estreito - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2104057
    cmbCidadeEmitente.AddItem "Feira Nova do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2104073
    cmbCidadeEmitente.AddItem "Fernando Falcao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2104081
    cmbCidadeEmitente.AddItem "Formosa da Serra Negra - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2104099
    cmbCidadeEmitente.AddItem "Fortaleza dos Nogueiras - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2104107
    cmbCidadeEmitente.AddItem "Fortuna - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2104206
    cmbCidadeEmitente.AddItem "Godofredo Viana - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2104305
    cmbCidadeEmitente.AddItem "Goncalves Dias - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2104404
    cmbCidadeEmitente.AddItem "Governador Archer - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2104503
    cmbCidadeEmitente.AddItem "Governador Edison Lobao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2104552
    cmbCidadeEmitente.AddItem "Governador Eugenio Barros - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2104602
    cmbCidadeEmitente.AddItem "Governador Luiz Rocha - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2104628
    cmbCidadeEmitente.AddItem "Governador Newton Bello - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2104651
    cmbCidadeEmitente.AddItem "Governador Nunes Freire - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2104677
    cmbCidadeEmitente.AddItem "Graca Aranha - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2104701
    cmbCidadeEmitente.AddItem "Grajau - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2104800
    cmbCidadeEmitente.AddItem "Guimaraes - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2104909
    cmbCidadeEmitente.AddItem "Humberto de Campos - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105005
    cmbCidadeEmitente.AddItem "Icatu - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105104
    cmbCidadeEmitente.AddItem "Igarape do Meio - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105153
    cmbCidadeEmitente.AddItem "Igarape Grande - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105203
    cmbCidadeEmitente.AddItem "Imperatriz - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105302
    cmbCidadeEmitente.AddItem "Itaipava do Grajau - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105351
    cmbCidadeEmitente.AddItem "Itapecuru Mirim - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105401
    cmbCidadeEmitente.AddItem "Itinga do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105427
    cmbCidadeEmitente.AddItem "Jatoba - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105450
    cmbCidadeEmitente.AddItem "Jenipapo dos Vieiras - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105476
    cmbCidadeEmitente.AddItem "Joao Lisboa - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105500
    cmbCidadeEmitente.AddItem "Joselandia - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105609
    cmbCidadeEmitente.AddItem "Junco do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105658
    cmbCidadeEmitente.AddItem "Lago da Pedra - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105708
    cmbCidadeEmitente.AddItem "Lago do Junco - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105807
    cmbCidadeEmitente.AddItem "Lago dos Rodrigues - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105948
    cmbCidadeEmitente.AddItem "Lago Verde - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105906
    cmbCidadeEmitente.AddItem "Lagoa do Mato - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105922
    cmbCidadeEmitente.AddItem "Lagoa Grande do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105963
    cmbCidadeEmitente.AddItem "Lajeado Novo - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2105989
    cmbCidadeEmitente.AddItem "Lima Campos - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2106003
    cmbCidadeEmitente.AddItem "Loreto - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2106102
    cmbCidadeEmitente.AddItem "Luis Domingues - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2106201
    cmbCidadeEmitente.AddItem "Magalhaes de Almeida - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2106300
    cmbCidadeEmitente.AddItem "Maracacume - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2106326
    cmbCidadeEmitente.AddItem "Maraja do Sena - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2106359
    cmbCidadeEmitente.AddItem "Maranhaozinho - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2106375
    cmbCidadeEmitente.AddItem "Mata Roma - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2106409
    cmbCidadeEmitente.AddItem "Matinha - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2106508
    cmbCidadeEmitente.AddItem "Matoes - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2106607
    cmbCidadeEmitente.AddItem "Matoes do Norte - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2106631
    cmbCidadeEmitente.AddItem "Milagres do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2106672
    cmbCidadeEmitente.AddItem "Mirador - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2106706
    cmbCidadeEmitente.AddItem "Miranda do Norte - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2106755
    cmbCidadeEmitente.AddItem "Mirinzal - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2106805
    cmbCidadeEmitente.AddItem "Moncao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2106904
    cmbCidadeEmitente.AddItem "Montes Altos - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2107001
    cmbCidadeEmitente.AddItem "Morros - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2107100
    cmbCidadeEmitente.AddItem "Nina Rodrigues - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2107209
    cmbCidadeEmitente.AddItem "Nova Colinas - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2107258
    cmbCidadeEmitente.AddItem "Nova Iorque - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2107308
    cmbCidadeEmitente.AddItem "Nova Olinda do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2107357
    cmbCidadeEmitente.AddItem "Olho D Agua das Cunhas - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2107407
    cmbCidadeEmitente.AddItem "Olinda Nova do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2107456
    cmbCidadeEmitente.AddItem "Paco do Lumiar - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2107506
    cmbCidadeEmitente.AddItem "Palmeirandia - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2107605
    cmbCidadeEmitente.AddItem "Paraibano - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2107704
    cmbCidadeEmitente.AddItem "Parnarama - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2107803
    cmbCidadeEmitente.AddItem "Passagem Franca - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2107902
    cmbCidadeEmitente.AddItem "Pastos Bons - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2108009
    cmbCidadeEmitente.AddItem "Paulino Neves - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2108058
    cmbCidadeEmitente.AddItem "Paulo Ramos - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2108108
    cmbCidadeEmitente.AddItem "Pedreiras - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2108207
    cmbCidadeEmitente.AddItem "Pedro do Rosario - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2108256
    cmbCidadeEmitente.AddItem "Penalva - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2108306
    cmbCidadeEmitente.AddItem "Peri Mirim - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2108405
    cmbCidadeEmitente.AddItem "Peritoro - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2108454
    cmbCidadeEmitente.AddItem "Pindare-Mirim - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2108504
    cmbCidadeEmitente.AddItem "Pinheiro - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2108603
    cmbCidadeEmitente.AddItem "Pio Xii - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2108702
    cmbCidadeEmitente.AddItem "Pirapemas - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2108801
    cmbCidadeEmitente.AddItem "Pocao de Pedras - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2108900
    cmbCidadeEmitente.AddItem "Porto Franco - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2109007
    cmbCidadeEmitente.AddItem "Porto Rico do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2109056
    cmbCidadeEmitente.AddItem "Presidente Dutra - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2109106
End Sub

Private Sub Maranhao2(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Presidente Juscelino - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2109205
    cmbCidadeEmitente.AddItem "Presidente Medici - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2109239
    cmbCidadeEmitente.AddItem "Presidente Sarney - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2109270
    cmbCidadeEmitente.AddItem "Presidente Vargas - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2109304
    cmbCidadeEmitente.AddItem "Primeira Cruz - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2109403
    cmbCidadeEmitente.AddItem "Raposa - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2109452
    cmbCidadeEmitente.AddItem "Riachao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2109502
    cmbCidadeEmitente.AddItem "Ribamar Fiquene - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2109551
    cmbCidadeEmitente.AddItem "Rosario - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2109601
    cmbCidadeEmitente.AddItem "Sambaiba - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2109700
    cmbCidadeEmitente.AddItem "Santa Filomena do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2109759
    cmbCidadeEmitente.AddItem "Santa Helena - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2109809
    cmbCidadeEmitente.AddItem "Santa Ines - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2109908
    cmbCidadeEmitente.AddItem "Santa Luzia - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2110005
    cmbCidadeEmitente.AddItem "Santa Luzia do Parua - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2110039
    cmbCidadeEmitente.AddItem "Santa Quiteria do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2110104
    cmbCidadeEmitente.AddItem "Santa Rita - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2110203
    cmbCidadeEmitente.AddItem "Santana do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2110237
    cmbCidadeEmitente.AddItem "Santo Amaro do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2110278
    cmbCidadeEmitente.AddItem "Santo Antonio dos Lopes - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2110302
    cmbCidadeEmitente.AddItem "Sao Benedito do Rio Preto - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2110401
    cmbCidadeEmitente.AddItem "Sao Bento - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2110500
    cmbCidadeEmitente.AddItem "Sao Bernardo - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2110609
    cmbCidadeEmitente.AddItem "Sao Domingos do Azeitao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2110658
    cmbCidadeEmitente.AddItem "Sao Domingos do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2110708
    cmbCidadeEmitente.AddItem "Sao Felix de Balsas - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2110807
    cmbCidadeEmitente.AddItem "Sao Francisco do Brejao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2110856
    cmbCidadeEmitente.AddItem "Sao Francisco do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2110906
    cmbCidadeEmitente.AddItem "Sao Joao Batista - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111003
    cmbCidadeEmitente.AddItem "Sao Joao do Caru - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111029
    cmbCidadeEmitente.AddItem "Sao Joao do Paraiso - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111052
    cmbCidadeEmitente.AddItem "Sao Joao do Soter - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111078
    cmbCidadeEmitente.AddItem "Sao Joao dos Patos - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111102
    cmbCidadeEmitente.AddItem "Sao Jose de Ribamar - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111201
    cmbCidadeEmitente.AddItem "Sao Jose dos Basilios - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111250
    cmbCidadeEmitente.AddItem "Sao Luis - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111300
    cmbCidadeEmitente.AddItem "Sao Luis Gonzaga do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111409
    cmbCidadeEmitente.AddItem "Sao Mateus do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111508
    cmbCidadeEmitente.AddItem "Sao Pedro da Agua Branca - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111532
    cmbCidadeEmitente.AddItem "Sao Pedro dos Crentes - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111573
    cmbCidadeEmitente.AddItem "Sao Raimundo das Mangabeiras - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111607
    cmbCidadeEmitente.AddItem "Sao Raimundo do Doca Bezerra - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111631
    cmbCidadeEmitente.AddItem "Sao Roberto - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111672
    cmbCidadeEmitente.AddItem "Sao Vicente Ferrer - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111706
    cmbCidadeEmitente.AddItem "Satubinha - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111722
    cmbCidadeEmitente.AddItem "Senador Alexandre Costa - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111748
    cmbCidadeEmitente.AddItem "Senador La Rocque - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111763
    cmbCidadeEmitente.AddItem "Serrano do Maranhao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111789
    cmbCidadeEmitente.AddItem "Sitio Novo - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111805
    cmbCidadeEmitente.AddItem "Sucupira do Norte - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111904
    cmbCidadeEmitente.AddItem "Sucupira do Riachao - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2111953
    cmbCidadeEmitente.AddItem "Tasso Fragoso - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2112001
    cmbCidadeEmitente.AddItem "Timbiras - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2112100
    cmbCidadeEmitente.AddItem "Timon - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2112209
    cmbCidadeEmitente.AddItem "Trizidela do Vale - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2112233
    cmbCidadeEmitente.AddItem "Tufilandia - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2112274
    cmbCidadeEmitente.AddItem "Tuntum - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2112308
    cmbCidadeEmitente.AddItem "Turiacu - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2112407
    cmbCidadeEmitente.AddItem "Turilandia - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2112456
    cmbCidadeEmitente.AddItem "Tutoia - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2112506
    cmbCidadeEmitente.AddItem "Urbano Santos - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2112605
    cmbCidadeEmitente.AddItem "Vargem Grande - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2112704
    cmbCidadeEmitente.AddItem "Viana - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2112803
    cmbCidadeEmitente.AddItem "Vila Nova dos Martirios - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2112852
    cmbCidadeEmitente.AddItem "Vitoria do Mearim - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2112902
    cmbCidadeEmitente.AddItem "Vitorino Freire - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2113009
    cmbCidadeEmitente.AddItem "Ze Doca - MA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2114007
End Sub

Public Sub Piaui(ByRef cmbCidadeEmitente As ComboBox)
    Piaui1 cmbCidadeEmitente
    Piaui2 cmbCidadeEmitente
End Sub

Private Sub Piaui1(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Acaua - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2200053
    cmbCidadeEmitente.AddItem "Agricolandia - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2200103
    cmbCidadeEmitente.AddItem "Agua Branca - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2200202
    cmbCidadeEmitente.AddItem "Alagoinha do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2200251
    cmbCidadeEmitente.AddItem "Alegrete do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2200277
    cmbCidadeEmitente.AddItem "Alto Longa - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2200301
    cmbCidadeEmitente.AddItem "Altos - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2200400
    cmbCidadeEmitente.AddItem "Alvorada do Gurgueia - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2200459
    cmbCidadeEmitente.AddItem "Amarante - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2200509
    cmbCidadeEmitente.AddItem "Angical do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2200608
    cmbCidadeEmitente.AddItem "Anisio de Abreu - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2200707
    cmbCidadeEmitente.AddItem "Antonio Almeida - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2200806
    cmbCidadeEmitente.AddItem "Aroazes - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2200905
    cmbCidadeEmitente.AddItem "Aroeiras do Itaim - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2200954
    cmbCidadeEmitente.AddItem "Arraial - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201002
    cmbCidadeEmitente.AddItem "Assuncao do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201051
    cmbCidadeEmitente.AddItem "Avelino Lopes - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201101
    cmbCidadeEmitente.AddItem "Baixa Grande do Ribeiro - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201150
    cmbCidadeEmitente.AddItem "Barra D Alcantara - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201176
    cmbCidadeEmitente.AddItem "Barras - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201200
    cmbCidadeEmitente.AddItem "Barreiras do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201309
    cmbCidadeEmitente.AddItem "Barro Duro - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201408
    cmbCidadeEmitente.AddItem "Batalha - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201507
    cmbCidadeEmitente.AddItem "Bela Vista do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201556
    cmbCidadeEmitente.AddItem "Belem do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201572
    cmbCidadeEmitente.AddItem "Beneditinos - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201606
    cmbCidadeEmitente.AddItem "Bertolinia - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201705
    cmbCidadeEmitente.AddItem "Betania do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201739
    cmbCidadeEmitente.AddItem "Boa Hora - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201770
    cmbCidadeEmitente.AddItem "Bocaina - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201804
    cmbCidadeEmitente.AddItem "Bom Jesus - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201903
    cmbCidadeEmitente.AddItem "Bom Principio do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201919
    cmbCidadeEmitente.AddItem "Bonfim do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201929
    cmbCidadeEmitente.AddItem "Boqueirao do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201945
    cmbCidadeEmitente.AddItem "Brasileira - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201960
    cmbCidadeEmitente.AddItem "Brejo do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2201988
    cmbCidadeEmitente.AddItem "Buriti dos Lopes - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202000
    cmbCidadeEmitente.AddItem "Buriti dos Montes - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202026
    cmbCidadeEmitente.AddItem "Cabeceiras do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202059
    cmbCidadeEmitente.AddItem "Cajazeiras do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202075
    cmbCidadeEmitente.AddItem "Cajueiro da Praia - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202083
    cmbCidadeEmitente.AddItem "Caldeirao Grande do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202091
    cmbCidadeEmitente.AddItem "Campinas do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202109
    cmbCidadeEmitente.AddItem "Campo Alegre do Fidalgo - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202117
    cmbCidadeEmitente.AddItem "Campo Grande do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202133
    cmbCidadeEmitente.AddItem "Campo Largo do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202174
    cmbCidadeEmitente.AddItem "Campo Maior - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202208
    cmbCidadeEmitente.AddItem "Canavieira - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202251
    cmbCidadeEmitente.AddItem "Canto do Buriti - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202307
    cmbCidadeEmitente.AddItem "Capitao de Campos - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202406
    cmbCidadeEmitente.AddItem "Capitao Gervasio Oliveira - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202455
    cmbCidadeEmitente.AddItem "Caracol - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202505
    cmbCidadeEmitente.AddItem "Caraubas do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202539
    cmbCidadeEmitente.AddItem "Caridade do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202554
    cmbCidadeEmitente.AddItem "Castelo do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202604
    cmbCidadeEmitente.AddItem "Caxingo - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202653
    cmbCidadeEmitente.AddItem "Cocal - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202703
    cmbCidadeEmitente.AddItem "Cocal de Telha - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202711
    cmbCidadeEmitente.AddItem "Cocal dos Alves - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202729
    cmbCidadeEmitente.AddItem "Coivaras - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202737
    cmbCidadeEmitente.AddItem "Colonia do Gurgueia - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202752
    cmbCidadeEmitente.AddItem "Colonia do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202778
    cmbCidadeEmitente.AddItem "Conceicao do Caninde - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202802
    cmbCidadeEmitente.AddItem "Coronel Jose Dias - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202851
    cmbCidadeEmitente.AddItem "Corrente - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2202901
    cmbCidadeEmitente.AddItem "Cristalandia do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2203008
    cmbCidadeEmitente.AddItem "Cristino Castro - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2203107
    cmbCidadeEmitente.AddItem "Curimata - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2203206
    cmbCidadeEmitente.AddItem "Currais - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2203230
    cmbCidadeEmitente.AddItem "Curral Novo do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2203271
    cmbCidadeEmitente.AddItem "Curralinhos - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2203255
    cmbCidadeEmitente.AddItem "Demerval Lobao - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2203305
    cmbCidadeEmitente.AddItem "Dirceu Arcoverde - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2203354
    cmbCidadeEmitente.AddItem "Dom Expedito Lopes - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2203404
    cmbCidadeEmitente.AddItem "Dom Inocencio - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2203453
    cmbCidadeEmitente.AddItem "Domingos Mourao - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2203420
    cmbCidadeEmitente.AddItem "Elesbao Veloso - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2203503
    cmbCidadeEmitente.AddItem "Eliseu Martins - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2203602
    cmbCidadeEmitente.AddItem "Esperantina - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2203701
    cmbCidadeEmitente.AddItem "Fartura do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2203750
    cmbCidadeEmitente.AddItem "Flores do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2203800
    cmbCidadeEmitente.AddItem "Floresta do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2203859
    cmbCidadeEmitente.AddItem "Floriano - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2203909
    cmbCidadeEmitente.AddItem "Francinopolis - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2204006
    cmbCidadeEmitente.AddItem "Francisco Ayres - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2204105
    cmbCidadeEmitente.AddItem "Francisco Macedo - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2204154
    cmbCidadeEmitente.AddItem "Francisco Santos - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2204204
    cmbCidadeEmitente.AddItem "Fronteiras - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2204303
    cmbCidadeEmitente.AddItem "Geminiano - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2204352
    cmbCidadeEmitente.AddItem "Gilbues - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2204402
    cmbCidadeEmitente.AddItem "Guadalupe - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2204501
    cmbCidadeEmitente.AddItem "Guaribas - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2204550
    cmbCidadeEmitente.AddItem "Hugo Napoleao - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2204600
    cmbCidadeEmitente.AddItem "Ilha Grande - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2204659
    cmbCidadeEmitente.AddItem "Inhuma - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2204709
    cmbCidadeEmitente.AddItem "Ipiranga do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2204808
    cmbCidadeEmitente.AddItem "Isaias Coelho - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2204907
    cmbCidadeEmitente.AddItem "Itainopolis - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205003
    cmbCidadeEmitente.AddItem "Itaueira - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205102
    cmbCidadeEmitente.AddItem "Jacobina do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205151
    cmbCidadeEmitente.AddItem "Jaicos - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205201
    cmbCidadeEmitente.AddItem "Jardim do Mulato - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205250
    cmbCidadeEmitente.AddItem "Jatoba do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205276
    cmbCidadeEmitente.AddItem "Jerumenha - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205300
    cmbCidadeEmitente.AddItem "Joao Costa - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205359
    cmbCidadeEmitente.AddItem "Joaquim Pires - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205409
    cmbCidadeEmitente.AddItem "Joca Marques - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205458
    cmbCidadeEmitente.AddItem "Jose de Freitas - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205508
    cmbCidadeEmitente.AddItem "Juazeiro do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205516
    cmbCidadeEmitente.AddItem "Julio Borges - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205524
    cmbCidadeEmitente.AddItem "Jurema - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205532
    cmbCidadeEmitente.AddItem "Lagoa Alegre - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205557
    cmbCidadeEmitente.AddItem "Lagoa de Sao Francisco - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205573
    cmbCidadeEmitente.AddItem "Lagoa do Barro do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205565
    cmbCidadeEmitente.AddItem "Lagoa do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205581
    cmbCidadeEmitente.AddItem "Lagoa do Sitio - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205599
    cmbCidadeEmitente.AddItem "Lagoinha do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205540
    cmbCidadeEmitente.AddItem "Landri Sales - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205607
    cmbCidadeEmitente.AddItem "Luís Correia - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205706
    cmbCidadeEmitente.AddItem "Luzilandia - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205805
    cmbCidadeEmitente.AddItem "Madeiro - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205854
    cmbCidadeEmitente.AddItem "Manoel Emidio - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205904
    cmbCidadeEmitente.AddItem "Marcolandia - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2205953
    cmbCidadeEmitente.AddItem "Marcos Parente - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2206001
    cmbCidadeEmitente.AddItem "Massape do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2206050
    cmbCidadeEmitente.AddItem "Matias Olimpio - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2206100
    cmbCidadeEmitente.AddItem "Miguel Alves - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2206209
    cmbCidadeEmitente.AddItem "Miguel Leao - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2206308
    cmbCidadeEmitente.AddItem "Milton Brandao - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2206357
    cmbCidadeEmitente.AddItem "Monsenhor Gil - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2206407
    cmbCidadeEmitente.AddItem "Monsenhor Hipolito - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2206506
    cmbCidadeEmitente.AddItem "Monte Alegre do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2206605
    cmbCidadeEmitente.AddItem "Morro Cabeca No Tempo - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2206654
    cmbCidadeEmitente.AddItem "Morro do Chapeu do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2206670
    cmbCidadeEmitente.AddItem "Murici dos Portelas - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2206696
    cmbCidadeEmitente.AddItem "Nazare do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2206704
    cmbCidadeEmitente.AddItem "Nazaria - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2206720
    cmbCidadeEmitente.AddItem "Nossa Senhora de Nazare - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2206753
    cmbCidadeEmitente.AddItem "Nossa Senhora dos Remedios - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2206803
    cmbCidadeEmitente.AddItem "Nova Santa Rita - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2207959
    cmbCidadeEmitente.AddItem "Novo Oriente do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2206902
    cmbCidadeEmitente.AddItem "Novo Santo Antonio - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2206951
    cmbCidadeEmitente.AddItem "Oeiras - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2207009
    cmbCidadeEmitente.AddItem "Olho D Agua do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2207108
    cmbCidadeEmitente.AddItem "Padre Marcos - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2207207
    cmbCidadeEmitente.AddItem "Paes Landim - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2207306
    cmbCidadeEmitente.AddItem "Pajeu do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2207355
    cmbCidadeEmitente.AddItem "Palmeira do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2207405
    cmbCidadeEmitente.AddItem "Palmeirais - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2207504
    cmbCidadeEmitente.AddItem "Paqueta - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2207553
End Sub

Private Sub Piaui2(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Parnagua - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2207603
    cmbCidadeEmitente.AddItem "Parnaíba - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2207702
    cmbCidadeEmitente.AddItem "Passagem Franca do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2207751
    cmbCidadeEmitente.AddItem "Patos do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2207777
    cmbCidadeEmitente.AddItem "Pau D Arco do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2207793
    cmbCidadeEmitente.AddItem "Paulistana - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2207801
    cmbCidadeEmitente.AddItem "Pavussu - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2207850
    cmbCidadeEmitente.AddItem "Pedro II - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2207900
    cmbCidadeEmitente.AddItem "Pedro Laurentino - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2207934
    cmbCidadeEmitente.AddItem "Picos - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2208007
    cmbCidadeEmitente.AddItem "Pimenteiras - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2208106
    cmbCidadeEmitente.AddItem "Pio IX - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2208205
    cmbCidadeEmitente.AddItem "Piracuruca - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2208304
    cmbCidadeEmitente.AddItem "Piripiri - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2208403
    cmbCidadeEmitente.AddItem "Porto - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2208502
    cmbCidadeEmitente.AddItem "Porto Alegre do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2208551
    cmbCidadeEmitente.AddItem "Prata do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2208601
    cmbCidadeEmitente.AddItem "Queimada Nova - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2208650
    cmbCidadeEmitente.AddItem "Redencao do Gurgueia - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2208700
    cmbCidadeEmitente.AddItem "Regeneracao - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2208809
    cmbCidadeEmitente.AddItem "Riacho Frio - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2208858
    cmbCidadeEmitente.AddItem "Ribeira do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2208874
    cmbCidadeEmitente.AddItem "Ribeiro Goncalves - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2208908
    cmbCidadeEmitente.AddItem "Rio Grande do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209005
    cmbCidadeEmitente.AddItem "Santa Cruz do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209104
    cmbCidadeEmitente.AddItem "Santa Cruz dos Milagres - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209153
    cmbCidadeEmitente.AddItem "Santa Filomena - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209203
    cmbCidadeEmitente.AddItem "Santa Luz - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209302
    cmbCidadeEmitente.AddItem "Santa Rosa do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209377
    cmbCidadeEmitente.AddItem "Santana do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209351
    cmbCidadeEmitente.AddItem "Santo Antonio de Lisboa - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209401
    cmbCidadeEmitente.AddItem "Santo Antonio dos Milagres - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209450
    cmbCidadeEmitente.AddItem "Santo Inacio do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209500
    cmbCidadeEmitente.AddItem "Sao Braz do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209559
    cmbCidadeEmitente.AddItem "Sao Felix do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209609
    cmbCidadeEmitente.AddItem "Sao Francisco de Assis do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209658
    cmbCidadeEmitente.AddItem "Sao Francisco do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209708
    cmbCidadeEmitente.AddItem "Sao Goncalo do Gurgueia - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209757
    cmbCidadeEmitente.AddItem "Sao Goncalo do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209807
    cmbCidadeEmitente.AddItem "Sao Joao da Canabrava - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209856
    cmbCidadeEmitente.AddItem "Sao Joao da Fronteira - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209872
    cmbCidadeEmitente.AddItem "Sao Joao da Serra - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209906
    cmbCidadeEmitente.AddItem "Sao Joao da Varjota - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209955
    cmbCidadeEmitente.AddItem "Sao Joao do Arraial - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2209971
    cmbCidadeEmitente.AddItem "Sao Joao do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210003
    cmbCidadeEmitente.AddItem "Sao Jose do Divino - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210052
    cmbCidadeEmitente.AddItem "Sao Jose do Peixe - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210102
    cmbCidadeEmitente.AddItem "Sao Jose do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210201
    cmbCidadeEmitente.AddItem "Sao Juliao - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210300
    cmbCidadeEmitente.AddItem "Sao Lourenco do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210359
    cmbCidadeEmitente.AddItem "Sao Luis do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210375
    cmbCidadeEmitente.AddItem "Sao Miguel da Baixa Grande - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210383
    cmbCidadeEmitente.AddItem "Sao Miguel do Fidalgo - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210391
    cmbCidadeEmitente.AddItem "Sao Miguel do Tapuio - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210409
    cmbCidadeEmitente.AddItem "Sao Pedro do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210508
    cmbCidadeEmitente.AddItem "Sao Raimundo Nonato - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210607
    cmbCidadeEmitente.AddItem "Sebastiao Barros - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210623
    cmbCidadeEmitente.AddItem "Sebastiao Leal - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210631
    cmbCidadeEmitente.AddItem "Sigefredo Pacheco - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210656
    cmbCidadeEmitente.AddItem "Simoes - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210706
    cmbCidadeEmitente.AddItem "Simplicio Mendes - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210805
    cmbCidadeEmitente.AddItem "Socorro do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210904
    cmbCidadeEmitente.AddItem "Sussuapara - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210938
    cmbCidadeEmitente.AddItem "Tamboril do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210953
    cmbCidadeEmitente.AddItem "Tanque do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2210979
    cmbCidadeEmitente.AddItem "Teresina - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2211001
    cmbCidadeEmitente.AddItem "Uniao - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2211100
    cmbCidadeEmitente.AddItem "Urucui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2211209
    cmbCidadeEmitente.AddItem "Valenca do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2211308
    cmbCidadeEmitente.AddItem "Varzea Branca - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2211357
    cmbCidadeEmitente.AddItem "Varzea Grande - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2211407
    cmbCidadeEmitente.AddItem "Vera Mendes - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2211506
    cmbCidadeEmitente.AddItem "Vila Nova do Piaui - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2211605
    cmbCidadeEmitente.AddItem "Wall Ferraz - PI"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2211704
End Sub

Public Sub Ceara(ByRef cmbCidadeEmitente As ComboBox)
    Ceara1 cmbCidadeEmitente
    Ceara2 cmbCidadeEmitente
End Sub

Private Sub Ceara1(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Abaiara - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2300101
    cmbCidadeEmitente.AddItem "Acarape - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2300150
    cmbCidadeEmitente.AddItem "Acarau - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2300200
    cmbCidadeEmitente.AddItem "Acopiara - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2300309
    cmbCidadeEmitente.AddItem "Aiuaba - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2300408
    cmbCidadeEmitente.AddItem "Alcantaras - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2300507
    cmbCidadeEmitente.AddItem "Altaneira - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2300606
    cmbCidadeEmitente.AddItem "Alto Santo - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2300705
    cmbCidadeEmitente.AddItem "Amontada - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2300754
    cmbCidadeEmitente.AddItem "Antonina do Norte - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2300804
    cmbCidadeEmitente.AddItem "Apuiares - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2300903
    cmbCidadeEmitente.AddItem "Aquiraz - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2301000
    cmbCidadeEmitente.AddItem "Aracati - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2301109
    cmbCidadeEmitente.AddItem "Aracoiaba - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2301208
    cmbCidadeEmitente.AddItem "Ararenda - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2301257
    cmbCidadeEmitente.AddItem "Araripe - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2301307
    cmbCidadeEmitente.AddItem "Aratuba - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2301406
    cmbCidadeEmitente.AddItem "Arneiroz - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2301505
    cmbCidadeEmitente.AddItem "Assare - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2301604
    cmbCidadeEmitente.AddItem "Aurora - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2301703
    cmbCidadeEmitente.AddItem "Baixio - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2301802
    cmbCidadeEmitente.AddItem "Banabuiu - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2301851
    cmbCidadeEmitente.AddItem "Barbalha - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2301901
    cmbCidadeEmitente.AddItem "Barreira - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2301950
    cmbCidadeEmitente.AddItem "Barro - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2302008
    cmbCidadeEmitente.AddItem "Barroquinha - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2302057
    cmbCidadeEmitente.AddItem "Baturite - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2302107
    cmbCidadeEmitente.AddItem "Beberibe - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2302206
    cmbCidadeEmitente.AddItem "Bela Cruz - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2302305
    cmbCidadeEmitente.AddItem "Boa Viagem - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2302404
    cmbCidadeEmitente.AddItem "Brejo Santo - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2302503
    cmbCidadeEmitente.AddItem "Camocim - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2302602
    cmbCidadeEmitente.AddItem "Campos Sales - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2302701
    cmbCidadeEmitente.AddItem "Caninde - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2302800
    cmbCidadeEmitente.AddItem "Capistrano - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2302909
    cmbCidadeEmitente.AddItem "Caridade - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2303006
    cmbCidadeEmitente.AddItem "Carire - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2303105
    cmbCidadeEmitente.AddItem "Caririacu - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2303204
    cmbCidadeEmitente.AddItem "Carius - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2303303
    cmbCidadeEmitente.AddItem "Carnaubal - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2303402
    cmbCidadeEmitente.AddItem "Cascavel - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2303501
    cmbCidadeEmitente.AddItem "Catarina - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2303600
    cmbCidadeEmitente.AddItem "Catunda - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2303659
    cmbCidadeEmitente.AddItem "Caucaia - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2303709
    cmbCidadeEmitente.AddItem "Cedro - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2303808
    cmbCidadeEmitente.AddItem "Chaval - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2303907
    cmbCidadeEmitente.AddItem "Choro - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2303931
    cmbCidadeEmitente.AddItem "Chorozinho - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2303956
    cmbCidadeEmitente.AddItem "Coreau - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2304004
    cmbCidadeEmitente.AddItem "Crateus - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2304103
    cmbCidadeEmitente.AddItem "Crato - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2304202
    cmbCidadeEmitente.AddItem "Croata - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2304236
    cmbCidadeEmitente.AddItem "Cruz - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2304251
    cmbCidadeEmitente.AddItem "Deputado Irapuan Pinheiro - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2304269
    cmbCidadeEmitente.AddItem "Erere - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2304277
    cmbCidadeEmitente.AddItem "Eusebio - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2304285
    cmbCidadeEmitente.AddItem "Farias Brito - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2304301
    cmbCidadeEmitente.AddItem "Forquilha - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2304350
    cmbCidadeEmitente.AddItem "Fortaleza - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2304400
    cmbCidadeEmitente.AddItem "Fortim - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2304459
    cmbCidadeEmitente.AddItem "Frecheirinha - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2304509
    cmbCidadeEmitente.AddItem "General Sampaio - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2304608
    cmbCidadeEmitente.AddItem "Graca - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2304657
    cmbCidadeEmitente.AddItem "Granja - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2304707
    cmbCidadeEmitente.AddItem "Granjeiro - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2304806
    cmbCidadeEmitente.AddItem "Groairas - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2304905
    cmbCidadeEmitente.AddItem "Guaiuba - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2304954
    cmbCidadeEmitente.AddItem "Guaraciaba do Norte - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2305001
    cmbCidadeEmitente.AddItem "Guaramiranga - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2305100
    cmbCidadeEmitente.AddItem "Hidrolandia - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2305209
    cmbCidadeEmitente.AddItem "Horizonte - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2305233
    cmbCidadeEmitente.AddItem "Ibaretama - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2305266
    cmbCidadeEmitente.AddItem "Ibiapina - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2305308
    cmbCidadeEmitente.AddItem "Ibicuitinga - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2305332
    cmbCidadeEmitente.AddItem "Icapui - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2305357
    cmbCidadeEmitente.AddItem "Ico - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2305407
    cmbCidadeEmitente.AddItem "Iguatu - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2305506
    cmbCidadeEmitente.AddItem "Independencia - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2305605
    cmbCidadeEmitente.AddItem "Ipaporanga - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2305654
    cmbCidadeEmitente.AddItem "Ipaumirim - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2305704
    cmbCidadeEmitente.AddItem "Ipu - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2305803
    cmbCidadeEmitente.AddItem "Ipueiras - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2305902
    cmbCidadeEmitente.AddItem "Iracema - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2306009
    cmbCidadeEmitente.AddItem "Iraucuba - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2306108
    cmbCidadeEmitente.AddItem "Itaicaba - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2306207
    cmbCidadeEmitente.AddItem "Itaitinga - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2306256
    cmbCidadeEmitente.AddItem "Itapage - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2306306
    cmbCidadeEmitente.AddItem "Itapipoca - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2306405
    cmbCidadeEmitente.AddItem "Itapiuna - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2306504
    cmbCidadeEmitente.AddItem "Itarema - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2306553
    cmbCidadeEmitente.AddItem "Itatira - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2306603
    cmbCidadeEmitente.AddItem "Jaguaretama - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2306702
    cmbCidadeEmitente.AddItem "Jaguaribara - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2306801
    cmbCidadeEmitente.AddItem "Jaguaribe - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2306900
    cmbCidadeEmitente.AddItem "Jaguaruana - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2307007
    cmbCidadeEmitente.AddItem "Jardim - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2307106
    cmbCidadeEmitente.AddItem "Jati - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2307205
    cmbCidadeEmitente.AddItem "Jijoca de Jericoacoara - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2307254
    cmbCidadeEmitente.AddItem "Juazeiro do Norte - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2307304
    cmbCidadeEmitente.AddItem "Jucas - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2307403
    cmbCidadeEmitente.AddItem "Lavras da Mangabeira - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2307502
    cmbCidadeEmitente.AddItem "Limoeiro do Norte - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2307601
    cmbCidadeEmitente.AddItem "Madalena - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2307635
    cmbCidadeEmitente.AddItem "Maracanau - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2307650
    cmbCidadeEmitente.AddItem "Maranguape - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2307700
    cmbCidadeEmitente.AddItem "Marco - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2307809
    cmbCidadeEmitente.AddItem "Martinopole - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2307908
    cmbCidadeEmitente.AddItem "Massape - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2308005
    cmbCidadeEmitente.AddItem "Mauriti - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2308104
    cmbCidadeEmitente.AddItem "Meruoca - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2308203
    cmbCidadeEmitente.AddItem "Milagres - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2308302
    cmbCidadeEmitente.AddItem "Milha - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2308351
    cmbCidadeEmitente.AddItem "Miraima - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2308377
    cmbCidadeEmitente.AddItem "Missao Velha - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2308401
    cmbCidadeEmitente.AddItem "Mombaca - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2308500
    cmbCidadeEmitente.AddItem "Monsenhor Tabosa - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2308609
    cmbCidadeEmitente.AddItem "Morada Nova - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2308708
    cmbCidadeEmitente.AddItem "Moraujo - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2308807
    cmbCidadeEmitente.AddItem "Morrinhos - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2308906
    cmbCidadeEmitente.AddItem "Mucambo - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2309003
    cmbCidadeEmitente.AddItem "Mulungu - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2309102
    cmbCidadeEmitente.AddItem "Nova Olinda - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2309201
    cmbCidadeEmitente.AddItem "Nova Russas - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2309300
    cmbCidadeEmitente.AddItem "Novo Oriente - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2309409
    cmbCidadeEmitente.AddItem "Ocara - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2309458
    cmbCidadeEmitente.AddItem "Oros - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2309508
    cmbCidadeEmitente.AddItem "Pacajus - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2309607
    cmbCidadeEmitente.AddItem "Pacatuba - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2309706
    cmbCidadeEmitente.AddItem "Pacoti - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2309805
    cmbCidadeEmitente.AddItem "Pacuja - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2309904
    cmbCidadeEmitente.AddItem "Palhano - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2310001
    cmbCidadeEmitente.AddItem "Palmacia - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2310100
    cmbCidadeEmitente.AddItem "Paracuru - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2310209
    cmbCidadeEmitente.AddItem "Paraipaba - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2310258
    cmbCidadeEmitente.AddItem "Parambu - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2310308
    cmbCidadeEmitente.AddItem "Paramoti - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2310407
    cmbCidadeEmitente.AddItem "Pedra Branca - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2310506
    cmbCidadeEmitente.AddItem "Penaforte - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2310605
    cmbCidadeEmitente.AddItem "Pentecoste - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2310704
    cmbCidadeEmitente.AddItem "Pereiro - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2310803
    cmbCidadeEmitente.AddItem "Pindoretama - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2310852
    cmbCidadeEmitente.AddItem "Piquet Carneiro - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2310902
    cmbCidadeEmitente.AddItem "Pires Ferreira - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2310951
    cmbCidadeEmitente.AddItem "Poranga - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2311009
    cmbCidadeEmitente.AddItem "Porteiras - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2311108
    cmbCidadeEmitente.AddItem "Potengi - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2311207
    cmbCidadeEmitente.AddItem "Potiretama - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2311231
    cmbCidadeEmitente.AddItem "Quiterianopolis - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2311264
    cmbCidadeEmitente.AddItem "Quixada - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2311306
    cmbCidadeEmitente.AddItem "Quixelo - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2311355
End Sub

Private Sub Ceara2(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Quixeramobim - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2311405
    cmbCidadeEmitente.AddItem "Quixere - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2311504
    cmbCidadeEmitente.AddItem "Redencao - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2311603
    cmbCidadeEmitente.AddItem "Reriutaba - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2311702
    cmbCidadeEmitente.AddItem "Russas - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2311801
    cmbCidadeEmitente.AddItem "Saboeiro - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2311900
    cmbCidadeEmitente.AddItem "Salitre - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2311959
    cmbCidadeEmitente.AddItem "Santa Quiteria - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2312205
    cmbCidadeEmitente.AddItem "Santana do Acarau - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2312007
    cmbCidadeEmitente.AddItem "Santana do Cariri - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2312106
    cmbCidadeEmitente.AddItem "Sao Benedito - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2312304
    cmbCidadeEmitente.AddItem "Sao Goncalo do Amarante - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2312403
    cmbCidadeEmitente.AddItem "Sao Joao do Jaguaribe - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2312502
    cmbCidadeEmitente.AddItem "Sao Luis do Curu - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2312601
    cmbCidadeEmitente.AddItem "Senador Pompeu - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2312700
    cmbCidadeEmitente.AddItem "Senador Sa - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2312809
    cmbCidadeEmitente.AddItem "Sobral - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2312908
    cmbCidadeEmitente.AddItem "Solonopole - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2313005
    cmbCidadeEmitente.AddItem "Tabuleiro do Norte - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2313104
    cmbCidadeEmitente.AddItem "Tamboril - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2313203
    cmbCidadeEmitente.AddItem "Tarrafas - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2313252
    cmbCidadeEmitente.AddItem "Taua - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2313302
    cmbCidadeEmitente.AddItem "Tejucuoca - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2313351
    cmbCidadeEmitente.AddItem "Tiangua - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2313401
    cmbCidadeEmitente.AddItem "Trairi - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2313500
    cmbCidadeEmitente.AddItem "Tururu - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2313559
    cmbCidadeEmitente.AddItem "Ubajara - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2313609
    cmbCidadeEmitente.AddItem "Umari - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2313708
    cmbCidadeEmitente.AddItem "Umirim - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2313757
    cmbCidadeEmitente.AddItem "Uruburetama - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2313807
    cmbCidadeEmitente.AddItem "Uruoca - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2313906
    cmbCidadeEmitente.AddItem "Varjota - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2313955
    cmbCidadeEmitente.AddItem "Varzea Alegre - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2314003
    cmbCidadeEmitente.AddItem "Vicosa do Ceara - CE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2314102
End Sub

Public Sub RioGrandedoNorte(ByRef cmbCidadeEmitente As ComboBox)
    RioGrandedoNorte1 cmbCidadeEmitente
    RioGrandedoNorte2 cmbCidadeEmitente
End Sub

Private Sub RioGrandedoNorte1(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Acari - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2400109
    cmbCidadeEmitente.AddItem "Acu - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2400208
    cmbCidadeEmitente.AddItem "Afonso Bezerra - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2400307
    cmbCidadeEmitente.AddItem "Agua Nova - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2400406
    cmbCidadeEmitente.AddItem "Alexandria - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2400505
    cmbCidadeEmitente.AddItem "Almino Afonso - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2400604
    cmbCidadeEmitente.AddItem "Alto do Rodrigues - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2400703
    cmbCidadeEmitente.AddItem "Angicos - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2400802
    cmbCidadeEmitente.AddItem "Antonio Martins - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2400901
    cmbCidadeEmitente.AddItem "Apodi - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2401008
    cmbCidadeEmitente.AddItem "Areia Branca - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2401107
    cmbCidadeEmitente.AddItem "Ares - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2401206
    cmbCidadeEmitente.AddItem "Augusto Severo - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2401305
    cmbCidadeEmitente.AddItem "Baia Formosa - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2401404
    cmbCidadeEmitente.AddItem "Barauna - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2401453
    cmbCidadeEmitente.AddItem "Barcelona - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2401503
    cmbCidadeEmitente.AddItem "Bento Fernandes - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2401602
    cmbCidadeEmitente.AddItem "Bodo - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2401651
    cmbCidadeEmitente.AddItem "Bom Jesus - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2401701
    cmbCidadeEmitente.AddItem "Brejinho - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2401800
    cmbCidadeEmitente.AddItem "Caicara do Norte - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2401859
    cmbCidadeEmitente.AddItem "Caicara do Rio do Vento - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2401909
    cmbCidadeEmitente.AddItem "Caico - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2402006
    cmbCidadeEmitente.AddItem "Campo Redondo - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2402105
    cmbCidadeEmitente.AddItem "Canguaretama - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2402204
    cmbCidadeEmitente.AddItem "Caraubas - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2402303
    cmbCidadeEmitente.AddItem "Carnauba dos Dantas - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2402402
    cmbCidadeEmitente.AddItem "Carnaubais - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2402501
    cmbCidadeEmitente.AddItem "Ceara-Mirim - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2402600
    cmbCidadeEmitente.AddItem "Cerro Cora - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2402709
    cmbCidadeEmitente.AddItem "Coronel Ezequiel - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2402808
    cmbCidadeEmitente.AddItem "Coronel Joao Pessoa - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2402907
    cmbCidadeEmitente.AddItem "Cruzeta - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2403004
    cmbCidadeEmitente.AddItem "Currais Novos - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2403103
    cmbCidadeEmitente.AddItem "Doutor Severiano - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2403202
    cmbCidadeEmitente.AddItem "Encanto - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2403301
    cmbCidadeEmitente.AddItem "Equador - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2403400
    cmbCidadeEmitente.AddItem "Espirito Santo - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2403509
    cmbCidadeEmitente.AddItem "Extremoz - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2403608
    cmbCidadeEmitente.AddItem "Felipe Guerra - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2403707
    cmbCidadeEmitente.AddItem "Fernando Pedroza - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2403756
    cmbCidadeEmitente.AddItem "Florania - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2403806
    cmbCidadeEmitente.AddItem "Francisco Dantas - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2403905
    cmbCidadeEmitente.AddItem "Frutuoso Gomes - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2404002
    cmbCidadeEmitente.AddItem "Galinhos - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2404101
    cmbCidadeEmitente.AddItem "Goianinha - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2404200
    cmbCidadeEmitente.AddItem "Governador Dix-Sept Rosado - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2404309
    cmbCidadeEmitente.AddItem "Grossos - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2404408
    cmbCidadeEmitente.AddItem "Guamare - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2404507
    cmbCidadeEmitente.AddItem "Ielmo Marinho - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2404606
    cmbCidadeEmitente.AddItem "Ipanguacu - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2404705
    cmbCidadeEmitente.AddItem "Ipueira - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2404804
    cmbCidadeEmitente.AddItem "Itaja - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2404853
    cmbCidadeEmitente.AddItem "Itau - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2404903
    cmbCidadeEmitente.AddItem "Jacana - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2405009
    cmbCidadeEmitente.AddItem "Jandaira - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2405108
    cmbCidadeEmitente.AddItem "Janduis - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2405207
    cmbCidadeEmitente.AddItem "Januario Cicco - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2405306
    cmbCidadeEmitente.AddItem "Japi - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2405405
    cmbCidadeEmitente.AddItem "Jardim de Angicos - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2405504
    cmbCidadeEmitente.AddItem "Jardim de Piranhas - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2405603
    cmbCidadeEmitente.AddItem "Jardim do Serido - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2405702
    cmbCidadeEmitente.AddItem "Joao Camara - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2405801
    cmbCidadeEmitente.AddItem "Joao Dias - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2405900
    cmbCidadeEmitente.AddItem "Jose da Penha - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2406007
    cmbCidadeEmitente.AddItem "Jucurutu - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2406106
    cmbCidadeEmitente.AddItem "Jundia - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2406155
    cmbCidadeEmitente.AddItem "Lagoa D Anta - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2406205
    cmbCidadeEmitente.AddItem "Lagoa de Pedras - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2406304
    cmbCidadeEmitente.AddItem "Lagoa de Velhos - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2406403
    cmbCidadeEmitente.AddItem "Lagoa Nova - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2406502
    cmbCidadeEmitente.AddItem "Lagoa Salgada - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2406601
    cmbCidadeEmitente.AddItem "Lajes - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2406700
    cmbCidadeEmitente.AddItem "Lajes Pintadas - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2406809
    cmbCidadeEmitente.AddItem "Lucrecia - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2406908
    cmbCidadeEmitente.AddItem "Luis Gomes - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2407005
    cmbCidadeEmitente.AddItem "Macaiba - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2407104
    cmbCidadeEmitente.AddItem "Macau - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2407203
    cmbCidadeEmitente.AddItem "Major Sales - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2407252
    cmbCidadeEmitente.AddItem "Marcelino Vieira - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2407302
    cmbCidadeEmitente.AddItem "Martins - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2407401
    cmbCidadeEmitente.AddItem "Maxaranguape - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2407500
    cmbCidadeEmitente.AddItem "Messias Targino - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2407609
    cmbCidadeEmitente.AddItem "Montanhas - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2407708
    cmbCidadeEmitente.AddItem "Monte Alegre - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2407807
    cmbCidadeEmitente.AddItem "Monte das Gameleiras - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2407906
    cmbCidadeEmitente.AddItem "Mossoro - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2408003
    cmbCidadeEmitente.AddItem "Natal - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2408102
    cmbCidadeEmitente.AddItem "Nisia Floresta - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2408201
    cmbCidadeEmitente.AddItem "Nova Cruz - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2408300
    cmbCidadeEmitente.AddItem "Olho-D Agua do Borges - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2408409
    cmbCidadeEmitente.AddItem "Ouro Branco - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2408508
    cmbCidadeEmitente.AddItem "Parana - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2408607
    cmbCidadeEmitente.AddItem "Parau - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2408706
    cmbCidadeEmitente.AddItem "Parazinho - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2408805
    cmbCidadeEmitente.AddItem "Parelhas - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2408904
    cmbCidadeEmitente.AddItem "Parnamirim - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2403251
    cmbCidadeEmitente.AddItem "Passa E Fica - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2409100
    cmbCidadeEmitente.AddItem "Passagem - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2409209
    cmbCidadeEmitente.AddItem "Patu - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2409308
    cmbCidadeEmitente.AddItem "Pau dos Ferros - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2409407
    cmbCidadeEmitente.AddItem "Pedra Grande - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2409506
    cmbCidadeEmitente.AddItem "Pedra Preta - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2409605
    cmbCidadeEmitente.AddItem "Pedro Avelino - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2409704
    cmbCidadeEmitente.AddItem "Pedro Velho - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2409803
    cmbCidadeEmitente.AddItem "Pendencias - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2409902
    cmbCidadeEmitente.AddItem "Piloes - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2410009
    cmbCidadeEmitente.AddItem "Poco Branco - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2410108
    cmbCidadeEmitente.AddItem "Portalegre - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2410207
    cmbCidadeEmitente.AddItem "Porto do Mangue - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2410256
    cmbCidadeEmitente.AddItem "Presidente Juscelino - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2410306
    cmbCidadeEmitente.AddItem "Pureza - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2410405
    cmbCidadeEmitente.AddItem "Rafael Fernandes - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2410504
    cmbCidadeEmitente.AddItem "Rafael Godeiro - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2410603
    cmbCidadeEmitente.AddItem "Riacho da Cruz - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2410702
    cmbCidadeEmitente.AddItem "Riacho de Santana - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2410801
    cmbCidadeEmitente.AddItem "Riachuelo - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2410900
    cmbCidadeEmitente.AddItem "Rio do Fogo - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2408953
    cmbCidadeEmitente.AddItem "Rodolfo Fernandes - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2411007
    cmbCidadeEmitente.AddItem "Ruy Barbosa - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2411106
    cmbCidadeEmitente.AddItem "Santa Cruz - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2411205
    cmbCidadeEmitente.AddItem "Santa Maria - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2409332
    cmbCidadeEmitente.AddItem "Santana do Matos - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2411403
    cmbCidadeEmitente.AddItem "Santana do Serido - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2411429
    cmbCidadeEmitente.AddItem "Santo Antonio - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2411502
    cmbCidadeEmitente.AddItem "Sao Bento do Norte - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2411601
    cmbCidadeEmitente.AddItem "Sao Bento do Trairi - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2411700
    cmbCidadeEmitente.AddItem "Sao Fernando - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2411809
    cmbCidadeEmitente.AddItem "Sao Francisco do Oeste - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2411908
    cmbCidadeEmitente.AddItem "Sao Goncalo do Amarante - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2412005
    cmbCidadeEmitente.AddItem "Sao Joao do Sabugi - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2412104
    cmbCidadeEmitente.AddItem "Sao Jose de Mipibu - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2412203
    cmbCidadeEmitente.AddItem "Sao Jose do Campestre - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2412302
    cmbCidadeEmitente.AddItem "Sao Jose do Serido - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2412401
    cmbCidadeEmitente.AddItem "Sao Miguel - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2412500
    cmbCidadeEmitente.AddItem "Sao Miguel do Gostoso - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2412559
    cmbCidadeEmitente.AddItem "Sao Paulo do Potengi - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2412609
    cmbCidadeEmitente.AddItem "Sao Pedro - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2412708
    cmbCidadeEmitente.AddItem "Sao Rafael - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2412807
    cmbCidadeEmitente.AddItem "Sao Tome - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2412906
    cmbCidadeEmitente.AddItem "Sao Vicente - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2413003
    cmbCidadeEmitente.AddItem "Senador Eloi de Souza - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2413102
    cmbCidadeEmitente.AddItem "Senador Georgino Avelino - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2413201
    cmbCidadeEmitente.AddItem "Serra de Sao Bento - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2413300
    cmbCidadeEmitente.AddItem "Serra do Mel - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2413359
    cmbCidadeEmitente.AddItem "Serra Negra do Norte - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2413409
    cmbCidadeEmitente.AddItem "Serrinha - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2413508
    cmbCidadeEmitente.AddItem "Serrinha dos Pintos - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2413557
    cmbCidadeEmitente.AddItem "Severiano Melo - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2413607
    cmbCidadeEmitente.AddItem "Sitio Novo - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2413706
End Sub

Private Sub RioGrandedoNorte2(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Taboleiro Grande - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2413805
    cmbCidadeEmitente.AddItem "Taipu - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2413904
    cmbCidadeEmitente.AddItem "Tangara - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2414001
    cmbCidadeEmitente.AddItem "Tenente Ananias - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2414100
    cmbCidadeEmitente.AddItem "Tenente Laurentino Cruz - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2414159
    cmbCidadeEmitente.AddItem "Tibau - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2411056
    cmbCidadeEmitente.AddItem "Tibau do Sul - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2414209
    cmbCidadeEmitente.AddItem "Timbauba dos Batistas - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2414308
    cmbCidadeEmitente.AddItem "Touros - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2414407
    cmbCidadeEmitente.AddItem "Triunfo Potiguar - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2414456
    cmbCidadeEmitente.AddItem "Umarizal - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2414506
    cmbCidadeEmitente.AddItem "Upanema - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2414605
    cmbCidadeEmitente.AddItem "Varzea - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2414704
    cmbCidadeEmitente.AddItem "Venha-Ver - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2414753
    cmbCidadeEmitente.AddItem "Vera Cruz - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2414803
    cmbCidadeEmitente.AddItem "Vicosa - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2414902
    cmbCidadeEmitente.AddItem "Vila Flor - RN"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2415008
End Sub

Public Sub Paraiba(ByRef cmbCidadeEmitente As ComboBox)
    Paraiba1 cmbCidadeEmitente
    Paraiba2 cmbCidadeEmitente
End Sub

Private Sub Paraiba1(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Agua Branca - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2500106
    cmbCidadeEmitente.AddItem "Aguiar - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2500205
    cmbCidadeEmitente.AddItem "Alagoa Grande - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2500304
    cmbCidadeEmitente.AddItem "Alagoa Nova - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2500403
    cmbCidadeEmitente.AddItem "Alagoinha - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2500502
    cmbCidadeEmitente.AddItem "Alcantil - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2500536
    cmbCidadeEmitente.AddItem "Algodao de Jandaira - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2500577
    cmbCidadeEmitente.AddItem "Alhandra - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2500601
    cmbCidadeEmitente.AddItem "Amparo - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2500734
    cmbCidadeEmitente.AddItem "Aparecida - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2500775
    cmbCidadeEmitente.AddItem "Aracagi - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2500809
    cmbCidadeEmitente.AddItem "Arara - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2500908
    cmbCidadeEmitente.AddItem "Araruna - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2501005
    cmbCidadeEmitente.AddItem "Areia - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2501104
    cmbCidadeEmitente.AddItem "Areia de Baraunas - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2501153
    cmbCidadeEmitente.AddItem "Areial - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2501203
    cmbCidadeEmitente.AddItem "Aroeiras - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2501302
    cmbCidadeEmitente.AddItem "Assuncao - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2501351
    cmbCidadeEmitente.AddItem "Baia da Traicao - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2501401
    cmbCidadeEmitente.AddItem "Bananeiras - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2501500
    cmbCidadeEmitente.AddItem "Barauna - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2501534
    cmbCidadeEmitente.AddItem "Barra de Santa Rosa - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2501609
    cmbCidadeEmitente.AddItem "Barra de Santana - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2501575
    cmbCidadeEmitente.AddItem "Barra de Sao Miguel - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2501708
    cmbCidadeEmitente.AddItem "Bayeux - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2501807
    cmbCidadeEmitente.AddItem "Belem - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2501906
    cmbCidadeEmitente.AddItem "Belem do Brejo do Cruz - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2502003
    cmbCidadeEmitente.AddItem "Bernardino Batista - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2502052
    cmbCidadeEmitente.AddItem "Boa Ventura - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2502102
    cmbCidadeEmitente.AddItem "Boa Vista - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2502151
    cmbCidadeEmitente.AddItem "Bom Jesus - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2502201
    cmbCidadeEmitente.AddItem "Bom Sucesso - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2502300
    cmbCidadeEmitente.AddItem "Bonito de Santa Fe - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2502409
    cmbCidadeEmitente.AddItem "Boqueirao - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2502508
    cmbCidadeEmitente.AddItem "Borborema - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2502706
    cmbCidadeEmitente.AddItem "Brejo do Cruz - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2502805
    cmbCidadeEmitente.AddItem "Brejo dos Santos - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2502904
    cmbCidadeEmitente.AddItem "Caapora - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2503001
    cmbCidadeEmitente.AddItem "Cabaceiras - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2503100
    cmbCidadeEmitente.AddItem "Cabedelo - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2503209
    cmbCidadeEmitente.AddItem "Cachoeira dos Indios - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2503308
    cmbCidadeEmitente.AddItem "Cacimba de Areia - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2503407
    cmbCidadeEmitente.AddItem "Cacimba de Dentro - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2503506
    cmbCidadeEmitente.AddItem "Cacimbas - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2503555
    cmbCidadeEmitente.AddItem "Caicara - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2503605
    cmbCidadeEmitente.AddItem "Cajazeiras - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2503704
    cmbCidadeEmitente.AddItem "Cajazeirinhas - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2503753
    cmbCidadeEmitente.AddItem "Caldas Brandao - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2503803
    cmbCidadeEmitente.AddItem "Camalau - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2503902
    cmbCidadeEmitente.AddItem "Campina Grande - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2504009
    cmbCidadeEmitente.AddItem "Campo de Santana - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2516409
    cmbCidadeEmitente.AddItem "Capim - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2504033
    cmbCidadeEmitente.AddItem "Caraubas - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2504074
    cmbCidadeEmitente.AddItem "Carrapateira - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2504108
    cmbCidadeEmitente.AddItem "Casserengue - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2504157
    cmbCidadeEmitente.AddItem "Catingueira - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2504207
    cmbCidadeEmitente.AddItem "Catole do Rocha - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2504306
    cmbCidadeEmitente.AddItem "Caturite - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2504355
    cmbCidadeEmitente.AddItem "Conceicao - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2504405
    cmbCidadeEmitente.AddItem "Condado - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2504504
    cmbCidadeEmitente.AddItem "Conde - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2504603
    cmbCidadeEmitente.AddItem "Congo - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2504702
    cmbCidadeEmitente.AddItem "Coremas - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2504801
    cmbCidadeEmitente.AddItem "Coxixola - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2504850
    cmbCidadeEmitente.AddItem "Cruz do Espirito Santo - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2504900
    cmbCidadeEmitente.AddItem "Cubati - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2505006
    cmbCidadeEmitente.AddItem "Cuite - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2505105
    cmbCidadeEmitente.AddItem "Cuite de Mamanguape - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2505238
    cmbCidadeEmitente.AddItem "Cuitegi - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2505204
    cmbCidadeEmitente.AddItem "Curral de Cima - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2505279
    cmbCidadeEmitente.AddItem "Curral Velho - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2505303
    cmbCidadeEmitente.AddItem "Damiao - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2505352
    cmbCidadeEmitente.AddItem "Desterro - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2505402
    cmbCidadeEmitente.AddItem "Diamante - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2505600
    cmbCidadeEmitente.AddItem "Dona Ines - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2505709
    cmbCidadeEmitente.AddItem "Duas Estradas - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2505808
    cmbCidadeEmitente.AddItem "Emas - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2505907
    cmbCidadeEmitente.AddItem "Esperanca - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2506004
    cmbCidadeEmitente.AddItem "Fagundes - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2506103
    cmbCidadeEmitente.AddItem "Frei Martinho - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2506202
    cmbCidadeEmitente.AddItem "Gado Bravo - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2506251
    cmbCidadeEmitente.AddItem "Guarabira - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2506301
    cmbCidadeEmitente.AddItem "Gurinhem - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2506400
    cmbCidadeEmitente.AddItem "Gurjao - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2506509
    cmbCidadeEmitente.AddItem "Ibiara - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2506608
    cmbCidadeEmitente.AddItem "Igaracy - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2502607
    cmbCidadeEmitente.AddItem "Imaculada - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2506707
    cmbCidadeEmitente.AddItem "Inga - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2506806
    cmbCidadeEmitente.AddItem "Itabaiana - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2506905
    cmbCidadeEmitente.AddItem "Itaporanga - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2507002
    cmbCidadeEmitente.AddItem "Itapororoca - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2507101
    cmbCidadeEmitente.AddItem "Itatuba - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2507200
    cmbCidadeEmitente.AddItem "Jacarau - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2507309
    cmbCidadeEmitente.AddItem "Jerico - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2507408
    cmbCidadeEmitente.AddItem "Joao Pessoa - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2507507
    cmbCidadeEmitente.AddItem "Joca Claudino - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2513653
    cmbCidadeEmitente.AddItem "Juarez Tavora - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2507606
    cmbCidadeEmitente.AddItem "Juazeirinho - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2507705
    cmbCidadeEmitente.AddItem "Junco do Serido - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2507804
    cmbCidadeEmitente.AddItem "Juripiranga - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2507903
    cmbCidadeEmitente.AddItem "Juru - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2508000
    cmbCidadeEmitente.AddItem "Lagoa - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2508109
    cmbCidadeEmitente.AddItem "Lagoa de Dentro - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2508208
    cmbCidadeEmitente.AddItem "Lagoa Seca - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2508307
    cmbCidadeEmitente.AddItem "Lastro - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2508406
    cmbCidadeEmitente.AddItem "Livramento - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2508505
    cmbCidadeEmitente.AddItem "Logradouro - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2508554
    cmbCidadeEmitente.AddItem "Lucena - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2508604
    cmbCidadeEmitente.AddItem "Mae D Agua - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2508703
    cmbCidadeEmitente.AddItem "Malta - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2508802
    cmbCidadeEmitente.AddItem "Mamanguape - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2508901
    cmbCidadeEmitente.AddItem "Manaira - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2509008
    cmbCidadeEmitente.AddItem "Marcacao - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2509057
    cmbCidadeEmitente.AddItem "Mari - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2509107
    cmbCidadeEmitente.AddItem "Marizopolis - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2509156
    cmbCidadeEmitente.AddItem "Massaranduba - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2509206
    cmbCidadeEmitente.AddItem "Mataraca - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2509305
    cmbCidadeEmitente.AddItem "Matinhas - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2509339
    cmbCidadeEmitente.AddItem "Mato Grosso - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2509370
    cmbCidadeEmitente.AddItem "Matureia - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2509396
    cmbCidadeEmitente.AddItem "Mogeiro - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2509404
    cmbCidadeEmitente.AddItem "Montadas - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2509503
    cmbCidadeEmitente.AddItem "Monte Horebe - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2509602
    cmbCidadeEmitente.AddItem "Monteiro - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2509701
    cmbCidadeEmitente.AddItem "Mulungu - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2509800
    cmbCidadeEmitente.AddItem "Natuba - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2509909
    cmbCidadeEmitente.AddItem "Nazarezinho - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2510006
    cmbCidadeEmitente.AddItem "Nova Floresta - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2510105
    cmbCidadeEmitente.AddItem "Nova Olinda - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2510204
    cmbCidadeEmitente.AddItem "Nova Palmeira - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2510303
    cmbCidadeEmitente.AddItem "Olho D Agua - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2510402
    cmbCidadeEmitente.AddItem "Olivedos - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2510501
    cmbCidadeEmitente.AddItem "Ouro Velho - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2510600
    cmbCidadeEmitente.AddItem "Parari - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2510659
    cmbCidadeEmitente.AddItem "Passagem - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2510709
    cmbCidadeEmitente.AddItem "Patos - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2510808
    cmbCidadeEmitente.AddItem "Paulista - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2510907
    cmbCidadeEmitente.AddItem "Pedra Branca - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2511004
    cmbCidadeEmitente.AddItem "Pedra Lavrada - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2511103
    cmbCidadeEmitente.AddItem "Pedras de Fogo - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2511202
    cmbCidadeEmitente.AddItem "Pedro Regis - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2512721
    cmbCidadeEmitente.AddItem "Pianco - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2511301
    cmbCidadeEmitente.AddItem "Picui - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2511400
    cmbCidadeEmitente.AddItem "Pilar - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2511509
    cmbCidadeEmitente.AddItem "Piloes - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2511608
    cmbCidadeEmitente.AddItem "Piloezinhos - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2511707
    cmbCidadeEmitente.AddItem "Pirpirituba - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2511806
    cmbCidadeEmitente.AddItem "Pitimbu - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2511905
    cmbCidadeEmitente.AddItem "Pocinhos - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2512002
    cmbCidadeEmitente.AddItem "Poco Dantas - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2512036
End Sub

Private Sub Paraiba2(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Poco de Jose de Moura - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2512077
    cmbCidadeEmitente.AddItem "Pombal - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2512101
    cmbCidadeEmitente.AddItem "Prata - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2512200
    cmbCidadeEmitente.AddItem "Princesa Isabel - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2512309
    cmbCidadeEmitente.AddItem "Puxinana - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2512408
    cmbCidadeEmitente.AddItem "Queimadas - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2512507
    cmbCidadeEmitente.AddItem "Quixaba - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2512606
    cmbCidadeEmitente.AddItem "Remigio - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2512705
    cmbCidadeEmitente.AddItem "Riachao - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2512747
    cmbCidadeEmitente.AddItem "Riachao do Bacamarte - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2512754
    cmbCidadeEmitente.AddItem "Riachao do Poco - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2512762
    cmbCidadeEmitente.AddItem "Riacho de Santo Antonio - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2512788
    cmbCidadeEmitente.AddItem "Riacho dos Cavalos - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2512804
    cmbCidadeEmitente.AddItem "Rio Tinto - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2512903
    cmbCidadeEmitente.AddItem "Salgadinho - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2513000
    cmbCidadeEmitente.AddItem "Salgado de Sao Felix - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2513109
    cmbCidadeEmitente.AddItem "Santa Cecilia - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2513158
    cmbCidadeEmitente.AddItem "Santa Cruz - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2513208
    cmbCidadeEmitente.AddItem "Santa Helena - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2513307
    cmbCidadeEmitente.AddItem "Santa Ines - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2513356
    cmbCidadeEmitente.AddItem "Santa Luzia - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2513406
    cmbCidadeEmitente.AddItem "Santa Rita - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2513703
    cmbCidadeEmitente.AddItem "Santa Teresinha - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2513802
    cmbCidadeEmitente.AddItem "Santana de Mangueira - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2513505
    cmbCidadeEmitente.AddItem "Santana dos Garrotes - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2513604
    cmbCidadeEmitente.AddItem "Santo Andre - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2513851
    cmbCidadeEmitente.AddItem "Sao Bentinho - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2513927
    cmbCidadeEmitente.AddItem "Sao Bento - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2513901
    cmbCidadeEmitente.AddItem "Sao Domingos - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2513968
    cmbCidadeEmitente.AddItem "Sao Domingos do Cariri - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2513943
    cmbCidadeEmitente.AddItem "Sao Francisco - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2513984
    cmbCidadeEmitente.AddItem "Sao Joao do Cariri - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2514008
    cmbCidadeEmitente.AddItem "Sao Joao do Rio do Peixe - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2500700
    cmbCidadeEmitente.AddItem "Sao Joao do Tigre - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2514107
    cmbCidadeEmitente.AddItem "Sao Jose da Lagoa Tapada - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2514206
    cmbCidadeEmitente.AddItem "Sao Jose de Caiana - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2514305
    cmbCidadeEmitente.AddItem "Sao Jose de Espinharas - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2514404
    cmbCidadeEmitente.AddItem "Sao Jose de Piranhas - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2514503
    cmbCidadeEmitente.AddItem "Sao Jose de Princesa - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2514552
    cmbCidadeEmitente.AddItem "Sao Jose do Bonfim - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2514602
    cmbCidadeEmitente.AddItem "Sao Jose do Brejo do Cruz - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2514651
    cmbCidadeEmitente.AddItem "Sao Jose do Sabugi - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2514701
    cmbCidadeEmitente.AddItem "Sao Jose dos Cordeiros - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2514800
    cmbCidadeEmitente.AddItem "Sao Jose dos Ramos - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2514453
    cmbCidadeEmitente.AddItem "Sao Mamede - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2514909
    cmbCidadeEmitente.AddItem "Sao Miguel de Taipu - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2515005
    cmbCidadeEmitente.AddItem "Sao Sebastiao de Lagoa de Roca - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2515104
    cmbCidadeEmitente.AddItem "Sao Sebastiao do Umbuzeiro - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2515203
    cmbCidadeEmitente.AddItem "Sape - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2515302
    cmbCidadeEmitente.AddItem "Serido - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2515401
    cmbCidadeEmitente.AddItem "Serra Branca - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2515500
    cmbCidadeEmitente.AddItem "Serra da Raiz - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2515609
    cmbCidadeEmitente.AddItem "Serra Grande - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2515708
    cmbCidadeEmitente.AddItem "Serra Redonda - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2515807
    cmbCidadeEmitente.AddItem "Serraria - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2515906
    cmbCidadeEmitente.AddItem "Sertaozinho - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2515930
    cmbCidadeEmitente.AddItem "Sobrado - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2515971
    cmbCidadeEmitente.AddItem "Solanea - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2516003
    cmbCidadeEmitente.AddItem "Soledade - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2516102
    cmbCidadeEmitente.AddItem "Sossego - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2516151
    cmbCidadeEmitente.AddItem "Sousa - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2516201
    cmbCidadeEmitente.AddItem "Sume - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2516300
    cmbCidadeEmitente.AddItem "Taperoa - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2516508
    cmbCidadeEmitente.AddItem "Tavares - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2516607
    cmbCidadeEmitente.AddItem "Teixeira - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2516706
    cmbCidadeEmitente.AddItem "Tenorio - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2516755
    cmbCidadeEmitente.AddItem "Triunfo - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2516805
    cmbCidadeEmitente.AddItem "Uirauna - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2516904
    cmbCidadeEmitente.AddItem "Umbuzeiro - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2517001
    cmbCidadeEmitente.AddItem "Varzea - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2517100
    cmbCidadeEmitente.AddItem "Vieiropolis - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2517209
    cmbCidadeEmitente.AddItem "Vista Serrana - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2505501
    cmbCidadeEmitente.AddItem "Zabele - PB"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2517407
End Sub

Public Sub Pernambuco(ByRef cmbCidadeEmitente As ComboBox)
    Pernambuco1 cmbCidadeEmitente
    Pernambuco2 cmbCidadeEmitente
End Sub

Private Sub Pernambuco1(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Abreu e Lima - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2600054
    cmbCidadeEmitente.AddItem "Afogados da Ingazeira - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2600104
    cmbCidadeEmitente.AddItem "Afranio - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2600203
    cmbCidadeEmitente.AddItem "Agrestina - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2600302
    cmbCidadeEmitente.AddItem "Agua Preta - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2600401
    cmbCidadeEmitente.AddItem "Aguas Belas - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2600500
    cmbCidadeEmitente.AddItem "Alagoinha - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2600609
    cmbCidadeEmitente.AddItem "Alianca - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2600708
    cmbCidadeEmitente.AddItem "Altinho - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2600807
    cmbCidadeEmitente.AddItem "Amaraji - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2600906
    cmbCidadeEmitente.AddItem "Angelim - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2601003
    cmbCidadeEmitente.AddItem "Aracoiaba - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2601052
    cmbCidadeEmitente.AddItem "Araripina - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2601102
    cmbCidadeEmitente.AddItem "Arcoverde - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2601201
    cmbCidadeEmitente.AddItem "Barra de Guabiraba - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2601300
    cmbCidadeEmitente.AddItem "Barreiros - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2601409
    cmbCidadeEmitente.AddItem "Belem de Maria - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2601508
    cmbCidadeEmitente.AddItem "Belem de Sao Francisco - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2601607
    cmbCidadeEmitente.AddItem "Belo Jardim - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2601706
    cmbCidadeEmitente.AddItem "Betania - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2601805
    cmbCidadeEmitente.AddItem "Bezerros - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2601904
    cmbCidadeEmitente.AddItem "Bodoco - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2602001
    cmbCidadeEmitente.AddItem "Bom Conselho - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2602100
    cmbCidadeEmitente.AddItem "Bom Jardim - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2602209
    cmbCidadeEmitente.AddItem "Bonito - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2602308
    cmbCidadeEmitente.AddItem "Brejao - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2602407
    cmbCidadeEmitente.AddItem "Brejinho - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2602506
    cmbCidadeEmitente.AddItem "Brejo da Madre de Deus - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2602605
    cmbCidadeEmitente.AddItem "Buenos Aires - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2602704
    cmbCidadeEmitente.AddItem "Buique - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2602803
    cmbCidadeEmitente.AddItem "Cabo de Santo Agostinho - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2602902
    cmbCidadeEmitente.AddItem "Cabrobo - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2603009
    cmbCidadeEmitente.AddItem "Cachoeirinha - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2603108
    cmbCidadeEmitente.AddItem "Caetes - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2603207
    cmbCidadeEmitente.AddItem "Calcado - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2603306
    cmbCidadeEmitente.AddItem "Calumbi - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2603405
    cmbCidadeEmitente.AddItem "Camaragibe - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2603454
    cmbCidadeEmitente.AddItem "Camocim de Sao Felix - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2603504
    cmbCidadeEmitente.AddItem "Camutanga - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2603603
    cmbCidadeEmitente.AddItem "Canhotinho - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2603702
    cmbCidadeEmitente.AddItem "Capoeiras - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2603801
    cmbCidadeEmitente.AddItem "Carnaiba - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2603900
    cmbCidadeEmitente.AddItem "Carnaubeira da Penha - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2603926
    cmbCidadeEmitente.AddItem "Carpina - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2604007
    cmbCidadeEmitente.AddItem "Caruaru - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2604106
    cmbCidadeEmitente.AddItem "Casinhas - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2604155
    cmbCidadeEmitente.AddItem "Catende - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2604205
    cmbCidadeEmitente.AddItem "Cedro - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2604304
    cmbCidadeEmitente.AddItem "Cha de Alegria - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2604403
    cmbCidadeEmitente.AddItem "Cha Grande - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2604502
    cmbCidadeEmitente.AddItem "Condado - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2604601
    cmbCidadeEmitente.AddItem "Correntes - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2604700
    cmbCidadeEmitente.AddItem "Cortes - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2604809
    cmbCidadeEmitente.AddItem "Cumaru - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2604908
    cmbCidadeEmitente.AddItem "Cupira - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2605004
    cmbCidadeEmitente.AddItem "Custodia - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2605103
    cmbCidadeEmitente.AddItem "Dormentes - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2605152
    cmbCidadeEmitente.AddItem "Escada - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2605202
    cmbCidadeEmitente.AddItem "Exu - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2605301
    cmbCidadeEmitente.AddItem "Feira Nova - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2605400
    cmbCidadeEmitente.AddItem "Fernando de Noronha - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2605459
    cmbCidadeEmitente.AddItem "Ferreiros - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2605509
    cmbCidadeEmitente.AddItem "Flores - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2605608
    cmbCidadeEmitente.AddItem "Floresta - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2605707
    cmbCidadeEmitente.AddItem "Frei Miguelinho - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2605806
    cmbCidadeEmitente.AddItem "Gameleira - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2605905
    cmbCidadeEmitente.AddItem "Garanhuns - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2606002
    cmbCidadeEmitente.AddItem "Gloria do Goita - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2606101
    cmbCidadeEmitente.AddItem "Goiana - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2606200
    cmbCidadeEmitente.AddItem "Granito - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2606309
    cmbCidadeEmitente.AddItem "Gravata - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2606408
    cmbCidadeEmitente.AddItem "Iati - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2606507
    cmbCidadeEmitente.AddItem "Ibimirim - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2606606
    cmbCidadeEmitente.AddItem "Ibirajuba - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2606705
    cmbCidadeEmitente.AddItem "Igarassu - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2606804
    cmbCidadeEmitente.AddItem "Iguaraci - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2606903
    cmbCidadeEmitente.AddItem "Ilha de Itamaraca - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2607604
    cmbCidadeEmitente.AddItem "Inaja - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2607000
    cmbCidadeEmitente.AddItem "Ingazeira - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2607109
    cmbCidadeEmitente.AddItem "Ipojuca - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2607208
    cmbCidadeEmitente.AddItem "Ipubi - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2607307
    cmbCidadeEmitente.AddItem "Itacuruba - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2607406
    cmbCidadeEmitente.AddItem "Itaiba - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2607505
    cmbCidadeEmitente.AddItem "Itambe - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2607653
    cmbCidadeEmitente.AddItem "Itapetim - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2607703
    cmbCidadeEmitente.AddItem "Itapissuma - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2607752
    cmbCidadeEmitente.AddItem "Itaquitinga - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2607802
    cmbCidadeEmitente.AddItem "Jaboatao dos Guararapes - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2607901
    cmbCidadeEmitente.AddItem "Jaqueira - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2607950
    cmbCidadeEmitente.AddItem "Jatauba - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2608008
    cmbCidadeEmitente.AddItem "Jatoba - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2608057
    cmbCidadeEmitente.AddItem "Joao Alfredo - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2608107
    cmbCidadeEmitente.AddItem "Joaquim Nabuco - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2608206
    cmbCidadeEmitente.AddItem "Jucati - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2608255
    cmbCidadeEmitente.AddItem "Jupi - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2608305
    cmbCidadeEmitente.AddItem "Jurema - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2608404
    cmbCidadeEmitente.AddItem "Lagoa do Carro - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2608453
    cmbCidadeEmitente.AddItem "Lagoa do Itaenga - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2608503
    cmbCidadeEmitente.AddItem "Lagoa do Ouro - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2608602
    cmbCidadeEmitente.AddItem "Lagoa dos Gatos - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2608701
    cmbCidadeEmitente.AddItem "Lagoa Grande - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2608750
    cmbCidadeEmitente.AddItem "Lajedo - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2608800
    cmbCidadeEmitente.AddItem "Limoeiro - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2608909
    cmbCidadeEmitente.AddItem "Macaparana - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2609006
    cmbCidadeEmitente.AddItem "Machados - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2609105
    cmbCidadeEmitente.AddItem "Manari - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2609154
    cmbCidadeEmitente.AddItem "Maraial - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2609204
    cmbCidadeEmitente.AddItem "Mirandiba - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2609303
    cmbCidadeEmitente.AddItem "Moreilandia - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2614303
    cmbCidadeEmitente.AddItem "Moreno - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2609402
    cmbCidadeEmitente.AddItem "Nazare da Mata - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2609501
    cmbCidadeEmitente.AddItem "Olinda - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2609600
    cmbCidadeEmitente.AddItem "Orobo - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2609709
    cmbCidadeEmitente.AddItem "Oroco - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2609808
    cmbCidadeEmitente.AddItem "Ouricuri - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2609907
    cmbCidadeEmitente.AddItem "Palmares - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2610004
    cmbCidadeEmitente.AddItem "Palmeirina - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2610103
    cmbCidadeEmitente.AddItem "Panelas - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2610202
    cmbCidadeEmitente.AddItem "Paranatama - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2610301
    cmbCidadeEmitente.AddItem "Parnamirim - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2610400
    cmbCidadeEmitente.AddItem "Passira - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2610509
    cmbCidadeEmitente.AddItem "Paudalho - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2610608
    cmbCidadeEmitente.AddItem "Paulista - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2610707
    cmbCidadeEmitente.AddItem "Pedra - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2610806
    cmbCidadeEmitente.AddItem "Pesqueira - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2610905
    cmbCidadeEmitente.AddItem "Petrolandia - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2611002
    cmbCidadeEmitente.AddItem "Petrolina - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2611101
    cmbCidadeEmitente.AddItem "Pocao - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2611200
    cmbCidadeEmitente.AddItem "Pombos - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2611309
    cmbCidadeEmitente.AddItem "Primavera - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2611408
    cmbCidadeEmitente.AddItem "Quipapa - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2611507
    cmbCidadeEmitente.AddItem "Quixaba - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2611533
    cmbCidadeEmitente.AddItem "Recife - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2611606
    cmbCidadeEmitente.AddItem "Riacho das Almas - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2611705
    cmbCidadeEmitente.AddItem "Ribeirao - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2611804
    cmbCidadeEmitente.AddItem "Rio Formoso - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2611903
    cmbCidadeEmitente.AddItem "Saire - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2612000
    cmbCidadeEmitente.AddItem "Salgadinho - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2612109
    cmbCidadeEmitente.AddItem "Salgueiro - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2612208
    cmbCidadeEmitente.AddItem "Saloa - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2612307
    cmbCidadeEmitente.AddItem "Sanharo - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2612406
    cmbCidadeEmitente.AddItem "Santa Cruz - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2612455
    cmbCidadeEmitente.AddItem "Santa Cruz da Baixa Verde - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2612471
    cmbCidadeEmitente.AddItem "Santa Cruz do Capibaribe - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2612505
    cmbCidadeEmitente.AddItem "Santa Filomena - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2612554
    cmbCidadeEmitente.AddItem "Santa Maria da Boa Vista - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2612604
    cmbCidadeEmitente.AddItem "Santa Maria do Cambuca - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2612703
    cmbCidadeEmitente.AddItem "Santa Terezinha - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2612802
    cmbCidadeEmitente.AddItem "Sao Benedito do Sul - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2612901
    cmbCidadeEmitente.AddItem "Sao Bento do Una - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2613008
End Sub

Private Sub Pernambuco2(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Sao Caitano - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2613107
    cmbCidadeEmitente.AddItem "Sao Joao - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2613206
    cmbCidadeEmitente.AddItem "Sao Joaquim do Monte - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2613305
    cmbCidadeEmitente.AddItem "Sao Jose da Coroa Grande - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2613404
    cmbCidadeEmitente.AddItem "Sao Jose do Belmonte - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2613503
    cmbCidadeEmitente.AddItem "Sao Jose do Egito - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2613602
    cmbCidadeEmitente.AddItem "Sao Lourenco da Mata - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2613701
    cmbCidadeEmitente.AddItem "Sao Vicente Ferrer - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2613800
    cmbCidadeEmitente.AddItem "Serra Talhada - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2613909
    cmbCidadeEmitente.AddItem "Serrita - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2614006
    cmbCidadeEmitente.AddItem "Sertania - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2614105
    cmbCidadeEmitente.AddItem "Sirinhaem - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2614204
    cmbCidadeEmitente.AddItem "Solidao - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2614402
    cmbCidadeEmitente.AddItem "Surubim - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2614501
    cmbCidadeEmitente.AddItem "Tabira - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2614600
    cmbCidadeEmitente.AddItem "Tacaimbo - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2614709
    cmbCidadeEmitente.AddItem "Tacaratu - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2614808
    cmbCidadeEmitente.AddItem "Tamandare - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2614857
    cmbCidadeEmitente.AddItem "Taquaritinga do Norte - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2615003
    cmbCidadeEmitente.AddItem "Terezinha - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2615102
    cmbCidadeEmitente.AddItem "Terra Nova - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2615201
    cmbCidadeEmitente.AddItem "Timbauba - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2615300
    cmbCidadeEmitente.AddItem "Toritama - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2615409
    cmbCidadeEmitente.AddItem "Tracunhaem - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2615508
    cmbCidadeEmitente.AddItem "Trindade - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2615607
    cmbCidadeEmitente.AddItem "Triunfo - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2615706
    cmbCidadeEmitente.AddItem "Tupanatinga - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2615805
    cmbCidadeEmitente.AddItem "Tuparetama - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2615904
    cmbCidadeEmitente.AddItem "Venturosa - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2616001
    cmbCidadeEmitente.AddItem "Verdejante - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2616100
    cmbCidadeEmitente.AddItem "Vertente do Lerio - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2616183
    cmbCidadeEmitente.AddItem "Vertentes - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2616209
    cmbCidadeEmitente.AddItem "Vicencia - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2616308
    cmbCidadeEmitente.AddItem "Vitoria de Santo Antao - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2616407
    cmbCidadeEmitente.AddItem "Xexeu - PE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2616506
End Sub

Public Sub Alagoas(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Agua Branca - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2700102
    cmbCidadeEmitente.AddItem "Anadia - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2700201
    cmbCidadeEmitente.AddItem "Arapiraca - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2700300
    cmbCidadeEmitente.AddItem "Atalaia - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2700409
    cmbCidadeEmitente.AddItem "Barra de Santo Antonio - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2700508
    cmbCidadeEmitente.AddItem "Barra de Sao Miguel - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2700607
    cmbCidadeEmitente.AddItem "Batalha - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2700706
    cmbCidadeEmitente.AddItem "Belem - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2700805
    cmbCidadeEmitente.AddItem "Belo Monte - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2700904
    cmbCidadeEmitente.AddItem "Boca da Mata - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2701001
    cmbCidadeEmitente.AddItem "Branquinha - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2701100
    cmbCidadeEmitente.AddItem "Cacimbinhas - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2701209
    cmbCidadeEmitente.AddItem "Cajueiro - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2701308
    cmbCidadeEmitente.AddItem "Campestre - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2701357
    cmbCidadeEmitente.AddItem "Campo Alegre - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2701407
    cmbCidadeEmitente.AddItem "Campo Grande - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2701506
    cmbCidadeEmitente.AddItem "Canapi - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2701605
    cmbCidadeEmitente.AddItem "Capela - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2701704
    cmbCidadeEmitente.AddItem "Carneiros - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2701803
    cmbCidadeEmitente.AddItem "Cha Preta - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2701902
    cmbCidadeEmitente.AddItem "Coite do Noia - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2702009
    cmbCidadeEmitente.AddItem "Colonia Leopoldina - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2702108
    cmbCidadeEmitente.AddItem "Coqueiro Seco - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2702207
    cmbCidadeEmitente.AddItem "Coruripe - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2702306
    cmbCidadeEmitente.AddItem "Craibas - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2702355
    cmbCidadeEmitente.AddItem "Delmiro Gouveia - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2702405
    cmbCidadeEmitente.AddItem "Dois Riachos - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2702504
    cmbCidadeEmitente.AddItem "Estrela de Alagoas - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2702553
    cmbCidadeEmitente.AddItem "Feira Grande - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2702603
    cmbCidadeEmitente.AddItem "Feliz Deserto - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2702702
    cmbCidadeEmitente.AddItem "Flexeiras - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2702801
    cmbCidadeEmitente.AddItem "Girau do Ponciano - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2702900
    cmbCidadeEmitente.AddItem "Ibateguara - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2703007
    cmbCidadeEmitente.AddItem "Igaci - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2703106
    cmbCidadeEmitente.AddItem "Igreja Nova - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2703205
    cmbCidadeEmitente.AddItem "Inhapi - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2703304
    cmbCidadeEmitente.AddItem "Jacare dos Homens - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2703403
    cmbCidadeEmitente.AddItem "Jacuipe - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2703502
    cmbCidadeEmitente.AddItem "Japaratinga - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2703601
    cmbCidadeEmitente.AddItem "Jaramataia - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2703700
    cmbCidadeEmitente.AddItem "Jequia da Praia - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2703759
    cmbCidadeEmitente.AddItem "Joaquim Gomes - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2703809
    cmbCidadeEmitente.AddItem "Jundia - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2703908
    cmbCidadeEmitente.AddItem "Junqueiro - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2704005
    cmbCidadeEmitente.AddItem "Lagoa da Canoa - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2704104
    cmbCidadeEmitente.AddItem "Limoeiro de Anadia - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2704203
    cmbCidadeEmitente.AddItem "Maceio - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2704302
    cmbCidadeEmitente.AddItem "Major Isidoro - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2704401
    cmbCidadeEmitente.AddItem "Mar Vermelho - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2704906
    cmbCidadeEmitente.AddItem "Maragogi - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2704500
    cmbCidadeEmitente.AddItem "Maravilha - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2704609
    cmbCidadeEmitente.AddItem "Marechal Deodoro - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2704708
    cmbCidadeEmitente.AddItem "Maribondo - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2704807
    cmbCidadeEmitente.AddItem "Mata Grande - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2705002
    cmbCidadeEmitente.AddItem "Matriz de Camaragibe - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2705101
    cmbCidadeEmitente.AddItem "Messias - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2705200
    cmbCidadeEmitente.AddItem "Minador do Negrao - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2705309
    cmbCidadeEmitente.AddItem "Monteiropolis - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2705408
    cmbCidadeEmitente.AddItem "Murici - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2705507
    cmbCidadeEmitente.AddItem "Novo Lino - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2705606
    cmbCidadeEmitente.AddItem "Olho D Agua das Flores - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2705705
    cmbCidadeEmitente.AddItem "Olho D Agua do Casado - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2705804
    cmbCidadeEmitente.AddItem "Olho D Agua Grande - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2705903
    cmbCidadeEmitente.AddItem "Olivenca - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2706000
    cmbCidadeEmitente.AddItem "Ouro Branco - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2706109
    cmbCidadeEmitente.AddItem "Palestina - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2706208
    cmbCidadeEmitente.AddItem "Palmeira dos Indios - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2706307
    cmbCidadeEmitente.AddItem "Pao de Acucar - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2706406
    cmbCidadeEmitente.AddItem "Pariconha - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2706422
    cmbCidadeEmitente.AddItem "Paripueira - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2706448
    cmbCidadeEmitente.AddItem "Passo de Camaragibe - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2706505
    cmbCidadeEmitente.AddItem "Paulo Jacinto - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2706604
    cmbCidadeEmitente.AddItem "Penedo - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2706703
    cmbCidadeEmitente.AddItem "Piacabucu - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2706802
    cmbCidadeEmitente.AddItem "Pilar - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2706901
    cmbCidadeEmitente.AddItem "Pindoba - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2707008
    cmbCidadeEmitente.AddItem "Piranhas - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2707107
    cmbCidadeEmitente.AddItem "Poco das Trincheiras - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2707206
    cmbCidadeEmitente.AddItem "Porto Calvo - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2707305
    cmbCidadeEmitente.AddItem "Porto de Pedras - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2707404
    cmbCidadeEmitente.AddItem "Porto Real do Colegio - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2707503
    cmbCidadeEmitente.AddItem "Quebrangulo - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2707602
    cmbCidadeEmitente.AddItem "Rio Largo - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2707701
    cmbCidadeEmitente.AddItem "Roteiro - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2707800
    cmbCidadeEmitente.AddItem "Santa Luzia do Norte - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2707909
    cmbCidadeEmitente.AddItem "Santana do Ipanema - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2708006
    cmbCidadeEmitente.AddItem "Santana do Mundau - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2708105
    cmbCidadeEmitente.AddItem "Sao Bras - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2708204
    cmbCidadeEmitente.AddItem "Sao Jose da Laje - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2708303
    cmbCidadeEmitente.AddItem "Sao Jose da Tapera - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2708402
    cmbCidadeEmitente.AddItem "Sao Luis do Quitunde - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2708501
    cmbCidadeEmitente.AddItem "Sao Miguel dos Campos - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2708600
    cmbCidadeEmitente.AddItem "Sao Miguel dos Milagres - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2708709
    cmbCidadeEmitente.AddItem "Sao Sebastiao - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2708808
    cmbCidadeEmitente.AddItem "Satuba - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2708907
    cmbCidadeEmitente.AddItem "Senador Rui Palmeira - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2708956
    cmbCidadeEmitente.AddItem "Tanque D Arca - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2709004
    cmbCidadeEmitente.AddItem "Taquarana - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2709103
    cmbCidadeEmitente.AddItem "Teotonio Vilela - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2709152
    cmbCidadeEmitente.AddItem "Traipu - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2709202
    cmbCidadeEmitente.AddItem "Uniao dos Palmares - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2709301
    cmbCidadeEmitente.AddItem "Vicosa - AL"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2709400
End Sub

Public Sub Sergipe(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Amparo de Sao Francisco - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2800100
    cmbCidadeEmitente.AddItem "Aquidaba - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2800209
    cmbCidadeEmitente.AddItem "Aracaju - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2800308
    cmbCidadeEmitente.AddItem "Araua - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2800407
    cmbCidadeEmitente.AddItem "Areia Branca - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2800506
    cmbCidadeEmitente.AddItem "Barra dos Coqueiros - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2800605
    cmbCidadeEmitente.AddItem "Boquim - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2800670
    cmbCidadeEmitente.AddItem "Brejo Grande - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2800704
    cmbCidadeEmitente.AddItem "Campo do Brito - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2801009
    cmbCidadeEmitente.AddItem "Canhoba - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2801108
    cmbCidadeEmitente.AddItem "Caninde de Sao Francisco - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2801207
    cmbCidadeEmitente.AddItem "Capela - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2801306
    cmbCidadeEmitente.AddItem "Carira - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2801405
    cmbCidadeEmitente.AddItem "Carmopolis - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2801504
    cmbCidadeEmitente.AddItem "Cedro de Sao Joao - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2801603
    cmbCidadeEmitente.AddItem "Cristinapolis - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2801702
    cmbCidadeEmitente.AddItem "Cumbe - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2801900
    cmbCidadeEmitente.AddItem "Divina Pastora - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2802007
    cmbCidadeEmitente.AddItem "Estancia - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2802106
    cmbCidadeEmitente.AddItem "Feira Nova - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2802205
    cmbCidadeEmitente.AddItem "Frei Paulo - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2802304
    cmbCidadeEmitente.AddItem "Gararu - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2802403
    cmbCidadeEmitente.AddItem "General Maynard - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2802502
    cmbCidadeEmitente.AddItem "Gracho Cardoso - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2802601
    cmbCidadeEmitente.AddItem "Ilha das Flores - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2802700
    cmbCidadeEmitente.AddItem "Indiaroba - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2802809
    cmbCidadeEmitente.AddItem "Itabaiana - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2802908
    cmbCidadeEmitente.AddItem "Itabaianinha - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2803005
    cmbCidadeEmitente.AddItem "Itabi - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2803104
    cmbCidadeEmitente.AddItem "Itaporanga D Ajuda - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2803203
    cmbCidadeEmitente.AddItem "Japaratuba - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2803302
    cmbCidadeEmitente.AddItem "Japoata - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2803401
    cmbCidadeEmitente.AddItem "Lagarto - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2803500
    cmbCidadeEmitente.AddItem "Laranjeiras - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2803609
    cmbCidadeEmitente.AddItem "Macambira - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2803708
    cmbCidadeEmitente.AddItem "Malhada dos Bois - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2803807
    cmbCidadeEmitente.AddItem "Malhador - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2803906
    cmbCidadeEmitente.AddItem "Maruim - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2804003
    cmbCidadeEmitente.AddItem "Moita Bonita - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2804102
    cmbCidadeEmitente.AddItem "Monte Alegre de Sergipe - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2804201
    cmbCidadeEmitente.AddItem "Muribeca - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2804300
    cmbCidadeEmitente.AddItem "Neopolis - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2804409
    cmbCidadeEmitente.AddItem "Nossa Senhora Aparecida - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2804458
    cmbCidadeEmitente.AddItem "Nossa Senhora da Gloria - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2804508
    cmbCidadeEmitente.AddItem "Nossa Senhora das Dores - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2804607
    cmbCidadeEmitente.AddItem "Nossa Senhora de Lourdes - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2804706
    cmbCidadeEmitente.AddItem "Nossa Senhora do Socorro - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2804805
    cmbCidadeEmitente.AddItem "Pacatuba - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2804904
    cmbCidadeEmitente.AddItem "Pedra Mole - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2805000
    cmbCidadeEmitente.AddItem "Pedrinhas - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2805109
    cmbCidadeEmitente.AddItem "Pinhao - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2805208
    cmbCidadeEmitente.AddItem "Pirambu - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2805307
    cmbCidadeEmitente.AddItem "Poco Redondo - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2805406
    cmbCidadeEmitente.AddItem "Poco Verde - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2805505
    cmbCidadeEmitente.AddItem "Porto da Folha - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2805604
    cmbCidadeEmitente.AddItem "Propria - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2805703
    cmbCidadeEmitente.AddItem "Riachao do Dantas - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2805802
    cmbCidadeEmitente.AddItem "Riachuelo - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2805901
    cmbCidadeEmitente.AddItem "Ribeiropolis - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2806008
    cmbCidadeEmitente.AddItem "Rosario do Catete - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2806107
    cmbCidadeEmitente.AddItem "Salgado - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2806206
    cmbCidadeEmitente.AddItem "Santa Luzia do Itanhy - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2806305
    cmbCidadeEmitente.AddItem "Santa Rosa de Lima - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2806503
    cmbCidadeEmitente.AddItem "Santana do Sao Francisco - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2806404
    cmbCidadeEmitente.AddItem "Santo Amaro das Brotas - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2806602
    cmbCidadeEmitente.AddItem "Sao Cristovao - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2806701
    cmbCidadeEmitente.AddItem "Sao Domingos - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2806800
    cmbCidadeEmitente.AddItem "Sao Francisco - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2806909
    cmbCidadeEmitente.AddItem "Sao Miguel do Aleixo - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2807006
    cmbCidadeEmitente.AddItem "Simao Dias - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2807105
    cmbCidadeEmitente.AddItem "Siriri - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2807204
    cmbCidadeEmitente.AddItem "Telha - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2807303
    cmbCidadeEmitente.AddItem "Tobias Barreto - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2807402
    cmbCidadeEmitente.AddItem "Tomar do Geru - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2807501
    cmbCidadeEmitente.AddItem "Umbauba - SE"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2807600
End Sub

Public Sub Bahia(ByRef cmbCidadeEmitente As ComboBox)
    Bahia1 cmbCidadeEmitente
    Bahia2 cmbCidadeEmitente
    Bahia3 cmbCidadeEmitente
End Sub

Private Sub Bahia1(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Abaira - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2900108
    cmbCidadeEmitente.AddItem "Abare - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2900207
    cmbCidadeEmitente.AddItem "Acajutiba - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2900306
    cmbCidadeEmitente.AddItem "Adustina - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2900355
    cmbCidadeEmitente.AddItem "Agua Fria - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2900405
    cmbCidadeEmitente.AddItem "Aiquara - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2900603
    cmbCidadeEmitente.AddItem "Alagoinhas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2900702
    cmbCidadeEmitente.AddItem "Alcobaca - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2900801
    cmbCidadeEmitente.AddItem "Almadina - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2900900
    cmbCidadeEmitente.AddItem "Amargosa - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2901007
    cmbCidadeEmitente.AddItem "Amelia Rodrigues - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2901106
    cmbCidadeEmitente.AddItem "America Dourada - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2901155
    cmbCidadeEmitente.AddItem "Anage - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2901205
    cmbCidadeEmitente.AddItem "Andarai - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2901304
    cmbCidadeEmitente.AddItem "Andorinha - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2901353
    cmbCidadeEmitente.AddItem "Angical - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2901403
    cmbCidadeEmitente.AddItem "Anguera - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2901502
    cmbCidadeEmitente.AddItem "Antas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2901601
    cmbCidadeEmitente.AddItem "Antonio Cardoso - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2901700
    cmbCidadeEmitente.AddItem "Antonio Goncalves - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2901809
    cmbCidadeEmitente.AddItem "Apora - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2901908
    cmbCidadeEmitente.AddItem "Apuarema - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2901957
    cmbCidadeEmitente.AddItem "Aracas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2902054
    cmbCidadeEmitente.AddItem "Aracatu - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2902005
    cmbCidadeEmitente.AddItem "Araci - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2902104
    cmbCidadeEmitente.AddItem "Aramari - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2902203
    cmbCidadeEmitente.AddItem "Arataca - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2902252
    cmbCidadeEmitente.AddItem "Aratuipe - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2902302
    cmbCidadeEmitente.AddItem "Aurelino Leal - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2902401
    cmbCidadeEmitente.AddItem "Baianopolis - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2902500
    cmbCidadeEmitente.AddItem "Baixa Grande - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2902609
    cmbCidadeEmitente.AddItem "Banzae - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2902658
    cmbCidadeEmitente.AddItem "Barra - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2902708
    cmbCidadeEmitente.AddItem "Barra da Estiva - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2902807
    cmbCidadeEmitente.AddItem "Barra do Choca - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2902906
    cmbCidadeEmitente.AddItem "Barra do Mendes - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2903003
    cmbCidadeEmitente.AddItem "Barra do Rocha - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2903102
    cmbCidadeEmitente.AddItem "Barreiras - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2903201
    cmbCidadeEmitente.AddItem "Barro Alto - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2903235
    cmbCidadeEmitente.AddItem "Barro Preto - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2903300
    cmbCidadeEmitente.AddItem "Barrocas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2903276
    cmbCidadeEmitente.AddItem "Belmonte - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2903409
    cmbCidadeEmitente.AddItem "Belo Campo - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2903508
    cmbCidadeEmitente.AddItem "Biritinga - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2903607
    cmbCidadeEmitente.AddItem "Boa Nova - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2903706
    cmbCidadeEmitente.AddItem "Boa Vista do Tupim - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2903805
    cmbCidadeEmitente.AddItem "Bom Jesus da Lapa - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2903904
    cmbCidadeEmitente.AddItem "Bom Jesus da Serra - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2903953
    cmbCidadeEmitente.AddItem "Boninal - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2904001
    cmbCidadeEmitente.AddItem "Bonito - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2904050
    cmbCidadeEmitente.AddItem "Boquira - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2904100
    cmbCidadeEmitente.AddItem "Botupora - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2904209
    cmbCidadeEmitente.AddItem "Brejoes - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2904308
    cmbCidadeEmitente.AddItem "Brejolandia - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2904407
    cmbCidadeEmitente.AddItem "Brotas de Macaubas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2904506
    cmbCidadeEmitente.AddItem "Brumado - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2904605
    cmbCidadeEmitente.AddItem "Buerarema - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2904704
    cmbCidadeEmitente.AddItem "Buritirama - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2904753
    cmbCidadeEmitente.AddItem "Caatiba - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2904803
    cmbCidadeEmitente.AddItem "Cabaceiras do Paraguacu - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2904852
    cmbCidadeEmitente.AddItem "Cachoeira - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2904902
    cmbCidadeEmitente.AddItem "Cacule - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2905008
    cmbCidadeEmitente.AddItem "Caem - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2905107
    cmbCidadeEmitente.AddItem "Caetanos - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2905156
    cmbCidadeEmitente.AddItem "Caetite - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2905206
    cmbCidadeEmitente.AddItem "Cafarnaum - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2905305
    cmbCidadeEmitente.AddItem "Cairu - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2905404
    cmbCidadeEmitente.AddItem "Caldeirao Grande - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2905503
    cmbCidadeEmitente.AddItem "Camacan - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2905602
    cmbCidadeEmitente.AddItem "Camacari - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2905701
    cmbCidadeEmitente.AddItem "Camamu - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2905800
    cmbCidadeEmitente.AddItem "Campo Alegre de Lourdes - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2905909
    cmbCidadeEmitente.AddItem "Campo Formoso - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2906006
    cmbCidadeEmitente.AddItem "Canapolis - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2906105
    cmbCidadeEmitente.AddItem "Canarana - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2906204
    cmbCidadeEmitente.AddItem "Canavieiras - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2906303
    cmbCidadeEmitente.AddItem "Candeal - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2906402
    cmbCidadeEmitente.AddItem "Candeias - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2906501
    cmbCidadeEmitente.AddItem "Candiba - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2906600
    cmbCidadeEmitente.AddItem "Candido Sales - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2906709
    cmbCidadeEmitente.AddItem "Cansancao - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2906808
    cmbCidadeEmitente.AddItem "Canudos - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2906824
    cmbCidadeEmitente.AddItem "Capela do Alto Alegre - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2906857
    cmbCidadeEmitente.AddItem "Capim Grosso - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2906873
    cmbCidadeEmitente.AddItem "Caraibas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2906899
    cmbCidadeEmitente.AddItem "Caravelas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2906907
    cmbCidadeEmitente.AddItem "Cardeal da Silva - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2907004
    cmbCidadeEmitente.AddItem "Carinhanha - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2907103
    cmbCidadeEmitente.AddItem "Casa Nova - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2907202
    cmbCidadeEmitente.AddItem "Castro Alves - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2907301
    cmbCidadeEmitente.AddItem "Catolandia - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2907400
    cmbCidadeEmitente.AddItem "Catu - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2907509
    cmbCidadeEmitente.AddItem "Caturama - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2907558
    cmbCidadeEmitente.AddItem "Central - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2907608
    cmbCidadeEmitente.AddItem "Chorrocho - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2907707
    cmbCidadeEmitente.AddItem "Cicero Dantas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2907806
    cmbCidadeEmitente.AddItem "Cipo - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2907905
    cmbCidadeEmitente.AddItem "Coaraci - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2908002
    cmbCidadeEmitente.AddItem "Cocos - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2908101
    cmbCidadeEmitente.AddItem "Conceicao da Feira - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2908200
    cmbCidadeEmitente.AddItem "Conceicao do Almeida - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2908309
    cmbCidadeEmitente.AddItem "Conceicao do Coite - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2908408
    cmbCidadeEmitente.AddItem "Conceicao do Jacuipe - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2908507
    cmbCidadeEmitente.AddItem "Conde - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2908606
    cmbCidadeEmitente.AddItem "Condeuba - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2908705
    cmbCidadeEmitente.AddItem "Contendas do Sincora - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2908804
    cmbCidadeEmitente.AddItem "Coracao de Maria - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2908903
    cmbCidadeEmitente.AddItem "Cordeiros - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2909000
    cmbCidadeEmitente.AddItem "Coribe - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2909109
    cmbCidadeEmitente.AddItem "Coronel Joao Sa - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2909208
    cmbCidadeEmitente.AddItem "Correntina - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2909307
    cmbCidadeEmitente.AddItem "Cotegipe - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2909406
    cmbCidadeEmitente.AddItem "Cravolandia - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2909505
    cmbCidadeEmitente.AddItem "Crisopolis - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2909604
    cmbCidadeEmitente.AddItem "Cristopolis - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2909703
    cmbCidadeEmitente.AddItem "Cruz das Almas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2909802
    cmbCidadeEmitente.AddItem "Curaca - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2909901
    cmbCidadeEmitente.AddItem "Dario Meira - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2910008
    cmbCidadeEmitente.AddItem "Dias D Avila - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2910057
    cmbCidadeEmitente.AddItem "Dom Basilio - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2910107
    cmbCidadeEmitente.AddItem "Dom Macedo Costa - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2910206
    cmbCidadeEmitente.AddItem "Elisio Medrado - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2910305
    cmbCidadeEmitente.AddItem "Encruzilhada - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2910404
    cmbCidadeEmitente.AddItem "Entre Rios - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2910503
    cmbCidadeEmitente.AddItem "Erico Cardoso - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2900504
    cmbCidadeEmitente.AddItem "Esplanada - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2910602
    cmbCidadeEmitente.AddItem "Euclides da Cunha - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2910701
    cmbCidadeEmitente.AddItem "Eunapolis - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2910727
    cmbCidadeEmitente.AddItem "Fatima - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2910750
    cmbCidadeEmitente.AddItem "Feira da Mata - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2910776
    cmbCidadeEmitente.AddItem "Feira de Santana - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2910800
    cmbCidadeEmitente.AddItem "Filadelfia - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2910859
    cmbCidadeEmitente.AddItem "Firmino Alves - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2910909
    cmbCidadeEmitente.AddItem "Floresta Azul - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2911006
    cmbCidadeEmitente.AddItem "Formosa do Rio Preto - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2911105
    cmbCidadeEmitente.AddItem "Gandu - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2911204
    cmbCidadeEmitente.AddItem "Gaviao - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2911253
    cmbCidadeEmitente.AddItem "Gentio do Ouro - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2911303
    cmbCidadeEmitente.AddItem "Gloria - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2911402
    cmbCidadeEmitente.AddItem "Gongogi - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2911501
    cmbCidadeEmitente.AddItem "Governador Mangabeira - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2911600
    cmbCidadeEmitente.AddItem "Guajeru - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2911659
    cmbCidadeEmitente.AddItem "Guanambi - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2911709
    cmbCidadeEmitente.AddItem "Guaratinga - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2911808
    cmbCidadeEmitente.AddItem "Heliopolis - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2911857
    cmbCidadeEmitente.AddItem "Iacu - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2911907
    cmbCidadeEmitente.AddItem "Ibiassuce - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2912004
    cmbCidadeEmitente.AddItem "Ibicarai - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2912103
    cmbCidadeEmitente.AddItem "Ibicoara - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2912202
    cmbCidadeEmitente.AddItem "Ibicui - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2912301
End Sub

Private Sub Bahia2(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Ibipeba - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2912400
    cmbCidadeEmitente.AddItem "Ibipitanga - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2912509
    cmbCidadeEmitente.AddItem "Ibiquera - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2912608
    cmbCidadeEmitente.AddItem "Ibirapitanga - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2912707
    cmbCidadeEmitente.AddItem "Ibirapua - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2912806
    cmbCidadeEmitente.AddItem "Ibirataia - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2912905
    cmbCidadeEmitente.AddItem "Ibitiara - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2913002
    cmbCidadeEmitente.AddItem "Ibitita - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2913101
    cmbCidadeEmitente.AddItem "Ibotirama - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2913200
    cmbCidadeEmitente.AddItem "Ichu - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2913309
    cmbCidadeEmitente.AddItem "Igapora - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2913408
    cmbCidadeEmitente.AddItem "Igrapiuna - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2913457
    cmbCidadeEmitente.AddItem "Iguai - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2913507
    cmbCidadeEmitente.AddItem "Ilheus - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2913606
    cmbCidadeEmitente.AddItem "Inhambupe - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2913705
    cmbCidadeEmitente.AddItem "Ipecaeta - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2913804
    cmbCidadeEmitente.AddItem "Ipiau - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2913903
    cmbCidadeEmitente.AddItem "Ipira - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2914000
    cmbCidadeEmitente.AddItem "Ipupiara - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2914109
    cmbCidadeEmitente.AddItem "Irajuba - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2914208
    cmbCidadeEmitente.AddItem "Iramaia - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2914307
    cmbCidadeEmitente.AddItem "Iraquara - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2914406
    cmbCidadeEmitente.AddItem "Irara - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2914505
    cmbCidadeEmitente.AddItem "Irece - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2914604
    cmbCidadeEmitente.AddItem "Itabela - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2914653
    cmbCidadeEmitente.AddItem "Itaberaba - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2914703
    cmbCidadeEmitente.AddItem "Itabuna - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2914802
    cmbCidadeEmitente.AddItem "Itacare - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2914901
    cmbCidadeEmitente.AddItem "Itaete - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2915007
    cmbCidadeEmitente.AddItem "Itagi - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2915106
    cmbCidadeEmitente.AddItem "Itagiba - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2915205
    cmbCidadeEmitente.AddItem "Itagimirim - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2915304
    cmbCidadeEmitente.AddItem "Itaguacu da Bahia - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2915353
    cmbCidadeEmitente.AddItem "Itaju do Colonia - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2915403
    cmbCidadeEmitente.AddItem "Itajuipe - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2915502
    cmbCidadeEmitente.AddItem "Itamaraju - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2915601
    cmbCidadeEmitente.AddItem "Itamari - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2915700
    cmbCidadeEmitente.AddItem "Itambe - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2915809
    cmbCidadeEmitente.AddItem "Itanagra - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2915908
    cmbCidadeEmitente.AddItem "Itanhem - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2916005
    cmbCidadeEmitente.AddItem "Itaparica - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2916104
    cmbCidadeEmitente.AddItem "Itape - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2916203
    cmbCidadeEmitente.AddItem "Itapebi - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2916302
    cmbCidadeEmitente.AddItem "Itapetinga - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2916401
    cmbCidadeEmitente.AddItem "Itapicuru - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2916500
    cmbCidadeEmitente.AddItem "Itapitanga - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2916609
    cmbCidadeEmitente.AddItem "Itaquara - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2916708
    cmbCidadeEmitente.AddItem "Itarantim - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2916807
    cmbCidadeEmitente.AddItem "Itatim - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2916856
    cmbCidadeEmitente.AddItem "Itirucu - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2916906
    cmbCidadeEmitente.AddItem "Itiuba - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2917003
    cmbCidadeEmitente.AddItem "Itororo - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2917102
    cmbCidadeEmitente.AddItem "Ituacu - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2917201
    cmbCidadeEmitente.AddItem "Itubera - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2917300
    cmbCidadeEmitente.AddItem "Iuiu - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2917334
    cmbCidadeEmitente.AddItem "Jaborandi - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2917359
    cmbCidadeEmitente.AddItem "Jacaraci - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2917409
    cmbCidadeEmitente.AddItem "Jacobina - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2917508
    cmbCidadeEmitente.AddItem "Jaguaquara - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2917607
    cmbCidadeEmitente.AddItem "Jaguarari - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2917706
    cmbCidadeEmitente.AddItem "Jaguaripe - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2917805
    cmbCidadeEmitente.AddItem "Jandaira - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2917904
    cmbCidadeEmitente.AddItem "Jequie - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2918001
    cmbCidadeEmitente.AddItem "Jeremoabo - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2918100
    cmbCidadeEmitente.AddItem "Jiquirica - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2918209
    cmbCidadeEmitente.AddItem "Jitauna - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2918308
    cmbCidadeEmitente.AddItem "Joao Dourado - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2918357
    cmbCidadeEmitente.AddItem "Juazeiro - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2918407
    cmbCidadeEmitente.AddItem "Jucurucu - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2918456
    cmbCidadeEmitente.AddItem "Jussara - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2918506
    cmbCidadeEmitente.AddItem "Jussari - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2918555
    cmbCidadeEmitente.AddItem "Jussiape - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2918605
    cmbCidadeEmitente.AddItem "Lafaiete Coutinho - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2918704
    cmbCidadeEmitente.AddItem "Lagoa Real - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2918753
    cmbCidadeEmitente.AddItem "Laje - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2918803
    cmbCidadeEmitente.AddItem "Lajedao - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2918902
    cmbCidadeEmitente.AddItem "Lajedinho - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2919009
    cmbCidadeEmitente.AddItem "Lajedo do Tabocal - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2919058
    cmbCidadeEmitente.AddItem "Lamarao - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2919108
    cmbCidadeEmitente.AddItem "Lapao - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2919157
    cmbCidadeEmitente.AddItem "Lauro de Freitas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2919207
    cmbCidadeEmitente.AddItem "Lencois - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2919306
    cmbCidadeEmitente.AddItem "Licinio de Almeida - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2919405
    cmbCidadeEmitente.AddItem "Livramento de Nossa Senhora - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2919504
    cmbCidadeEmitente.AddItem "Luiz Eduardo Magalhaes - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2919553
    cmbCidadeEmitente.AddItem "Macajuba - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2919603
    cmbCidadeEmitente.AddItem "Macarani - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2919702
    cmbCidadeEmitente.AddItem "Macaubas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2919801
    cmbCidadeEmitente.AddItem "Macurure - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2919900
    cmbCidadeEmitente.AddItem "Madre de Deus - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2919926
    cmbCidadeEmitente.AddItem "Maetinga - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2919959
    cmbCidadeEmitente.AddItem "Maiquinique - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2920007
    cmbCidadeEmitente.AddItem "Mairi - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2920106
    cmbCidadeEmitente.AddItem "Malhada - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2920205
    cmbCidadeEmitente.AddItem "Malhada de Pedras - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2920304
    cmbCidadeEmitente.AddItem "Manoel Vitorino - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2920403
    cmbCidadeEmitente.AddItem "Mansidao - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2920452
    cmbCidadeEmitente.AddItem "Maracas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2920502
    cmbCidadeEmitente.AddItem "Maragogipe - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2920601
    cmbCidadeEmitente.AddItem "Marau - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2920700
    cmbCidadeEmitente.AddItem "Marcionilio Souza - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2920809
    cmbCidadeEmitente.AddItem "Mascote - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2920908
    cmbCidadeEmitente.AddItem "Mata de Sao Joao - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2921005
    cmbCidadeEmitente.AddItem "Matina - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2921054
    cmbCidadeEmitente.AddItem "Medeiros Neto - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2921104
    cmbCidadeEmitente.AddItem "Miguel Calmon - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2921203
    cmbCidadeEmitente.AddItem "Milagres - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2921302
    cmbCidadeEmitente.AddItem "Mirangaba - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2921401
    cmbCidadeEmitente.AddItem "Mirante - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2921450
    cmbCidadeEmitente.AddItem "Monte Santo - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2921500
    cmbCidadeEmitente.AddItem "Morpara - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2921609
    cmbCidadeEmitente.AddItem "Morro do Chapeu - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2921708
    cmbCidadeEmitente.AddItem "Mortugaba - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2921807
    cmbCidadeEmitente.AddItem "Mucuge - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2921906
    cmbCidadeEmitente.AddItem "Mucuri - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2922003
    cmbCidadeEmitente.AddItem "Mulungu do Morro - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2922052
    cmbCidadeEmitente.AddItem "Mundo Novo - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2922102
    cmbCidadeEmitente.AddItem "Muniz Ferreira - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2922201
    cmbCidadeEmitente.AddItem "Muquem de Sao Francisco - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2922250
    cmbCidadeEmitente.AddItem "Muritiba - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2922300
    cmbCidadeEmitente.AddItem "Mutuipe - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2922409
    cmbCidadeEmitente.AddItem "Nazare - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2922508
    cmbCidadeEmitente.AddItem "Nilo Pecanha - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2922607
    cmbCidadeEmitente.AddItem "Nordestina - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2922656
    cmbCidadeEmitente.AddItem "Nova Canaa - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2922706
    cmbCidadeEmitente.AddItem "Nova Fatima - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2922730
    cmbCidadeEmitente.AddItem "Nova Ibia - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2922755
    cmbCidadeEmitente.AddItem "Nova Itarana - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2922805
    cmbCidadeEmitente.AddItem "Nova Redencao - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2922854
    cmbCidadeEmitente.AddItem "Nova Soure - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2922904
    cmbCidadeEmitente.AddItem "Nova Vicosa - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2923001
    cmbCidadeEmitente.AddItem "Novo Horizonte - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2923035
    cmbCidadeEmitente.AddItem "Novo Triunfo - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2923050
    cmbCidadeEmitente.AddItem "Olindina - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2923100
    cmbCidadeEmitente.AddItem "Oliveira dos Brejinhos - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2923209
    cmbCidadeEmitente.AddItem "Ouricangas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2923308
    cmbCidadeEmitente.AddItem "Ourolandia - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2923357
    cmbCidadeEmitente.AddItem "Palmas de Monte Alto - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2923407
    cmbCidadeEmitente.AddItem "Palmeiras - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2923506
    cmbCidadeEmitente.AddItem "Paramirim - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2923605
    cmbCidadeEmitente.AddItem "Paratinga - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2923704
    cmbCidadeEmitente.AddItem "Paripiranga - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2923803
    cmbCidadeEmitente.AddItem "Pau Brasil - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2923902
    cmbCidadeEmitente.AddItem "Paulo Afonso - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2924009
    cmbCidadeEmitente.AddItem "Pe de Serra - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2924058
    cmbCidadeEmitente.AddItem "Pedrao - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2924108
    cmbCidadeEmitente.AddItem "Pedro Alexandre - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2924207
    cmbCidadeEmitente.AddItem "Piata - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2924306
    cmbCidadeEmitente.AddItem "Pilao Arcado - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2924405
    cmbCidadeEmitente.AddItem "Pindai - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2924504
End Sub

Private Sub Bahia3(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Pindobacu - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2924603
    cmbCidadeEmitente.AddItem "Pintadas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2924652
    cmbCidadeEmitente.AddItem "Pirai do Norte - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2924678
    cmbCidadeEmitente.AddItem "Piripa - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2924702
    cmbCidadeEmitente.AddItem "Piritiba - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2924801
    cmbCidadeEmitente.AddItem "Planaltino - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2924900
    cmbCidadeEmitente.AddItem "Planalto - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2925006
    cmbCidadeEmitente.AddItem "Pocoes - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2925105
    cmbCidadeEmitente.AddItem "Pojuca - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2925204
    cmbCidadeEmitente.AddItem "Ponto Novo - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2925253
    cmbCidadeEmitente.AddItem "Porto Seguro - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2925303
    cmbCidadeEmitente.AddItem "Potiragua - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2925402
    cmbCidadeEmitente.AddItem "Prado - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2925501
    cmbCidadeEmitente.AddItem "Presidente Dutra - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2925600
    cmbCidadeEmitente.AddItem "Presidente Janio Quadros - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2925709
    cmbCidadeEmitente.AddItem "Presidente Tancredo Neves - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2925758
    cmbCidadeEmitente.AddItem "Queimadas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2925808
    cmbCidadeEmitente.AddItem "Quijingue - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2925907
    cmbCidadeEmitente.AddItem "Quixabeira - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2925931
    cmbCidadeEmitente.AddItem "Rafael Jambeiro - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2925956
    cmbCidadeEmitente.AddItem "Remanso - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2926004
    cmbCidadeEmitente.AddItem "Retirolandia - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2926103
    cmbCidadeEmitente.AddItem "Riachao das Neves - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2926202
    cmbCidadeEmitente.AddItem "Riachao do Jacuipe - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2926301
    cmbCidadeEmitente.AddItem "Riacho de Santana - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2926400
    cmbCidadeEmitente.AddItem "Ribeira do Amparo - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2926509
    cmbCidadeEmitente.AddItem "Ribeira do Pombal - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2926608
    cmbCidadeEmitente.AddItem "Ribeirao do Largo - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2926657
    cmbCidadeEmitente.AddItem "Rio de Contas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2926707
    cmbCidadeEmitente.AddItem "Rio do Antonio - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2926806
    cmbCidadeEmitente.AddItem "Rio do Pires - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2926905
    cmbCidadeEmitente.AddItem "Rio Real - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2927002
    cmbCidadeEmitente.AddItem "Rodelas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2927101
    cmbCidadeEmitente.AddItem "Ruy Barbosa - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2927200
    cmbCidadeEmitente.AddItem "Salinas da Margarida - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2927309
    cmbCidadeEmitente.AddItem "Salvador - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2927408
    cmbCidadeEmitente.AddItem "Santa Barbara - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2927507
    cmbCidadeEmitente.AddItem "Santa Brigida - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2927606
    cmbCidadeEmitente.AddItem "Santa Cruz Cabralia - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2927705
    cmbCidadeEmitente.AddItem "Santa Cruz da Vitoria - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2927804
    cmbCidadeEmitente.AddItem "Santa Ines - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2927903
    cmbCidadeEmitente.AddItem "Santa Luzia - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2928059
    cmbCidadeEmitente.AddItem "Santa Maria da Vitoria - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2928109
    cmbCidadeEmitente.AddItem "Santa Rita de Cassia - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2928406
    cmbCidadeEmitente.AddItem "Santa Teresinha - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2928505
    cmbCidadeEmitente.AddItem "Santaluz - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2928000
    cmbCidadeEmitente.AddItem "Santana - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2928208
    cmbCidadeEmitente.AddItem "Santanopolis - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2928307
    cmbCidadeEmitente.AddItem "Santo Amaro - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2928604
    cmbCidadeEmitente.AddItem "Santo Antonio de Jesus - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2928703
    cmbCidadeEmitente.AddItem "Santo Estevao - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2928802
    cmbCidadeEmitente.AddItem "Sao Desiderio - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2928901
    cmbCidadeEmitente.AddItem "Sao Domingos - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2928950
    cmbCidadeEmitente.AddItem "Sao Felipe - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2929107
    cmbCidadeEmitente.AddItem "Sao Felix - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2929008
    cmbCidadeEmitente.AddItem "Sao Felix do Coribe - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2929057
    cmbCidadeEmitente.AddItem "Sao Francisco do Conde - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2929206
    cmbCidadeEmitente.AddItem "Sao Gabriel - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2929255
    cmbCidadeEmitente.AddItem "Sao Goncalo dos Campos - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2929305
    cmbCidadeEmitente.AddItem "Sao Jose da Vitoria - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2929354
    cmbCidadeEmitente.AddItem "Sao Jose do Jacuipe - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2929370
    cmbCidadeEmitente.AddItem "Sao Miguel das Matas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2929404
    cmbCidadeEmitente.AddItem "Sao Sebastiao do Passe - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2929503
    cmbCidadeEmitente.AddItem "Sapeacu - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2929602
    cmbCidadeEmitente.AddItem "Satiro Dias - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2929701
    cmbCidadeEmitente.AddItem "Saubara - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2929750
    cmbCidadeEmitente.AddItem "Saude - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2929800
    cmbCidadeEmitente.AddItem "Seabra - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2929909
    cmbCidadeEmitente.AddItem "Sebastiao Laranjeiras - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2930006
    cmbCidadeEmitente.AddItem "Senhor do Bonfim - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2930105
    cmbCidadeEmitente.AddItem "Sento Se - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2930204
    cmbCidadeEmitente.AddItem "Serra do Ramalho - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2930154
    cmbCidadeEmitente.AddItem "Serra Dourada - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2930303
    cmbCidadeEmitente.AddItem "Serra Preta - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2930402
    cmbCidadeEmitente.AddItem "Serrinha - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2930501
    cmbCidadeEmitente.AddItem "Serrolandia - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2930600
    cmbCidadeEmitente.AddItem "Simoes Filho - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2930709
    cmbCidadeEmitente.AddItem "Sitio do Mato - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2930758
    cmbCidadeEmitente.AddItem "Sitio do Quinto - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2930766
    cmbCidadeEmitente.AddItem "Sobradinho - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2930774
    cmbCidadeEmitente.AddItem "Souto Soares - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2930808
    cmbCidadeEmitente.AddItem "Tabocas do Brejo Velho - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2930907
    cmbCidadeEmitente.AddItem "Tanhacu - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2931004
    cmbCidadeEmitente.AddItem "Tanque Novo - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2931053
    cmbCidadeEmitente.AddItem "Tanquinho - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2931103
    cmbCidadeEmitente.AddItem "Taperoa - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2931202
    cmbCidadeEmitente.AddItem "Tapiramuta - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2931301
    cmbCidadeEmitente.AddItem "Teixeira de Freitas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2931350
    cmbCidadeEmitente.AddItem "Teodoro Sampaio - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2931400
    cmbCidadeEmitente.AddItem "Teofilandia - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2931509
    cmbCidadeEmitente.AddItem "Teolandia - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2931608
    cmbCidadeEmitente.AddItem "Terra Nova - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2931707
    cmbCidadeEmitente.AddItem "Tremedal - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2931806
    cmbCidadeEmitente.AddItem "Tucano - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2931905
    cmbCidadeEmitente.AddItem "Uaua - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2932002
    cmbCidadeEmitente.AddItem "Ubaira - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2932101
    cmbCidadeEmitente.AddItem "Ubaitaba - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2932200
    cmbCidadeEmitente.AddItem "Ubata - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2932309
    cmbCidadeEmitente.AddItem "Uibai - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2932408
    cmbCidadeEmitente.AddItem "Umburanas - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2932457
    cmbCidadeEmitente.AddItem "Una - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2932507
    cmbCidadeEmitente.AddItem "Urandi - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2932606
    cmbCidadeEmitente.AddItem "Urucuca - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2932705
    cmbCidadeEmitente.AddItem "Utinga - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2932804
    cmbCidadeEmitente.AddItem "Valenca - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2932903
    cmbCidadeEmitente.AddItem "Valente - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2933000
    cmbCidadeEmitente.AddItem "Varzea da Roca - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2933059
    cmbCidadeEmitente.AddItem "Varzea do Poco - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2933109
    cmbCidadeEmitente.AddItem "Varzea Nova - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2933158
    cmbCidadeEmitente.AddItem "Varzedo - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2933174
    cmbCidadeEmitente.AddItem "Vera Cruz - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2933208
    cmbCidadeEmitente.AddItem "Vereda - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2933257
    cmbCidadeEmitente.AddItem "Vitoria da Conquista - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2933307
    cmbCidadeEmitente.AddItem "Wagner - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2933406
    cmbCidadeEmitente.AddItem "Wanderley - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2933455
    cmbCidadeEmitente.AddItem "Wenceslau Guimaraes - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2933505
    cmbCidadeEmitente.AddItem "Xique-Xique - BA"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 2933604
End Sub

Public Sub MinasGerais(ByRef cmbCidadeEmitente As ComboBox)
    MinasGerais1 cmbCidadeEmitente
    MinasGerais2 cmbCidadeEmitente
    MinasGerais3 cmbCidadeEmitente
    MinasGerais4 cmbCidadeEmitente
    MinasGerais5 cmbCidadeEmitente
    MinasGerais6 cmbCidadeEmitente
End Sub

Private Sub MinasGerais1(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Abadia dos Dourados - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3100104
    cmbCidadeEmitente.AddItem "Abaete - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3100203
    cmbCidadeEmitente.AddItem "Abre Campo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3100302
    cmbCidadeEmitente.AddItem "Acaiaca - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3100401
    cmbCidadeEmitente.AddItem "Acucena - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3100500
    cmbCidadeEmitente.AddItem "Agua Boa - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3100609
    cmbCidadeEmitente.AddItem "Agua Comprida - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3100708
    cmbCidadeEmitente.AddItem "Aguanil - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3100807
    cmbCidadeEmitente.AddItem "Aguas Formosas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3100906
    cmbCidadeEmitente.AddItem "Aguas Vermelhas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3101003
    cmbCidadeEmitente.AddItem "Aimores - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3101102
    cmbCidadeEmitente.AddItem "Aiuruoca - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3101201
    cmbCidadeEmitente.AddItem "Alagoa - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3101300
    cmbCidadeEmitente.AddItem "Albertina - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3101409
    cmbCidadeEmitente.AddItem "Alem Paraiba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3101508
    cmbCidadeEmitente.AddItem "Alfenas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3101607
    cmbCidadeEmitente.AddItem "Alfredo Vasconcelos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3101631
    cmbCidadeEmitente.AddItem "Almenara - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3101706
    cmbCidadeEmitente.AddItem "Alpercata - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3101805
    cmbCidadeEmitente.AddItem "Alpinopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3101904
    cmbCidadeEmitente.AddItem "Alterosa - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3102001
    cmbCidadeEmitente.AddItem "Alto Caparao - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3102050
    cmbCidadeEmitente.AddItem "Alto Jequitiba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3153509
    cmbCidadeEmitente.AddItem "Alto Rio Doce - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3102100
    cmbCidadeEmitente.AddItem "Alvarenga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3102209
    cmbCidadeEmitente.AddItem "Alvinopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3102308
    cmbCidadeEmitente.AddItem "Alvorada de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3102407
    cmbCidadeEmitente.AddItem "Amparo do Serra - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3102506
    cmbCidadeEmitente.AddItem "Andradas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3102605
    cmbCidadeEmitente.AddItem "Andrelandia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3102803
    cmbCidadeEmitente.AddItem "Angelandia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3102852
    cmbCidadeEmitente.AddItem "Antonio Carlos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3102902
    cmbCidadeEmitente.AddItem "Antonio Dias - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3103009
    cmbCidadeEmitente.AddItem "Antonio Prado de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3103108
    cmbCidadeEmitente.AddItem "Aracai - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3103207
    cmbCidadeEmitente.AddItem "Aracitaba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3103306
    cmbCidadeEmitente.AddItem "Aracuai - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3103405
    cmbCidadeEmitente.AddItem "Araguari - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3103504
    cmbCidadeEmitente.AddItem "Arantina - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3103603
    cmbCidadeEmitente.AddItem "Araponga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3103702
    cmbCidadeEmitente.AddItem "Arapora - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3103751
    cmbCidadeEmitente.AddItem "Arapua - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3103801
    cmbCidadeEmitente.AddItem "Araujos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3103900
    cmbCidadeEmitente.AddItem "Araxa - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3104007
    cmbCidadeEmitente.AddItem "Arceburgo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3104106
    cmbCidadeEmitente.AddItem "Arcos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3104205
    cmbCidadeEmitente.AddItem "Areado - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3104304
    cmbCidadeEmitente.AddItem "Argirita - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3104403
    cmbCidadeEmitente.AddItem "Aricanduva - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3104452
    cmbCidadeEmitente.AddItem "Arinos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3104502
    cmbCidadeEmitente.AddItem "Astolfo Dutra - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3104601
    cmbCidadeEmitente.AddItem "Ataleia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3104700
    cmbCidadeEmitente.AddItem "Augusto de Lima - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3104809
    cmbCidadeEmitente.AddItem "Baependi - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3104908
    cmbCidadeEmitente.AddItem "Baldim - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3105004
    cmbCidadeEmitente.AddItem "Bambui - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3105103
    cmbCidadeEmitente.AddItem "Bandeira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3105202
    cmbCidadeEmitente.AddItem "Bandeira do Sul - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3105301
    cmbCidadeEmitente.AddItem "Barao de Cocais - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3105400
    cmbCidadeEmitente.AddItem "Barao do Monte Alto - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3105509
    cmbCidadeEmitente.AddItem "Barbacena - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3105608
    cmbCidadeEmitente.AddItem "Barra Longa - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3105707
    cmbCidadeEmitente.AddItem "Barroso - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3105905
    cmbCidadeEmitente.AddItem "Bela Vista de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3106002
    cmbCidadeEmitente.AddItem "Belmiro Braga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3106101
    cmbCidadeEmitente.AddItem "Belo Horizonte - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3106200
    cmbCidadeEmitente.AddItem "Belo Oriente - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3106309
    cmbCidadeEmitente.AddItem "Belo Vale - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3106408
    cmbCidadeEmitente.AddItem "Berilo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3106507
    cmbCidadeEmitente.AddItem "Berizal - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3106655
    cmbCidadeEmitente.AddItem "Bertopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3106606
    cmbCidadeEmitente.AddItem "Betim - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3106705
    cmbCidadeEmitente.AddItem "Bias Fortes - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3106804
    cmbCidadeEmitente.AddItem "Bicas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3106903
    cmbCidadeEmitente.AddItem "Biquinhas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3107000
    cmbCidadeEmitente.AddItem "Boa Esperanca - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3107109
    cmbCidadeEmitente.AddItem "Bocaina de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3107208
    cmbCidadeEmitente.AddItem "Bocaiuva - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3107307
    cmbCidadeEmitente.AddItem "Bom Despacho - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3107406
    cmbCidadeEmitente.AddItem "Bom Jardim de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3107505
    cmbCidadeEmitente.AddItem "Bom Jesus da Penha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3107604
    cmbCidadeEmitente.AddItem "Bom Jesus do Amparo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3107703
    cmbCidadeEmitente.AddItem "Bom Jesus do Galho - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3107802
    cmbCidadeEmitente.AddItem "Bom Repouso - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3107901
    cmbCidadeEmitente.AddItem "Bom Sucesso - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3108008
    cmbCidadeEmitente.AddItem "Bonfim - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3108107
    cmbCidadeEmitente.AddItem "Bonfinopolis de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3108206
    cmbCidadeEmitente.AddItem "Bonito de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3108255
    cmbCidadeEmitente.AddItem "Borda da Mata - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3108305
    cmbCidadeEmitente.AddItem "Botelhos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3108404
    cmbCidadeEmitente.AddItem "Botumirim - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3108503
    cmbCidadeEmitente.AddItem "Bras Pires - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3108701
    cmbCidadeEmitente.AddItem "Brasilandia de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3108552
    cmbCidadeEmitente.AddItem "Brasilia de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3108602
    cmbCidadeEmitente.AddItem "Brasopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3108909
    cmbCidadeEmitente.AddItem "Braunas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3108800
    cmbCidadeEmitente.AddItem "Brumadinho - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3109006
    cmbCidadeEmitente.AddItem "Bueno Brandao - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3109105
    cmbCidadeEmitente.AddItem "Buenopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3109204
    cmbCidadeEmitente.AddItem "Bugre - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3109253
    cmbCidadeEmitente.AddItem "Buritis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3109303
    cmbCidadeEmitente.AddItem "Buritizeiro - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3109402
    cmbCidadeEmitente.AddItem "Cabeceira Grande - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3109451
    cmbCidadeEmitente.AddItem "Cabo Verde - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3109501
    cmbCidadeEmitente.AddItem "Cachoeira da Prata - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3109600
    cmbCidadeEmitente.AddItem "Cachoeira de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3109709
    cmbCidadeEmitente.AddItem "Cachoeira de Pajeu - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3102704
    cmbCidadeEmitente.AddItem "Cachoeira Dourada - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3109808
    cmbCidadeEmitente.AddItem "Caetanopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3109907
    cmbCidadeEmitente.AddItem "Caete - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3110004
    cmbCidadeEmitente.AddItem "Caiana - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3110103
    cmbCidadeEmitente.AddItem "Cajuri - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3110202
    cmbCidadeEmitente.AddItem "Caldas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3110301
    cmbCidadeEmitente.AddItem "Camacho - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3110400
    cmbCidadeEmitente.AddItem "Camanducaia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3110509
    cmbCidadeEmitente.AddItem "Cambui - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3110608
    cmbCidadeEmitente.AddItem "Cambuquira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3110707
    cmbCidadeEmitente.AddItem "Campanario - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3110806
    cmbCidadeEmitente.AddItem "Campanha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3110905
    cmbCidadeEmitente.AddItem "Campestre - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3111002
    cmbCidadeEmitente.AddItem "Campina Verde - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3111101
    cmbCidadeEmitente.AddItem "Campo Azul - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3111150
    cmbCidadeEmitente.AddItem "Campo Belo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3111200
    cmbCidadeEmitente.AddItem "Campo do Meio - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3111309
    cmbCidadeEmitente.AddItem "Campo Florido - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3111408
    cmbCidadeEmitente.AddItem "Campos Altos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3111507
    cmbCidadeEmitente.AddItem "Campos Gerais - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3111606
    cmbCidadeEmitente.AddItem "Cana Verde - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3111903
    cmbCidadeEmitente.AddItem "Canaa - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3111705
    cmbCidadeEmitente.AddItem "Canapolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3111804
    cmbCidadeEmitente.AddItem "Candeias - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3112000
    cmbCidadeEmitente.AddItem "Cantagalo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3112059
    cmbCidadeEmitente.AddItem "Caparao - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3112109
    cmbCidadeEmitente.AddItem "Capela Nova - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3112208
    cmbCidadeEmitente.AddItem "Capelinha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3112307
    cmbCidadeEmitente.AddItem "Capetinga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3112406
    cmbCidadeEmitente.AddItem "Capim Branco - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3112505
    cmbCidadeEmitente.AddItem "Capinopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3112604
    cmbCidadeEmitente.AddItem "Capitao Andrade - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3112653
    cmbCidadeEmitente.AddItem "Capitao Eneas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3112703
    cmbCidadeEmitente.AddItem "Capitolio - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3112802
    cmbCidadeEmitente.AddItem "Caputira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3112901
    cmbCidadeEmitente.AddItem "Carai - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3113008
    cmbCidadeEmitente.AddItem "Caranaiba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3113107
    cmbCidadeEmitente.AddItem "Carandai - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3113206
    cmbCidadeEmitente.AddItem "Carangola - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3113305
    cmbCidadeEmitente.AddItem "Caratinga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3113404
    cmbCidadeEmitente.AddItem "Carbonita - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3113503
    cmbCidadeEmitente.AddItem "Careacu - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3113602
    cmbCidadeEmitente.AddItem "Carlos Chagas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3113701
End Sub

Private Sub MinasGerais2(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Carmesia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3113800
    cmbCidadeEmitente.AddItem "Carmo da Cachoeira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3113909
    cmbCidadeEmitente.AddItem "Carmo da Mata - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3114006
    cmbCidadeEmitente.AddItem "Carmo de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3114105
    cmbCidadeEmitente.AddItem "Carmo do Cajuru - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3114204
    cmbCidadeEmitente.AddItem "Carmo do Paranaiba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3114303
    cmbCidadeEmitente.AddItem "Carmo do Rio Claro - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3114402
    cmbCidadeEmitente.AddItem "Carmopolis de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3114501
    cmbCidadeEmitente.AddItem "Carneirinho - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3114550
    cmbCidadeEmitente.AddItem "Carrancas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3114600
    cmbCidadeEmitente.AddItem "Carvalhopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3114709
    cmbCidadeEmitente.AddItem "Carvalhos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3114808
    cmbCidadeEmitente.AddItem "Casa Grande - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3114907
    cmbCidadeEmitente.AddItem "Cascalho Rico - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3115003
    cmbCidadeEmitente.AddItem "Cassia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3115102
    cmbCidadeEmitente.AddItem "Cataguases - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3115300
    cmbCidadeEmitente.AddItem "Catas Altas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3115359
    cmbCidadeEmitente.AddItem "Catas Altas da Noruega - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3115409
    cmbCidadeEmitente.AddItem "Catuji - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3115458
    cmbCidadeEmitente.AddItem "Catuti - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3115474
    cmbCidadeEmitente.AddItem "Caxambu - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3115508
    cmbCidadeEmitente.AddItem "Cedro do Abaete - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3115607
    cmbCidadeEmitente.AddItem "Central de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3115706
    cmbCidadeEmitente.AddItem "Centralina - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3115805
    cmbCidadeEmitente.AddItem "Chacara - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3115904
    cmbCidadeEmitente.AddItem "Chale - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3116001
    cmbCidadeEmitente.AddItem "Chapada do Norte - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3116100
    cmbCidadeEmitente.AddItem "Chapada Gaucha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3116159
    cmbCidadeEmitente.AddItem "Chiador - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3116209
    cmbCidadeEmitente.AddItem "Cipotanea - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3116308
    cmbCidadeEmitente.AddItem "Claraval - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3116407
    cmbCidadeEmitente.AddItem "Claro dos Pocoes - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3116506
    cmbCidadeEmitente.AddItem "Claudio - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3116605
    cmbCidadeEmitente.AddItem "Coimbra - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3116704
    cmbCidadeEmitente.AddItem "Coluna - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3116803
    cmbCidadeEmitente.AddItem "Comendador Gomes - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3116902
    cmbCidadeEmitente.AddItem "Comercinho - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3117009
    cmbCidadeEmitente.AddItem "Conceicao da Aparecida - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3117108
    cmbCidadeEmitente.AddItem "Conceicao da Barra de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3115201
    cmbCidadeEmitente.AddItem "Conceicao das Alagoas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3117306
    cmbCidadeEmitente.AddItem "Conceicao das Pedras - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3117207
    cmbCidadeEmitente.AddItem "Conceicao de Ipanema - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3117405
    cmbCidadeEmitente.AddItem "Conceicao do Mato Dentro - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3117504
    cmbCidadeEmitente.AddItem "Conceicao do Para - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3117603
    cmbCidadeEmitente.AddItem "Conceicao do Rio Verde - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3117702
    cmbCidadeEmitente.AddItem "Conceicao dos Ouros - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3117801
    cmbCidadeEmitente.AddItem "Conego Marinho - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3117836
    cmbCidadeEmitente.AddItem "Confins - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3117876
    cmbCidadeEmitente.AddItem "Congonhal - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3117900
    cmbCidadeEmitente.AddItem "Congonhas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3118007
    cmbCidadeEmitente.AddItem "Congonhas do Norte - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3118106
    cmbCidadeEmitente.AddItem "Conquista - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3118205
    cmbCidadeEmitente.AddItem "Conselheiro Lafaiete - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3118304
    cmbCidadeEmitente.AddItem "Conselheiro Pena - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3118403
    cmbCidadeEmitente.AddItem "Consolacao - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3118502
    cmbCidadeEmitente.AddItem "Contagem - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3118601
    cmbCidadeEmitente.AddItem "Coqueiral - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3118700
    cmbCidadeEmitente.AddItem "Coracao de Jesus - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3118809
    cmbCidadeEmitente.AddItem "Cordisburgo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3118908
    cmbCidadeEmitente.AddItem "Cordislandia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3119005
    cmbCidadeEmitente.AddItem "Corinto - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3119104
    cmbCidadeEmitente.AddItem "Coroaci - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3119203
    cmbCidadeEmitente.AddItem "Coromandel - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3119302
    cmbCidadeEmitente.AddItem "Coronel Fabriciano - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3119401
    cmbCidadeEmitente.AddItem "Coronel Murta - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3119500
    cmbCidadeEmitente.AddItem "Coronel Pacheco - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3119609
    cmbCidadeEmitente.AddItem "Coronel Xavier Chaves - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3119708
    cmbCidadeEmitente.AddItem "Corrego Danta - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3119807
    cmbCidadeEmitente.AddItem "Corrego do Bom Jesus - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3119906
    cmbCidadeEmitente.AddItem "Corrego Fundo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3119955
    cmbCidadeEmitente.AddItem "Corrego Novo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3120003
    cmbCidadeEmitente.AddItem "Couto de Magalhaes de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3120102
    cmbCidadeEmitente.AddItem "Crisolita - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3120151
    cmbCidadeEmitente.AddItem "Cristais - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3120201
    cmbCidadeEmitente.AddItem "Cristalia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3120300
    cmbCidadeEmitente.AddItem "Cristiano Otoni - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3120409
    cmbCidadeEmitente.AddItem "Cristina - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3120508
    cmbCidadeEmitente.AddItem "Crucilandia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3120607
    cmbCidadeEmitente.AddItem "Cruzeiro da Fortaleza - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3120706
    cmbCidadeEmitente.AddItem "Cruzilia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3120805
    cmbCidadeEmitente.AddItem "Cuparaque - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3120839
    cmbCidadeEmitente.AddItem "Curral de Dentro - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3120870
    cmbCidadeEmitente.AddItem "Curvelo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3120904
    cmbCidadeEmitente.AddItem "Datas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3121001
    cmbCidadeEmitente.AddItem "Delfim Moreira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3121100
    cmbCidadeEmitente.AddItem "Delfinopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3121209
    cmbCidadeEmitente.AddItem "Delta - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3121258
    cmbCidadeEmitente.AddItem "Descoberto - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3121308
    cmbCidadeEmitente.AddItem "Desterro de Entre Rios - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3121407
    cmbCidadeEmitente.AddItem "Desterro do Melo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3121506
    cmbCidadeEmitente.AddItem "Diamantina - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3121605
    cmbCidadeEmitente.AddItem "Diogo de Vasconcelos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3121704
    cmbCidadeEmitente.AddItem "Dionisio - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3121803
    cmbCidadeEmitente.AddItem "Divinesia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3121902
    cmbCidadeEmitente.AddItem "Divino - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3122009
    cmbCidadeEmitente.AddItem "Divino das Laranjeiras - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3122108
    cmbCidadeEmitente.AddItem "Divinolandia de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3122207
    cmbCidadeEmitente.AddItem "Divinopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3122306
    cmbCidadeEmitente.AddItem "Divisa Alegre - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3122355
    cmbCidadeEmitente.AddItem "Divisa Nova - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3122405
    cmbCidadeEmitente.AddItem "Divisopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3122454
    cmbCidadeEmitente.AddItem "Dom Bosco - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3122470
    cmbCidadeEmitente.AddItem "Dom Cavati - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3122504
    cmbCidadeEmitente.AddItem "Dom Joaquim - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3122603
    cmbCidadeEmitente.AddItem "Dom Silverio - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3122702
    cmbCidadeEmitente.AddItem "Dom Vicoso - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3122801
    cmbCidadeEmitente.AddItem "Dona Eusebia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3122900
    cmbCidadeEmitente.AddItem "Dores de Campos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3123007
    cmbCidadeEmitente.AddItem "Dores de Guanhaes - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3123106
    cmbCidadeEmitente.AddItem "Dores do Indaia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3123205
    cmbCidadeEmitente.AddItem "Dores do Turvo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3123304
    cmbCidadeEmitente.AddItem "Doresopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3123403
    cmbCidadeEmitente.AddItem "Douradoquara - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3123502
    cmbCidadeEmitente.AddItem "Durande - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3123528
    cmbCidadeEmitente.AddItem "Eloi Mendes - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3123601
    cmbCidadeEmitente.AddItem "Engenheiro Caldas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3123700
    cmbCidadeEmitente.AddItem "Engenheiro Navarro - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3123809
    cmbCidadeEmitente.AddItem "Entre Folhas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3123858
    cmbCidadeEmitente.AddItem "Entre Rios de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3123908
    cmbCidadeEmitente.AddItem "Ervalia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3124005
    cmbCidadeEmitente.AddItem "Esmeraldas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3124104
    cmbCidadeEmitente.AddItem "Espera Feliz - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3124203
    cmbCidadeEmitente.AddItem "Espinosa - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3124302
    cmbCidadeEmitente.AddItem "Espirito Santo do Dourado - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3124401
    cmbCidadeEmitente.AddItem "Estiva - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3124500
    cmbCidadeEmitente.AddItem "Estrela Dalva - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3124609
    cmbCidadeEmitente.AddItem "Estrela do Indaia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3124708
    cmbCidadeEmitente.AddItem "Estrela do Sul - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3124807
    cmbCidadeEmitente.AddItem "Eugenopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3124906
    cmbCidadeEmitente.AddItem "Ewbank da Camara - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3125002
    cmbCidadeEmitente.AddItem "Extrema - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3125101
    cmbCidadeEmitente.AddItem "Fama - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3125200
    cmbCidadeEmitente.AddItem "Faria Lemos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3125309
    cmbCidadeEmitente.AddItem "Felicio dos Santos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3125408
    cmbCidadeEmitente.AddItem "Felisburgo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3125606
    cmbCidadeEmitente.AddItem "Felixlandia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3125705
    cmbCidadeEmitente.AddItem "Fernandes Tourinho - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3125804
    cmbCidadeEmitente.AddItem "Ferros - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3125903
    cmbCidadeEmitente.AddItem "Fervedouro - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3125952
    cmbCidadeEmitente.AddItem "Florestal - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3126000
    cmbCidadeEmitente.AddItem "Formiga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3126109
    cmbCidadeEmitente.AddItem "Formoso - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3126208
    cmbCidadeEmitente.AddItem "Fortaleza de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3126307
    cmbCidadeEmitente.AddItem "Fortuna de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3126406
    cmbCidadeEmitente.AddItem "Francisco Badaro - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3126505
    cmbCidadeEmitente.AddItem "Francisco Dumont - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3126604
    cmbCidadeEmitente.AddItem "Francisco Sa - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3126703
    cmbCidadeEmitente.AddItem "Franciscopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3126752
    cmbCidadeEmitente.AddItem "Frei Gaspar - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3126802
    cmbCidadeEmitente.AddItem "Frei Inocencio - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3126901
End Sub

Private Sub MinasGerais3(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Frei Lagonegro - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3126950
    cmbCidadeEmitente.AddItem "Fronteira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3127008
    cmbCidadeEmitente.AddItem "Fronteira dos Vales - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3127057
    cmbCidadeEmitente.AddItem "Fruta de Leite - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3127073
    cmbCidadeEmitente.AddItem "Frutal - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3127107
    cmbCidadeEmitente.AddItem "Funilandia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3127206
    cmbCidadeEmitente.AddItem "Galileia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3127305
    cmbCidadeEmitente.AddItem "Gameleiras - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3127339
    cmbCidadeEmitente.AddItem "Glaucilandia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3127354
    cmbCidadeEmitente.AddItem "Goiabeira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3127370
    cmbCidadeEmitente.AddItem "Goiana - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3127388
    cmbCidadeEmitente.AddItem "Goncalves - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3127404
    cmbCidadeEmitente.AddItem "Gonzaga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3127503
    cmbCidadeEmitente.AddItem "Gouveia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3127602
    cmbCidadeEmitente.AddItem "Governador Valadares - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3127701
    cmbCidadeEmitente.AddItem "Grao Mogol - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3127800
    cmbCidadeEmitente.AddItem "Grupiara - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3127909
    cmbCidadeEmitente.AddItem "Guanhaes - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3128006
    cmbCidadeEmitente.AddItem "Guape - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3128105
    cmbCidadeEmitente.AddItem "Guaraciaba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3128204
    cmbCidadeEmitente.AddItem "Guaraciama - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3128253
    cmbCidadeEmitente.AddItem "Guaranesia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3128303
    cmbCidadeEmitente.AddItem "Guarani - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3128402
    cmbCidadeEmitente.AddItem "Guarara - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3128501
    cmbCidadeEmitente.AddItem "Guarda-Mor - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3128600
    cmbCidadeEmitente.AddItem "Guaxupe - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3128709
    cmbCidadeEmitente.AddItem "Guidoval - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3128808
    cmbCidadeEmitente.AddItem "Guimarania - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3128907
    cmbCidadeEmitente.AddItem "Guiricema - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3129004
    cmbCidadeEmitente.AddItem "Gurinhata - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3129103
    cmbCidadeEmitente.AddItem "Heliodora - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3129202
    cmbCidadeEmitente.AddItem "Iapu - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3129301
    cmbCidadeEmitente.AddItem "Ibertioga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3129400
    cmbCidadeEmitente.AddItem "Ibia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3129509
    cmbCidadeEmitente.AddItem "Ibiai - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3129608
    cmbCidadeEmitente.AddItem "Ibiracatu - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3129657
    cmbCidadeEmitente.AddItem "Ibiraci - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3129707
    cmbCidadeEmitente.AddItem "Ibirite - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3129806
    cmbCidadeEmitente.AddItem "Ibitiura de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3129905
    cmbCidadeEmitente.AddItem "Ibituruna - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3130002
    cmbCidadeEmitente.AddItem "Icarai de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3130051
    cmbCidadeEmitente.AddItem "Igarape - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3130101
    cmbCidadeEmitente.AddItem "Igaratinga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3130200
    cmbCidadeEmitente.AddItem "Iguatama - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3130309
    cmbCidadeEmitente.AddItem "Ijaci - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3130408
    cmbCidadeEmitente.AddItem "Ilicinea - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3130507
    cmbCidadeEmitente.AddItem "Imbe de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3130556
    cmbCidadeEmitente.AddItem "Inconfidentes - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3130606
    cmbCidadeEmitente.AddItem "Indaiabira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3130655
    cmbCidadeEmitente.AddItem "Indianopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3130705
    cmbCidadeEmitente.AddItem "Ingai - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3130804
    cmbCidadeEmitente.AddItem "Inhapim - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3130903
    cmbCidadeEmitente.AddItem "Inhauma - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3131000
    cmbCidadeEmitente.AddItem "Inimutaba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3131109
    cmbCidadeEmitente.AddItem "Ipaba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3131158
    cmbCidadeEmitente.AddItem "Ipanema - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3131208
    cmbCidadeEmitente.AddItem "Ipatinga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3131307
    cmbCidadeEmitente.AddItem "Ipiacu - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3131406
    cmbCidadeEmitente.AddItem "Ipuiuna - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3131505
    cmbCidadeEmitente.AddItem "Irai de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3131604
    cmbCidadeEmitente.AddItem "Itabira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3131703
    cmbCidadeEmitente.AddItem "Itabirinha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3131802
    cmbCidadeEmitente.AddItem "Itabirito - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3131901
    cmbCidadeEmitente.AddItem "Itacambira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3132008
    cmbCidadeEmitente.AddItem "Itacarambi - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3132107
    cmbCidadeEmitente.AddItem "Itaguara - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3132206
    cmbCidadeEmitente.AddItem "Itaipe - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3132305
    cmbCidadeEmitente.AddItem "Itajuba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3132404
    cmbCidadeEmitente.AddItem "Itamarandiba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3132503
    cmbCidadeEmitente.AddItem "Itamarati de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3132602
    cmbCidadeEmitente.AddItem "Itambacuri - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3132701
    cmbCidadeEmitente.AddItem "Itambe do Mato Dentro - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3132800
    cmbCidadeEmitente.AddItem "Itamogi - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3132909
    cmbCidadeEmitente.AddItem "Itamonte - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3133006
    cmbCidadeEmitente.AddItem "Itanhandu - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3133105
    cmbCidadeEmitente.AddItem "Itanhomi - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3133204
    cmbCidadeEmitente.AddItem "Itaobim - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3133303
    cmbCidadeEmitente.AddItem "Itapagipe - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3133402
    cmbCidadeEmitente.AddItem "Itapecerica - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3133501
    cmbCidadeEmitente.AddItem "Itapeva - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3133600
    cmbCidadeEmitente.AddItem "Itatiaiucu - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3133709
    cmbCidadeEmitente.AddItem "Itau de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3133758
    cmbCidadeEmitente.AddItem "Itauna - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3133808
    cmbCidadeEmitente.AddItem "Itaverava - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3133907
    cmbCidadeEmitente.AddItem "Itinga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3134004
    cmbCidadeEmitente.AddItem "Itueta - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3134103
    cmbCidadeEmitente.AddItem "Ituiutaba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3134202
    cmbCidadeEmitente.AddItem "Itumirim - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3134301
    cmbCidadeEmitente.AddItem "Iturama - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3134400
    cmbCidadeEmitente.AddItem "Itutinga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3134509
    cmbCidadeEmitente.AddItem "Jaboticatubas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3134608
    cmbCidadeEmitente.AddItem "Jacinto - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3134707
    cmbCidadeEmitente.AddItem "Jacui - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3134806
    cmbCidadeEmitente.AddItem "Jacutinga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3134905
    cmbCidadeEmitente.AddItem "Jaguaracu - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3135001
    cmbCidadeEmitente.AddItem "Jaiba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3135050
    cmbCidadeEmitente.AddItem "Jampruca - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3135076
    cmbCidadeEmitente.AddItem "Janauba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3135100
    cmbCidadeEmitente.AddItem "Januaria - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3135209
    cmbCidadeEmitente.AddItem "Japaraiba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3135308
    cmbCidadeEmitente.AddItem "Japonvar - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3135357
    cmbCidadeEmitente.AddItem "Jeceaba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3135407
    cmbCidadeEmitente.AddItem "Jenipapo de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3135456
    cmbCidadeEmitente.AddItem "Jequeri - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3135506
    cmbCidadeEmitente.AddItem "Jequitai - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3135605
    cmbCidadeEmitente.AddItem "Jequitiba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3135704
    cmbCidadeEmitente.AddItem "Jequitinhonha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3135803
    cmbCidadeEmitente.AddItem "Jesuania - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3135902
    cmbCidadeEmitente.AddItem "Joaima - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3136009
    cmbCidadeEmitente.AddItem "Joanesia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3136108
    cmbCidadeEmitente.AddItem "Joao Monlevade - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3136207
    cmbCidadeEmitente.AddItem "Joao Pinheiro - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3136306
    cmbCidadeEmitente.AddItem "Joaquim Felicio - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3136405
    cmbCidadeEmitente.AddItem "Jordania - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3136504
    cmbCidadeEmitente.AddItem "Jose Goncalves de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3136520
    cmbCidadeEmitente.AddItem "Jose Raydan - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3136553
    cmbCidadeEmitente.AddItem "Josenopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3136579
    cmbCidadeEmitente.AddItem "Juatuba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3136652
    cmbCidadeEmitente.AddItem "Juiz de Fora - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3136702
    cmbCidadeEmitente.AddItem "Juramento - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3136801
    cmbCidadeEmitente.AddItem "Juruaia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3136900
    cmbCidadeEmitente.AddItem "Juvenilia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3136959
    cmbCidadeEmitente.AddItem "Ladainha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3137007
    cmbCidadeEmitente.AddItem "Lagamar - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3137106
    cmbCidadeEmitente.AddItem "Lagoa da Prata - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3137205
    cmbCidadeEmitente.AddItem "Lagoa dos Patos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3137304
    cmbCidadeEmitente.AddItem "Lagoa Dourada - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3137403
    cmbCidadeEmitente.AddItem "Lagoa Formosa - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3137502
    cmbCidadeEmitente.AddItem "Lagoa Grande - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3137536
    cmbCidadeEmitente.AddItem "Lagoa Santa - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3137601
    cmbCidadeEmitente.AddItem "Lajinha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3137700
    cmbCidadeEmitente.AddItem "Lambari - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3137809
    cmbCidadeEmitente.AddItem "Lamim - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3137908
    cmbCidadeEmitente.AddItem "Laranjal - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3138005
    cmbCidadeEmitente.AddItem "Lassance - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3138104
    cmbCidadeEmitente.AddItem "Lavras - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3138203
    cmbCidadeEmitente.AddItem "Leandro Ferreira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3138302
    cmbCidadeEmitente.AddItem "Leme do Prado - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3138351
    cmbCidadeEmitente.AddItem "Leopoldina - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3138401
    cmbCidadeEmitente.AddItem "Liberdade - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3138500
    cmbCidadeEmitente.AddItem "Lima Duarte - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3138609
    cmbCidadeEmitente.AddItem "Limeira do Oeste - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3138625
    cmbCidadeEmitente.AddItem "Lontra - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3138658
    cmbCidadeEmitente.AddItem "Luisburgo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3138674
    cmbCidadeEmitente.AddItem "Luislandia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3138682
    cmbCidadeEmitente.AddItem "Luminarias - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3138708
    cmbCidadeEmitente.AddItem "Luz - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3138807
    cmbCidadeEmitente.AddItem "Machacalis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3138906
    cmbCidadeEmitente.AddItem "Machado - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3139003
    cmbCidadeEmitente.AddItem "Madre de Deus de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3139102
End Sub

Private Sub MinasGerais4(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Malacacheta - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3139201
    cmbCidadeEmitente.AddItem "Mamonas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3139250
    cmbCidadeEmitente.AddItem "Manga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3139300
    cmbCidadeEmitente.AddItem "Manhuacu - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3139409
    cmbCidadeEmitente.AddItem "Manhumirim - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3139508
    cmbCidadeEmitente.AddItem "Mantena - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3139607
    cmbCidadeEmitente.AddItem "Mar de Espanha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3139805
    cmbCidadeEmitente.AddItem "Maravilhas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3139706
    cmbCidadeEmitente.AddItem "Maria da Fe - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3139904
    cmbCidadeEmitente.AddItem "Mariana - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3140001
    cmbCidadeEmitente.AddItem "Marilac - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3140100
    cmbCidadeEmitente.AddItem "Mario Campos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3140159
    cmbCidadeEmitente.AddItem "Maripa de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3140209
    cmbCidadeEmitente.AddItem "Marlieria - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3140308
    cmbCidadeEmitente.AddItem "Marmelopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3140407
    cmbCidadeEmitente.AddItem "Martinho Campos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3140506
    cmbCidadeEmitente.AddItem "Martins Soares - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3140530
    cmbCidadeEmitente.AddItem "Mata Verde - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3140555
    cmbCidadeEmitente.AddItem "Materlandia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3140605
    cmbCidadeEmitente.AddItem "Mateus Leme - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3140704
    cmbCidadeEmitente.AddItem "Mathias Lobato - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3171501
    cmbCidadeEmitente.AddItem "Matias Barbosa - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3140803
    cmbCidadeEmitente.AddItem "Matias Cardoso - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3140852
    cmbCidadeEmitente.AddItem "Matipo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3140902
    cmbCidadeEmitente.AddItem "Mato Verde - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3141009
    cmbCidadeEmitente.AddItem "Matozinhos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3141108
    cmbCidadeEmitente.AddItem "Matutina - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3141207
    cmbCidadeEmitente.AddItem "Medeiros - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3141306
    cmbCidadeEmitente.AddItem "Medina - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3141405
    cmbCidadeEmitente.AddItem "Mendes Pimentel - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3141504
    cmbCidadeEmitente.AddItem "Merces - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3141603
    cmbCidadeEmitente.AddItem "Mesquita - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3141702
    cmbCidadeEmitente.AddItem "Minas Novas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3141801
    cmbCidadeEmitente.AddItem "Minduri - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3141900
    cmbCidadeEmitente.AddItem "Mirabela - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3142007
    cmbCidadeEmitente.AddItem "Miradouro - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3142106
    cmbCidadeEmitente.AddItem "Mirai - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3142205
    cmbCidadeEmitente.AddItem "Miravania - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3142254
    cmbCidadeEmitente.AddItem "Moeda - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3142304
    cmbCidadeEmitente.AddItem "Moema - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3142403
    cmbCidadeEmitente.AddItem "Monjolos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3142502
    cmbCidadeEmitente.AddItem "Monsenhor Paulo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3142601
    cmbCidadeEmitente.AddItem "Montalvania - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3142700
    cmbCidadeEmitente.AddItem "Monte Alegre de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3142809
    cmbCidadeEmitente.AddItem "Monte Azul - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3142908
    cmbCidadeEmitente.AddItem "Monte Belo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3143005
    cmbCidadeEmitente.AddItem "Monte Carmelo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3143104
    cmbCidadeEmitente.AddItem "Monte Formoso - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3143153
    cmbCidadeEmitente.AddItem "Monte Santo de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3143203
    cmbCidadeEmitente.AddItem "Monte Siao - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3143401
    cmbCidadeEmitente.AddItem "Montes Claros - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3143302
    cmbCidadeEmitente.AddItem "Montezuma - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3143450
    cmbCidadeEmitente.AddItem "Morada Nova de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3143500
    cmbCidadeEmitente.AddItem "Morro da Garca - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3143609
    cmbCidadeEmitente.AddItem "Morro do Pilar - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3143708
    cmbCidadeEmitente.AddItem "Munhoz - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3143807
    cmbCidadeEmitente.AddItem "Muriae - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3143906
    cmbCidadeEmitente.AddItem "Mutum - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3144003
    cmbCidadeEmitente.AddItem "Muzambinho - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3144102
    cmbCidadeEmitente.AddItem "Nacip Raydan - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3144201
    cmbCidadeEmitente.AddItem "Nanuque - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3144300
    cmbCidadeEmitente.AddItem "Naque - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3144359
    cmbCidadeEmitente.AddItem "Natalandia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3144375
    cmbCidadeEmitente.AddItem "Natercia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3144409
    cmbCidadeEmitente.AddItem "Nazareno - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3144508
    cmbCidadeEmitente.AddItem "Nepomuceno - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3144607
    cmbCidadeEmitente.AddItem "Ninheira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3144656
    cmbCidadeEmitente.AddItem "Nova Belem - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3144672
    cmbCidadeEmitente.AddItem "Nova Era - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3144706
    cmbCidadeEmitente.AddItem "Nova Lima - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3144805
    cmbCidadeEmitente.AddItem "Nova Modica - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3144904
    cmbCidadeEmitente.AddItem "Nova Ponte - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3145000
    cmbCidadeEmitente.AddItem "Nova Porteirinha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3145059
    cmbCidadeEmitente.AddItem "Nova Resende - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3145109
    cmbCidadeEmitente.AddItem "Nova Serrana - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3145208
    cmbCidadeEmitente.AddItem "Nova Uniao - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3136603
    cmbCidadeEmitente.AddItem "Novo Cruzeiro - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3145307
    cmbCidadeEmitente.AddItem "Novo Oriente de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3145356
    cmbCidadeEmitente.AddItem "Novorizonte - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3145372
    cmbCidadeEmitente.AddItem "Olaria - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3145406
    cmbCidadeEmitente.AddItem "Olhos-D Agua - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3145455
    cmbCidadeEmitente.AddItem "Olimpio Noronha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3145505
    cmbCidadeEmitente.AddItem "Oliveira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3145604
    cmbCidadeEmitente.AddItem "Oliveira Fortes - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3145703
    cmbCidadeEmitente.AddItem "Onca de Pitangui - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3145802
    cmbCidadeEmitente.AddItem "Oratorios - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3145851
    cmbCidadeEmitente.AddItem "Orizania - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3145877
    cmbCidadeEmitente.AddItem "Ouro Branco - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3145901
    cmbCidadeEmitente.AddItem "Ouro Fino - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3146008
    cmbCidadeEmitente.AddItem "Ouro Preto - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3146107
    cmbCidadeEmitente.AddItem "Ouro Verde de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3146206
    cmbCidadeEmitente.AddItem "Padre Carvalho - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3146255
    cmbCidadeEmitente.AddItem "Padre Paraiso - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3146305
    cmbCidadeEmitente.AddItem "Pai Pedro - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3146552
    cmbCidadeEmitente.AddItem "Paineiras - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3146404
    cmbCidadeEmitente.AddItem "Pains - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3146503
    cmbCidadeEmitente.AddItem "Paiva - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3146602
    cmbCidadeEmitente.AddItem "Palma - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3146701
    cmbCidadeEmitente.AddItem "Palmopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3146750
    cmbCidadeEmitente.AddItem "Papagaios - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3146909
    cmbCidadeEmitente.AddItem "Para de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3147105
    cmbCidadeEmitente.AddItem "Paracatu - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3147006
    cmbCidadeEmitente.AddItem "Paraguacu - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3147204
    cmbCidadeEmitente.AddItem "Paraisopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3147303
    cmbCidadeEmitente.AddItem "Paraopeba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3147402
    cmbCidadeEmitente.AddItem "Passa Quatro - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3147600
    cmbCidadeEmitente.AddItem "Passa Tempo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3147709
    cmbCidadeEmitente.AddItem "Passa-Vinte - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3147808
    cmbCidadeEmitente.AddItem "Passabem - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3147501
    cmbCidadeEmitente.AddItem "Passos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3147907
    cmbCidadeEmitente.AddItem "Patis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3147956
    cmbCidadeEmitente.AddItem "Patos de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3148004
    cmbCidadeEmitente.AddItem "Patrocinio - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3148103
    cmbCidadeEmitente.AddItem "Patrocinio do Muriae - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3148202
    cmbCidadeEmitente.AddItem "Paula Candido - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3148301
    cmbCidadeEmitente.AddItem "Paulistas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3148400
    cmbCidadeEmitente.AddItem "Pavao - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3148509
    cmbCidadeEmitente.AddItem "Pecanha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3148608
    cmbCidadeEmitente.AddItem "Pedra Azul - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3148707
    cmbCidadeEmitente.AddItem "Pedra Bonita - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3148756
    cmbCidadeEmitente.AddItem "Pedra do Anta - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3148806
    cmbCidadeEmitente.AddItem "Pedra do Indaia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3148905
    cmbCidadeEmitente.AddItem "Pedra Dourada - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3149002
    cmbCidadeEmitente.AddItem "Pedralva - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3149101
    cmbCidadeEmitente.AddItem "Pedras de Maria da Cruz - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3149150
    cmbCidadeEmitente.AddItem "Pedrinopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3149200
    cmbCidadeEmitente.AddItem "Pedro Leopoldo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3149309
    cmbCidadeEmitente.AddItem "Pedro Teixeira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3149408
    cmbCidadeEmitente.AddItem "Pequeri - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3149507
    cmbCidadeEmitente.AddItem "Pequi - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3149606
    cmbCidadeEmitente.AddItem "Perdigao - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3149705
    cmbCidadeEmitente.AddItem "Perdizes - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3149804
    cmbCidadeEmitente.AddItem "Perdoes - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3149903
    cmbCidadeEmitente.AddItem "Periquito - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3149952
    cmbCidadeEmitente.AddItem "Pescador - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3150000
    cmbCidadeEmitente.AddItem "Piau - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3150109
    cmbCidadeEmitente.AddItem "Piedade de Caratinga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3150158
    cmbCidadeEmitente.AddItem "Piedade de Ponte Nova - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3150208
    cmbCidadeEmitente.AddItem "Piedade do Rio Grande - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3150307
    cmbCidadeEmitente.AddItem "Piedade dos Gerais - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3150406
    cmbCidadeEmitente.AddItem "Pimenta - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3150505
    cmbCidadeEmitente.AddItem "Pingo-D Agua - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3150539
    cmbCidadeEmitente.AddItem "Pintopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3150570
    cmbCidadeEmitente.AddItem "Piracema - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3150604
    cmbCidadeEmitente.AddItem "Pirajuba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3150703
    cmbCidadeEmitente.AddItem "Piranga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3150802
    cmbCidadeEmitente.AddItem "Pirangucu - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3150901
    cmbCidadeEmitente.AddItem "Piranguinho - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3151008
    cmbCidadeEmitente.AddItem "Pirapetinga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3151107
    cmbCidadeEmitente.AddItem "Pirapora - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3151206
End Sub

Private Sub MinasGerais5(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Pirauba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3151305
    cmbCidadeEmitente.AddItem "Pitangui - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3151404
    cmbCidadeEmitente.AddItem "Piumhi - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3151503
    cmbCidadeEmitente.AddItem "Planura - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3151602
    cmbCidadeEmitente.AddItem "Poco Fundo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3151701
    cmbCidadeEmitente.AddItem "Pocos de Caldas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3151800
    cmbCidadeEmitente.AddItem "Pocrane - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3151909
    cmbCidadeEmitente.AddItem "Pompeu - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3152006
    cmbCidadeEmitente.AddItem "Ponte Nova - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3152105
    cmbCidadeEmitente.AddItem "Ponto Chique - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3152131
    cmbCidadeEmitente.AddItem "Ponto dos Volantes - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3152170
    cmbCidadeEmitente.AddItem "Porteirinha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3152204
    cmbCidadeEmitente.AddItem "Porto Firme - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3152303
    cmbCidadeEmitente.AddItem "Pote - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3152402
    cmbCidadeEmitente.AddItem "Pouso Alegre - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3152501
    cmbCidadeEmitente.AddItem "Pouso Alto - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3152600
    cmbCidadeEmitente.AddItem "Prados - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3152709
    cmbCidadeEmitente.AddItem "Prata - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3152808
    cmbCidadeEmitente.AddItem "Pratapolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3152907
    cmbCidadeEmitente.AddItem "Pratinha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3153004
    cmbCidadeEmitente.AddItem "Presidente Bernardes - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3153103
    cmbCidadeEmitente.AddItem "Presidente Juscelino - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3153202
    cmbCidadeEmitente.AddItem "Presidente Kubitschek - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3153301
    cmbCidadeEmitente.AddItem "Presidente Olegario - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3153400
    cmbCidadeEmitente.AddItem "Prudente de Morais - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3153608
    cmbCidadeEmitente.AddItem "Quartel Geral - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3153707
    cmbCidadeEmitente.AddItem "Queluzito - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3153806
    cmbCidadeEmitente.AddItem "Raposos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3153905
    cmbCidadeEmitente.AddItem "Raul Soares - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3154002
    cmbCidadeEmitente.AddItem "Recreio - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3154101
    cmbCidadeEmitente.AddItem "Reduto - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3154150
    cmbCidadeEmitente.AddItem "Resende Costa - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3154200
    cmbCidadeEmitente.AddItem "Resplendor - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3154309
    cmbCidadeEmitente.AddItem "Ressaquinha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3154408
    cmbCidadeEmitente.AddItem "Riachinho - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3154457
    cmbCidadeEmitente.AddItem "Riacho dos Machados - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3154507
    cmbCidadeEmitente.AddItem "Ribeirao das Neves - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3154606
    cmbCidadeEmitente.AddItem "Ribeirao Vermelho - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3154705
    cmbCidadeEmitente.AddItem "Rio Acima - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3154804
    cmbCidadeEmitente.AddItem "Rio Casca - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3154903
    cmbCidadeEmitente.AddItem "Rio do Prado - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3155108
    cmbCidadeEmitente.AddItem "Rio Doce - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3155009
    cmbCidadeEmitente.AddItem "Rio Espera - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3155207
    cmbCidadeEmitente.AddItem "Rio Manso - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3155306
    cmbCidadeEmitente.AddItem "Rio Novo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3155405
    cmbCidadeEmitente.AddItem "Rio Paranaiba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3155504
    cmbCidadeEmitente.AddItem "Rio Pardo de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3155603
    cmbCidadeEmitente.AddItem "Rio Piracicaba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3155702
    cmbCidadeEmitente.AddItem "Rio Pomba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3155801
    cmbCidadeEmitente.AddItem "Rio Preto - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3155900
    cmbCidadeEmitente.AddItem "Rio Vermelho - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3156007
    cmbCidadeEmitente.AddItem "Ritapolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3156106
    cmbCidadeEmitente.AddItem "Rochedo de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3156205
    cmbCidadeEmitente.AddItem "Rodeiro - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3156304
    cmbCidadeEmitente.AddItem "Romaria - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3156403
    cmbCidadeEmitente.AddItem "Rosario da Limeira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3156452
    cmbCidadeEmitente.AddItem "Rubelita - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3156502
    cmbCidadeEmitente.AddItem "Rubim - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3156601
    cmbCidadeEmitente.AddItem "Sabara - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3156700
    cmbCidadeEmitente.AddItem "Sabinopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3156809
    cmbCidadeEmitente.AddItem "Sacramento - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3156908
    cmbCidadeEmitente.AddItem "Salinas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3157005
    cmbCidadeEmitente.AddItem "Salto da Divisa - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3157104
    cmbCidadeEmitente.AddItem "Santa Barbara - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3157203
    cmbCidadeEmitente.AddItem "Santa Barbara do Leste - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3157252
    cmbCidadeEmitente.AddItem "Santa Barbara do Monte Verde - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3157278
    cmbCidadeEmitente.AddItem "Santa Barbara do Tugurio - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3157302
    cmbCidadeEmitente.AddItem "Santa Cruz de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3157336
    cmbCidadeEmitente.AddItem "Santa Cruz de Salinas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3157377
    cmbCidadeEmitente.AddItem "Santa Cruz do Escalvado - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3157401
    cmbCidadeEmitente.AddItem "Santa Efigenia de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3157500
    cmbCidadeEmitente.AddItem "Santa Fe de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3157609
    cmbCidadeEmitente.AddItem "Santa Helena de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3157658
    cmbCidadeEmitente.AddItem "Santa Juliana - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3157708
    cmbCidadeEmitente.AddItem "Santa Luzia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3157807
    cmbCidadeEmitente.AddItem "Santa Margarida - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3157906
    cmbCidadeEmitente.AddItem "Santa Maria de Itabira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3158003
    cmbCidadeEmitente.AddItem "Santa Maria do Salto - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3158102
    cmbCidadeEmitente.AddItem "Santa Maria do Suacui - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3158201
    cmbCidadeEmitente.AddItem "Santa Rita de Caldas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3159209
    cmbCidadeEmitente.AddItem "Santa Rita de Ibitipoca - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3159407
    cmbCidadeEmitente.AddItem "Santa Rita de Jacutinga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3159308
    cmbCidadeEmitente.AddItem "Santa Rita de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3159357
    cmbCidadeEmitente.AddItem "Santa Rita do Itueto - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3159506
    cmbCidadeEmitente.AddItem "Santa Rita do Sapucai - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3159605
    cmbCidadeEmitente.AddItem "Santa Rosa da Serra - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3159704
    cmbCidadeEmitente.AddItem "Santa Vitoria - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3159803
    cmbCidadeEmitente.AddItem "Santana da Vargem - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3158300
    cmbCidadeEmitente.AddItem "Santana de Cataguases - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3158409
    cmbCidadeEmitente.AddItem "Santana de Pirapama - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3158508
    cmbCidadeEmitente.AddItem "Santana do Deserto - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3158607
    cmbCidadeEmitente.AddItem "Santana do Garambeu - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3158706
    cmbCidadeEmitente.AddItem "Santana do Jacare - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3158805
    cmbCidadeEmitente.AddItem "Santana do Manhuacu - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3158904
    cmbCidadeEmitente.AddItem "Santana do Paraiso - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3158953
    cmbCidadeEmitente.AddItem "Santana do Riacho - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3159001
    cmbCidadeEmitente.AddItem "Santana dos Montes - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3159100
    cmbCidadeEmitente.AddItem "Santo Antonio do Amparo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3159902
    cmbCidadeEmitente.AddItem "Santo Antonio do Aventureiro - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3160009
    cmbCidadeEmitente.AddItem "Santo Antonio do Grama - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3160108
    cmbCidadeEmitente.AddItem "Santo Antonio do Itambe - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3160207
    cmbCidadeEmitente.AddItem "Santo Antonio do Jacinto - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3160306
    cmbCidadeEmitente.AddItem "Santo Antonio do Monte - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3160405
    cmbCidadeEmitente.AddItem "Santo Antonio do Retiro - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3160454
    cmbCidadeEmitente.AddItem "Santo Antonio do Rio Abaixo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3160504
    cmbCidadeEmitente.AddItem "Santo Hipolito - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3160603
    cmbCidadeEmitente.AddItem "Santos Dumont - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3160702
    cmbCidadeEmitente.AddItem "Sao Bento Abade - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3160801
    cmbCidadeEmitente.AddItem "Sao Bras do Suacui - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3160900
    cmbCidadeEmitente.AddItem "Sao Domingos das Dores - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3160959
    cmbCidadeEmitente.AddItem "Sao Domingos do Prata - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3161007
    cmbCidadeEmitente.AddItem "Sao Felix de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3161056
    cmbCidadeEmitente.AddItem "Sao Francisco - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3161106
    cmbCidadeEmitente.AddItem "Sao Francisco de Paula - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3161205
    cmbCidadeEmitente.AddItem "Sao Francisco de Sales - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3161304
    cmbCidadeEmitente.AddItem "Sao Francisco do Gloria - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3161403
    cmbCidadeEmitente.AddItem "Sao Geraldo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3161502
    cmbCidadeEmitente.AddItem "Sao Geraldo da Piedade - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3161601
    cmbCidadeEmitente.AddItem "Sao Geraldo do Baixio - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3161650
    cmbCidadeEmitente.AddItem "Sao Goncalo do Abaete - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3161700
    cmbCidadeEmitente.AddItem "Sao Goncalo do Para - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3161809
    cmbCidadeEmitente.AddItem "Sao Goncalo do Rio Abaixo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3161908
    cmbCidadeEmitente.AddItem "Sao Goncalo do Rio Preto - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3125507
    cmbCidadeEmitente.AddItem "Sao Goncalo do Sapucai - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3162005
    cmbCidadeEmitente.AddItem "Sao Gotardo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3162104
    cmbCidadeEmitente.AddItem "Sao Joao Batista do Gloria - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3162203
    cmbCidadeEmitente.AddItem "Sao Joao da Lagoa - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3162252
    cmbCidadeEmitente.AddItem "Sao Joao da Mata - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3162302
    cmbCidadeEmitente.AddItem "Sao Joao da Ponte - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3162401
    cmbCidadeEmitente.AddItem "Sao Joao das Missoes - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3162450
    cmbCidadeEmitente.AddItem "Sao Joao Del Rei - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3162500
    cmbCidadeEmitente.AddItem "Sao Joao do Manhuacu - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3162559
    cmbCidadeEmitente.AddItem "Sao Joao do Manteninha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3162575
    cmbCidadeEmitente.AddItem "Sao Joao do Oriente - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3162609
    cmbCidadeEmitente.AddItem "Sao Joao do Pacui - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3162658
    cmbCidadeEmitente.AddItem "Sao Joao do Paraiso - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3162708
    cmbCidadeEmitente.AddItem "Sao Joao Evangelista - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3162807
    cmbCidadeEmitente.AddItem "Sao Joao Nepomuceno - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3162906
    cmbCidadeEmitente.AddItem "Sao Joaquim de Bicas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3162922
    cmbCidadeEmitente.AddItem "Sao Jose da Barra - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3162948
    cmbCidadeEmitente.AddItem "Sao Jose da Lapa - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3162955
    cmbCidadeEmitente.AddItem "Sao Jose da Safira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3163003
    cmbCidadeEmitente.AddItem "Sao Jose da Varginha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3163102
    cmbCidadeEmitente.AddItem "Sao Jose do Alegre - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3163201
    cmbCidadeEmitente.AddItem "Sao Jose do Divino - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3163300
    cmbCidadeEmitente.AddItem "Sao Jose do Goiabal - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3163409
    cmbCidadeEmitente.AddItem "Sao Jose do Jacuri - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3163508
    cmbCidadeEmitente.AddItem "Sao Jose do Mantimento - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3163607
    cmbCidadeEmitente.AddItem "Sao Lourenco - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3163706
    cmbCidadeEmitente.AddItem "Sao Miguel do Anta - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3163805
End Sub

Private Sub MinasGerais6(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Sao Pedro da Uniao - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3163904
    cmbCidadeEmitente.AddItem "Sao Pedro do Suacui - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3164100
    cmbCidadeEmitente.AddItem "Sao Pedro dos Ferros - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3164001
    cmbCidadeEmitente.AddItem "Sao Romao - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3164209
    cmbCidadeEmitente.AddItem "Sao Roque de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3164308
    cmbCidadeEmitente.AddItem "Sao Sebastiao da Bela Vista - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3164407
    cmbCidadeEmitente.AddItem "Sao Sebastiao da Vargem Alegre - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3164431
    cmbCidadeEmitente.AddItem "Sao Sebastiao do Anta - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3164472
    cmbCidadeEmitente.AddItem "Sao Sebastiao do Maranhao - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3164506
    cmbCidadeEmitente.AddItem "Sao Sebastiao do Oeste - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3164605
    cmbCidadeEmitente.AddItem "Sao Sebastiao do Paraiso - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3164704
    cmbCidadeEmitente.AddItem "Sao Sebastiao do Rio Preto - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3164803
    cmbCidadeEmitente.AddItem "Sao Sebastiao do Rio Verde - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3164902
    cmbCidadeEmitente.AddItem "Sao Thome das Letras - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3165206
    cmbCidadeEmitente.AddItem "Sao Tiago - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3165008
    cmbCidadeEmitente.AddItem "Sao Tomas de Aquino - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3165107
    cmbCidadeEmitente.AddItem "Sao Vicente de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3165305
    cmbCidadeEmitente.AddItem "Sapucai-Mirim - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3165404
    cmbCidadeEmitente.AddItem "Sardoa - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3165503
    cmbCidadeEmitente.AddItem "Sarzedo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3165537
    cmbCidadeEmitente.AddItem "Sem-Peixe - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3165560
    cmbCidadeEmitente.AddItem "Senador Amaral - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3165578
    cmbCidadeEmitente.AddItem "Senador Cortes - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3165602
    cmbCidadeEmitente.AddItem "Senador Firmino - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3165701
    cmbCidadeEmitente.AddItem "Senador Jose Bento - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3165800
    cmbCidadeEmitente.AddItem "Senador Modestino Goncalves - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3165909
    cmbCidadeEmitente.AddItem "Senhora de Oliveira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3166006
    cmbCidadeEmitente.AddItem "Senhora do Porto - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3166105
    cmbCidadeEmitente.AddItem "Senhora dos Remedios - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3166204
    cmbCidadeEmitente.AddItem "Sericita - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3166303
    cmbCidadeEmitente.AddItem "Seritinga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3166402
    cmbCidadeEmitente.AddItem "Serra Azul de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3166501
    cmbCidadeEmitente.AddItem "Serra da Saudade - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3166600
    cmbCidadeEmitente.AddItem "Serra do Salitre - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3166808
    cmbCidadeEmitente.AddItem "Serra dos Aimores - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3166709
    cmbCidadeEmitente.AddItem "Serrania - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3166907
    cmbCidadeEmitente.AddItem "Serranopolis de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3166956
    cmbCidadeEmitente.AddItem "Serranos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3167004
    cmbCidadeEmitente.AddItem "Serro - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3167103
    cmbCidadeEmitente.AddItem "Sete Lagoas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3167202
    cmbCidadeEmitente.AddItem "Setubinha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3165552
    cmbCidadeEmitente.AddItem "Silveirania - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3167301
    cmbCidadeEmitente.AddItem "Silvianopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3167400
    cmbCidadeEmitente.AddItem "Simao Pereira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3167509
    cmbCidadeEmitente.AddItem "Simonesia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3167608
    cmbCidadeEmitente.AddItem "Sobralia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3167707
    cmbCidadeEmitente.AddItem "Soledade de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3167806
    cmbCidadeEmitente.AddItem "Tabuleiro - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3167905
    cmbCidadeEmitente.AddItem "Taiobeiras - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3168002
    cmbCidadeEmitente.AddItem "Taparuba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3168051
    cmbCidadeEmitente.AddItem "Tapira - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3168101
    cmbCidadeEmitente.AddItem "Tapirai - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3168200
    cmbCidadeEmitente.AddItem "Taquaracu de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3168309
    cmbCidadeEmitente.AddItem "Tarumirim - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3168408
    cmbCidadeEmitente.AddItem "Teixeiras - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3168507
    cmbCidadeEmitente.AddItem "Teofilo Otoni - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3168606
    cmbCidadeEmitente.AddItem "Timoteo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3168705
    cmbCidadeEmitente.AddItem "Tiradentes - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3168804
    cmbCidadeEmitente.AddItem "Tiros - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3168903
    cmbCidadeEmitente.AddItem "Tocantins - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3169000
    cmbCidadeEmitente.AddItem "Tocos do Moji - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3169059
    cmbCidadeEmitente.AddItem "Toledo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3169109
    cmbCidadeEmitente.AddItem "Tombos - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3169208
    cmbCidadeEmitente.AddItem "Tres Coracoes - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3169307
    cmbCidadeEmitente.AddItem "Tres Marias - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3169356
    cmbCidadeEmitente.AddItem "Tres Pontas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3169406
    cmbCidadeEmitente.AddItem "Tumiritinga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3169505
    cmbCidadeEmitente.AddItem "Tupaciguara - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3169604
    cmbCidadeEmitente.AddItem "Turmalina - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3169703
    cmbCidadeEmitente.AddItem "Turvolandia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3169802
    cmbCidadeEmitente.AddItem "Uba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3169901
    cmbCidadeEmitente.AddItem "Ubai - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3170008
    cmbCidadeEmitente.AddItem "Ubaporanga - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3170057
    cmbCidadeEmitente.AddItem "Uberaba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3170107
    cmbCidadeEmitente.AddItem "Uberlandia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3170206
    cmbCidadeEmitente.AddItem "Umburatiba - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3170305
    cmbCidadeEmitente.AddItem "Unai - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3170404
    cmbCidadeEmitente.AddItem "Uniao de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3170438
    cmbCidadeEmitente.AddItem "Uruana de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3170479
    cmbCidadeEmitente.AddItem "Urucania - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3170503
    cmbCidadeEmitente.AddItem "Urucuia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3170529
    cmbCidadeEmitente.AddItem "Vargem Alegre - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3170578
    cmbCidadeEmitente.AddItem "Vargem Bonita - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3170602
    cmbCidadeEmitente.AddItem "Vargem Grande do Rio Pardo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3170651
    cmbCidadeEmitente.AddItem "Varginha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3170701
    cmbCidadeEmitente.AddItem "Varjao de Minas - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3170750
    cmbCidadeEmitente.AddItem "Varzea da Palma - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3170800
    cmbCidadeEmitente.AddItem "Varzelandia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3170909
    cmbCidadeEmitente.AddItem "Vazante - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3171006
    cmbCidadeEmitente.AddItem "Verdelandia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3171030
    cmbCidadeEmitente.AddItem "Veredinha - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3171071
    cmbCidadeEmitente.AddItem "Verissimo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3171105
    cmbCidadeEmitente.AddItem "Vermelho Novo - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3171154
    cmbCidadeEmitente.AddItem "Vespasiano - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3171204
    cmbCidadeEmitente.AddItem "Vicosa - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3171303
    cmbCidadeEmitente.AddItem "Vieiras - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3171402
    cmbCidadeEmitente.AddItem "Virgem da Lapa - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3171600
    cmbCidadeEmitente.AddItem "Virginia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3171709
    cmbCidadeEmitente.AddItem "Virginopolis - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3171808
    cmbCidadeEmitente.AddItem "Virgolandia - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3171907
    cmbCidadeEmitente.AddItem "Visconde do Rio Branco - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3172004
    cmbCidadeEmitente.AddItem "Volta Grande - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3172103
    cmbCidadeEmitente.AddItem "Wenceslau Braz - MG"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3172202
End Sub

Public Sub EspiritoSanto(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Afonso Claudio - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3200102
    cmbCidadeEmitente.AddItem "Agua Doce do Norte - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3200169
    cmbCidadeEmitente.AddItem "Aguia Branca - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3200136
    cmbCidadeEmitente.AddItem "Alegre - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3200201
    cmbCidadeEmitente.AddItem "Alfredo Chaves - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3200300
    cmbCidadeEmitente.AddItem "Alto Rio Novo - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3200359
    cmbCidadeEmitente.AddItem "Anchieta - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3200409
    cmbCidadeEmitente.AddItem "Apiaca - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3200508
    cmbCidadeEmitente.AddItem "Aracruz - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3200607
    cmbCidadeEmitente.AddItem "Atilio Vivacqua - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3200706
    cmbCidadeEmitente.AddItem "Baixo Guandu - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3200805
    cmbCidadeEmitente.AddItem "Barra de Sao Francisco - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3200904
    cmbCidadeEmitente.AddItem "Boa Esperanca - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3201001
    cmbCidadeEmitente.AddItem "Bom Jesus do Norte - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3201100
    cmbCidadeEmitente.AddItem "Brejetuba - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3201159
    cmbCidadeEmitente.AddItem "Cachoeiro do Itapemirim - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3201209
    cmbCidadeEmitente.AddItem "Cariacica - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3201308
    cmbCidadeEmitente.AddItem "Castelo - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3201407
    cmbCidadeEmitente.AddItem "Colatina - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3201506
    cmbCidadeEmitente.AddItem "Conceicao da Barra - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3201605
    cmbCidadeEmitente.AddItem "Conceicao do Castelo - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3201704
    cmbCidadeEmitente.AddItem "Divino de Sao Lourenco - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3201803
    cmbCidadeEmitente.AddItem "Domingos Martins - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3201902
    cmbCidadeEmitente.AddItem "Dores do Rio Preto - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3202009
    cmbCidadeEmitente.AddItem "Ecoporanga - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3202108
    cmbCidadeEmitente.AddItem "Fundao - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3202207
    cmbCidadeEmitente.AddItem "Governador Lindenberg - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3202256
    cmbCidadeEmitente.AddItem "Guacui - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3202306
    cmbCidadeEmitente.AddItem "Guarapari - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3202405
    cmbCidadeEmitente.AddItem "Ibatiba - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3202454
    cmbCidadeEmitente.AddItem "Ibiracu - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3202504
    cmbCidadeEmitente.AddItem "Ibitirama - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3202553
    cmbCidadeEmitente.AddItem "Iconha - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3202603
    cmbCidadeEmitente.AddItem "Irupi - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3202652
    cmbCidadeEmitente.AddItem "Itaguacu - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3202702
    cmbCidadeEmitente.AddItem "Itapemirim - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3202801
    cmbCidadeEmitente.AddItem "Itarana - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3202900
    cmbCidadeEmitente.AddItem "Iuna - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3203007
    cmbCidadeEmitente.AddItem "Jaguare - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3203056
    cmbCidadeEmitente.AddItem "Jeronimo Monteiro - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3203106
    cmbCidadeEmitente.AddItem "Joao Neiva - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3203130
    cmbCidadeEmitente.AddItem "Laranja da Terra - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3203163
    cmbCidadeEmitente.AddItem "Linhares - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3203205
    cmbCidadeEmitente.AddItem "Mantenopolis - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3203304
    cmbCidadeEmitente.AddItem "Marataizes - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3203320
    cmbCidadeEmitente.AddItem "Marechal Floriano - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3203346
    cmbCidadeEmitente.AddItem "Marilandia - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3203353
    cmbCidadeEmitente.AddItem "Mimoso do Sul - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3203403
    cmbCidadeEmitente.AddItem "Montanha - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3203502
    cmbCidadeEmitente.AddItem "Mucurici - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3203601
    cmbCidadeEmitente.AddItem "Muniz Freire - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3203700
    cmbCidadeEmitente.AddItem "Muqui - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3203809
    cmbCidadeEmitente.AddItem "Nova Venecia - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3203908
    cmbCidadeEmitente.AddItem "Pancas - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3204005
    cmbCidadeEmitente.AddItem "Pedro Canario - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3204054
    cmbCidadeEmitente.AddItem "Pinheiros - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3204104
    cmbCidadeEmitente.AddItem "Piuma - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3204203
    cmbCidadeEmitente.AddItem "Ponto Belo - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3204252
    cmbCidadeEmitente.AddItem "Presidente Kennedy - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3204302
    cmbCidadeEmitente.AddItem "Rio Bananal - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3204351
    cmbCidadeEmitente.AddItem "Rio Novo do Sul - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3204401
    cmbCidadeEmitente.AddItem "Santa Leopoldina - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3204500
    cmbCidadeEmitente.AddItem "Santa Maria de Jetiba - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3204559
    cmbCidadeEmitente.AddItem "Santa Teresa - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3204609
    cmbCidadeEmitente.AddItem "Sao Domingos do Norte - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3204658
    cmbCidadeEmitente.AddItem "Sao Gabriel da Palha - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3204708
    cmbCidadeEmitente.AddItem "Sao Jose do Calcado - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3204807
    cmbCidadeEmitente.AddItem "Sao Mateus - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3204906
    cmbCidadeEmitente.AddItem "Sao Roque do Canaa - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3204955
    cmbCidadeEmitente.AddItem "Serra - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3205002
    cmbCidadeEmitente.AddItem "Sooretama - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3205010
    cmbCidadeEmitente.AddItem "Vargem Alta - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3205036
    cmbCidadeEmitente.AddItem "Venda Nova do Imigrante - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3205069
    cmbCidadeEmitente.AddItem "Viana - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3205101
    cmbCidadeEmitente.AddItem "Vila Pavao - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3205150
    cmbCidadeEmitente.AddItem "Vila Valerio - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3205176
    cmbCidadeEmitente.AddItem "Vila Velha - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3205200
    cmbCidadeEmitente.AddItem "Vitoria - ES"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3205309
End Sub

Public Sub RiodeJaneiro(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Angra dos Reis - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3300100
    cmbCidadeEmitente.AddItem "Aperibe - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3300159
    cmbCidadeEmitente.AddItem "Araruama - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3300209
    cmbCidadeEmitente.AddItem "Areal - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3300225
    cmbCidadeEmitente.AddItem "Armacao dos Buzios - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3300233
    cmbCidadeEmitente.AddItem "Arraial do Cabo - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3300258
    cmbCidadeEmitente.AddItem "Barra do Pirai - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3300308
    cmbCidadeEmitente.AddItem "Barra Mansa - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3300407
    cmbCidadeEmitente.AddItem "Belford Roxo - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3300456
    cmbCidadeEmitente.AddItem "Bom Jardim - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3300506
    cmbCidadeEmitente.AddItem "Bom Jesus do Itabapoana - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3300605
    cmbCidadeEmitente.AddItem "Cabo Frio - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3300704
    cmbCidadeEmitente.AddItem "Cachoeiras de Macacu - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3300803
    cmbCidadeEmitente.AddItem "Cambuci - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3300902
    cmbCidadeEmitente.AddItem "Campos dos Goytacazes - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3301009
    cmbCidadeEmitente.AddItem "Cantagalo - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3301108
    cmbCidadeEmitente.AddItem "Carapebus - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3300936
    cmbCidadeEmitente.AddItem "Cardoso Moreira - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3301157
    cmbCidadeEmitente.AddItem "Carmo - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3301207
    cmbCidadeEmitente.AddItem "Casimiro de Abreu - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3301306
    cmbCidadeEmitente.AddItem "Comendador Levy Gasparian - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3300951
    cmbCidadeEmitente.AddItem "Conceicao de Macabu - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3301405
    cmbCidadeEmitente.AddItem "Cordeiro - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3301504
    cmbCidadeEmitente.AddItem "Duas Barras - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3301603
    cmbCidadeEmitente.AddItem "Duque de Caxias - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3301702
    cmbCidadeEmitente.AddItem "Engenheiro Paulo de Frontin - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3301801
    cmbCidadeEmitente.AddItem "Guapimirim - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3301850
    cmbCidadeEmitente.AddItem "Iguaba Grande - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3301876
    cmbCidadeEmitente.AddItem "Itaborai - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3301900
    cmbCidadeEmitente.AddItem "Itaguai - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3302007
    cmbCidadeEmitente.AddItem "Italva - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3302056
    cmbCidadeEmitente.AddItem "Itaocara - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3302106
    cmbCidadeEmitente.AddItem "Itaperuna - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3302205
    cmbCidadeEmitente.AddItem "Itatiaia - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3302254
    cmbCidadeEmitente.AddItem "Japeri - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3302270
    cmbCidadeEmitente.AddItem "Laje do Muriae - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3302304
    cmbCidadeEmitente.AddItem "Macae - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3302403
    cmbCidadeEmitente.AddItem "Macuco - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3302452
    cmbCidadeEmitente.AddItem "Mage - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3302502
    cmbCidadeEmitente.AddItem "Mangaratiba - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3302601
    cmbCidadeEmitente.AddItem "Marica - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3302700
    cmbCidadeEmitente.AddItem "Mendes - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3302809
    cmbCidadeEmitente.AddItem "Mesquita - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3302858
    cmbCidadeEmitente.AddItem "Miguel Pereira - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3302908
    cmbCidadeEmitente.AddItem "Miracema - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3303005
    cmbCidadeEmitente.AddItem "Natividade - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3303104
    cmbCidadeEmitente.AddItem "Nilopolis - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3303203
    cmbCidadeEmitente.AddItem "Niteroi - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3303302
    cmbCidadeEmitente.AddItem "Nova Friburgo - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3303401
    cmbCidadeEmitente.AddItem "Nova Iguacu - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3303500
    cmbCidadeEmitente.AddItem "Paracambi - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3303609
    cmbCidadeEmitente.AddItem "Paraiba do Sul - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3303708
    cmbCidadeEmitente.AddItem "Parati - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3303807
    cmbCidadeEmitente.AddItem "Paty do Alferes - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3303856
    cmbCidadeEmitente.AddItem "Petropolis - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3303906
    cmbCidadeEmitente.AddItem "Pinheiral - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3303955
    cmbCidadeEmitente.AddItem "Piraí - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3304003
    cmbCidadeEmitente.AddItem "Porciuncula - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3304102
    cmbCidadeEmitente.AddItem "Porto Real - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3304110
    cmbCidadeEmitente.AddItem "Quatis - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3304128
    cmbCidadeEmitente.AddItem "Queimados - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3304144
    cmbCidadeEmitente.AddItem "Quissama - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3304151
    cmbCidadeEmitente.AddItem "Resende - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3304201
    cmbCidadeEmitente.AddItem "Rio Bonito - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3304300
    cmbCidadeEmitente.AddItem "Rio Claro - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3304409
    cmbCidadeEmitente.AddItem "Rio das Flores - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3304508
    cmbCidadeEmitente.AddItem "Rio das Ostras - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3304524
    cmbCidadeEmitente.AddItem "Rio de Janeiro - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3304557
    cmbCidadeEmitente.AddItem "Santa Maria Madalena - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3304607
    cmbCidadeEmitente.AddItem "Santo Antonio de Padua - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3304706
    cmbCidadeEmitente.AddItem "Sao Fidelis - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3304805
    cmbCidadeEmitente.AddItem "Sao Francisco de Itabapoana - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3304755
    cmbCidadeEmitente.AddItem "Sao Goncalo - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3304904
    cmbCidadeEmitente.AddItem "Sao Joao da Barra - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3305000
    cmbCidadeEmitente.AddItem "Sao Joao de Meriti - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3305109
    cmbCidadeEmitente.AddItem "Sao Jose de Uba - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3305133
    cmbCidadeEmitente.AddItem "Sao Jose do Vale do Rio Preto - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3305158
    cmbCidadeEmitente.AddItem "Sao Pedro da Aldeia - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3305208
    cmbCidadeEmitente.AddItem "Sao Sebastiao do Alto - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3305307
    cmbCidadeEmitente.AddItem "Sapucaia - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3305406
    cmbCidadeEmitente.AddItem "Saquarema - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3305505
    cmbCidadeEmitente.AddItem "Seropedica - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3305554
    cmbCidadeEmitente.AddItem "Silva Jardim - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3305604
    cmbCidadeEmitente.AddItem "Sumidouro - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3305703
    cmbCidadeEmitente.AddItem "Tangua - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3305752
    cmbCidadeEmitente.AddItem "Teresopolis - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3305802
    cmbCidadeEmitente.AddItem "Trajano de Morais - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3305901
    cmbCidadeEmitente.AddItem "Tres Rios - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3306008
    cmbCidadeEmitente.AddItem "Valenca - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3306107
    cmbCidadeEmitente.AddItem "Varre-Sai - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3306156
    cmbCidadeEmitente.AddItem "Vassouras - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3306206
    cmbCidadeEmitente.AddItem "Volta Redonda - RJ"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3306305
End Sub

Public Sub SaoPaulo(ByRef cmbCidadeEmitente As ComboBox)
    SaoPaulo1 cmbCidadeEmitente
    SaoPaulo2 cmbCidadeEmitente
    SaoPaulo3 cmbCidadeEmitente
    SaoPaulo4 cmbCidadeEmitente
    SaoPaulo5 cmbCidadeEmitente
End Sub

Private Sub SaoPaulo1(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Adamantina - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3500105
    cmbCidadeEmitente.AddItem "Adolfo - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3500204
    cmbCidadeEmitente.AddItem "Aguai - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3500303
    cmbCidadeEmitente.AddItem "Aguas da Prata - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3500402
    cmbCidadeEmitente.AddItem "Aguas de Lindoia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3500501
    cmbCidadeEmitente.AddItem "Aguas de Santa Barbara - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3500550
    cmbCidadeEmitente.AddItem "Aguas de Sao Pedro - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3500600
    cmbCidadeEmitente.AddItem "Agudos - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3500709
    cmbCidadeEmitente.AddItem "Alambari - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3500758
    cmbCidadeEmitente.AddItem "Alfredo Marcondes - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3500808
    cmbCidadeEmitente.AddItem "Altair - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3500907
    cmbCidadeEmitente.AddItem "Altinopolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3501004
    cmbCidadeEmitente.AddItem "Alto Alegre - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3501103
    cmbCidadeEmitente.AddItem "Aluminio - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3501152
    cmbCidadeEmitente.AddItem "Alvares Florence - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3501202
    cmbCidadeEmitente.AddItem "Alvares Machado - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3501301
    cmbCidadeEmitente.AddItem "Alvaro de Carvalho - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3501400
    cmbCidadeEmitente.AddItem "Alvinlandia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3501509
    cmbCidadeEmitente.AddItem "Americana - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3501608
    cmbCidadeEmitente.AddItem "Americo Brasiliense - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3501707
    cmbCidadeEmitente.AddItem "Americo de Campos - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3501806
    cmbCidadeEmitente.AddItem "Amparo - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3501905
    cmbCidadeEmitente.AddItem "Analandia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3502002
    cmbCidadeEmitente.AddItem "Andradina - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3502101
    cmbCidadeEmitente.AddItem "Angatuba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3502200
    cmbCidadeEmitente.AddItem "Anhembi - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3502309
    cmbCidadeEmitente.AddItem "Anhumas - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3502408
    cmbCidadeEmitente.AddItem "Aparecida - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3502507
    cmbCidadeEmitente.AddItem "Aparecida D Oeste - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3502606
    cmbCidadeEmitente.AddItem "Apiai - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3502705
    cmbCidadeEmitente.AddItem "Aracariguama - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3502754
    cmbCidadeEmitente.AddItem "Aracatuba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3502804
    cmbCidadeEmitente.AddItem "Aracoiaba da Serra - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3502903
    cmbCidadeEmitente.AddItem "Aramina - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3503000
    cmbCidadeEmitente.AddItem "Arandu - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3503109
    cmbCidadeEmitente.AddItem "Arapei - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3503158
    cmbCidadeEmitente.AddItem "Araraquara - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3503208
    cmbCidadeEmitente.AddItem "Araras - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3503307
    cmbCidadeEmitente.AddItem "Arco-Iris - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3503356
    cmbCidadeEmitente.AddItem "Arealva - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3503406
    cmbCidadeEmitente.AddItem "Areias - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3503505
    cmbCidadeEmitente.AddItem "Areiopolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3503604
    cmbCidadeEmitente.AddItem "Ariranha - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3503703
    cmbCidadeEmitente.AddItem "Artur Nogueira - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3503802
    cmbCidadeEmitente.AddItem "Aruja - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3503901
    cmbCidadeEmitente.AddItem "Aspasia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3503950
    cmbCidadeEmitente.AddItem "Assis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3504008
    cmbCidadeEmitente.AddItem "Atibaia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3504107
    cmbCidadeEmitente.AddItem "Auriflama - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3504206
    cmbCidadeEmitente.AddItem "Avai - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3504305
    cmbCidadeEmitente.AddItem "Avanhandava - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3504404
    cmbCidadeEmitente.AddItem "Avare - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3504503
    cmbCidadeEmitente.AddItem "Bady Bassitt - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3504602
    cmbCidadeEmitente.AddItem "Balbinos - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3504701
    cmbCidadeEmitente.AddItem "Balsamo - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3504800
    cmbCidadeEmitente.AddItem "Bananal - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3504909
    cmbCidadeEmitente.AddItem "Barao de Antonina - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3505005
    cmbCidadeEmitente.AddItem "Barbosa - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3505104
    cmbCidadeEmitente.AddItem "Bariri - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3505203
    cmbCidadeEmitente.AddItem "Barra Bonita - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3505302
    cmbCidadeEmitente.AddItem "Barra do Chapeu - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3505351
    cmbCidadeEmitente.AddItem "Barra do Turvo - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3505401
    cmbCidadeEmitente.AddItem "Barretos - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3505500
    cmbCidadeEmitente.AddItem "Barrinha - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3505609
    cmbCidadeEmitente.AddItem "Barueri - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3505708
    cmbCidadeEmitente.AddItem "Bastos - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3505807
    cmbCidadeEmitente.AddItem "Batatais - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3505906
    cmbCidadeEmitente.AddItem "Bauru - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3506003
    cmbCidadeEmitente.AddItem "Bebedouro - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3506102
    cmbCidadeEmitente.AddItem "Bento de Abreu - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3506201
    cmbCidadeEmitente.AddItem "Bernardino de Campos - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3506300
    cmbCidadeEmitente.AddItem "Bertioga - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3506359
    cmbCidadeEmitente.AddItem "Bilac - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3506409
    cmbCidadeEmitente.AddItem "Birigui - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3506508
    cmbCidadeEmitente.AddItem "Biritiba-Mirim - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3506607
    cmbCidadeEmitente.AddItem "Boa Esperanca do Sul - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3506706
    cmbCidadeEmitente.AddItem "Bocaina - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3506805
    cmbCidadeEmitente.AddItem "Bofete - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3506904
    cmbCidadeEmitente.AddItem "Boituva - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3507001
    cmbCidadeEmitente.AddItem "Bom Jesus dos Perdoes - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3507100
    cmbCidadeEmitente.AddItem "Bom Sucesso de Itarare - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3507159
    cmbCidadeEmitente.AddItem "Bora - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3507209
    cmbCidadeEmitente.AddItem "Boraceia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3507308
    cmbCidadeEmitente.AddItem "Borborema - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3507407
    cmbCidadeEmitente.AddItem "Borebi - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3507456
    cmbCidadeEmitente.AddItem "Botucatu - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3507506
    cmbCidadeEmitente.AddItem "Braganca Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3507605
    cmbCidadeEmitente.AddItem "Brauna - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3507704
    cmbCidadeEmitente.AddItem "Brejo Alegre - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3507753
    cmbCidadeEmitente.AddItem "Brodowski - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3507803
    cmbCidadeEmitente.AddItem "Brotas - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3507902
    cmbCidadeEmitente.AddItem "Buri - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3508009
    cmbCidadeEmitente.AddItem "Buritama - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3508108
    cmbCidadeEmitente.AddItem "Buritizal - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3508207
    cmbCidadeEmitente.AddItem "Cabralia Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3508306
    cmbCidadeEmitente.AddItem "Cabreuva - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3508405
    cmbCidadeEmitente.AddItem "Cacapava - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3508504
    cmbCidadeEmitente.AddItem "Cachoeira Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3508603
    cmbCidadeEmitente.AddItem "Caconde - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3508702
    cmbCidadeEmitente.AddItem "Cafelandia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3508801
    cmbCidadeEmitente.AddItem "Caiabu - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3508900
    cmbCidadeEmitente.AddItem "Caieiras - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3509007
    cmbCidadeEmitente.AddItem "Caiua - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3509106
    cmbCidadeEmitente.AddItem "Cajamar - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3509205
    cmbCidadeEmitente.AddItem "Cajati - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3509254
    cmbCidadeEmitente.AddItem "Cajobi - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3509304
    cmbCidadeEmitente.AddItem "Cajuru - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3509403
    cmbCidadeEmitente.AddItem "Campina do Monte Alegre - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3509452
    cmbCidadeEmitente.AddItem "Campinas - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3509502
    cmbCidadeEmitente.AddItem "Campo Limpo Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3509601
    cmbCidadeEmitente.AddItem "Campos do Jordao - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3509700
    cmbCidadeEmitente.AddItem "Campos Novos Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3509809
    cmbCidadeEmitente.AddItem "Cananeia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3509908
    cmbCidadeEmitente.AddItem "Canas - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3509957
    cmbCidadeEmitente.AddItem "Candido Mota - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3510005
    cmbCidadeEmitente.AddItem "Candido Rodrigues - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3510104
    cmbCidadeEmitente.AddItem "Canitar - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3510153
    cmbCidadeEmitente.AddItem "Capao Bonito - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3510203
    cmbCidadeEmitente.AddItem "Capela do Alto - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3510302
    cmbCidadeEmitente.AddItem "Capivari - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3510401
    cmbCidadeEmitente.AddItem "Caraguatatuba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3510500
    cmbCidadeEmitente.AddItem "Carapicuiba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3510609
    cmbCidadeEmitente.AddItem "Cardoso - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3510708
    cmbCidadeEmitente.AddItem "Casa Branca - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3510807
    cmbCidadeEmitente.AddItem "Cassia dos Coqueiros - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3510906
    cmbCidadeEmitente.AddItem "Castilho - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3511003
    cmbCidadeEmitente.AddItem "Catanduva - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3511102
    cmbCidadeEmitente.AddItem "Catigua - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3511201
    cmbCidadeEmitente.AddItem "Cedral - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3511300
    cmbCidadeEmitente.AddItem "Cerqueira Cesar - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3511409
    cmbCidadeEmitente.AddItem "Cerquilho - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3511508
    cmbCidadeEmitente.AddItem "Cesario Lange - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3511607
    cmbCidadeEmitente.AddItem "Charqueada - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3511706
    cmbCidadeEmitente.AddItem "Chavantes - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3557204
    cmbCidadeEmitente.AddItem "Clementina - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3511904
    cmbCidadeEmitente.AddItem "Colina - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3512001
    cmbCidadeEmitente.AddItem "Colombia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3512100
    cmbCidadeEmitente.AddItem "Conchal - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3512209
    cmbCidadeEmitente.AddItem "Conchas - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3512308
    cmbCidadeEmitente.AddItem "Cordeiropolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3512407
    cmbCidadeEmitente.AddItem "Coroados - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3512506
    cmbCidadeEmitente.AddItem "Coronel Macedo - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3512605
    cmbCidadeEmitente.AddItem "Corumbatai - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3512704
    cmbCidadeEmitente.AddItem "Cosmopolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3512803
    cmbCidadeEmitente.AddItem "Cosmorama - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3512902
    cmbCidadeEmitente.AddItem "Cotia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3513009
    cmbCidadeEmitente.AddItem "Cravinhos - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3513108
    cmbCidadeEmitente.AddItem "Cristais Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3513207
    cmbCidadeEmitente.AddItem "Cruzalia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3513306
    cmbCidadeEmitente.AddItem "Cruzeiro - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3513405
End Sub

Private Sub SaoPaulo2(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Cubatao - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3513504
    cmbCidadeEmitente.AddItem "Cunha - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3513603
    cmbCidadeEmitente.AddItem "Descalvado - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3513702
    cmbCidadeEmitente.AddItem "Diadema - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3513801
    cmbCidadeEmitente.AddItem "Dirce Reis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3513850
    cmbCidadeEmitente.AddItem "Divinolandia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3513900
    cmbCidadeEmitente.AddItem "Dobrada - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3514007
    cmbCidadeEmitente.AddItem "Dois Corregos - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3514106
    cmbCidadeEmitente.AddItem "Dolcinopolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3514205
    cmbCidadeEmitente.AddItem "Dourado - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3514304
    cmbCidadeEmitente.AddItem "Dracena - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3514403
    cmbCidadeEmitente.AddItem "Duartina - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3514502
    cmbCidadeEmitente.AddItem "Dumont - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3514601
    cmbCidadeEmitente.AddItem "Echapora - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3514700
    cmbCidadeEmitente.AddItem "Eldorado - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3514809
    cmbCidadeEmitente.AddItem "Elias Fausto - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3514908
    cmbCidadeEmitente.AddItem "Elisiario - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3514924
    cmbCidadeEmitente.AddItem "Embauba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3514957
    cmbCidadeEmitente.AddItem "Embu das Artes - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3515004
    cmbCidadeEmitente.AddItem "Embu-Guacu - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3515103
    cmbCidadeEmitente.AddItem "Emilianopolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3515129
    cmbCidadeEmitente.AddItem "Engenheiro Coelho - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3515152
    cmbCidadeEmitente.AddItem "Espirito Santo do Pinhal - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3515186
    cmbCidadeEmitente.AddItem "Espirito Santo do Turvo - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3515194
    cmbCidadeEmitente.AddItem "Estiva Gerbi - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3557303
    cmbCidadeEmitente.AddItem "Estrela D Oeste - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3515202
    cmbCidadeEmitente.AddItem "Estrela do Norte - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3515301
    cmbCidadeEmitente.AddItem "Euclides da Cunha Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3515350
    cmbCidadeEmitente.AddItem "Fartura - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3515400
    cmbCidadeEmitente.AddItem "Fernando Prestes - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3515608
    cmbCidadeEmitente.AddItem "Fernandopolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3515509
    cmbCidadeEmitente.AddItem "Fernao - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3515657
    cmbCidadeEmitente.AddItem "Ferraz de Vasconcelos - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3515707
    cmbCidadeEmitente.AddItem "Flora Rica - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3515806
    cmbCidadeEmitente.AddItem "Floreal - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3515905
    cmbCidadeEmitente.AddItem "Florida Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3516002
    cmbCidadeEmitente.AddItem "Florinia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3516101
    cmbCidadeEmitente.AddItem "Franca - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3516200
    cmbCidadeEmitente.AddItem "Francisco Morato - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3516309
    cmbCidadeEmitente.AddItem "Franco da Rocha - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3516408
    cmbCidadeEmitente.AddItem "Gabriel Monteiro - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3516507
    cmbCidadeEmitente.AddItem "Galia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3516606
    cmbCidadeEmitente.AddItem "Garca - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3516705
    cmbCidadeEmitente.AddItem "Gastao Vidigal - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3516804
    cmbCidadeEmitente.AddItem "Gaviao Peixoto - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3516853
    cmbCidadeEmitente.AddItem "General Salgado - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3516903
    cmbCidadeEmitente.AddItem "Getulina - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3517000
    cmbCidadeEmitente.AddItem "Glicerio - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3517109
    cmbCidadeEmitente.AddItem "Guaicara - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3517208
    cmbCidadeEmitente.AddItem "Guaimbe - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3517307
    cmbCidadeEmitente.AddItem "Guaira - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3517406
    cmbCidadeEmitente.AddItem "Guapiaçu - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3517505
    cmbCidadeEmitente.AddItem "Guapiara - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3517604
    cmbCidadeEmitente.AddItem "Guara - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3517703
    cmbCidadeEmitente.AddItem "Guaracai - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3517802
    cmbCidadeEmitente.AddItem "Guaraci - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3517901
    cmbCidadeEmitente.AddItem "Guarani D Oeste - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3518008
    cmbCidadeEmitente.AddItem "Guaranta - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3518107
    cmbCidadeEmitente.AddItem "Guararapes - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3518206
    cmbCidadeEmitente.AddItem "Guararema - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3518305
    cmbCidadeEmitente.AddItem "Guaratingueta - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3518404
    cmbCidadeEmitente.AddItem "Guarei - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3518503
    cmbCidadeEmitente.AddItem "Guariba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3518602
    cmbCidadeEmitente.AddItem "Guaruja - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3518701
    cmbCidadeEmitente.AddItem "Guarulhos - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3518800
    cmbCidadeEmitente.AddItem "Guatapara - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3518859
    cmbCidadeEmitente.AddItem "Guzolandia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3518909
    cmbCidadeEmitente.AddItem "Herculandia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3519006
    cmbCidadeEmitente.AddItem "Holambra - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3519055
    cmbCidadeEmitente.AddItem "Hortolandia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3519071
    cmbCidadeEmitente.AddItem "Iacanga - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3519105
    cmbCidadeEmitente.AddItem "Iacri - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3519204
    cmbCidadeEmitente.AddItem "Iaras - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3519253
    cmbCidadeEmitente.AddItem "Ibate - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3519303
    cmbCidadeEmitente.AddItem "Ibira - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3519402
    cmbCidadeEmitente.AddItem "Ibirarema - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3519501
    cmbCidadeEmitente.AddItem "Ibitinga - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3519600
    cmbCidadeEmitente.AddItem "Ibiuna - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3519709
    cmbCidadeEmitente.AddItem "Icem - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3519808
    cmbCidadeEmitente.AddItem "Iepe - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3519907
    cmbCidadeEmitente.AddItem "Igaracu do Tiete - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3520004
    cmbCidadeEmitente.AddItem "Igarapava - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3520103
    cmbCidadeEmitente.AddItem "Igarata - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3520202
    cmbCidadeEmitente.AddItem "Iguape - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3520301
    cmbCidadeEmitente.AddItem "Ilha Comprida - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3520426
    cmbCidadeEmitente.AddItem "Ilha Solteira - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3520442
    cmbCidadeEmitente.AddItem "Ilhabela - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3520400
    cmbCidadeEmitente.AddItem "Indaiatuba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3520509
    cmbCidadeEmitente.AddItem "Indiana - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3520608
    cmbCidadeEmitente.AddItem "Indiapora - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3520707
    cmbCidadeEmitente.AddItem "Inubia Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3520806
    cmbCidadeEmitente.AddItem "Ipaussu - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3520905
    cmbCidadeEmitente.AddItem "Ipero - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3521002
    cmbCidadeEmitente.AddItem "Ipeuna - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3521101
    cmbCidadeEmitente.AddItem "Ipigua - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3521150
    cmbCidadeEmitente.AddItem "Iporanga - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3521200
    cmbCidadeEmitente.AddItem "Ipua - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3521309
    cmbCidadeEmitente.AddItem "Iracemapolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3521408
    cmbCidadeEmitente.AddItem "Irapua - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3521507
    cmbCidadeEmitente.AddItem "Irapuru - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3521606
    cmbCidadeEmitente.AddItem "Itabera - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3521705
    cmbCidadeEmitente.AddItem "Itai - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3521804
    cmbCidadeEmitente.AddItem "Itajobi - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3521903
    cmbCidadeEmitente.AddItem "Itaju - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3522000
    cmbCidadeEmitente.AddItem "Itanhaem - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3522109
    cmbCidadeEmitente.AddItem "Itaoca - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3522158
    cmbCidadeEmitente.AddItem "Itapecerica da Serra - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3522208
    cmbCidadeEmitente.AddItem "Itapetininga - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3522307
    cmbCidadeEmitente.AddItem "Itapeva - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3522406
    cmbCidadeEmitente.AddItem "Itapevi - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3522505
    cmbCidadeEmitente.AddItem "Itapira - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3522604
    cmbCidadeEmitente.AddItem "Itapirapua Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3522653
    cmbCidadeEmitente.AddItem "Itapolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3522703
    cmbCidadeEmitente.AddItem "Itaporanga - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3522802
    cmbCidadeEmitente.AddItem "Itapui - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3522901
    cmbCidadeEmitente.AddItem "Itapura - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3523008
    cmbCidadeEmitente.AddItem "Itaquaquecetuba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3523107
    cmbCidadeEmitente.AddItem "Itarare - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3523206
    cmbCidadeEmitente.AddItem "Itariri - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3523305
    cmbCidadeEmitente.AddItem "Itatiba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3523404
    cmbCidadeEmitente.AddItem "Itatinga - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3523503
    cmbCidadeEmitente.AddItem "Itirapina - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3523602
    cmbCidadeEmitente.AddItem "Itirapua - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3523701
    cmbCidadeEmitente.AddItem "Itobi - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3523800
    cmbCidadeEmitente.AddItem "Itu - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3523909
    cmbCidadeEmitente.AddItem "Itupeva - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3524006
    cmbCidadeEmitente.AddItem "Ituverava - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3524105
    cmbCidadeEmitente.AddItem "Jaborandi - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3524204
    cmbCidadeEmitente.AddItem "Jaboticabal - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3524303
    cmbCidadeEmitente.AddItem "Jacarei - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3524402
    cmbCidadeEmitente.AddItem "Jaci - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3524501
    cmbCidadeEmitente.AddItem "Jacupiranga - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3524600
    cmbCidadeEmitente.AddItem "Jaguariuna - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3524709
    cmbCidadeEmitente.AddItem "Jales - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3524808
    cmbCidadeEmitente.AddItem "Jambeiro - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3524907
    cmbCidadeEmitente.AddItem "Jandira - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3525003
    cmbCidadeEmitente.AddItem "Jardinopolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3525102
    cmbCidadeEmitente.AddItem "Jarinu - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3525201
    cmbCidadeEmitente.AddItem "Jau - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3525300
    cmbCidadeEmitente.AddItem "Jeriquara - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3525409
    cmbCidadeEmitente.AddItem "Joanopolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3525508
    cmbCidadeEmitente.AddItem "Joao Ramalho - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3525607
    cmbCidadeEmitente.AddItem "Jose Bonifacio - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3525706
    cmbCidadeEmitente.AddItem "Julio Mesquita - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3525805
    cmbCidadeEmitente.AddItem "Jumirim - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3525854
    cmbCidadeEmitente.AddItem "Jundiai - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3525904
    cmbCidadeEmitente.AddItem "Junqueiropolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3526001
    cmbCidadeEmitente.AddItem "Juquia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3526100
    cmbCidadeEmitente.AddItem "Juquitiba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3526209
    cmbCidadeEmitente.AddItem "Lagoinha - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3526308
End Sub

Private Sub SaoPaulo3(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Laranjal Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3526407
    cmbCidadeEmitente.AddItem "Lavinia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3526506
    cmbCidadeEmitente.AddItem "Lavrinhas - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3526605
    cmbCidadeEmitente.AddItem "Leme - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3526704
    cmbCidadeEmitente.AddItem "Lencois Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3526803
    cmbCidadeEmitente.AddItem "Limeira - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3526902
    cmbCidadeEmitente.AddItem "Lindoia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3527009
    cmbCidadeEmitente.AddItem "Lins - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3527108
    cmbCidadeEmitente.AddItem "Lorena - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3527207
    cmbCidadeEmitente.AddItem "Lourdes - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3527256
    cmbCidadeEmitente.AddItem "Louveira - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3527306
    cmbCidadeEmitente.AddItem "Lucelia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3527405
    cmbCidadeEmitente.AddItem "Lucianopolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3527504
    cmbCidadeEmitente.AddItem "Luis Antonio - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3527603
    cmbCidadeEmitente.AddItem "Luiziania - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3527702
    cmbCidadeEmitente.AddItem "Lupercio - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3527801
    cmbCidadeEmitente.AddItem "Lutecia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3527900
    cmbCidadeEmitente.AddItem "Macatuba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3528007
    cmbCidadeEmitente.AddItem "Macaubal - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3528106
    cmbCidadeEmitente.AddItem "Macedonia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3528205
    cmbCidadeEmitente.AddItem "Magda - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3528304
    cmbCidadeEmitente.AddItem "Mairinque - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3528403
    cmbCidadeEmitente.AddItem "Mairipora - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3528502
    cmbCidadeEmitente.AddItem "Manduri - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3528601
    cmbCidadeEmitente.AddItem "Maraba Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3528700
    cmbCidadeEmitente.AddItem "Maracai - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3528809
    cmbCidadeEmitente.AddItem "Marapoama - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3528858
    cmbCidadeEmitente.AddItem "Mariapolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3528908
    cmbCidadeEmitente.AddItem "Marilia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3529005
    cmbCidadeEmitente.AddItem "Marinopolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3529104
    cmbCidadeEmitente.AddItem "Martinopolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3529203
    cmbCidadeEmitente.AddItem "Matao - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3529302
    cmbCidadeEmitente.AddItem "Maua - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3529401
    cmbCidadeEmitente.AddItem "Mendonca - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3529500
    cmbCidadeEmitente.AddItem "Meridiano - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3529609
    cmbCidadeEmitente.AddItem "Mesopolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3529658
    cmbCidadeEmitente.AddItem "Miguelopolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3529708
    cmbCidadeEmitente.AddItem "Mineiros do Tiete - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3529807
    cmbCidadeEmitente.AddItem "Mira Estrela - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3530003
    cmbCidadeEmitente.AddItem "Miracatu - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3529906
    cmbCidadeEmitente.AddItem "Mirandopolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3530102
    cmbCidadeEmitente.AddItem "Mirante do Paranapanema - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3530201
    cmbCidadeEmitente.AddItem "Mirassol - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3530300
    cmbCidadeEmitente.AddItem "Mirassolandia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3530409
    cmbCidadeEmitente.AddItem "Mococa - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3530508
    cmbCidadeEmitente.AddItem "Mogi das Cruzes - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3530607
    cmbCidadeEmitente.AddItem "Mogi Guacu - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3530706
    cmbCidadeEmitente.AddItem "Mogi Mirim - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3530805
    cmbCidadeEmitente.AddItem "Mombuca - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3530904
    cmbCidadeEmitente.AddItem "Moncoes - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3531001
    cmbCidadeEmitente.AddItem "Mongagua - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3531100
    cmbCidadeEmitente.AddItem "Monte Alegre do Sul - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3531209
    cmbCidadeEmitente.AddItem "Monte Alto - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3531308
    cmbCidadeEmitente.AddItem "Monte Aprazivel - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3531407
    cmbCidadeEmitente.AddItem "Monte Azul Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3531506
    cmbCidadeEmitente.AddItem "Monte Castelo - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3531605
    cmbCidadeEmitente.AddItem "Monte Mor - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3531803
    cmbCidadeEmitente.AddItem "Monteiro Lobato - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3531704
    cmbCidadeEmitente.AddItem "Morro Agudo - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3531902
    cmbCidadeEmitente.AddItem "Morungaba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3532009
    cmbCidadeEmitente.AddItem "Motuca - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3532058
    cmbCidadeEmitente.AddItem "Murutinga do Sul - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3532108
    cmbCidadeEmitente.AddItem "Nantes - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3532157
    cmbCidadeEmitente.AddItem "Narandiba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3532207
    cmbCidadeEmitente.AddItem "Natividade da Serra - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3532306
    cmbCidadeEmitente.AddItem "Nazare Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3532405
    cmbCidadeEmitente.AddItem "Neves Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3532504
    cmbCidadeEmitente.AddItem "Nhandeara - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3532603
    cmbCidadeEmitente.AddItem "Nipoa - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3532702
    cmbCidadeEmitente.AddItem "Nova Alianca - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3532801
    cmbCidadeEmitente.AddItem "Nova Campina - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3532827
    cmbCidadeEmitente.AddItem "Nova Canaa Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3532843
    cmbCidadeEmitente.AddItem "Nova Castilho - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3532868
    cmbCidadeEmitente.AddItem "Nova Europa - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3532900
    cmbCidadeEmitente.AddItem "Nova Granada - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3533007
    cmbCidadeEmitente.AddItem "Nova Guataporanga - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3533106
    cmbCidadeEmitente.AddItem "Nova Independencia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3533205
    cmbCidadeEmitente.AddItem "Nova Luzitania - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3533304
    cmbCidadeEmitente.AddItem "Nova Odessa - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3533403
    cmbCidadeEmitente.AddItem "Novais - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3533254
    cmbCidadeEmitente.AddItem "Novo Horizonte - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3533502
    cmbCidadeEmitente.AddItem "Nuporanga - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3533601
    cmbCidadeEmitente.AddItem "Ocaucu - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3533700
    cmbCidadeEmitente.AddItem "Oleo - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3533809
    cmbCidadeEmitente.AddItem "Olimpia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3533908
    cmbCidadeEmitente.AddItem "Onda Verde - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3534005
    cmbCidadeEmitente.AddItem "Oriente - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3534104
    cmbCidadeEmitente.AddItem "Orindiuva - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3534203
    cmbCidadeEmitente.AddItem "Orlandia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3534302
    cmbCidadeEmitente.AddItem "Osasco - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3534401
    cmbCidadeEmitente.AddItem "Oscar Bressane - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3534500
    cmbCidadeEmitente.AddItem "Osvaldo Cruz - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3534609
    cmbCidadeEmitente.AddItem "Ourinhos - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3534708
    cmbCidadeEmitente.AddItem "Ouro Verde - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3534807
    cmbCidadeEmitente.AddItem "Ouroeste - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3534757
    cmbCidadeEmitente.AddItem "Pacaembu - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3534906
    cmbCidadeEmitente.AddItem "Palestina - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3535002
    cmbCidadeEmitente.AddItem "Palmares Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3535101
    cmbCidadeEmitente.AddItem "Palmeira D Oeste - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3535200
    cmbCidadeEmitente.AddItem "Palmital - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3535309
    cmbCidadeEmitente.AddItem "Panorama - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3535408
    cmbCidadeEmitente.AddItem "Paraguacu Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3535507
    cmbCidadeEmitente.AddItem "Paraibuna - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3535606
    cmbCidadeEmitente.AddItem "Paraiso - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3535705
    cmbCidadeEmitente.AddItem "Paranapanema - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3535804
    cmbCidadeEmitente.AddItem "Paranapua - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3535903
    cmbCidadeEmitente.AddItem "Parapua - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3536000
    cmbCidadeEmitente.AddItem "Pardinho - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3536109
    cmbCidadeEmitente.AddItem "Pariquera-Acu - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3536208
    cmbCidadeEmitente.AddItem "Parisi - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3536257
    cmbCidadeEmitente.AddItem "Patrocinio Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3536307
    cmbCidadeEmitente.AddItem "Pauliceia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3536406
    cmbCidadeEmitente.AddItem "Paulinia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3536505
    cmbCidadeEmitente.AddItem "Paulistania - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3536570
    cmbCidadeEmitente.AddItem "Paulo de Faria - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3536604
    cmbCidadeEmitente.AddItem "Pederneiras - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3536703
    cmbCidadeEmitente.AddItem "Pedra Bela - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3536802
    cmbCidadeEmitente.AddItem "Pedranopolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3536901
    cmbCidadeEmitente.AddItem "Pedregulho - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3537008
    cmbCidadeEmitente.AddItem "Pedreira - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3537107
    cmbCidadeEmitente.AddItem "Pedrinhas Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3537156
    cmbCidadeEmitente.AddItem "Pedro de Toledo - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3537206
    cmbCidadeEmitente.AddItem "Penapolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3537305
    cmbCidadeEmitente.AddItem "Pereira Barreto - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3537404
    cmbCidadeEmitente.AddItem "Pereiras - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3537503
    cmbCidadeEmitente.AddItem "Peruibe - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3537602
    cmbCidadeEmitente.AddItem "Piacatu - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3537701
    cmbCidadeEmitente.AddItem "Piedade - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3537800
    cmbCidadeEmitente.AddItem "Pilar do Sul - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3537909
    cmbCidadeEmitente.AddItem "Pindamonhangaba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3538006
    cmbCidadeEmitente.AddItem "Pindorama - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3538105
    cmbCidadeEmitente.AddItem "Pinhalzinho - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3538204
    cmbCidadeEmitente.AddItem "Piquerobi - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3538303
    cmbCidadeEmitente.AddItem "Piquete - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3538501
    cmbCidadeEmitente.AddItem "Piracaia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3538600
    cmbCidadeEmitente.AddItem "Piracicaba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3538709
    cmbCidadeEmitente.AddItem "Piraju - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3538808
    cmbCidadeEmitente.AddItem "Pirajui - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3538907
    cmbCidadeEmitente.AddItem "Pirangi - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3539004
    cmbCidadeEmitente.AddItem "Pirapora do Bom Jesus - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3539103
    cmbCidadeEmitente.AddItem "Pirapozinho - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3539202
    cmbCidadeEmitente.AddItem "Pirassununga - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3539301
    cmbCidadeEmitente.AddItem "Piratininga - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3539400
    cmbCidadeEmitente.AddItem "Pitangueiras - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3539509
    cmbCidadeEmitente.AddItem "Planalto - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3539608
    cmbCidadeEmitente.AddItem "Platina - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3539707
    cmbCidadeEmitente.AddItem "Poa - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3539806
    cmbCidadeEmitente.AddItem "Poloni - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3539905
    cmbCidadeEmitente.AddItem "Pompeia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3540002
    cmbCidadeEmitente.AddItem "Pongai - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3540101
End Sub

Private Sub SaoPaulo4(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Pontal - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3540200
    cmbCidadeEmitente.AddItem "Pontalinda - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3540259
    cmbCidadeEmitente.AddItem "Pontes Gestal - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3540309
    cmbCidadeEmitente.AddItem "Populina - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3540408
    cmbCidadeEmitente.AddItem "Porangaba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3540507
    cmbCidadeEmitente.AddItem "Porto Feliz - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3540606
    cmbCidadeEmitente.AddItem "Porto Ferreira - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3540705
    cmbCidadeEmitente.AddItem "Potim - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3540754
    cmbCidadeEmitente.AddItem "Potirendaba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3540804
    cmbCidadeEmitente.AddItem "Pracinha - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3540853
    cmbCidadeEmitente.AddItem "Pradopolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3540903
    cmbCidadeEmitente.AddItem "Praia Grande - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3541000
    cmbCidadeEmitente.AddItem "Pratania - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3541059
    cmbCidadeEmitente.AddItem "Presidente Alves - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3541109
    cmbCidadeEmitente.AddItem "Presidente Bernardes - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3541208
    cmbCidadeEmitente.AddItem "Presidente Epitacio - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3541307
    cmbCidadeEmitente.AddItem "Presidente Prudente - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3541406
    cmbCidadeEmitente.AddItem "Presidente Venceslau - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3541505
    cmbCidadeEmitente.AddItem "Promissao - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3541604
    cmbCidadeEmitente.AddItem "Quadra - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3541653
    cmbCidadeEmitente.AddItem "Quata - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3541703
    cmbCidadeEmitente.AddItem "Queiroz - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3541802
    cmbCidadeEmitente.AddItem "Queluz - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3541901
    cmbCidadeEmitente.AddItem "Quintana - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3542008
    cmbCidadeEmitente.AddItem "Rafard - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3542107
    cmbCidadeEmitente.AddItem "Rancharia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3542206
    cmbCidadeEmitente.AddItem "Redencao da Serra - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3542305
    cmbCidadeEmitente.AddItem "Regente Feijo - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3542404
    cmbCidadeEmitente.AddItem "Reginopolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3542503
    cmbCidadeEmitente.AddItem "Registro - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3542602
    cmbCidadeEmitente.AddItem "Restinga - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3542701
    cmbCidadeEmitente.AddItem "Ribeira - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3542800
    cmbCidadeEmitente.AddItem "Ribeirao Bonito - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3542909
    cmbCidadeEmitente.AddItem "Ribeirao Branco - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3543006
    cmbCidadeEmitente.AddItem "Ribeirao Corrente - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3543105
    cmbCidadeEmitente.AddItem "Ribeirao do Sul - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3543204
    cmbCidadeEmitente.AddItem "Ribeirao dos Indios - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3543238
    cmbCidadeEmitente.AddItem "Ribeirao Grande - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3543253
    cmbCidadeEmitente.AddItem "Ribeirao Pires - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3543303
    cmbCidadeEmitente.AddItem "Ribeirao Preto - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3543402
    cmbCidadeEmitente.AddItem "Rifaina - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3543600
    cmbCidadeEmitente.AddItem "Rincao - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3543709
    cmbCidadeEmitente.AddItem "Rinopolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3543808
    cmbCidadeEmitente.AddItem "Rio Claro - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3543907
    cmbCidadeEmitente.AddItem "Rio das Pedras - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3544004
    cmbCidadeEmitente.AddItem "Rio Grande da Serra - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3544103
    cmbCidadeEmitente.AddItem "Riolandia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3544202
    cmbCidadeEmitente.AddItem "Riversul - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3543501
    cmbCidadeEmitente.AddItem "Rosana - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3544251
    cmbCidadeEmitente.AddItem "Roseira - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3544301
    cmbCidadeEmitente.AddItem "Rubiacea - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3544400
    cmbCidadeEmitente.AddItem "Rubineia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3544509
    cmbCidadeEmitente.AddItem "Sabino - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3544608
    cmbCidadeEmitente.AddItem "Sagres - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3544707
    cmbCidadeEmitente.AddItem "Sales - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3544806
    cmbCidadeEmitente.AddItem "Sales Oliveira - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3544905
    cmbCidadeEmitente.AddItem "Salesopolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3545001
    cmbCidadeEmitente.AddItem "Salmourao - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3545100
    cmbCidadeEmitente.AddItem "Saltinho - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3545159
    cmbCidadeEmitente.AddItem "Salto - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3545209
    cmbCidadeEmitente.AddItem "Salto de Pirapora - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3545308
    cmbCidadeEmitente.AddItem "Salto Grande - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3545407
    cmbCidadeEmitente.AddItem "Sandovalina - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3545506
    cmbCidadeEmitente.AddItem "Santa Adelia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3545605
    cmbCidadeEmitente.AddItem "Santa Albertina - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3545704
    cmbCidadeEmitente.AddItem "Santa Barbara D Oeste - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3545803
    cmbCidadeEmitente.AddItem "Santa Branca - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3546009
    cmbCidadeEmitente.AddItem "Santa Clara D Oeste - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3546108
    cmbCidadeEmitente.AddItem "Santa Cruz da Conceicao - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3546207
    cmbCidadeEmitente.AddItem "Santa Cruz da Esperanca - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3546256
    cmbCidadeEmitente.AddItem "Santa Cruz das Palmeiras - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3546306
    cmbCidadeEmitente.AddItem "Santa Cruz do Rio Pardo - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3546405
    cmbCidadeEmitente.AddItem "Santa Ernestina - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3546504
    cmbCidadeEmitente.AddItem "Santa Fe do Sul - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3546603
    cmbCidadeEmitente.AddItem "Santa Gertrudes - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3546702
    cmbCidadeEmitente.AddItem "Santa Isabel - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3546801
    cmbCidadeEmitente.AddItem "Santa Lucia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3546900
    cmbCidadeEmitente.AddItem "Santa Maria da Serra - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3547007
    cmbCidadeEmitente.AddItem "Santa Mercedes - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3547106
    cmbCidadeEmitente.AddItem "Santa Rita D Oeste - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3547403
    cmbCidadeEmitente.AddItem "Santa Rita do Passa Quatro - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3547502
    cmbCidadeEmitente.AddItem "Santa Rosa de Viterbo - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3547601
    cmbCidadeEmitente.AddItem "Santa Salete - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3547650
    cmbCidadeEmitente.AddItem "Santana da Ponte Pensa - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3547205
    cmbCidadeEmitente.AddItem "Santana de Parnaiba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3547304
    cmbCidadeEmitente.AddItem "Santo Anastacio - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3547700
    cmbCidadeEmitente.AddItem "Santo Andre - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3547809
    cmbCidadeEmitente.AddItem "Santo Antonio da Alegria - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3547908
    cmbCidadeEmitente.AddItem "Santo Antonio de Posse - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3548005
    cmbCidadeEmitente.AddItem "Santo Antonio do Aracangua - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3548054
    cmbCidadeEmitente.AddItem "Santo Antonio do Jardim - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3548104
    cmbCidadeEmitente.AddItem "Santo Antonio do Pinhal - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3548203
    cmbCidadeEmitente.AddItem "Santo Expedito - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3548302
    cmbCidadeEmitente.AddItem "Santopolis do Aguapei - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3548401
    cmbCidadeEmitente.AddItem "Santos - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3548500
    cmbCidadeEmitente.AddItem "Sao Bento do Sapucai - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3548609
    cmbCidadeEmitente.AddItem "Sao Bernardo do Campo - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3548708
    cmbCidadeEmitente.AddItem "Sao Caetano do Sul - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3548807
    cmbCidadeEmitente.AddItem "Sao Carlos - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3548906
    cmbCidadeEmitente.AddItem "Sao Francisco - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3549003
    cmbCidadeEmitente.AddItem "Sao Joao da Boa Vista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3549102
    cmbCidadeEmitente.AddItem "Sao Joao das Duas Pontes - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3549201
    cmbCidadeEmitente.AddItem "Sao Joao de Iracema - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3549250
    cmbCidadeEmitente.AddItem "Sao Joao do Pau D Alho - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3549300
    cmbCidadeEmitente.AddItem "Sao Joaquim da Barra - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3549409
    cmbCidadeEmitente.AddItem "Sao Jose da Bela Vista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3549508
    cmbCidadeEmitente.AddItem "Sao Jose do Barreiro - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3549607
    cmbCidadeEmitente.AddItem "Sao Jose do Rio Pardo - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3549706
    cmbCidadeEmitente.AddItem "Sao Jose do Rio Preto - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3549805
    cmbCidadeEmitente.AddItem "Sao Jose dos Campos - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3549904
    cmbCidadeEmitente.AddItem "Sao Lourenco da Serra - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3549953
    cmbCidadeEmitente.AddItem "Sao Luis do Paraitinga - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3550001
    cmbCidadeEmitente.AddItem "Sao Manuel - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3550100
    cmbCidadeEmitente.AddItem "Sao Miguel Arcanjo - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3550209
    cmbCidadeEmitente.AddItem "Sao Paulo - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3550308
    cmbCidadeEmitente.AddItem "Sao Pedro - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3550407
    cmbCidadeEmitente.AddItem "Sao Pedro do Turvo - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3550506
    cmbCidadeEmitente.AddItem "Sao Roque - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3550605
    cmbCidadeEmitente.AddItem "Sao Sebastiao - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3550704
    cmbCidadeEmitente.AddItem "Sao Sebastiao da Grama - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3550803
    cmbCidadeEmitente.AddItem "Sao Simao - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3550902
    cmbCidadeEmitente.AddItem "Sao Vicente - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3551009
    cmbCidadeEmitente.AddItem "Sarapui - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3551108
    cmbCidadeEmitente.AddItem "Sarutaia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3551207
    cmbCidadeEmitente.AddItem "Sebastianopolis do Sul - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3551306
    cmbCidadeEmitente.AddItem "Serra Azul - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3551405
    cmbCidadeEmitente.AddItem "Serra Negra - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3551603
    cmbCidadeEmitente.AddItem "Serrana - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3551504
    cmbCidadeEmitente.AddItem "Sertaozinho - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3551702
    cmbCidadeEmitente.AddItem "Sete Barras - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3551801
    cmbCidadeEmitente.AddItem "Severinia - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3551900
    cmbCidadeEmitente.AddItem "Silveiras - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3552007
    cmbCidadeEmitente.AddItem "Socorro - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3552106
    cmbCidadeEmitente.AddItem "Sorocaba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3552205
    cmbCidadeEmitente.AddItem "Sud Mennucci - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3552304
    cmbCidadeEmitente.AddItem "Sumare - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3552403
    cmbCidadeEmitente.AddItem "Suzanapolis - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3552551
    cmbCidadeEmitente.AddItem "Suzano - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3552502
    cmbCidadeEmitente.AddItem "Tabapua - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3552601
    cmbCidadeEmitente.AddItem "Tabatinga - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3552700
    cmbCidadeEmitente.AddItem "Taboao da Serra - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3552809
    cmbCidadeEmitente.AddItem "Taciba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3552908
    cmbCidadeEmitente.AddItem "Taguai - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3553005
    cmbCidadeEmitente.AddItem "Taiacu - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3553104
    cmbCidadeEmitente.AddItem "Taiuva - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3553203
    cmbCidadeEmitente.AddItem "Tambau - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3553302
    cmbCidadeEmitente.AddItem "Tanabi - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3553401
    cmbCidadeEmitente.AddItem "Tapirai - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3553500
    cmbCidadeEmitente.AddItem "Tapiratiba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3553609
    cmbCidadeEmitente.AddItem "Taquaral - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3553658
End Sub

Private Sub SaoPaulo5(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Taquaritinga - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3553708
    cmbCidadeEmitente.AddItem "Taquarituba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3553807
    cmbCidadeEmitente.AddItem "Taquarivai - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3553856
    cmbCidadeEmitente.AddItem "Tarabai - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3553906
    cmbCidadeEmitente.AddItem "Taruma - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3553955
    cmbCidadeEmitente.AddItem "Tatui - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3554003
    cmbCidadeEmitente.AddItem "Taubate - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3554102
    cmbCidadeEmitente.AddItem "Tejupa - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3554201
    cmbCidadeEmitente.AddItem "Teodoro Sampaio - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3554300
    cmbCidadeEmitente.AddItem "Terra Roxa - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3554409
    cmbCidadeEmitente.AddItem "Tiete - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3554508
    cmbCidadeEmitente.AddItem "Timburi - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3554607
    cmbCidadeEmitente.AddItem "Torre de Pedra - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3554656
    cmbCidadeEmitente.AddItem "Torrinha - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3554706
    cmbCidadeEmitente.AddItem "Trabiju - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3554755
    cmbCidadeEmitente.AddItem "Tremembe - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3554805
    cmbCidadeEmitente.AddItem "Tres Fronteiras - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3554904
    cmbCidadeEmitente.AddItem "Tuiuti - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3554953
    cmbCidadeEmitente.AddItem "Tupa - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3555000
    cmbCidadeEmitente.AddItem "Tupi Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3555109
    cmbCidadeEmitente.AddItem "Turiuba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3555208
    cmbCidadeEmitente.AddItem "Turmalina - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3555307
    cmbCidadeEmitente.AddItem "Ubarana - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3555356
    cmbCidadeEmitente.AddItem "Ubatuba - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3555406
    cmbCidadeEmitente.AddItem "Ubirajara - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3555505
    cmbCidadeEmitente.AddItem "Uchoa - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3555604
    cmbCidadeEmitente.AddItem "Uniao Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3555703
    cmbCidadeEmitente.AddItem "Urania - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3555802
    cmbCidadeEmitente.AddItem "Uru - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3555901
    cmbCidadeEmitente.AddItem "Urupes - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3556008
    cmbCidadeEmitente.AddItem "Valentim Gentil - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3556107
    cmbCidadeEmitente.AddItem "Valinhos - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3556206
    cmbCidadeEmitente.AddItem "Valparaiso - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3556305
    cmbCidadeEmitente.AddItem "Vargem - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3556354
    cmbCidadeEmitente.AddItem "Vargem Grande do Sul - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3556404
    cmbCidadeEmitente.AddItem "Vargem Grande Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3556453
    cmbCidadeEmitente.AddItem "Varzea Paulista - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3556503
    cmbCidadeEmitente.AddItem "Vera Cruz - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3556602
    cmbCidadeEmitente.AddItem "Vinhedo - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3556701
    cmbCidadeEmitente.AddItem "Viradouro - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3556800
    cmbCidadeEmitente.AddItem "Vista Alegre do Alto - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3556909
    cmbCidadeEmitente.AddItem "Vitoria Brasil - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3556958
    cmbCidadeEmitente.AddItem "Votorantim - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3557006
    cmbCidadeEmitente.AddItem "Votuporanga - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3557105
    cmbCidadeEmitente.AddItem "Zacarias - SP"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 3557154
End Sub

Public Sub Parana(ByRef cmbCidadeEmitente As ComboBox)
    Parana1 cmbCidadeEmitente
    Parana2 cmbCidadeEmitente
    Parana3 cmbCidadeEmitente
End Sub

Private Sub Parana1(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Abatia - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4100103
    cmbCidadeEmitente.AddItem "Adrianopolis - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4100202
    cmbCidadeEmitente.AddItem "Agudos do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4100301
    cmbCidadeEmitente.AddItem "Almirante Tamandare - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4100400
    cmbCidadeEmitente.AddItem "Altamira do Parana - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4100459
    cmbCidadeEmitente.AddItem "Alto Paraiso - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4128625
    cmbCidadeEmitente.AddItem "Alto Parana - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4100608
    cmbCidadeEmitente.AddItem "Alto Piquiri - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4100707
    cmbCidadeEmitente.AddItem "Altonia - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4100509
    cmbCidadeEmitente.AddItem "Alvorada do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4100806
    cmbCidadeEmitente.AddItem "Amapora - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4100905
    cmbCidadeEmitente.AddItem "Ampere - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4101002
    cmbCidadeEmitente.AddItem "Anahy - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4101051
    cmbCidadeEmitente.AddItem "Andira - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4101101
    cmbCidadeEmitente.AddItem "Angulo - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4101150
    cmbCidadeEmitente.AddItem "Antonina - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4101200
    cmbCidadeEmitente.AddItem "Antonio Olinto - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4101309
    cmbCidadeEmitente.AddItem "Apucarana - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4101408
    cmbCidadeEmitente.AddItem "Arapongas - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4101507
    cmbCidadeEmitente.AddItem "Arapoti - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4101606
    cmbCidadeEmitente.AddItem "Arapua - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4101655
    cmbCidadeEmitente.AddItem "Araruna - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4101705
    cmbCidadeEmitente.AddItem "Araucaria - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4101804
    cmbCidadeEmitente.AddItem "Ariranha do Ivai - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4101853
    cmbCidadeEmitente.AddItem "Assai - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4101903
    cmbCidadeEmitente.AddItem "Assis Chateaubriand - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4102000
    cmbCidadeEmitente.AddItem "Astorga - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4102109
    cmbCidadeEmitente.AddItem "Atalaia - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4102208
    cmbCidadeEmitente.AddItem "Balsa Nova - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4102307
    cmbCidadeEmitente.AddItem "Bandeirantes - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4102406
    cmbCidadeEmitente.AddItem "Barbosa Ferraz - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4102505
    cmbCidadeEmitente.AddItem "Barra do Jacare - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4102703
    cmbCidadeEmitente.AddItem "Barracao - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4102604
    cmbCidadeEmitente.AddItem "Bela Vista da Caroba - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4102752
    cmbCidadeEmitente.AddItem "Bela Vista do Paraiso - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4102802
    cmbCidadeEmitente.AddItem "Bituruna - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4102901
    cmbCidadeEmitente.AddItem "Boa Esperanca - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103008
    cmbCidadeEmitente.AddItem "Boa Esperanca do Iguacu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103024
    cmbCidadeEmitente.AddItem "Boa Ventura de Sao Roque - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103040
    cmbCidadeEmitente.AddItem "Boa Vista da Aparecida - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103057
    cmbCidadeEmitente.AddItem "Bocaiuva do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103107
    cmbCidadeEmitente.AddItem "Bom Jesus do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103156
    cmbCidadeEmitente.AddItem "Bom Sucesso - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103206
    cmbCidadeEmitente.AddItem "Bom Sucesso do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103222
    cmbCidadeEmitente.AddItem "Borrazopolis - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103305
    cmbCidadeEmitente.AddItem "Braganey - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103354
    cmbCidadeEmitente.AddItem "Brasilandia do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103370
    cmbCidadeEmitente.AddItem "Cafeara - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103404
    cmbCidadeEmitente.AddItem "Cafelandia - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103453
    cmbCidadeEmitente.AddItem "Cafezal do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103479
    cmbCidadeEmitente.AddItem "California - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103503
    cmbCidadeEmitente.AddItem "Cambara - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103602
    cmbCidadeEmitente.AddItem "Cambe - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103701
    cmbCidadeEmitente.AddItem "Cambira - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103800
    cmbCidadeEmitente.AddItem "Campina da Lagoa - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103909
    cmbCidadeEmitente.AddItem "Campina do Simao - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4103958
    cmbCidadeEmitente.AddItem "Campina Grande do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4104006
    cmbCidadeEmitente.AddItem "Campo Bonito - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4104055
    cmbCidadeEmitente.AddItem "Campo do Tenente - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4104105
    cmbCidadeEmitente.AddItem "Campo Largo - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4104204
    cmbCidadeEmitente.AddItem "Campo Magro - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4104253
    cmbCidadeEmitente.AddItem "Campo Mourao - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4104303
    cmbCidadeEmitente.AddItem "Candido de Abreu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4104402
    cmbCidadeEmitente.AddItem "Candoi - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4104428
    cmbCidadeEmitente.AddItem "Cantagalo - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4104451
    cmbCidadeEmitente.AddItem "Capanema - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4104501
    cmbCidadeEmitente.AddItem "Capitao Leonidas Marques - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4104600
    cmbCidadeEmitente.AddItem "Carambei - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4104659
    cmbCidadeEmitente.AddItem "Carlopolis - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4104709
    cmbCidadeEmitente.AddItem "Cascavel - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4104808
    cmbCidadeEmitente.AddItem "Castro - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4104907
    cmbCidadeEmitente.AddItem "Catanduvas - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4105003
    cmbCidadeEmitente.AddItem "Centenario do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4105102
    cmbCidadeEmitente.AddItem "Cerro Azul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4105201
    cmbCidadeEmitente.AddItem "Ceu Azul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4105300
    cmbCidadeEmitente.AddItem "Chopinzinho - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4105409
    cmbCidadeEmitente.AddItem "Cianorte - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4105508
    cmbCidadeEmitente.AddItem "Cidade Gaucha - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4105607
    cmbCidadeEmitente.AddItem "Clevelandia - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4105706
    cmbCidadeEmitente.AddItem "Colombo - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4105805
    cmbCidadeEmitente.AddItem "Colorado - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4105904
    cmbCidadeEmitente.AddItem "Congonhinhas - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4106001
    cmbCidadeEmitente.AddItem "Conselheiro Mairinck - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4106100
    cmbCidadeEmitente.AddItem "Contenda - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4106209
    cmbCidadeEmitente.AddItem "Corbelia - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4106308
    cmbCidadeEmitente.AddItem "Cornelio Procopio - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4106407
    cmbCidadeEmitente.AddItem "Coronel Domingos Soares - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4106456
    cmbCidadeEmitente.AddItem "Coronel Vivida - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4106506
    cmbCidadeEmitente.AddItem "Corumbatai do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4106555
    cmbCidadeEmitente.AddItem "Cruz Machado - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4106803
    cmbCidadeEmitente.AddItem "Cruzeiro do Iguacu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4106571
    cmbCidadeEmitente.AddItem "Cruzeiro do Oeste - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4106605
    cmbCidadeEmitente.AddItem "Cruzeiro do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4106704
    cmbCidadeEmitente.AddItem "Cruzmaltina - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4106852
    cmbCidadeEmitente.AddItem "Curitiba - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4106902
    cmbCidadeEmitente.AddItem "Curiuva - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107009
    cmbCidadeEmitente.AddItem "Diamante D Oeste - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107157
    cmbCidadeEmitente.AddItem "Diamante do Norte - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107108
    cmbCidadeEmitente.AddItem "Diamante do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107124
    cmbCidadeEmitente.AddItem "Dois Vizinhos - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107207
    cmbCidadeEmitente.AddItem "Douradina - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107256
    cmbCidadeEmitente.AddItem "Doutor Camargo - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107306
    cmbCidadeEmitente.AddItem "Doutor Ulysses - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4128633
    cmbCidadeEmitente.AddItem "Eneas Marques - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107405
    cmbCidadeEmitente.AddItem "Engenheiro Beltrao - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107504
    cmbCidadeEmitente.AddItem "Entre Rios do Oeste - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107538
    cmbCidadeEmitente.AddItem "Esperanca Nova - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107520
    cmbCidadeEmitente.AddItem "Espigao Alto do Iguacu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107546
    cmbCidadeEmitente.AddItem "Farol - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107553
    cmbCidadeEmitente.AddItem "Faxinal - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107603
    cmbCidadeEmitente.AddItem "Fazenda Rio Grande - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107652
    cmbCidadeEmitente.AddItem "Fenix - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107702
    cmbCidadeEmitente.AddItem "Fernandes Pinheiro - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107736
    cmbCidadeEmitente.AddItem "Figueira - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107751
    cmbCidadeEmitente.AddItem "Flor da Serra do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107850
    cmbCidadeEmitente.AddItem "Florai - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107801
    cmbCidadeEmitente.AddItem "Floresta - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4107900
    cmbCidadeEmitente.AddItem "Florestopolis - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4108007
    cmbCidadeEmitente.AddItem "Florida - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4108106
    cmbCidadeEmitente.AddItem "Formosa do Oeste - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4108205
    cmbCidadeEmitente.AddItem "Foz do Iguacu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4108304
    cmbCidadeEmitente.AddItem "Foz do Jordao - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4108452
    cmbCidadeEmitente.AddItem "Francisco Alves - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4108320
    cmbCidadeEmitente.AddItem "Francisco Beltrao - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4108403
    cmbCidadeEmitente.AddItem "General Carneiro - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4108502
    cmbCidadeEmitente.AddItem "Godoy Moreira - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4108551
    cmbCidadeEmitente.AddItem "Goioere - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4108601
    cmbCidadeEmitente.AddItem "Goioxim - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4108650
    cmbCidadeEmitente.AddItem "Grandes Rios - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4108700
    cmbCidadeEmitente.AddItem "Guaira - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4108809
    cmbCidadeEmitente.AddItem "Guairaca - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4108908
    cmbCidadeEmitente.AddItem "Guamiranga - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4108957
    cmbCidadeEmitente.AddItem "Guapirama - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4109005
    cmbCidadeEmitente.AddItem "Guaporema - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4109104
    cmbCidadeEmitente.AddItem "Guaraci - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4109203
    cmbCidadeEmitente.AddItem "Guaraniacu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4109302
    cmbCidadeEmitente.AddItem "Guarapuava - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4109401
    cmbCidadeEmitente.AddItem "Guaraquecaba - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4109500
    cmbCidadeEmitente.AddItem "Guaratuba - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4109609
    cmbCidadeEmitente.AddItem "Honorio Serpa - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4109658
    cmbCidadeEmitente.AddItem "Ibaiti - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4109708
    cmbCidadeEmitente.AddItem "Ibema - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4109757
    cmbCidadeEmitente.AddItem "Ibipora - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4109807
    cmbCidadeEmitente.AddItem "Icaraima - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4109906
    cmbCidadeEmitente.AddItem "Iguaracu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4110003
    cmbCidadeEmitente.AddItem "Iguatu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4110052
    cmbCidadeEmitente.AddItem "Imbau - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4110078
    cmbCidadeEmitente.AddItem "Imbituva - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4110102
    cmbCidadeEmitente.AddItem "Inacio Martins - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4110201
    cmbCidadeEmitente.AddItem "Inaja - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4110300
End Sub

Private Sub Parana2(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Indianopolis - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4110409
    cmbCidadeEmitente.AddItem "Ipiranga - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4110508
    cmbCidadeEmitente.AddItem "Ipora - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4110607
    cmbCidadeEmitente.AddItem "Iracema do Oeste - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4110656
    cmbCidadeEmitente.AddItem "Irati - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4110706
    cmbCidadeEmitente.AddItem "Iretama - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4110805
    cmbCidadeEmitente.AddItem "Itaguaje - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4110904
    cmbCidadeEmitente.AddItem "Itaipulandia - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4110953
    cmbCidadeEmitente.AddItem "Itambaraca - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4111001
    cmbCidadeEmitente.AddItem "Itambe - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4111100
    cmbCidadeEmitente.AddItem "Itapejara D Oeste - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4111209
    cmbCidadeEmitente.AddItem "Itaperucu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4111258
    cmbCidadeEmitente.AddItem "Itauna do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4111308
    cmbCidadeEmitente.AddItem "Ivai - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4111407
    cmbCidadeEmitente.AddItem "Ivaipora - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4111506
    cmbCidadeEmitente.AddItem "Ivate - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4111555
    cmbCidadeEmitente.AddItem "Ivatuba - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4111605
    cmbCidadeEmitente.AddItem "Jaboti - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4111704
    cmbCidadeEmitente.AddItem "Jacarezinho - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4111803
    cmbCidadeEmitente.AddItem "Jaguapita - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4111902
    cmbCidadeEmitente.AddItem "Jaguariaiva - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4112009
    cmbCidadeEmitente.AddItem "Jandaia do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4112108
    cmbCidadeEmitente.AddItem "Janiopolis - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4112207
    cmbCidadeEmitente.AddItem "Japira - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4112306
    cmbCidadeEmitente.AddItem "Japura - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4112405
    cmbCidadeEmitente.AddItem "Jardim Alegre - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4112504
    cmbCidadeEmitente.AddItem "Jardim Olinda - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4112603
    cmbCidadeEmitente.AddItem "Jataizinho - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4112702
    cmbCidadeEmitente.AddItem "Jesuitas - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4112751
    cmbCidadeEmitente.AddItem "Joaquim Tavora - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4112801
    cmbCidadeEmitente.AddItem "Jundiai do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4112900
    cmbCidadeEmitente.AddItem "Juranda - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4112959
    cmbCidadeEmitente.AddItem "Jussara - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4113007
    cmbCidadeEmitente.AddItem "Kalore - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4113106
    cmbCidadeEmitente.AddItem "Lapa - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4113205
    cmbCidadeEmitente.AddItem "Laranjal - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4113254
    cmbCidadeEmitente.AddItem "Laranjeiras do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4113304
    cmbCidadeEmitente.AddItem "Leopolis - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4113403
    cmbCidadeEmitente.AddItem "Lidianopolis - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4113429
    cmbCidadeEmitente.AddItem "Lindoeste - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4113452
    cmbCidadeEmitente.AddItem "Loanda - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4113502
    cmbCidadeEmitente.AddItem "Lobato - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4113601
    cmbCidadeEmitente.AddItem "Londrina - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4113700
    cmbCidadeEmitente.AddItem "Luiziana - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4113734
    cmbCidadeEmitente.AddItem "Lunardelli - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4113759
    cmbCidadeEmitente.AddItem "Lupionopolis - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4113809
    cmbCidadeEmitente.AddItem "Mallet - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4113908
    cmbCidadeEmitente.AddItem "Mambore - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4114005
    cmbCidadeEmitente.AddItem "Mandaguacu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4114104
    cmbCidadeEmitente.AddItem "Mandaguari - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4114203
    cmbCidadeEmitente.AddItem "Mandirituba - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4114302
    cmbCidadeEmitente.AddItem "Manfrinopolis - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4114351
    cmbCidadeEmitente.AddItem "Mangueirinha - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4114401
    cmbCidadeEmitente.AddItem "Manoel Ribas - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4114500
    cmbCidadeEmitente.AddItem "Marechal Candido Rondon - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4114609
    cmbCidadeEmitente.AddItem "Maria Helena - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4114708
    cmbCidadeEmitente.AddItem "Marialva - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4114807
    cmbCidadeEmitente.AddItem "Marilandia do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4114906
    cmbCidadeEmitente.AddItem "Marilena - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4115002
    cmbCidadeEmitente.AddItem "Mariluz - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4115101
    cmbCidadeEmitente.AddItem "Maringa - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4115200
    cmbCidadeEmitente.AddItem "Mariopolis - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4115309
    cmbCidadeEmitente.AddItem "Maripa - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4115358
    cmbCidadeEmitente.AddItem "Marmeleiro - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4115408
    cmbCidadeEmitente.AddItem "Marquinho - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4115457
    cmbCidadeEmitente.AddItem "Marumbi - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4115507
    cmbCidadeEmitente.AddItem "Matelandia - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4115606
    cmbCidadeEmitente.AddItem "Matinhos - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4115705
    cmbCidadeEmitente.AddItem "Mato Rico - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4115739
    cmbCidadeEmitente.AddItem "Maua da Serra - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4115754
    cmbCidadeEmitente.AddItem "Medianeira - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4115804
    cmbCidadeEmitente.AddItem "Mercedes - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4115853
    cmbCidadeEmitente.AddItem "Mirador - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4115903
    cmbCidadeEmitente.AddItem "Miraselva - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4116000
    cmbCidadeEmitente.AddItem "Missal - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4116059
    cmbCidadeEmitente.AddItem "Moreira Sales - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4116109
    cmbCidadeEmitente.AddItem "Morretes - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4116208
    cmbCidadeEmitente.AddItem "Munhoz de Melo - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4116307
    cmbCidadeEmitente.AddItem "Nossa Senhora das Gracas - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4116406
    cmbCidadeEmitente.AddItem "Nova Alianca do Ivai - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4116505
    cmbCidadeEmitente.AddItem "Nova America da Colina - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4116604
    cmbCidadeEmitente.AddItem "Nova Aurora - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4116703
    cmbCidadeEmitente.AddItem "Nova Cantu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4116802
    cmbCidadeEmitente.AddItem "Nova Esperanca - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4116901
    cmbCidadeEmitente.AddItem "Nova Esperanca do Sudoeste - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4116950
    cmbCidadeEmitente.AddItem "Nova Fatima - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4117008
    cmbCidadeEmitente.AddItem "Nova Laranjeiras - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4117057
    cmbCidadeEmitente.AddItem "Nova Londrina - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4117107
    cmbCidadeEmitente.AddItem "Nova Olimpia - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4117206
    cmbCidadeEmitente.AddItem "Nova Prata do Iguacu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4117255
    cmbCidadeEmitente.AddItem "Nova Santa Barbara - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4117214
    cmbCidadeEmitente.AddItem "Nova Santa Rosa - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4117222
    cmbCidadeEmitente.AddItem "Nova Tebas - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4117271
    cmbCidadeEmitente.AddItem "Novo Itacolomi - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4117297
    cmbCidadeEmitente.AddItem "Ortigueira - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4117305
    cmbCidadeEmitente.AddItem "Ourizona - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4117404
    cmbCidadeEmitente.AddItem "Ouro Verde do Oeste - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4117453
    cmbCidadeEmitente.AddItem "Paicandu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4117503
    cmbCidadeEmitente.AddItem "Palmas - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4117602
    cmbCidadeEmitente.AddItem "Palmeira - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4117701
    cmbCidadeEmitente.AddItem "Palmital - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4117800
    cmbCidadeEmitente.AddItem "Palotina - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4117909
    cmbCidadeEmitente.AddItem "Paraiso do Norte - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4118006
    cmbCidadeEmitente.AddItem "Paranacity - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4118105
    cmbCidadeEmitente.AddItem "Paranagua - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4118204
    cmbCidadeEmitente.AddItem "Paranapoema - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4118303
    cmbCidadeEmitente.AddItem "Paranavai - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4118402
    cmbCidadeEmitente.AddItem "Pato Bragado - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4118451
    cmbCidadeEmitente.AddItem "Pato Branco - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4118501
    cmbCidadeEmitente.AddItem "Paula Freitas - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4118600
    cmbCidadeEmitente.AddItem "Paulo Frontin - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4118709
    cmbCidadeEmitente.AddItem "Peabiru - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4118808
    cmbCidadeEmitente.AddItem "Perobal - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4118857
    cmbCidadeEmitente.AddItem "Perola - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4118907
    cmbCidadeEmitente.AddItem "Perola D Oeste - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4119004
    cmbCidadeEmitente.AddItem "Pien - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4119103
    cmbCidadeEmitente.AddItem "Pinhais - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4119152
    cmbCidadeEmitente.AddItem "Pinhal de Sao Bento - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4119251
    cmbCidadeEmitente.AddItem "Pinhalao - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4119202
    cmbCidadeEmitente.AddItem "Pinhao - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4119301
    cmbCidadeEmitente.AddItem "Pirai do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4119400
    cmbCidadeEmitente.AddItem "Piraquara - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4119509
    cmbCidadeEmitente.AddItem "Pitanga - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4119608
    cmbCidadeEmitente.AddItem "Pitangueiras - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4119657
    cmbCidadeEmitente.AddItem "Planaltina do Parana - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4119707
    cmbCidadeEmitente.AddItem "Planalto - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4119806
    cmbCidadeEmitente.AddItem "Ponta Grossa - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4119905
    cmbCidadeEmitente.AddItem "Pontal do Parana - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4119954
    cmbCidadeEmitente.AddItem "Porecatu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4120002
    cmbCidadeEmitente.AddItem "Porto Amazonas - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4120101
    cmbCidadeEmitente.AddItem "Porto Barreiro - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4120150
    cmbCidadeEmitente.AddItem "Porto Rico - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4120200
    cmbCidadeEmitente.AddItem "Porto Vitoria - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4120309
    cmbCidadeEmitente.AddItem "Prado Ferreira - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4120333
    cmbCidadeEmitente.AddItem "Pranchita - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4120358
    cmbCidadeEmitente.AddItem "Presidente Castelo Branco - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4120408
    cmbCidadeEmitente.AddItem "Primeiro de Maio - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4120507
    cmbCidadeEmitente.AddItem "Prudentopolis - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4120606
    cmbCidadeEmitente.AddItem "Quarto Centenario - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4120655
    cmbCidadeEmitente.AddItem "Quatigua - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4120705
    cmbCidadeEmitente.AddItem "Quatro Barras - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4120804
    cmbCidadeEmitente.AddItem "Quatro Pontes - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4120853
    cmbCidadeEmitente.AddItem "Quedas do Iguacu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4120903
    cmbCidadeEmitente.AddItem "Querencia do Norte - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4121000
    cmbCidadeEmitente.AddItem "Quinta do Sol - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4121109
    cmbCidadeEmitente.AddItem "Quitandinha - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4121208
    cmbCidadeEmitente.AddItem "Ramilandia - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4121257
    cmbCidadeEmitente.AddItem "Rancho Alegre - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4121307
    cmbCidadeEmitente.AddItem "Rancho Alegre D Oeste - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4121356
    cmbCidadeEmitente.AddItem "Realeza - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4121406
End Sub

Private Sub Parana3(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Reboucas - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4121505
    cmbCidadeEmitente.AddItem "Renascenca - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4121604
    cmbCidadeEmitente.AddItem "Reserva - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4121703
    cmbCidadeEmitente.AddItem "Reserva do Iguacu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4121752
    cmbCidadeEmitente.AddItem "Ribeirao Claro - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4121802
    cmbCidadeEmitente.AddItem "Ribeirao do Pinhal - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4121901
    cmbCidadeEmitente.AddItem "Rio Azul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4122008
    cmbCidadeEmitente.AddItem "Rio Bom - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4122107
    cmbCidadeEmitente.AddItem "Rio Bonito do Iguacu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4122156
    cmbCidadeEmitente.AddItem "Rio Branco do Ivai - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4122172
    cmbCidadeEmitente.AddItem "Rio Branco do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4122206
    cmbCidadeEmitente.AddItem "Rio Negro - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4122305
    cmbCidadeEmitente.AddItem "Rolandia - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4122404
    cmbCidadeEmitente.AddItem "Roncador - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4122503
    cmbCidadeEmitente.AddItem "Rondon - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4122602
    cmbCidadeEmitente.AddItem "Rosario do Ivai - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4122651
    cmbCidadeEmitente.AddItem "Sabaudia - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4122701
    cmbCidadeEmitente.AddItem "Salgado Filho - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4122800
    cmbCidadeEmitente.AddItem "Salto do Itarare - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4122909
    cmbCidadeEmitente.AddItem "Salto do Lontra - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4123006
    cmbCidadeEmitente.AddItem "Santa Amelia - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4123105
    cmbCidadeEmitente.AddItem "Santa Cecilia do Pavao - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4123204
    cmbCidadeEmitente.AddItem "Santa Cruz de Monte Castelo - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4123303
    cmbCidadeEmitente.AddItem "Santa Fe - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4123402
    cmbCidadeEmitente.AddItem "Santa Helena - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4123501
    cmbCidadeEmitente.AddItem "Santa Ines - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4123600
    cmbCidadeEmitente.AddItem "Santa Isabel do Ivai - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4123709
    cmbCidadeEmitente.AddItem "Santa Izabel do Oeste - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4123808
    cmbCidadeEmitente.AddItem "Santa Lucia - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4123824
    cmbCidadeEmitente.AddItem "Santa Maria do Oeste - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4123857
    cmbCidadeEmitente.AddItem "Santa Mariana - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4123907
    cmbCidadeEmitente.AddItem "Santa Monica - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4123956
    cmbCidadeEmitente.AddItem "Santa Tereza do Oeste - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4124020
    cmbCidadeEmitente.AddItem "Santa Terezinha de Itaipu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4124053
    cmbCidadeEmitente.AddItem "Santana do Itarare - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4124004
    cmbCidadeEmitente.AddItem "Santo Antonio da Platina - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4124103
    cmbCidadeEmitente.AddItem "Santo Antonio do Caiua - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4124202
    cmbCidadeEmitente.AddItem "Santo Antonio do Paraiso - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4124301
    cmbCidadeEmitente.AddItem "Santo Antonio do Sudoeste - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4124400
    cmbCidadeEmitente.AddItem "Santo Inacio - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4124509
    cmbCidadeEmitente.AddItem "Sao Carlos do Ivai - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4124608
    cmbCidadeEmitente.AddItem "Sao Jeronimo da Serra - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4124707
    cmbCidadeEmitente.AddItem "Sao Joao - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4124806
    cmbCidadeEmitente.AddItem "Sao Joao do Caiua - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4124905
    cmbCidadeEmitente.AddItem "Sao Joao do Ivai - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4125001
    cmbCidadeEmitente.AddItem "Sao Joao do Triunfo - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4125100
    cmbCidadeEmitente.AddItem "Sao Jorge D Oeste - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4125209
    cmbCidadeEmitente.AddItem "Sao Jorge do Ivai - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4125308
    cmbCidadeEmitente.AddItem "Sao Jorge do Patrocinio - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4125357
    cmbCidadeEmitente.AddItem "Sao Jose da Boa Vista - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4125407
    cmbCidadeEmitente.AddItem "Sao Jose das Palmeiras - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4125456
    cmbCidadeEmitente.AddItem "Sao Jose dos Pinhais - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4125506
    cmbCidadeEmitente.AddItem "Sao Manoel do Parana - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4125555
    cmbCidadeEmitente.AddItem "Sao Mateus do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4125605
    cmbCidadeEmitente.AddItem "Sao Miguel do Iguacu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4125704
    cmbCidadeEmitente.AddItem "Sao Pedro do Iguacu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4125753
    cmbCidadeEmitente.AddItem "Sao Pedro do Ivai - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4125803
    cmbCidadeEmitente.AddItem "Sao Pedro do Parana - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4125902
    cmbCidadeEmitente.AddItem "Sao Sebastiao da Amoreira - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4126009
    cmbCidadeEmitente.AddItem "Sao Tome - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4126108
    cmbCidadeEmitente.AddItem "Sapopema - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4126207
    cmbCidadeEmitente.AddItem "Sarandi - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4126256
    cmbCidadeEmitente.AddItem "Saudade do Iguacu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4126272
    cmbCidadeEmitente.AddItem "Senges - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4126306
    cmbCidadeEmitente.AddItem "Serranopolis do Iguacu - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4126355
    cmbCidadeEmitente.AddItem "Sertaneja - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4126405
    cmbCidadeEmitente.AddItem "Sertanopolis - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4126504
    cmbCidadeEmitente.AddItem "Siqueira Campos - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4126603
    cmbCidadeEmitente.AddItem "Sulina - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4126652
    cmbCidadeEmitente.AddItem "Tamarana - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4126678
    cmbCidadeEmitente.AddItem "Tamboara - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4126702
    cmbCidadeEmitente.AddItem "Tapejara - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4126801
    cmbCidadeEmitente.AddItem "Tapira - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4126900
    cmbCidadeEmitente.AddItem "Teixeira Soares - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4127007
    cmbCidadeEmitente.AddItem "Telemaco Borba - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4127106
    cmbCidadeEmitente.AddItem "Terra Boa - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4127205
    cmbCidadeEmitente.AddItem "Terra Rica - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4127304
    cmbCidadeEmitente.AddItem "Terra Roxa - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4127403
    cmbCidadeEmitente.AddItem "Tibagi - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4127502
    cmbCidadeEmitente.AddItem "Tijucas do Sul - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4127601
    cmbCidadeEmitente.AddItem "Toledo - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4127700
    cmbCidadeEmitente.AddItem "Tomazina - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4127809
    cmbCidadeEmitente.AddItem "Tres Barras do Parana - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4127858
    cmbCidadeEmitente.AddItem "Tunas do Parana - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4127882
    cmbCidadeEmitente.AddItem "Tuneiras do Oeste - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4127908
    cmbCidadeEmitente.AddItem "Tupassi - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4127957
    cmbCidadeEmitente.AddItem "Turvo - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4127965
    cmbCidadeEmitente.AddItem "Ubirata - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4128005
    cmbCidadeEmitente.AddItem "Umuarama - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4128104
    cmbCidadeEmitente.AddItem "Uniao da Vitoria - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4128203
    cmbCidadeEmitente.AddItem "Uniflor - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4128302
    cmbCidadeEmitente.AddItem "Urai - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4128401
    cmbCidadeEmitente.AddItem "Ventania - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4128534
    cmbCidadeEmitente.AddItem "Vera Cruz do Oeste - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4128559
    cmbCidadeEmitente.AddItem "Vere - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4128609
    cmbCidadeEmitente.AddItem "Virmond - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4128658
    cmbCidadeEmitente.AddItem "Vitorino - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4128708
    cmbCidadeEmitente.AddItem "Wenceslau Braz - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4128500
    cmbCidadeEmitente.AddItem "Xambre - PR"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4128807
End Sub

Public Sub SantaCatarina(ByRef cmbCidadeEmitente As ComboBox)
    SantaCatarina1 cmbCidadeEmitente
    SantaCatarina2 cmbCidadeEmitente
End Sub

Private Sub SantaCatarina1(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Abdon Batista - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4200051
    cmbCidadeEmitente.AddItem "Abelardo Luz - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4200101
    cmbCidadeEmitente.AddItem "Agrolandia - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4200200
    cmbCidadeEmitente.AddItem "Agronomica - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4200309
    cmbCidadeEmitente.AddItem "Agua Doce - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4200408
    cmbCidadeEmitente.AddItem "Aguas de Chapeco - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4200507
    cmbCidadeEmitente.AddItem "Aguas Frias - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4200556
    cmbCidadeEmitente.AddItem "Aguas Mornas - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4200606
    cmbCidadeEmitente.AddItem "Alfredo Wagner - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4200705
    cmbCidadeEmitente.AddItem "Alto Bela Vista - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4200754
    cmbCidadeEmitente.AddItem "Anchieta - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4200804
    cmbCidadeEmitente.AddItem "Angelina - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4200903
    cmbCidadeEmitente.AddItem "Anita Garibaldi - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4201000
    cmbCidadeEmitente.AddItem "Anitapolis - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4201109
    cmbCidadeEmitente.AddItem "Antonio Carlos - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4201208
    cmbCidadeEmitente.AddItem "Apiuna - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4201257
    cmbCidadeEmitente.AddItem "Arabuta - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4201273
    cmbCidadeEmitente.AddItem "Araquari - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4201307
    cmbCidadeEmitente.AddItem "Ararangua - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4201406
    cmbCidadeEmitente.AddItem "Armazem - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4201505
    cmbCidadeEmitente.AddItem "Arroio Trinta - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4201604
    cmbCidadeEmitente.AddItem "Arvoredo - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4201653
    cmbCidadeEmitente.AddItem "Ascurra - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4201703
    cmbCidadeEmitente.AddItem "Atalanta - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4201802
    cmbCidadeEmitente.AddItem "Aurora - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4201901
    cmbCidadeEmitente.AddItem "Balneario Arroio do Silva - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4201950
    cmbCidadeEmitente.AddItem "Balneario Barra do Sul - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202057
    cmbCidadeEmitente.AddItem "Balneario Camboriu - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202008
    cmbCidadeEmitente.AddItem "Balneario Gaivota - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202073
    cmbCidadeEmitente.AddItem "Balneario Picarras - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4212809
    cmbCidadeEmitente.AddItem "Balneario Rincao - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4220000
    cmbCidadeEmitente.AddItem "Bandeirante - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202081
    cmbCidadeEmitente.AddItem "Barra Bonita - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202099
    cmbCidadeEmitente.AddItem "Barra Velha - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202107
    cmbCidadeEmitente.AddItem "Bela Vista do Toldo - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202131
    cmbCidadeEmitente.AddItem "Belmonte - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202156
    cmbCidadeEmitente.AddItem "Benedito Novo - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202206
    cmbCidadeEmitente.AddItem "Biguacu - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202305
    cmbCidadeEmitente.AddItem "Blumenau - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202404
    cmbCidadeEmitente.AddItem "Bocaina do Sul - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202438
    cmbCidadeEmitente.AddItem "Bom Jardim da Serra - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202503
    cmbCidadeEmitente.AddItem "Bom Jesus - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202537
    cmbCidadeEmitente.AddItem "Bom Jesus do Oeste - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202578
    cmbCidadeEmitente.AddItem "Bom Retiro - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202602
    cmbCidadeEmitente.AddItem "Bombinhas - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202453
    cmbCidadeEmitente.AddItem "Botuvera - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202701
    cmbCidadeEmitente.AddItem "Braco do Norte - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202800
    cmbCidadeEmitente.AddItem "Braco do Trombudo - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202859
    cmbCidadeEmitente.AddItem "Brunopolis - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202875
    cmbCidadeEmitente.AddItem "Brusque - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4202909
    cmbCidadeEmitente.AddItem "Cacador - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4203006
    cmbCidadeEmitente.AddItem "Caibi - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4203105
    cmbCidadeEmitente.AddItem "Calmon - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4203154
    cmbCidadeEmitente.AddItem "Camboriu - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4203204
    cmbCidadeEmitente.AddItem "Campo Alegre - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4203303
    cmbCidadeEmitente.AddItem "Campo Belo do Sul - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4203402
    cmbCidadeEmitente.AddItem "Campo Ere - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4203501
    cmbCidadeEmitente.AddItem "Campos Novos - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4203600
    cmbCidadeEmitente.AddItem "Canelinha - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4203709
    cmbCidadeEmitente.AddItem "Canoinhas - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4203808
    cmbCidadeEmitente.AddItem "Capao Alto - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4203253
    cmbCidadeEmitente.AddItem "Capinzal - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4203907
    cmbCidadeEmitente.AddItem "Capivari de Baixo - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4203956
    cmbCidadeEmitente.AddItem "Catanduvas - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4204004
    cmbCidadeEmitente.AddItem "Caxambu do Sul - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4204103
    cmbCidadeEmitente.AddItem "Celso Ramos - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4204152
    cmbCidadeEmitente.AddItem "Cerro Negro - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4204178
    cmbCidadeEmitente.AddItem "Chapadao do Lageado - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4204194
    cmbCidadeEmitente.AddItem "Chapeco - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4204202
    cmbCidadeEmitente.AddItem "Cocal do Sul - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4204251
    cmbCidadeEmitente.AddItem "Concordia - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4204301
    cmbCidadeEmitente.AddItem "Cordilheira Alta - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4204350
    cmbCidadeEmitente.AddItem "Coronel Freitas - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4204400
    cmbCidadeEmitente.AddItem "Coronel Martins - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4204459
    cmbCidadeEmitente.AddItem "Correia Pinto - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4204558
    cmbCidadeEmitente.AddItem "Corupa - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4204509
    cmbCidadeEmitente.AddItem "Criciuma - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4204608
    cmbCidadeEmitente.AddItem "Cunha Pora - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4204707
    cmbCidadeEmitente.AddItem "Cunhatai - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4204756
    cmbCidadeEmitente.AddItem "Curitibanos - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4204806
    cmbCidadeEmitente.AddItem "Descanso - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4204905
    cmbCidadeEmitente.AddItem "Dionisio Cerqueira - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4205001
    cmbCidadeEmitente.AddItem "Dona Emma - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4205100
    cmbCidadeEmitente.AddItem "Doutor Pedrinho - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4205159
    cmbCidadeEmitente.AddItem "Entre Rios - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4205175
    cmbCidadeEmitente.AddItem "Ermo - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4205191
    cmbCidadeEmitente.AddItem "Erval Velho - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4205209
    cmbCidadeEmitente.AddItem "Faxinal dos Guedes - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4205308
    cmbCidadeEmitente.AddItem "Flor do Sertao - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4205357
    cmbCidadeEmitente.AddItem "Florianopolis - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4205407
    cmbCidadeEmitente.AddItem "Formosa do Sul - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4205431
    cmbCidadeEmitente.AddItem "Forquilhinha - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4205456
    cmbCidadeEmitente.AddItem "Fraiburgo - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4205506
    cmbCidadeEmitente.AddItem "Frei Rogerio - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4205555
    cmbCidadeEmitente.AddItem "Galvao - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4205605
    cmbCidadeEmitente.AddItem "Garopaba - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4205704
    cmbCidadeEmitente.AddItem "Garuva - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4205803
    cmbCidadeEmitente.AddItem "Gaspar - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4205902
    cmbCidadeEmitente.AddItem "Governador Celso Ramos - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4206009
    cmbCidadeEmitente.AddItem "Grao Para - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4206108
    cmbCidadeEmitente.AddItem "Gravatal - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4206207
    cmbCidadeEmitente.AddItem "Guabiruba - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4206306
    cmbCidadeEmitente.AddItem "Guaraciaba - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4206405
    cmbCidadeEmitente.AddItem "Guaramirim - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4206504
    cmbCidadeEmitente.AddItem "Guaruja do Sul - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4206603
    cmbCidadeEmitente.AddItem "Guatambu - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4206652
    cmbCidadeEmitente.AddItem "Herval D Oeste - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4206702
    cmbCidadeEmitente.AddItem "Ibiam - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4206751
    cmbCidadeEmitente.AddItem "Ibicare - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4206801
    cmbCidadeEmitente.AddItem "Ibirama - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4206900
    cmbCidadeEmitente.AddItem "Icara - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4207007
    cmbCidadeEmitente.AddItem "Ilhota - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4207106
    cmbCidadeEmitente.AddItem "Imarui - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4207205
    cmbCidadeEmitente.AddItem "Imbituba - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4207304
    cmbCidadeEmitente.AddItem "Imbuia - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4207403
    cmbCidadeEmitente.AddItem "Indaial - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4207502
    cmbCidadeEmitente.AddItem "Iomere - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4207577
    cmbCidadeEmitente.AddItem "Ipira - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4207601
    cmbCidadeEmitente.AddItem "Ipora do Oeste - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4207650
    cmbCidadeEmitente.AddItem "Ipuacu - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4207684
    cmbCidadeEmitente.AddItem "Ipumirim - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4207700
    cmbCidadeEmitente.AddItem "Iraceminha - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4207759
    cmbCidadeEmitente.AddItem "Irani - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4207809
    cmbCidadeEmitente.AddItem "Irati - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4207858
    cmbCidadeEmitente.AddItem "Irineopolis - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4207908
    cmbCidadeEmitente.AddItem "Ita - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4208005
    cmbCidadeEmitente.AddItem "Itaiopolis - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4208104
    cmbCidadeEmitente.AddItem "Itajai - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4208203
    cmbCidadeEmitente.AddItem "Itapema - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4208302
    cmbCidadeEmitente.AddItem "Itapiranga - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4208401
    cmbCidadeEmitente.AddItem "Itapoa - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4208450
    cmbCidadeEmitente.AddItem "Ituporanga - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4208500
    cmbCidadeEmitente.AddItem "Jabora - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4208609
    cmbCidadeEmitente.AddItem "Jacinto Machado - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4208708
    cmbCidadeEmitente.AddItem "Jaguaruna - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4208807
    cmbCidadeEmitente.AddItem "Jaragua do Sul - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4208906
    cmbCidadeEmitente.AddItem "Jardinopolis - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4208955
    cmbCidadeEmitente.AddItem "Joacaba - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4209003
    cmbCidadeEmitente.AddItem "Joinville - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4209102
    cmbCidadeEmitente.AddItem "Jose Boiteux - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4209151
    cmbCidadeEmitente.AddItem "Jupia - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4209177
    cmbCidadeEmitente.AddItem "Lacerdopolis - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4209201
    cmbCidadeEmitente.AddItem "Lages - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4209300
    cmbCidadeEmitente.AddItem "Laguna - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4209409
    cmbCidadeEmitente.AddItem "Lajeado Grande - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4209458
    cmbCidadeEmitente.AddItem "Laurentino - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4209508
    cmbCidadeEmitente.AddItem "Lauro Muller - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4209607
    cmbCidadeEmitente.AddItem "Lebon Regis - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4209706
    cmbCidadeEmitente.AddItem "Leoberto Leal - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4209805
    cmbCidadeEmitente.AddItem "Lindoia do Sul - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4209854
End Sub

Private Sub SantaCatarina2(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Lontras - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4209904
    cmbCidadeEmitente.AddItem "Luiz Alves - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4210001
    cmbCidadeEmitente.AddItem "Luzerna - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4210035
    cmbCidadeEmitente.AddItem "Macieira - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4210050
    cmbCidadeEmitente.AddItem "Mafra - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4210100
    cmbCidadeEmitente.AddItem "Major Gercino - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4210209
    cmbCidadeEmitente.AddItem "Major Vieira - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4210308
    cmbCidadeEmitente.AddItem "Maracaja - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4210407
    cmbCidadeEmitente.AddItem "Maravilha - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4210506
    cmbCidadeEmitente.AddItem "Marema - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4210555
    cmbCidadeEmitente.AddItem "Massaranduba - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4210605
    cmbCidadeEmitente.AddItem "Matos Costa - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4210704
    cmbCidadeEmitente.AddItem "Meleiro - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4210803
    cmbCidadeEmitente.AddItem "Mirim Doce - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4210852
    cmbCidadeEmitente.AddItem "Modelo - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4210902
    cmbCidadeEmitente.AddItem "Mondai - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4211009
    cmbCidadeEmitente.AddItem "Monte Carlo - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4211058
    cmbCidadeEmitente.AddItem "Monte Castelo - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4211108
    cmbCidadeEmitente.AddItem "Morro da Fumaca - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4211207
    cmbCidadeEmitente.AddItem "Morro Grande - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4211256
    cmbCidadeEmitente.AddItem "Navegantes - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4211306
    cmbCidadeEmitente.AddItem "Nova Erechim - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4211405
    cmbCidadeEmitente.AddItem "Nova Itaberaba - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4211454
    cmbCidadeEmitente.AddItem "Nova Trento - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4211504
    cmbCidadeEmitente.AddItem "Nova Veneza - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4211603
    cmbCidadeEmitente.AddItem "Novo Horizonte - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4211652
    cmbCidadeEmitente.AddItem "Orleans - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4211702
    cmbCidadeEmitente.AddItem "Otacilio Costa - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4211751
    cmbCidadeEmitente.AddItem "Ouro - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4211801
    cmbCidadeEmitente.AddItem "Ouro Verde - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4211850
    cmbCidadeEmitente.AddItem "Paial - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4211876
    cmbCidadeEmitente.AddItem "Painel - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4211892
    cmbCidadeEmitente.AddItem "Palhoca - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4211900
    cmbCidadeEmitente.AddItem "Palma Sola - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4212007
    cmbCidadeEmitente.AddItem "Palmeira - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4212056
    cmbCidadeEmitente.AddItem "Palmitos - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4212106
    cmbCidadeEmitente.AddItem "Papanduva - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4212205
    cmbCidadeEmitente.AddItem "Paraiso - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4212239
    cmbCidadeEmitente.AddItem "Passo de Torres - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4212254
    cmbCidadeEmitente.AddItem "Passos Maia - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4212270
    cmbCidadeEmitente.AddItem "Paulo Lopes - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4212304
    cmbCidadeEmitente.AddItem "Pedras Grandes - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4212403
    cmbCidadeEmitente.AddItem "Penha - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4212502
    cmbCidadeEmitente.AddItem "Peritiba - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4212601
    cmbCidadeEmitente.AddItem "Pescaria Brava - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4212650
    cmbCidadeEmitente.AddItem "Petrolandia - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4212700
    cmbCidadeEmitente.AddItem "Pinhalzinho - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4212908
    cmbCidadeEmitente.AddItem "Pinheiro Preto - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4213005
    cmbCidadeEmitente.AddItem "Piratuba - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4213104
    cmbCidadeEmitente.AddItem "Planalto Alegre - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4213153
    cmbCidadeEmitente.AddItem "Pomerode - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4213203
    cmbCidadeEmitente.AddItem "Ponte Alta - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4213302
    cmbCidadeEmitente.AddItem "Ponte Alta do Norte - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4213351
    cmbCidadeEmitente.AddItem "Ponte Serrada - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4213401
    cmbCidadeEmitente.AddItem "Porto Belo - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4213500
    cmbCidadeEmitente.AddItem "Porto Uniao - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4213609
    cmbCidadeEmitente.AddItem "Pouso Redondo - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4213708
    cmbCidadeEmitente.AddItem "Praia Grande - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4213807
    cmbCidadeEmitente.AddItem "Presidente Castello Branco - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4213906
    cmbCidadeEmitente.AddItem "Presidente Getulio - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4214003
    cmbCidadeEmitente.AddItem "Presidente Nereu - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4214102
    cmbCidadeEmitente.AddItem "Princesa - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4214151
    cmbCidadeEmitente.AddItem "Quilombo - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4214201
    cmbCidadeEmitente.AddItem "Rancho Queimado - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4214300
    cmbCidadeEmitente.AddItem "Rio das Antas - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4214409
    cmbCidadeEmitente.AddItem "Rio do Campo - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4214508
    cmbCidadeEmitente.AddItem "Rio do Oeste - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4214607
    cmbCidadeEmitente.AddItem "Rio do Sul - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4214805
    cmbCidadeEmitente.AddItem "Rio dos Cedros - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4214706
    cmbCidadeEmitente.AddItem "Rio Fortuna - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4214904
    cmbCidadeEmitente.AddItem "Rio Negrinho - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215000
    cmbCidadeEmitente.AddItem "Rio Rufino - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215059
    cmbCidadeEmitente.AddItem "Riqueza - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215075
    cmbCidadeEmitente.AddItem "Rodeio - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215109
    cmbCidadeEmitente.AddItem "Romelandia - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215208
    cmbCidadeEmitente.AddItem "Salete - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215307
    cmbCidadeEmitente.AddItem "Saltinho - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215356
    cmbCidadeEmitente.AddItem "Salto Veloso - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215406
    cmbCidadeEmitente.AddItem "Sangao - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215455
    cmbCidadeEmitente.AddItem "Santa Cecilia - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215505
    cmbCidadeEmitente.AddItem "Santa Helena - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215554
    cmbCidadeEmitente.AddItem "Santa Rosa de Lima - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215604
    cmbCidadeEmitente.AddItem "Santa Rosa do Sul - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215653
    cmbCidadeEmitente.AddItem "Santa Terezinha - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215679
    cmbCidadeEmitente.AddItem "Santa Terezinha do Progresso - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215687
    cmbCidadeEmitente.AddItem "Santiago do Sul - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215695
    cmbCidadeEmitente.AddItem "Santo Amaro da Imperatriz - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215703
    cmbCidadeEmitente.AddItem "Sao Bento do Sul - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215802
    cmbCidadeEmitente.AddItem "Sao Bernardino - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215752
    cmbCidadeEmitente.AddItem "Sao Bonifacio - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4215901
    cmbCidadeEmitente.AddItem "Sao Carlos - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4216008
    cmbCidadeEmitente.AddItem "Sao Cristovao do Sul - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4216057
    cmbCidadeEmitente.AddItem "Sao Domingos - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4216107
    cmbCidadeEmitente.AddItem "Sao Francisco do Sul - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4216206
    cmbCidadeEmitente.AddItem "Sao Joao Batista - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4216305
    cmbCidadeEmitente.AddItem "Sao Joao do Itaperiu - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4216354
    cmbCidadeEmitente.AddItem "Sao Joao do Oeste - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4216255
    cmbCidadeEmitente.AddItem "Sao Joao do Sul - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4216404
    cmbCidadeEmitente.AddItem "Sao Joaquim - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4216503
    cmbCidadeEmitente.AddItem "Sao Jose - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4216602
    cmbCidadeEmitente.AddItem "Sao Jose do Cedro - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4216701
    cmbCidadeEmitente.AddItem "Sao Jose do Cerrito - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4216800
    cmbCidadeEmitente.AddItem "Sao Lourenco do Oeste - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4216909
    cmbCidadeEmitente.AddItem "Sao Ludgero - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4217006
    cmbCidadeEmitente.AddItem "Sao Martinho - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4217105
    cmbCidadeEmitente.AddItem "Sao Miguel da Boa Vista - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4217154
    cmbCidadeEmitente.AddItem "Sao Miguel do Oeste - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4217204
    cmbCidadeEmitente.AddItem "Sao Pedro de Alcantara - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4217253
    cmbCidadeEmitente.AddItem "Saudades - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4217303
    cmbCidadeEmitente.AddItem "Schroeder - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4217402
    cmbCidadeEmitente.AddItem "Seara - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4217501
    cmbCidadeEmitente.AddItem "Serra Alta - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4217550
    cmbCidadeEmitente.AddItem "Sideropolis - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4217600
    cmbCidadeEmitente.AddItem "Sombrio - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4217709
    cmbCidadeEmitente.AddItem "Sul Brasil - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4217758
    cmbCidadeEmitente.AddItem "Taio - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4217808
    cmbCidadeEmitente.AddItem "Tangara - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4217907
    cmbCidadeEmitente.AddItem "Tigrinhos - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4217956
    cmbCidadeEmitente.AddItem "Tijucas - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4218004
    cmbCidadeEmitente.AddItem "Timbe do Sul - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4218103
    cmbCidadeEmitente.AddItem "Timbo - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4218202
    cmbCidadeEmitente.AddItem "Timbo Grande - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4218251
    cmbCidadeEmitente.AddItem "Tres Barras - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4218301
    cmbCidadeEmitente.AddItem "Treviso - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4218350
    cmbCidadeEmitente.AddItem "Treze de Maio - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4218400
    cmbCidadeEmitente.AddItem "Treze Tilias - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4218509
    cmbCidadeEmitente.AddItem "Trombudo Central - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4218608
    cmbCidadeEmitente.AddItem "Tubarao - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4218707
    cmbCidadeEmitente.AddItem "Tunapolis - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4218756
    cmbCidadeEmitente.AddItem "Turvo - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4218806
    cmbCidadeEmitente.AddItem "Uniao do Oeste - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4218855
    cmbCidadeEmitente.AddItem "Urubici - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4218905
    cmbCidadeEmitente.AddItem "Urupema - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4218954
    cmbCidadeEmitente.AddItem "Urussanga - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4219002
    cmbCidadeEmitente.AddItem "Vargeao - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4219101
    cmbCidadeEmitente.AddItem "Vargem - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4219150
    cmbCidadeEmitente.AddItem "Vargem Bonita - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4219176
    cmbCidadeEmitente.AddItem "Vidal Ramos - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4219200
    cmbCidadeEmitente.AddItem "Videira - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4219309
    cmbCidadeEmitente.AddItem "Vitor Meireles - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4219358
    cmbCidadeEmitente.AddItem "Witmarsum - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4219408
    cmbCidadeEmitente.AddItem "Xanxere - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4219507
    cmbCidadeEmitente.AddItem "Xavantina - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4219606
    cmbCidadeEmitente.AddItem "Xaxim - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4219705
    cmbCidadeEmitente.AddItem "Zortea - SC"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4219853
End Sub

Public Sub RioGrandedoSul(ByRef cmbCidadeEmitente As ComboBox)
    RioGrandedoSul1 cmbCidadeEmitente
    RioGrandedoSul2 cmbCidadeEmitente
    RioGrandedoSul3 cmbCidadeEmitente
    RioGrandedoSul4 cmbCidadeEmitente
End Sub

Private Sub RioGrandedoSul1(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Acegua - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300034
    cmbCidadeEmitente.AddItem "Agua Santa - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300059
    cmbCidadeEmitente.AddItem "Agudo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300109
    cmbCidadeEmitente.AddItem "Ajuricaba - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300208
    cmbCidadeEmitente.AddItem "Alecrim - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300307
    cmbCidadeEmitente.AddItem "Alegrete - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300406
    cmbCidadeEmitente.AddItem "Alegria - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300455
    cmbCidadeEmitente.AddItem "Almirante Tamandare do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300471
    cmbCidadeEmitente.AddItem "Alpestre - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300505
    cmbCidadeEmitente.AddItem "Alto Alegre - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300554
    cmbCidadeEmitente.AddItem "Alto Feliz - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300570
    cmbCidadeEmitente.AddItem "Alvorada - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300604
    cmbCidadeEmitente.AddItem "Amaral Ferrador - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300638
    cmbCidadeEmitente.AddItem "Ametista do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300646
    cmbCidadeEmitente.AddItem "Andre da Rocha - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300661
    cmbCidadeEmitente.AddItem "Anta Gorda - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300703
    cmbCidadeEmitente.AddItem "Antonio Prado - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300802
    cmbCidadeEmitente.AddItem "Arambare - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300851
    cmbCidadeEmitente.AddItem "Ararica - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300877
    cmbCidadeEmitente.AddItem "Aratiba - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4300901
    cmbCidadeEmitente.AddItem "Arroio do Meio - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301008
    cmbCidadeEmitente.AddItem "Arroio do Padre - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301073
    cmbCidadeEmitente.AddItem "Arroio do Sal - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301057
    cmbCidadeEmitente.AddItem "Arroio do Tigre - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301206
    cmbCidadeEmitente.AddItem "Arroio dos Ratos - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301107
    cmbCidadeEmitente.AddItem "Arroio Grande - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301305
    cmbCidadeEmitente.AddItem "Arvorezinha - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301404
    cmbCidadeEmitente.AddItem "Augusto Pestana - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301503
    cmbCidadeEmitente.AddItem "Aurea - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301552
    cmbCidadeEmitente.AddItem "Bage - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301602
    cmbCidadeEmitente.AddItem "Balneario Pinhal - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301636
    cmbCidadeEmitente.AddItem "Barao - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301651
    cmbCidadeEmitente.AddItem "Barao de Cotegipe - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301701
    cmbCidadeEmitente.AddItem "Barao do Triunfo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301750
    cmbCidadeEmitente.AddItem "Barra do Guarita - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301859
    cmbCidadeEmitente.AddItem "Barra do Quarai - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301875
    cmbCidadeEmitente.AddItem "Barra do Ribeiro - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301909
    cmbCidadeEmitente.AddItem "Barra do Rio Azul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301925
    cmbCidadeEmitente.AddItem "Barra Funda - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301958
    cmbCidadeEmitente.AddItem "Barracao - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4301800
    cmbCidadeEmitente.AddItem "Barros Cassal - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302006
    cmbCidadeEmitente.AddItem "Benjamin Constant do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302055
    cmbCidadeEmitente.AddItem "Bento Goncalves - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302105
    cmbCidadeEmitente.AddItem "Boa Vista das Missoes - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302154
    cmbCidadeEmitente.AddItem "Boa vista do Burica - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302204
    cmbCidadeEmitente.AddItem "Boa Vista do Cadeado - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302220
    cmbCidadeEmitente.AddItem "Boa Vista do Incra - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302238
    cmbCidadeEmitente.AddItem "Boa Vista do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302253
    cmbCidadeEmitente.AddItem "Bom Jesus - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302303
    cmbCidadeEmitente.AddItem "Bom Principio - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302352
    cmbCidadeEmitente.AddItem "Bom Progresso - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302378
    cmbCidadeEmitente.AddItem "Bom Retiro do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302402
    cmbCidadeEmitente.AddItem "Boqueirao do Leao - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302451
    cmbCidadeEmitente.AddItem "Bossoroca - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302501
    cmbCidadeEmitente.AddItem "Bozano - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302584
    cmbCidadeEmitente.AddItem "Braga - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302600
    cmbCidadeEmitente.AddItem "Brochier - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302659
    cmbCidadeEmitente.AddItem "Butia - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302709
    cmbCidadeEmitente.AddItem "Cacapava do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302808
    cmbCidadeEmitente.AddItem "Cacequi - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4302907
    cmbCidadeEmitente.AddItem "Cachoeira do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4303004
    cmbCidadeEmitente.AddItem "Cachoeirinha - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4303103
    cmbCidadeEmitente.AddItem "Cacique Doble - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4303202
    cmbCidadeEmitente.AddItem "Caibate - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4303301
    cmbCidadeEmitente.AddItem "Caicara - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4303400
    cmbCidadeEmitente.AddItem "Camaqua - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4303509
    cmbCidadeEmitente.AddItem "Camargo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4303558
    cmbCidadeEmitente.AddItem "Cambara do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4303608
    cmbCidadeEmitente.AddItem "Campestre da Serra - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4303673
    cmbCidadeEmitente.AddItem "Campina das Missoes - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4303707
    cmbCidadeEmitente.AddItem "Campinas do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4303806
    cmbCidadeEmitente.AddItem "Campo Bom - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4303905
    cmbCidadeEmitente.AddItem "Campo Novo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304002
    cmbCidadeEmitente.AddItem "Campos Borges - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304101
    cmbCidadeEmitente.AddItem "Candelaria - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304200
    cmbCidadeEmitente.AddItem "Candido Godoi - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304309
    cmbCidadeEmitente.AddItem "Candiota - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304358
    cmbCidadeEmitente.AddItem "Canela - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304408
    cmbCidadeEmitente.AddItem "Cangucu - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304507
    cmbCidadeEmitente.AddItem "Canoas - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304606
    cmbCidadeEmitente.AddItem "Canudos do Vale - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304614
    cmbCidadeEmitente.AddItem "Capao Bonito do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304622
    cmbCidadeEmitente.AddItem "Capao da Canoa - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304630
    cmbCidadeEmitente.AddItem "Capao do Cipo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304655
    cmbCidadeEmitente.AddItem "Capao do Leao - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304663
    cmbCidadeEmitente.AddItem "Capela de Santana - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304689
    cmbCidadeEmitente.AddItem "Capitao - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304697
    cmbCidadeEmitente.AddItem "Capivari do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304671
    cmbCidadeEmitente.AddItem "Caraa - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304713
    cmbCidadeEmitente.AddItem "Carazinho - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304705
    cmbCidadeEmitente.AddItem "Carlos Barbosa - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304804
    cmbCidadeEmitente.AddItem "Carlos Gomes - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304853
    cmbCidadeEmitente.AddItem "Casca - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304903
    cmbCidadeEmitente.AddItem "Caseiros - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4304952
    cmbCidadeEmitente.AddItem "Catuipe - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305009
    cmbCidadeEmitente.AddItem "Caxias do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305108
    cmbCidadeEmitente.AddItem "Centenario - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305116
    cmbCidadeEmitente.AddItem "Cerrito - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305124
    cmbCidadeEmitente.AddItem "Cerro Branco - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305132
    cmbCidadeEmitente.AddItem "Cerro Grande - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305157
    cmbCidadeEmitente.AddItem "Cerro Grande do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305173
    cmbCidadeEmitente.AddItem "Cerro Largo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305207
    cmbCidadeEmitente.AddItem "Chapada - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305306
    cmbCidadeEmitente.AddItem "Charqueadas - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305355
    cmbCidadeEmitente.AddItem "Charrua - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305371
    cmbCidadeEmitente.AddItem "Chiapetta - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305405
    cmbCidadeEmitente.AddItem "Chui - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305439
    cmbCidadeEmitente.AddItem "Chuvisca - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305447
    cmbCidadeEmitente.AddItem "Cidreira - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305454
    cmbCidadeEmitente.AddItem "Ciriaco - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305504
    cmbCidadeEmitente.AddItem "Colinas - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305587
    cmbCidadeEmitente.AddItem "Colorado - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305603
    cmbCidadeEmitente.AddItem "Condor - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305702
    cmbCidadeEmitente.AddItem "Constantina - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305801
    cmbCidadeEmitente.AddItem "Coqueiro Baixo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305835
    cmbCidadeEmitente.AddItem "Coqueiros do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305850
    cmbCidadeEmitente.AddItem "Coronel Barros - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305871
    cmbCidadeEmitente.AddItem "Coronel Bicaco - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305900
    cmbCidadeEmitente.AddItem "Coronel Pilar - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305934
    cmbCidadeEmitente.AddItem "Cotipora - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305959
    cmbCidadeEmitente.AddItem "Coxilha - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4305975
    cmbCidadeEmitente.AddItem "Crissiumal - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306007
    cmbCidadeEmitente.AddItem "Cristal - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306056
    cmbCidadeEmitente.AddItem "Cristal do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306072
    cmbCidadeEmitente.AddItem "Cruz Alta - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306106
    cmbCidadeEmitente.AddItem "Cruzaltense - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306130
    cmbCidadeEmitente.AddItem "Cruzeiro do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306205
    cmbCidadeEmitente.AddItem "David Canabarro - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306304
    cmbCidadeEmitente.AddItem "Derrubadas - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306320
    cmbCidadeEmitente.AddItem "Dezesseis de Novembro - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306353
    cmbCidadeEmitente.AddItem "Dilermando de Aguiar - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306379
    cmbCidadeEmitente.AddItem "Dois Irmaos - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306403
    cmbCidadeEmitente.AddItem "Dois Irmaos das Missoes - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306429
    cmbCidadeEmitente.AddItem "Dois Lajeados - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306452
    cmbCidadeEmitente.AddItem "Dom Feliciano - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306502
    cmbCidadeEmitente.AddItem "Dom Pedrito - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306601
    cmbCidadeEmitente.AddItem "Dom Pedro de Alcantara - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306551
    cmbCidadeEmitente.AddItem "Dona Francisca - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306700
    cmbCidadeEmitente.AddItem "Doutor Mauricio Cardoso - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306734
    cmbCidadeEmitente.AddItem "Doutor Ricardo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306759
    cmbCidadeEmitente.AddItem "Eldorado do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306767
    cmbCidadeEmitente.AddItem "Encantado - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306809
    cmbCidadeEmitente.AddItem "Encruzilhada do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306908
    cmbCidadeEmitente.AddItem "Engenho Velho - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306924
    cmbCidadeEmitente.AddItem "Entre Rios do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306957
    cmbCidadeEmitente.AddItem "Entre-Ijuis - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306932
    cmbCidadeEmitente.AddItem "Erebango - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4306973
    cmbCidadeEmitente.AddItem "Erechim - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4307005
    cmbCidadeEmitente.AddItem "Ernestina - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4307054
    cmbCidadeEmitente.AddItem "Erval Grande - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4307203
End Sub

Private Sub RioGrandedoSul2(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Erval Seco - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4307302
    cmbCidadeEmitente.AddItem "Esmeralda - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4307401
    cmbCidadeEmitente.AddItem "Esperanca do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4307450
    cmbCidadeEmitente.AddItem "Espumoso - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4307500
    cmbCidadeEmitente.AddItem "Estacao - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4307559
    cmbCidadeEmitente.AddItem "Estancia Velha - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4307609
    cmbCidadeEmitente.AddItem "Esteio - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4307708
    cmbCidadeEmitente.AddItem "Estrela - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4307807
    cmbCidadeEmitente.AddItem "Estrela Velha - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4307815
    cmbCidadeEmitente.AddItem "Eugenio de Castro - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4307831
    cmbCidadeEmitente.AddItem "Fagundes Varela - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4307864
    cmbCidadeEmitente.AddItem "Farroupilha - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4307906
    cmbCidadeEmitente.AddItem "Faxinal do Soturno - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4308003
    cmbCidadeEmitente.AddItem "Faxinalzinho - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4308052
    cmbCidadeEmitente.AddItem "Fazenda Vilanova - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4308078
    cmbCidadeEmitente.AddItem "Feliz - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4308102
    cmbCidadeEmitente.AddItem "Flores da Cunha - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4308201
    cmbCidadeEmitente.AddItem "Floriano Peixoto - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4308250
    cmbCidadeEmitente.AddItem "Fontoura Xavier - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4308300
    cmbCidadeEmitente.AddItem "Formigueiro - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4308409
    cmbCidadeEmitente.AddItem "Forquetinha - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4308433
    cmbCidadeEmitente.AddItem "Fortaleza dos Valos - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4308458
    cmbCidadeEmitente.AddItem "Frederico Westphalen - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4308508
    cmbCidadeEmitente.AddItem "Garibaldi - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4308607
    cmbCidadeEmitente.AddItem "Garruchos - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4308656
    cmbCidadeEmitente.AddItem "Gaurama - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4308706
    cmbCidadeEmitente.AddItem "General Camara - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4308805
    cmbCidadeEmitente.AddItem "Gentil - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4308854
    cmbCidadeEmitente.AddItem "Getulio Vargas - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4308904
    cmbCidadeEmitente.AddItem "Girua - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4309001
    cmbCidadeEmitente.AddItem "Glorinha - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4309050
    cmbCidadeEmitente.AddItem "Gramado - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4309100
    cmbCidadeEmitente.AddItem "Gramado dos Loureiros - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4309126
    cmbCidadeEmitente.AddItem "Gramado Xavier - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4309159
    cmbCidadeEmitente.AddItem "Gravatai - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4309209
    cmbCidadeEmitente.AddItem "Guabiju - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4309258
    cmbCidadeEmitente.AddItem "Guaiba - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4309308
    cmbCidadeEmitente.AddItem "Guapore - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4309407
    cmbCidadeEmitente.AddItem "Guarani das Missoes - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4309506
    cmbCidadeEmitente.AddItem "Harmonia - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4309555
    cmbCidadeEmitente.AddItem "Herval - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4307104
    cmbCidadeEmitente.AddItem "Herveiras - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4309571
    cmbCidadeEmitente.AddItem "Horizontina - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4309605
    cmbCidadeEmitente.AddItem "Hulha Negra - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4309654
    cmbCidadeEmitente.AddItem "Humaita - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4309704
    cmbCidadeEmitente.AddItem "Ibarama - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4309753
    cmbCidadeEmitente.AddItem "Ibiaca - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4309803
    cmbCidadeEmitente.AddItem "Ibiraiaras - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4309902
    cmbCidadeEmitente.AddItem "Ibirapuita - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4309951
    cmbCidadeEmitente.AddItem "Ibiruba - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310009
    cmbCidadeEmitente.AddItem "Igrejinha - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310108
    cmbCidadeEmitente.AddItem "Ijui - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310207
    cmbCidadeEmitente.AddItem "Ilopolis - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310306
    cmbCidadeEmitente.AddItem "Imbe - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310330
    cmbCidadeEmitente.AddItem "Imigrante - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310363
    cmbCidadeEmitente.AddItem "Independencia - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310405
    cmbCidadeEmitente.AddItem "Inhacora - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310413
    cmbCidadeEmitente.AddItem "Ipe - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310439
    cmbCidadeEmitente.AddItem "Ipiranga do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310462
    cmbCidadeEmitente.AddItem "Irai - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310504
    cmbCidadeEmitente.AddItem "Itaara - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310538
    cmbCidadeEmitente.AddItem "Itacurubi - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310553
    cmbCidadeEmitente.AddItem "Itapuca - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310579
    cmbCidadeEmitente.AddItem "Itaqui - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310603
    cmbCidadeEmitente.AddItem "Itati - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310652
    cmbCidadeEmitente.AddItem "Itatiba do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310702
    cmbCidadeEmitente.AddItem "Ivora - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310751
    cmbCidadeEmitente.AddItem "Ivoti - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310801
    cmbCidadeEmitente.AddItem "Jaboticaba - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310850
    cmbCidadeEmitente.AddItem "Jacuizinho - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310876
    cmbCidadeEmitente.AddItem "Jacutinga - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4310900
    cmbCidadeEmitente.AddItem "Jaguarao - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311007
    cmbCidadeEmitente.AddItem "Jaguari - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311106
    cmbCidadeEmitente.AddItem "Jaquirana - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311122
    cmbCidadeEmitente.AddItem "Jari - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311130
    cmbCidadeEmitente.AddItem "Joia - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311155
    cmbCidadeEmitente.AddItem "Julio de Castilhos - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311205
    cmbCidadeEmitente.AddItem "Lagoa Bonita do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311239
    cmbCidadeEmitente.AddItem "Lagoa dos Tres Cantos - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311270
    cmbCidadeEmitente.AddItem "Lagoa Vermelha - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311304
    cmbCidadeEmitente.AddItem "Lagoao - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311254
    cmbCidadeEmitente.AddItem "Lajeado - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311403
    cmbCidadeEmitente.AddItem "Lajeado do Bugre - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311429
    cmbCidadeEmitente.AddItem "Lavras do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311502
    cmbCidadeEmitente.AddItem "Liberato Salzano - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311601
    cmbCidadeEmitente.AddItem "Lindolfo Collor - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311627
    cmbCidadeEmitente.AddItem "Linha Nova - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311643
    cmbCidadeEmitente.AddItem "Macambara - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311718
    cmbCidadeEmitente.AddItem "Machadinho - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311700
    cmbCidadeEmitente.AddItem "Mampituba - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311734
    cmbCidadeEmitente.AddItem "Manoel Viana - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311759
    cmbCidadeEmitente.AddItem "Maquine - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311775
    cmbCidadeEmitente.AddItem "Marata - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311791
    cmbCidadeEmitente.AddItem "Marau - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311809
    cmbCidadeEmitente.AddItem "Marcelino Ramos - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311908
    cmbCidadeEmitente.AddItem "Mariana Pimentel - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4311981
    cmbCidadeEmitente.AddItem "Mariano Moro - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312005
    cmbCidadeEmitente.AddItem "Marques de Souza - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312054
    cmbCidadeEmitente.AddItem "Mata - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312104
    cmbCidadeEmitente.AddItem "Mato Castelhano - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312138
    cmbCidadeEmitente.AddItem "Mato Leitao - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312153
    cmbCidadeEmitente.AddItem "Mato Queimado - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312179
    cmbCidadeEmitente.AddItem "Maximiliano de Almeida - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312203
    cmbCidadeEmitente.AddItem "Minas do Leao - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312252
    cmbCidadeEmitente.AddItem "Miraguai - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312302
    cmbCidadeEmitente.AddItem "Montauri - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312351
    cmbCidadeEmitente.AddItem "Monte Alegre dos Campos - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312377
    cmbCidadeEmitente.AddItem "Monte Belo do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312385
    cmbCidadeEmitente.AddItem "Montenegro - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312401
    cmbCidadeEmitente.AddItem "Mormaco - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312427
    cmbCidadeEmitente.AddItem "Morrinhos do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312443
    cmbCidadeEmitente.AddItem "Morro Redondo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312450
    cmbCidadeEmitente.AddItem "Morro Reuter - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312476
    cmbCidadeEmitente.AddItem "Mostardas - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312500
    cmbCidadeEmitente.AddItem "Mucum - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312609
    cmbCidadeEmitente.AddItem "Muitos Capoes - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312617
    cmbCidadeEmitente.AddItem "Muliterno - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312625
    cmbCidadeEmitente.AddItem "Nao-Me-Toque - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312658
    cmbCidadeEmitente.AddItem "Nicolau Vergueiro - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312674
    cmbCidadeEmitente.AddItem "Nonoai - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312708
    cmbCidadeEmitente.AddItem "Nova Alvorada - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312757
    cmbCidadeEmitente.AddItem "Nova Araca - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312807
    cmbCidadeEmitente.AddItem "Nova Bassano - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312906
    cmbCidadeEmitente.AddItem "Nova Boa Vista - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4312955
    cmbCidadeEmitente.AddItem "Nova Brescia - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313003
    cmbCidadeEmitente.AddItem "Nova Candelaria - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313011
    cmbCidadeEmitente.AddItem "Nova Esperanca do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313037
    cmbCidadeEmitente.AddItem "Nova Hartz - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313060
    cmbCidadeEmitente.AddItem "Nova Padua - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313086
    cmbCidadeEmitente.AddItem "Nova Palma - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313102
    cmbCidadeEmitente.AddItem "Nova Petropolis - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313201
    cmbCidadeEmitente.AddItem "Nova Prata - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313300
    cmbCidadeEmitente.AddItem "Nova Ramada - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313334
    cmbCidadeEmitente.AddItem "Nova Roma do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313359
    cmbCidadeEmitente.AddItem "Nova Santa Rita - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313375
    cmbCidadeEmitente.AddItem "Novo Barreiro - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313490
    cmbCidadeEmitente.AddItem "Novo Cabrais - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313391
    cmbCidadeEmitente.AddItem "Novo Hamburgo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313409
    cmbCidadeEmitente.AddItem "Novo Machado - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313425
    cmbCidadeEmitente.AddItem "Novo Tiradentes - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313441
    cmbCidadeEmitente.AddItem "Novo Xingu - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313466
    cmbCidadeEmitente.AddItem "Osorio - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313508
    cmbCidadeEmitente.AddItem "Paim Filho - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313607
    cmbCidadeEmitente.AddItem "Palmares do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313656
    cmbCidadeEmitente.AddItem "Palmeira das Missoes - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313706
    cmbCidadeEmitente.AddItem "Palmitinho - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313805
    cmbCidadeEmitente.AddItem "Panambi - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313904
    cmbCidadeEmitente.AddItem "Pantano Grande - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4313953
    cmbCidadeEmitente.AddItem "Parai - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314001
    cmbCidadeEmitente.AddItem "Paraiso do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314027
End Sub

Private Sub RioGrandedoSul3(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Pareci Novo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314035
    cmbCidadeEmitente.AddItem "Parobe - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314050
    cmbCidadeEmitente.AddItem "Passa Sete - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314068
    cmbCidadeEmitente.AddItem "Passo do Sobrado - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314076
    cmbCidadeEmitente.AddItem "Passo Fundo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314100
    cmbCidadeEmitente.AddItem "Paulo Bento - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314134
    cmbCidadeEmitente.AddItem "Paverama - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314159
    cmbCidadeEmitente.AddItem "Pedras Altas - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314175
    cmbCidadeEmitente.AddItem "Pedro Osorio - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314209
    cmbCidadeEmitente.AddItem "Pejucara - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314308
    cmbCidadeEmitente.AddItem "Pelotas - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314407
    cmbCidadeEmitente.AddItem "Picada Cafe - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314423
    cmbCidadeEmitente.AddItem "Pinhal - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314456
    cmbCidadeEmitente.AddItem "Pinhal da Serra - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314464
    cmbCidadeEmitente.AddItem "Pinhal Grande - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314472
    cmbCidadeEmitente.AddItem "Pinheirinho do Vale - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314498
    cmbCidadeEmitente.AddItem "Pinheiro Machado - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314506
    cmbCidadeEmitente.AddItem "Pinto Bandeira - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314548
    cmbCidadeEmitente.AddItem "Pirapo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314555
    cmbCidadeEmitente.AddItem "Piratini - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314605
    cmbCidadeEmitente.AddItem "Planalto - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314704
    cmbCidadeEmitente.AddItem "Poco das Antas - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314753
    cmbCidadeEmitente.AddItem "Pontao - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314779
    cmbCidadeEmitente.AddItem "Ponte Preta - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314787
    cmbCidadeEmitente.AddItem "Portao - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314803
    cmbCidadeEmitente.AddItem "Porto Alegre - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4314902
    cmbCidadeEmitente.AddItem "Porto Lucena - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315008
    cmbCidadeEmitente.AddItem "Porto Maua - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315057
    cmbCidadeEmitente.AddItem "Porto Vera Cruz - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315073
    cmbCidadeEmitente.AddItem "Porto Xavier - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315107
    cmbCidadeEmitente.AddItem "Pouso Novo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315131
    cmbCidadeEmitente.AddItem "Presidente Lucena - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315149
    cmbCidadeEmitente.AddItem "Progresso - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315156
    cmbCidadeEmitente.AddItem "Protasio Alves - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315172
    cmbCidadeEmitente.AddItem "Putinga - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315206
    cmbCidadeEmitente.AddItem "Quarai - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315305
    cmbCidadeEmitente.AddItem "Quatro Irmaos - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315313
    cmbCidadeEmitente.AddItem "Quevedos - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315321
    cmbCidadeEmitente.AddItem "Quinze de Novembro - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315354
    cmbCidadeEmitente.AddItem "Redentora - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315404
    cmbCidadeEmitente.AddItem "Relvado - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315453
    cmbCidadeEmitente.AddItem "Restinga Seca - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315503
    cmbCidadeEmitente.AddItem "Rio dos Indios - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315552
    cmbCidadeEmitente.AddItem "Rio Grande - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315602
    cmbCidadeEmitente.AddItem "Rio Pardo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315701
    cmbCidadeEmitente.AddItem "Riozinho - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315750
    cmbCidadeEmitente.AddItem "Roca Sales - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315800
    cmbCidadeEmitente.AddItem "Rodeio Bonito - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315909
    cmbCidadeEmitente.AddItem "Rolador - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4315958
    cmbCidadeEmitente.AddItem "Rolante - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4316006
    cmbCidadeEmitente.AddItem "Ronda Alta - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4316105
    cmbCidadeEmitente.AddItem "Rondinha - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4316204
    cmbCidadeEmitente.AddItem "Roque Gonzales - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4316303
    cmbCidadeEmitente.AddItem "Rosario do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4316402
    cmbCidadeEmitente.AddItem "Sagrada Familia - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4316428
    cmbCidadeEmitente.AddItem "Saldanha Marinho - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4316436
    cmbCidadeEmitente.AddItem "Salto do Jacui - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4316451
    cmbCidadeEmitente.AddItem "Salvador das Missoes - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4316477
    cmbCidadeEmitente.AddItem "Salvador do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4316501
    cmbCidadeEmitente.AddItem "Sananduva - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4316600
    cmbCidadeEmitente.AddItem "Santa Barbara do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4316709
    cmbCidadeEmitente.AddItem "Santa Cecilia do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4316733
    cmbCidadeEmitente.AddItem "Santa Clara do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4316758
    cmbCidadeEmitente.AddItem "Santa Cruz do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4316808
    cmbCidadeEmitente.AddItem "Santa Margarida do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4316972
    cmbCidadeEmitente.AddItem "Santa Maria - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4316907
    cmbCidadeEmitente.AddItem "Santa Maria do Herval - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4316956
    cmbCidadeEmitente.AddItem "Santa Rosa - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4317202
    cmbCidadeEmitente.AddItem "Santa Tereza - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4317251
    cmbCidadeEmitente.AddItem "Santa Vitoria do Palmar - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4317301
    cmbCidadeEmitente.AddItem "Santana da Boa Vista - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4317004
    cmbCidadeEmitente.AddItem "Santana do Livramento - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4317103
    cmbCidadeEmitente.AddItem "Santiago - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4317400
    cmbCidadeEmitente.AddItem "Santo Angelo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4317509
    cmbCidadeEmitente.AddItem "Santo Antonio da Patrulha - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4317608
    cmbCidadeEmitente.AddItem "Santo Antonio das Missoes - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4317707
    cmbCidadeEmitente.AddItem "Santo Antonio do Palma - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4317558
    cmbCidadeEmitente.AddItem "Santo Antonio do Planalto - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4317756
    cmbCidadeEmitente.AddItem "Santo Augusto - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4317806
    cmbCidadeEmitente.AddItem "Santo Cristo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4317905
    cmbCidadeEmitente.AddItem "Santo Expedito do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4317954
    cmbCidadeEmitente.AddItem "Sao Borja - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318002
    cmbCidadeEmitente.AddItem "Sao Domingos do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318051
    cmbCidadeEmitente.AddItem "Sao Francisco de Assis - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318101
    cmbCidadeEmitente.AddItem "Sao Francisco de Paula - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318200
    cmbCidadeEmitente.AddItem "Sao Gabriel - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318309
    cmbCidadeEmitente.AddItem "Sao Jeronimo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318408
    cmbCidadeEmitente.AddItem "Sao Joao da Urtiga - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318424
    cmbCidadeEmitente.AddItem "Sao Joao do Polesine - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318432
    cmbCidadeEmitente.AddItem "Sao Jorge - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318440
    cmbCidadeEmitente.AddItem "Sao Jose das Missoes - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318457
    cmbCidadeEmitente.AddItem "Sao Jose do Herval - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318465
    cmbCidadeEmitente.AddItem "Sao Jose do Hortencio - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318481
    cmbCidadeEmitente.AddItem "Sao Jose do Inhacora - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318499
    cmbCidadeEmitente.AddItem "Sao Jose do Norte - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318507
    cmbCidadeEmitente.AddItem "Sao Jose do Ouro - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318606
    cmbCidadeEmitente.AddItem "Sao Jose do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318614
    cmbCidadeEmitente.AddItem "Sao Jose dos Ausentes - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318622
    cmbCidadeEmitente.AddItem "Sao Leopoldo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318705
    cmbCidadeEmitente.AddItem "Sao Lourenco do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318804
    cmbCidadeEmitente.AddItem "Sao Luiz Gonzaga - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4318903
    cmbCidadeEmitente.AddItem "Sao Marcos - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4319000
    cmbCidadeEmitente.AddItem "Sao Martinho - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4319109
    cmbCidadeEmitente.AddItem "Sao Martinho da Serra - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4319125
    cmbCidadeEmitente.AddItem "Sao Miguel das Missoes - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4319158
    cmbCidadeEmitente.AddItem "Sao Nicolau - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4319208
    cmbCidadeEmitente.AddItem "Sao Paulo das Missoes - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4319307
    cmbCidadeEmitente.AddItem "Sao Pedro da Serra - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4319356
    cmbCidadeEmitente.AddItem "Sao Pedro das Missoes - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4319364
    cmbCidadeEmitente.AddItem "Sao Pedro do Butia - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4319372
    cmbCidadeEmitente.AddItem "Sao Pedro do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4319406
    cmbCidadeEmitente.AddItem "Sao Sebastiao do Cai - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4319505
    cmbCidadeEmitente.AddItem "Sao Sepe - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4319604
    cmbCidadeEmitente.AddItem "Sao Valentim - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4319703
    cmbCidadeEmitente.AddItem "Sao Valentim do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4319711
    cmbCidadeEmitente.AddItem "Sao Valerio do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4319737
    cmbCidadeEmitente.AddItem "Sao Vendelino - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4319752
    cmbCidadeEmitente.AddItem "Sao Vicente do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4319802
    cmbCidadeEmitente.AddItem "Sapiranga - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4319901
    cmbCidadeEmitente.AddItem "Sapucaia do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320008
    cmbCidadeEmitente.AddItem "Sarandi - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320107
    cmbCidadeEmitente.AddItem "Seberi - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320206
    cmbCidadeEmitente.AddItem "Sede Nova - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320230
    cmbCidadeEmitente.AddItem "Segredo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320263
    cmbCidadeEmitente.AddItem "Selbach - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320305
    cmbCidadeEmitente.AddItem "Senador Salgado Filho - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320321
    cmbCidadeEmitente.AddItem "Sentinela do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320354
    cmbCidadeEmitente.AddItem "Serafina Correa - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320404
    cmbCidadeEmitente.AddItem "Serio - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320453
    cmbCidadeEmitente.AddItem "Sertao - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320503
    cmbCidadeEmitente.AddItem "Sertao Santana - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320552
    cmbCidadeEmitente.AddItem "Sete de Setembro - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320578
    cmbCidadeEmitente.AddItem "Severiano de Almeida - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320602
    cmbCidadeEmitente.AddItem "Silveira Martins - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320651
    cmbCidadeEmitente.AddItem "Sinimbu - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320677
    cmbCidadeEmitente.AddItem "Sobradinho - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320701
    cmbCidadeEmitente.AddItem "Soledade - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320800
    cmbCidadeEmitente.AddItem "Tabai - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320859
    cmbCidadeEmitente.AddItem "Tapejara - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4320909
    cmbCidadeEmitente.AddItem "Tapera - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321006
    cmbCidadeEmitente.AddItem "Tapes - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321105
    cmbCidadeEmitente.AddItem "Taquara - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321204
    cmbCidadeEmitente.AddItem "Taquari - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321303
    cmbCidadeEmitente.AddItem "Taquarucu do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321329
    cmbCidadeEmitente.AddItem "Tavares - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321352
    cmbCidadeEmitente.AddItem "Tenente Portela - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321402
    cmbCidadeEmitente.AddItem "Terra de Areia - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321436
    cmbCidadeEmitente.AddItem "Teutonia - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321451
    cmbCidadeEmitente.AddItem "Tio Hugo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321469
    cmbCidadeEmitente.AddItem "Tiradentes do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321477
End Sub

Private Sub RioGrandedoSul4(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Toropi - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321493
    cmbCidadeEmitente.AddItem "Torres - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321501
    cmbCidadeEmitente.AddItem "Tramandai - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321600
    cmbCidadeEmitente.AddItem "Travesseiro - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321626
    cmbCidadeEmitente.AddItem "Tres Arroios - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321634
    cmbCidadeEmitente.AddItem "Tres Cachoeiras - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321667
    cmbCidadeEmitente.AddItem "Tres Coroas - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321709
    cmbCidadeEmitente.AddItem "Tres de Maio - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321808
    cmbCidadeEmitente.AddItem "Tres Forquilhas - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321832
    cmbCidadeEmitente.AddItem "Tres Palmeiras - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321857
    cmbCidadeEmitente.AddItem "Tres Passos - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321907
    cmbCidadeEmitente.AddItem "Trindade do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4321956
    cmbCidadeEmitente.AddItem "Triunfo - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322004
    cmbCidadeEmitente.AddItem "Tucunduva - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322103
    cmbCidadeEmitente.AddItem "Tunas - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322152
    cmbCidadeEmitente.AddItem "Tupanci do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322186
    cmbCidadeEmitente.AddItem "Tupancireta - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322202
    cmbCidadeEmitente.AddItem "Tupandi - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322251
    cmbCidadeEmitente.AddItem "Tuparendi - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322301
    cmbCidadeEmitente.AddItem "Turucu - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322327
    cmbCidadeEmitente.AddItem "Ubiretama - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322343
    cmbCidadeEmitente.AddItem "Uniao da Serra - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322350
    cmbCidadeEmitente.AddItem "Unistalda - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322376
    cmbCidadeEmitente.AddItem "Uruguaiana - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322400
    cmbCidadeEmitente.AddItem "Vacaria - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322509
    cmbCidadeEmitente.AddItem "Vale do Sol - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322533
    cmbCidadeEmitente.AddItem "Vale Real - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322541
    cmbCidadeEmitente.AddItem "Vale Verde - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322525
    cmbCidadeEmitente.AddItem "Vanini - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322558
    cmbCidadeEmitente.AddItem "Venancio Aires - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322608
    cmbCidadeEmitente.AddItem "Vera Cruz - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322707
    cmbCidadeEmitente.AddItem "Veranopolis - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322806
    cmbCidadeEmitente.AddItem "Vespasiano Correa - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322855
    cmbCidadeEmitente.AddItem "Viadutos - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4322905
    cmbCidadeEmitente.AddItem "Viamao - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4323002
    cmbCidadeEmitente.AddItem "Vicente Dutra - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4323101
    cmbCidadeEmitente.AddItem "Victor Graeff - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4323200
    cmbCidadeEmitente.AddItem "Vila Flores - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4323309
    cmbCidadeEmitente.AddItem "Vila Langaro - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4323358
    cmbCidadeEmitente.AddItem "Vila Maria - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4323408
    cmbCidadeEmitente.AddItem "Vila Nova do Sul - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4323457
    cmbCidadeEmitente.AddItem "Vista Alegre - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4323507
    cmbCidadeEmitente.AddItem "Vista Alegre do Prata - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4323606
    cmbCidadeEmitente.AddItem "Vista Gaucha - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4323705
    cmbCidadeEmitente.AddItem "Vitoria das Missoes - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4323754
    cmbCidadeEmitente.AddItem "Westfalia - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4323770
    cmbCidadeEmitente.AddItem "Xangri-La - RS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 4323804
End Sub

Public Sub MatoGrossodoSul(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Agua Clara - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5000203
    cmbCidadeEmitente.AddItem "Alcinopolis - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5000252
    cmbCidadeEmitente.AddItem "Amambai - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5000609
    cmbCidadeEmitente.AddItem "Anastacio - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5000708
    cmbCidadeEmitente.AddItem "Anaurilandia - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5000807
    cmbCidadeEmitente.AddItem "Angelica - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5000856
    cmbCidadeEmitente.AddItem "Antonio Joao - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5000906
    cmbCidadeEmitente.AddItem "Aparecida do Taboado - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5001003
    cmbCidadeEmitente.AddItem "Aquidauana - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5001102
    cmbCidadeEmitente.AddItem "Aral Moreira - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5001243
    cmbCidadeEmitente.AddItem "Bandeirantes - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5001508
    cmbCidadeEmitente.AddItem "Bataguassu - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5001904
    cmbCidadeEmitente.AddItem "Bataypora - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5002001
    cmbCidadeEmitente.AddItem "Bela Vista - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5002100
    cmbCidadeEmitente.AddItem "Bodoquena - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5002159
    cmbCidadeEmitente.AddItem "Bonito - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5002209
    cmbCidadeEmitente.AddItem "Brasilandia - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5002308
    cmbCidadeEmitente.AddItem "Caarapo - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5002407
    cmbCidadeEmitente.AddItem "Camapua - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5002605
    cmbCidadeEmitente.AddItem "Campo Grande - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5002704
    cmbCidadeEmitente.AddItem "Caracol - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5002803
    cmbCidadeEmitente.AddItem "Cassilandia - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5002902
    cmbCidadeEmitente.AddItem "Chapadao do Sul - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5002951
    cmbCidadeEmitente.AddItem "Corguinho - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5003108
    cmbCidadeEmitente.AddItem "Coronel Sapucaia - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5003157
    cmbCidadeEmitente.AddItem "Corumba - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5003207
    cmbCidadeEmitente.AddItem "Costa Rica - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5003256
    cmbCidadeEmitente.AddItem "Coxim - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5003306
    cmbCidadeEmitente.AddItem "Deodapolis - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5003454
    cmbCidadeEmitente.AddItem "Dois Irmaos do Buriti - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5003488
    cmbCidadeEmitente.AddItem "Douradina - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5003504
    cmbCidadeEmitente.AddItem "Dourados - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5003702
    cmbCidadeEmitente.AddItem "Eldorado - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5003751
    cmbCidadeEmitente.AddItem "Fatima do Sul - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5003801
    cmbCidadeEmitente.AddItem "Figueirao - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5003900
    cmbCidadeEmitente.AddItem "Gloria de Dourados - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5004007
    cmbCidadeEmitente.AddItem "Guia Lopes da Laguna - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5004106
    cmbCidadeEmitente.AddItem "Iguatemi - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5004304
    cmbCidadeEmitente.AddItem "Inocencia - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5004403
    cmbCidadeEmitente.AddItem "Itapora - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5004502
    cmbCidadeEmitente.AddItem "Itaquirai - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5004601
    cmbCidadeEmitente.AddItem "Ivinhema - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5004700
    cmbCidadeEmitente.AddItem "Japora - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5004809
    cmbCidadeEmitente.AddItem "Jaraguari - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5004908
    cmbCidadeEmitente.AddItem "Jardim - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5005004
    cmbCidadeEmitente.AddItem "Jatei - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5005103
    cmbCidadeEmitente.AddItem "Juti - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5005152
    cmbCidadeEmitente.AddItem "Ladario - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5005202
    cmbCidadeEmitente.AddItem "Laguna Carapa - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5005251
    cmbCidadeEmitente.AddItem "Maracaju - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5005400
    cmbCidadeEmitente.AddItem "Miranda - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5005608
    cmbCidadeEmitente.AddItem "Mundo Novo - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5005681
    cmbCidadeEmitente.AddItem "Navirai - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5005707
    cmbCidadeEmitente.AddItem "Nioaque - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5005806
    cmbCidadeEmitente.AddItem "Nova Alvorada do Sul - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5006002
    cmbCidadeEmitente.AddItem "Nova Andradina - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5006200
    cmbCidadeEmitente.AddItem "Novo Horizonte do Sul - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5006259
    cmbCidadeEmitente.AddItem "Paraiso das Aguas - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5006275
    cmbCidadeEmitente.AddItem "Paranaiba - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5006309
    cmbCidadeEmitente.AddItem "Paranhos - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5006358
    cmbCidadeEmitente.AddItem "Pedro Gomes - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5006408
    cmbCidadeEmitente.AddItem "Ponta Pora - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5006606
    cmbCidadeEmitente.AddItem "Porto Murtinho - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5006903
    cmbCidadeEmitente.AddItem "Ribas do Rio Pardo - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5007109
    cmbCidadeEmitente.AddItem "Rio Brilhante - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5007208
    cmbCidadeEmitente.AddItem "Rio Negro - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5007307
    cmbCidadeEmitente.AddItem "Rio Verde de Mato Grosso - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5007406
    cmbCidadeEmitente.AddItem "Rochedo - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5007505
    cmbCidadeEmitente.AddItem "Santa Rita do Pardo - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5007554
    cmbCidadeEmitente.AddItem "Sao Gabriel do Oeste - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5007695
    cmbCidadeEmitente.AddItem "Selviria - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5007802
    cmbCidadeEmitente.AddItem "Sete Quedas - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5007703
    cmbCidadeEmitente.AddItem "Sidrolandia - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5007901
    cmbCidadeEmitente.AddItem "Sonora - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5007935
    cmbCidadeEmitente.AddItem "Tacuru - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5007950
    cmbCidadeEmitente.AddItem "Taquarussu - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5007976
    cmbCidadeEmitente.AddItem "Terenos - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5008008
    cmbCidadeEmitente.AddItem "Tres Lagoas - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5008305
    cmbCidadeEmitente.AddItem "Vicentina - MS"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5008404
End Sub

Public Sub MatoGrosso(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Acorizal - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5100102
    cmbCidadeEmitente.AddItem "Agua Boa - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5100201
    cmbCidadeEmitente.AddItem "Alta Floresta - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5100250
    cmbCidadeEmitente.AddItem "Alto Araguaia - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5100300
    cmbCidadeEmitente.AddItem "Alto Boa Vista - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5100359
    cmbCidadeEmitente.AddItem "Alto Garcas - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5100409
    cmbCidadeEmitente.AddItem "Alto Paraguai - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5100508
    cmbCidadeEmitente.AddItem "Alto Taquari - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5100607
    cmbCidadeEmitente.AddItem "Apiacas - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5100805
    cmbCidadeEmitente.AddItem "Araguaiana - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5101001
    cmbCidadeEmitente.AddItem "Araguainha - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5101209
    cmbCidadeEmitente.AddItem "Araputanga - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5101258
    cmbCidadeEmitente.AddItem "Arenapolis - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5101308
    cmbCidadeEmitente.AddItem "Aripuana - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5101407
    cmbCidadeEmitente.AddItem "Barao de Melgaco - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5101605
    cmbCidadeEmitente.AddItem "Barra do Bugres - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5101704
    cmbCidadeEmitente.AddItem "Barra do Garcas - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5101803
    cmbCidadeEmitente.AddItem "Boa Esperanca do Norte - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5101837
    cmbCidadeEmitente.AddItem "Bom Jesus do Araguaia - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5101852
    cmbCidadeEmitente.AddItem "Brasnorte - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5101902
    cmbCidadeEmitente.AddItem "Caceres - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5102504
    cmbCidadeEmitente.AddItem "Campinapolis - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5102603
    cmbCidadeEmitente.AddItem "Campo Novo do Parecis - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5102637
    cmbCidadeEmitente.AddItem "Campo Verde - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5102678
    cmbCidadeEmitente.AddItem "Campos de Julio - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5102686
    cmbCidadeEmitente.AddItem "Canabrava do Norte - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5102694
    cmbCidadeEmitente.AddItem "Canarana - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5102702
    cmbCidadeEmitente.AddItem "Carlinda - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5102793
    cmbCidadeEmitente.AddItem "Castanheira - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5102850
    cmbCidadeEmitente.AddItem "Chapada dos Guimaraes - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5103007
    cmbCidadeEmitente.AddItem "Claudia - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5103056
    cmbCidadeEmitente.AddItem "Cocalinho - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5103106
    cmbCidadeEmitente.AddItem "Colider - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5103205
    cmbCidadeEmitente.AddItem "Colniza - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5103254
    cmbCidadeEmitente.AddItem "Comodoro - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5103304
    cmbCidadeEmitente.AddItem "Confresa - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5103353
    cmbCidadeEmitente.AddItem "Conquista do Oeste - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5103361
    cmbCidadeEmitente.AddItem "Cotriguacu - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5103379
    cmbCidadeEmitente.AddItem "Cuiaba - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5103403
    cmbCidadeEmitente.AddItem "Curvelandia - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5103437
    cmbCidadeEmitente.AddItem "Denise - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5103452
    cmbCidadeEmitente.AddItem "Diamantino - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5103502
    cmbCidadeEmitente.AddItem "Dom Aquino - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5103601
    cmbCidadeEmitente.AddItem "Feliz Natal - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5103700
    cmbCidadeEmitente.AddItem "Figueiropolis D Oeste - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5103809
    cmbCidadeEmitente.AddItem "Gaucha do Norte - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5103858
    cmbCidadeEmitente.AddItem "General Carneiro - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5103908
    cmbCidadeEmitente.AddItem "Gloria D Oeste - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5103957
    cmbCidadeEmitente.AddItem "Guaranta do Norte - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5104104
    cmbCidadeEmitente.AddItem "Guiratinga - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5104203
    cmbCidadeEmitente.AddItem "Indiavai - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5104500
    cmbCidadeEmitente.AddItem "Ipiranga do Norte - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5104526
    cmbCidadeEmitente.AddItem "Itanhanga - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5104542
    cmbCidadeEmitente.AddItem "Itauba - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5104559
    cmbCidadeEmitente.AddItem "Itiquira - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5104609
    cmbCidadeEmitente.AddItem "Jaciara - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5104807
    cmbCidadeEmitente.AddItem "Jangada - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5104906
    cmbCidadeEmitente.AddItem "Jauru - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5105002
    cmbCidadeEmitente.AddItem "Juara - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5105101
    cmbCidadeEmitente.AddItem "Juina - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5105150
    cmbCidadeEmitente.AddItem "Juruena - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5105176
    cmbCidadeEmitente.AddItem "Juscimeira - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5105200
    cmbCidadeEmitente.AddItem "Lambari D Oeste - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5105234
    cmbCidadeEmitente.AddItem "Lucas do Rio Verde - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5105259
    cmbCidadeEmitente.AddItem "Luciara - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5105309
    cmbCidadeEmitente.AddItem "Marcelandia - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5105580
    cmbCidadeEmitente.AddItem "Matupa - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5105606
    cmbCidadeEmitente.AddItem "Mirassol D Oeste - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5105622
    cmbCidadeEmitente.AddItem "Nobres - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5105903
    cmbCidadeEmitente.AddItem "Nortelandia - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106000
    cmbCidadeEmitente.AddItem "Nossa Senhora do Livramento - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106109
    cmbCidadeEmitente.AddItem "Nova Bandeirantes - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106158
    cmbCidadeEmitente.AddItem "Nova Brasilandia - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106208
    cmbCidadeEmitente.AddItem "Nova Canaa do Norte - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106216
    cmbCidadeEmitente.AddItem "Nova Guarita - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5108808
    cmbCidadeEmitente.AddItem "Nova Lacerda - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106182
    cmbCidadeEmitente.AddItem "Nova Marilandia - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5108857
    cmbCidadeEmitente.AddItem "Nova Maringa - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5108907
    cmbCidadeEmitente.AddItem "Nova Monte Verde - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5108956
    cmbCidadeEmitente.AddItem "Nova Mutum - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106224
    cmbCidadeEmitente.AddItem "Nova Nazare - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106174
    cmbCidadeEmitente.AddItem "Nova Olimpia - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106232
    cmbCidadeEmitente.AddItem "Nova Santa Helena - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106190
    cmbCidadeEmitente.AddItem "Nova Ubirata - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106240
    cmbCidadeEmitente.AddItem "Nova Xavantina - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106257
    cmbCidadeEmitente.AddItem "Novo Horizonte do Norte - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106273
    cmbCidadeEmitente.AddItem "Novo Mundo - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106265
    cmbCidadeEmitente.AddItem "Novo Santo Antonio - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106315
    cmbCidadeEmitente.AddItem "Novo Sao Joaquim - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106281
    cmbCidadeEmitente.AddItem "Paranaita - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106299
    cmbCidadeEmitente.AddItem "Paranatinga - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106307
    cmbCidadeEmitente.AddItem "Pedra Preta - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106372
    cmbCidadeEmitente.AddItem "Peixoto de Azevedo - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106422
    cmbCidadeEmitente.AddItem "Planalto da Serra - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106455
    cmbCidadeEmitente.AddItem "Pocone - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106505
    cmbCidadeEmitente.AddItem "Pontal do Araguaia - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106653
    cmbCidadeEmitente.AddItem "Ponte Branca - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106703
    cmbCidadeEmitente.AddItem "Pontes E Lacerda - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106752
    cmbCidadeEmitente.AddItem "Porto Alegre do Norte - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106778
    cmbCidadeEmitente.AddItem "Porto dos Gauchos - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106802
    cmbCidadeEmitente.AddItem "Porto Esperidiao - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106828
    cmbCidadeEmitente.AddItem "Porto Estrela - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5106851
    cmbCidadeEmitente.AddItem "Poxoreo - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107008
    cmbCidadeEmitente.AddItem "Primavera do Leste - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107040
    cmbCidadeEmitente.AddItem "Querencia - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107065
    cmbCidadeEmitente.AddItem "Reserva do Cabacal - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107156
    cmbCidadeEmitente.AddItem "Ribeirao Cascalheira - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107180
    cmbCidadeEmitente.AddItem "Ribeiraozinho - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107198
    cmbCidadeEmitente.AddItem "Rio Branco - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107206
    cmbCidadeEmitente.AddItem "Rondolandia - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107578
    cmbCidadeEmitente.AddItem "Rondonopolis - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107602
    cmbCidadeEmitente.AddItem "Rosario Oeste - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107701
    cmbCidadeEmitente.AddItem "Salto do Ceu - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107750
    cmbCidadeEmitente.AddItem "Santa Carmen - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107248
    cmbCidadeEmitente.AddItem "Santa Cruz do Xingu - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107743
    cmbCidadeEmitente.AddItem "Santa Rita do Trivelato - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107768
    cmbCidadeEmitente.AddItem "Santa Terezinha - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107776
    cmbCidadeEmitente.AddItem "Santo Afonso - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107263
    cmbCidadeEmitente.AddItem "Santo Antonio do Leste - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107792
    cmbCidadeEmitente.AddItem "Santo Antonio do Leverger - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107800
    cmbCidadeEmitente.AddItem "Sao Felix do Araguaia - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107859
    cmbCidadeEmitente.AddItem "Sao Jose do Povo - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107297
    cmbCidadeEmitente.AddItem "Sao Jose do Rio Claro - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107305
    cmbCidadeEmitente.AddItem "Sao Jose do Xingu - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107354
    cmbCidadeEmitente.AddItem "Sao Jose dos Quatro Marcos - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107107
    cmbCidadeEmitente.AddItem "Sao Pedro da Cipa - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107404
    cmbCidadeEmitente.AddItem "Sapezal - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107875
    cmbCidadeEmitente.AddItem "Serra Nova Dourada - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107883
    cmbCidadeEmitente.AddItem "Sinop - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107909
    cmbCidadeEmitente.AddItem "Sorriso - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107925
    cmbCidadeEmitente.AddItem "Tabapora - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107941
    cmbCidadeEmitente.AddItem "Tangara da Serra - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5107958
    cmbCidadeEmitente.AddItem "Tapurah - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5108006
    cmbCidadeEmitente.AddItem "Terra Nova do Norte - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5108055
    cmbCidadeEmitente.AddItem "Tesouro - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5108105
    cmbCidadeEmitente.AddItem "Torixoreu - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5108204
    cmbCidadeEmitente.AddItem "Uniao do Sul - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5108303
    cmbCidadeEmitente.AddItem "Vale de Sao Domingos - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5108352
    cmbCidadeEmitente.AddItem "Varzea Grande - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5108402
    cmbCidadeEmitente.AddItem "Vera - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5108501
    cmbCidadeEmitente.AddItem "Vila Bela da Santissima Trindade - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5105507
    cmbCidadeEmitente.AddItem "Vila Rica - MT"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5108600
End Sub

Public Sub Goias(ByRef cmbCidadeEmitente As ComboBox)
    Goias1 cmbCidadeEmitente
    Goias2 cmbCidadeEmitente
End Sub

Private Sub Goias1(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Abadia de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5200050
    cmbCidadeEmitente.AddItem "Abadiania - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5200100
    cmbCidadeEmitente.AddItem "Acreuna - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5200134
    cmbCidadeEmitente.AddItem "Adelandia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5200159
    cmbCidadeEmitente.AddItem "Agua Fria de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5200175
    cmbCidadeEmitente.AddItem "Agua Limpa - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5200209
    cmbCidadeEmitente.AddItem "Aguas Lindas de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5200258
    cmbCidadeEmitente.AddItem "Alexania - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5200308
    cmbCidadeEmitente.AddItem "Aloandia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5200506
    cmbCidadeEmitente.AddItem "Alto Horizonte - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5200555
    cmbCidadeEmitente.AddItem "Alto Paraiso de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5200605
    cmbCidadeEmitente.AddItem "Alvorada do Norte - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5200803
    cmbCidadeEmitente.AddItem "Amaralina - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5200829
    cmbCidadeEmitente.AddItem "Americano do Brasil - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5200852
    cmbCidadeEmitente.AddItem "Amorinopolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5200902
    cmbCidadeEmitente.AddItem "Anapolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5201108
    cmbCidadeEmitente.AddItem "Anhanguera - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5201207
    cmbCidadeEmitente.AddItem "Anicuns - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5201306
    cmbCidadeEmitente.AddItem "Aparecida de Goiania - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5201405
    cmbCidadeEmitente.AddItem "Aparecida do Rio Doce - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5201454
    cmbCidadeEmitente.AddItem "Apore - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5201504
    cmbCidadeEmitente.AddItem "Aracu - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5201603
    cmbCidadeEmitente.AddItem "Aragarcas - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5201702
    cmbCidadeEmitente.AddItem "Aragoiania - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5201801
    cmbCidadeEmitente.AddItem "Araguapaz - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5202155
    cmbCidadeEmitente.AddItem "Arenopolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5202353
    cmbCidadeEmitente.AddItem "Aruana - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5202502
    cmbCidadeEmitente.AddItem "Aurilandia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5202601
    cmbCidadeEmitente.AddItem "Avelinopolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5202809
    cmbCidadeEmitente.AddItem "Baliza - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5203104
    cmbCidadeEmitente.AddItem "Barro Alto - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5203203
    cmbCidadeEmitente.AddItem "Bela Vista de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5203302
    cmbCidadeEmitente.AddItem "Bom Jardim de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5203401
    cmbCidadeEmitente.AddItem "Bom Jesus de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5203500
    cmbCidadeEmitente.AddItem "Bonfinopolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5203559
    cmbCidadeEmitente.AddItem "Bonopolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5203575
    cmbCidadeEmitente.AddItem "Brazabrantes - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5203609
    cmbCidadeEmitente.AddItem "Britania - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5203807
    cmbCidadeEmitente.AddItem "Buriti Alegre - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5203906
    cmbCidadeEmitente.AddItem "Buriti de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5203939
    cmbCidadeEmitente.AddItem "Buritinopolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5203962
    cmbCidadeEmitente.AddItem "Cabeceiras - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5204003
    cmbCidadeEmitente.AddItem "Cachoeira Alta - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5204102
    cmbCidadeEmitente.AddItem "Cachoeira de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5204201
    cmbCidadeEmitente.AddItem "Cachoeira Dourada - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5204250
    cmbCidadeEmitente.AddItem "Cacu - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5204300
    cmbCidadeEmitente.AddItem "Caiaponia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5204409
    cmbCidadeEmitente.AddItem "Caldas Novas - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5204508
    cmbCidadeEmitente.AddItem "Caldazinha - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5204557
    cmbCidadeEmitente.AddItem "Campestre de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5204607
    cmbCidadeEmitente.AddItem "Campinacu - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5204656
    cmbCidadeEmitente.AddItem "Campinorte - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5204706
    cmbCidadeEmitente.AddItem "Campo Alegre de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5204805
    cmbCidadeEmitente.AddItem "Campo Limpo de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5204854
    cmbCidadeEmitente.AddItem "Campos Belos - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5204904
    cmbCidadeEmitente.AddItem "Campos Verdes - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5204953
    cmbCidadeEmitente.AddItem "Carmo do Rio Verde - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5205000
    cmbCidadeEmitente.AddItem "Castelandia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5205059
    cmbCidadeEmitente.AddItem "Catalao - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5205109
    cmbCidadeEmitente.AddItem "Caturai - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5205208
    cmbCidadeEmitente.AddItem "Cavalcante - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5205307
    cmbCidadeEmitente.AddItem "Ceres - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5205406
    cmbCidadeEmitente.AddItem "Cezarina - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5205455
    cmbCidadeEmitente.AddItem "Chapadao do Ceu - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5205471
    cmbCidadeEmitente.AddItem "Cidade Ocidental - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5205497
    cmbCidadeEmitente.AddItem "Cocalzinho de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5205513
    cmbCidadeEmitente.AddItem "Colinas do Sul - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5205521
    cmbCidadeEmitente.AddItem "Corrego do Ouro - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5205703
    cmbCidadeEmitente.AddItem "Corumba de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5205802
    cmbCidadeEmitente.AddItem "Corumbaiba - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5205901
    cmbCidadeEmitente.AddItem "Cristalina - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5206206
    cmbCidadeEmitente.AddItem "Cristianopolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5206305
    cmbCidadeEmitente.AddItem "Crixas - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5206404
    cmbCidadeEmitente.AddItem "Crominia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5206503
    cmbCidadeEmitente.AddItem "Cumari - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5206602
    cmbCidadeEmitente.AddItem "Damianopolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5206701
    cmbCidadeEmitente.AddItem "Damolandia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5206800
    cmbCidadeEmitente.AddItem "Davinopolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5206909
    cmbCidadeEmitente.AddItem "Diorama - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5207105
    cmbCidadeEmitente.AddItem "Divinopolis de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5208301
    cmbCidadeEmitente.AddItem "Doverlandia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5207253
    cmbCidadeEmitente.AddItem "Edealina - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5207352
    cmbCidadeEmitente.AddItem "Edeia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5207402
    cmbCidadeEmitente.AddItem "Estrela do Norte - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5207501
    cmbCidadeEmitente.AddItem "Faina - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5207535
    cmbCidadeEmitente.AddItem "Fazenda Nova - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5207600
    cmbCidadeEmitente.AddItem "Firminopolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5207808
    cmbCidadeEmitente.AddItem "Flores de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5207907
    cmbCidadeEmitente.AddItem "Formosa - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5208004
    cmbCidadeEmitente.AddItem "Formoso - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5208103
    cmbCidadeEmitente.AddItem "Gameleira de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5208152
    cmbCidadeEmitente.AddItem "Goianapolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5208400
    cmbCidadeEmitente.AddItem "Goiandira - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5208509
    cmbCidadeEmitente.AddItem "Goianesia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5208608
    cmbCidadeEmitente.AddItem "Goiania - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5208707
    cmbCidadeEmitente.AddItem "Goianira - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5208806
    cmbCidadeEmitente.AddItem "Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5208905
    cmbCidadeEmitente.AddItem "Goiatuba - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5209101
    cmbCidadeEmitente.AddItem "Gouvelandia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5209150
    cmbCidadeEmitente.AddItem "Guapo - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5209200
    cmbCidadeEmitente.AddItem "Guaraita - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5209291
    cmbCidadeEmitente.AddItem "Guarani de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5209408
    cmbCidadeEmitente.AddItem "Guarinos - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5209457
    cmbCidadeEmitente.AddItem "Heitorai - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5209606
    cmbCidadeEmitente.AddItem "Hidrolandia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5209705
    cmbCidadeEmitente.AddItem "Hidrolina - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5209804
    cmbCidadeEmitente.AddItem "Iaciara - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5209903
    cmbCidadeEmitente.AddItem "Inaciolandia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5209937
    cmbCidadeEmitente.AddItem "Indiara - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5209952
    cmbCidadeEmitente.AddItem "Inhumas - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5210000
    cmbCidadeEmitente.AddItem "Ipameri - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5210109
    cmbCidadeEmitente.AddItem "Ipiranga de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5210158
    cmbCidadeEmitente.AddItem "Ipora - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5210208
    cmbCidadeEmitente.AddItem "Israelandia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5210307
    cmbCidadeEmitente.AddItem "Itaberai - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5210406
    cmbCidadeEmitente.AddItem "Itaguari - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5210562
    cmbCidadeEmitente.AddItem "Itaguaru - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5210604
    cmbCidadeEmitente.AddItem "Itaja - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5210802
    cmbCidadeEmitente.AddItem "Itapaci - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5210901
    cmbCidadeEmitente.AddItem "Itapirapua - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5211008
    cmbCidadeEmitente.AddItem "Itapuranga - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5211206
    cmbCidadeEmitente.AddItem "Itaruma - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5211305
    cmbCidadeEmitente.AddItem "Itaucu - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5211404
    cmbCidadeEmitente.AddItem "Itumbiara - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5211503
    cmbCidadeEmitente.AddItem "Ivolandia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5211602
    cmbCidadeEmitente.AddItem "Jandaia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5211701
    cmbCidadeEmitente.AddItem "Jaragua - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5211800
    cmbCidadeEmitente.AddItem "Jatai - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5211909
    cmbCidadeEmitente.AddItem "Jaupaci - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5212006
    cmbCidadeEmitente.AddItem "Jesupolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5212055
    cmbCidadeEmitente.AddItem "Joviania - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5212105
    cmbCidadeEmitente.AddItem "Jussara - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5212204
    cmbCidadeEmitente.AddItem "Lagoa Santa - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5212253
    cmbCidadeEmitente.AddItem "Leopoldo de Bulhoes - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5212303
    cmbCidadeEmitente.AddItem "Luziania - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5212501
    cmbCidadeEmitente.AddItem "Mairipotaba - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5212600
    cmbCidadeEmitente.AddItem "Mambai - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5212709
    cmbCidadeEmitente.AddItem "Mara Rosa - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5212808
    cmbCidadeEmitente.AddItem "Marzagao - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5212907
    cmbCidadeEmitente.AddItem "Matrincha - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5212956
    cmbCidadeEmitente.AddItem "Maurilandia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5213004
    cmbCidadeEmitente.AddItem "Mimoso de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5213053
    cmbCidadeEmitente.AddItem "Minacu - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5213087
    cmbCidadeEmitente.AddItem "Mineiros - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5213103
    cmbCidadeEmitente.AddItem "Moipora - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5213400
    cmbCidadeEmitente.AddItem "Monte Alegre de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5213509
    cmbCidadeEmitente.AddItem "Montes Claros de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5213707
    cmbCidadeEmitente.AddItem "Montividiu - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5213756
    cmbCidadeEmitente.AddItem "Montividiu do Norte - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5213772
    cmbCidadeEmitente.AddItem "Morrinhos - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5213806
End Sub

Private Sub Goias2(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Morro Agudo de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5213855
    cmbCidadeEmitente.AddItem "Mossamedes - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5213905
    cmbCidadeEmitente.AddItem "Mozarlandia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5214002
    cmbCidadeEmitente.AddItem "Mundo Novo - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5214051
    cmbCidadeEmitente.AddItem "Mutunopolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5214101
    cmbCidadeEmitente.AddItem "Nazario - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5214408
    cmbCidadeEmitente.AddItem "Neropolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5214507
    cmbCidadeEmitente.AddItem "Niquelandia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5214606
    cmbCidadeEmitente.AddItem "Nova America - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5214705
    cmbCidadeEmitente.AddItem "Nova Aurora - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5214804
    cmbCidadeEmitente.AddItem "Nova Crixas - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5214838
    cmbCidadeEmitente.AddItem "Nova Gloria - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5214861
    cmbCidadeEmitente.AddItem "Nova Iguacu de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5214879
    cmbCidadeEmitente.AddItem "Nova Roma - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5214903
    cmbCidadeEmitente.AddItem "Nova Veneza - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5215009
    cmbCidadeEmitente.AddItem "Novo Brasil - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5215207
    cmbCidadeEmitente.AddItem "Novo Gama - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5215231
    cmbCidadeEmitente.AddItem "Novo Planalto - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5215256
    cmbCidadeEmitente.AddItem "Orizona - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5215306
    cmbCidadeEmitente.AddItem "Ouro Verde de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5215405
    cmbCidadeEmitente.AddItem "Ouvidor - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5215504
    cmbCidadeEmitente.AddItem "Padre Bernardo - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5215603
    cmbCidadeEmitente.AddItem "Palestina de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5215652
    cmbCidadeEmitente.AddItem "Palmeiras de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5215702
    cmbCidadeEmitente.AddItem "Palmelo - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5215801
    cmbCidadeEmitente.AddItem "Palminopolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5215900
    cmbCidadeEmitente.AddItem "Panama - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5216007
    cmbCidadeEmitente.AddItem "Paranaiguara - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5216304
    cmbCidadeEmitente.AddItem "Parauna - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5216403
    cmbCidadeEmitente.AddItem "Perolandia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5216452
    cmbCidadeEmitente.AddItem "Petrolina de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5216809
    cmbCidadeEmitente.AddItem "Pilar de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5216908
    cmbCidadeEmitente.AddItem "Piracanjuba - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5217104
    cmbCidadeEmitente.AddItem "Piranhas - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5217203
    cmbCidadeEmitente.AddItem "Pirenopolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5217302
    cmbCidadeEmitente.AddItem "Pires do Rio - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5217401
    cmbCidadeEmitente.AddItem "Planaltina - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5217609
    cmbCidadeEmitente.AddItem "Pontalina - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5217708
    cmbCidadeEmitente.AddItem "Porangatu - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5218003
    cmbCidadeEmitente.AddItem "Porteirao - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5218052
    cmbCidadeEmitente.AddItem "Portelandia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5218102
    cmbCidadeEmitente.AddItem "Posse - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5218300
    cmbCidadeEmitente.AddItem "Professor Jamil - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5218391
    cmbCidadeEmitente.AddItem "Quirinopolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5218508
    cmbCidadeEmitente.AddItem "Rialma - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5218607
    cmbCidadeEmitente.AddItem "Rianapolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5218706
    cmbCidadeEmitente.AddItem "Rio Quente - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5218789
    cmbCidadeEmitente.AddItem "Rio Verde - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5218805
    cmbCidadeEmitente.AddItem "Rubiataba - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5218904
    cmbCidadeEmitente.AddItem "Sanclerlandia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5219001
    cmbCidadeEmitente.AddItem "Santa Barbara de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5219100
    cmbCidadeEmitente.AddItem "Santa Cruz de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5219209
    cmbCidadeEmitente.AddItem "Santa Fe de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5219258
    cmbCidadeEmitente.AddItem "Santa Helena de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5219308
    cmbCidadeEmitente.AddItem "Santa Isabel - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5219357
    cmbCidadeEmitente.AddItem "Santa Rita do Araguaia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5219407
    cmbCidadeEmitente.AddItem "Santa Rita do Novo Destino - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5219456
    cmbCidadeEmitente.AddItem "Santa Rosa de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5219506
    cmbCidadeEmitente.AddItem "Santa Tereza de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5219605
    cmbCidadeEmitente.AddItem "Santa Terezinha de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5219704
    cmbCidadeEmitente.AddItem "Santo Antonio da Barra - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5219712
    cmbCidadeEmitente.AddItem "Santo Antonio de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5219738
    cmbCidadeEmitente.AddItem "Santo Antonio do Descoberto - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5219753
    cmbCidadeEmitente.AddItem "Sao Domingos - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5219803
    cmbCidadeEmitente.AddItem "Sao Francisco de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5219902
    cmbCidadeEmitente.AddItem "Sao Joao D Alianca - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5220009
    cmbCidadeEmitente.AddItem "Sao Joao da Parauna - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5220058
    cmbCidadeEmitente.AddItem "Sao Luis de Montes Belos - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5220108
    cmbCidadeEmitente.AddItem "Sao Luiz do Norte - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5220157
    cmbCidadeEmitente.AddItem "Sao Miguel do Araguaia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5220207
    cmbCidadeEmitente.AddItem "Sao Miguel do Passa Quatro - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5220264
    cmbCidadeEmitente.AddItem "Sao Patricio - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5220280
    cmbCidadeEmitente.AddItem "Sao Simao - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5220405
    cmbCidadeEmitente.AddItem "Senador Canedo - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5220454
    cmbCidadeEmitente.AddItem "Serranopolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5220504
    cmbCidadeEmitente.AddItem "Silvania - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5220603
    cmbCidadeEmitente.AddItem "Simolandia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5220686
    cmbCidadeEmitente.AddItem "Sitio D Abadia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5220702
    cmbCidadeEmitente.AddItem "Taquaral de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5221007
    cmbCidadeEmitente.AddItem "Teresina de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5221080
    cmbCidadeEmitente.AddItem "Terezopolis de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5221197
    cmbCidadeEmitente.AddItem "Tres Ranchos - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5221304
    cmbCidadeEmitente.AddItem "Trindade - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5221403
    cmbCidadeEmitente.AddItem "Trombas - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5221452
    cmbCidadeEmitente.AddItem "Turvania - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5221502
    cmbCidadeEmitente.AddItem "Turvelandia - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5221551
    cmbCidadeEmitente.AddItem "Uirapuru - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5221577
    cmbCidadeEmitente.AddItem "Uruacu - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5221601
    cmbCidadeEmitente.AddItem "Uruana - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5221700
    cmbCidadeEmitente.AddItem "Urutai - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5221809
    cmbCidadeEmitente.AddItem "Valparaiso de Goias - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5221858
    cmbCidadeEmitente.AddItem "Varjao - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5221908
    cmbCidadeEmitente.AddItem "Vianopolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5222005
    cmbCidadeEmitente.AddItem "Vicentinopolis - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5222054
    cmbCidadeEmitente.AddItem "Vila Boa - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5222203
    cmbCidadeEmitente.AddItem "Vila Propicio - GO"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5222302
End Sub

Public Sub Brasilia(ByRef cmbCidadeEmitente As ComboBox)
    cmbCidadeEmitente.AddItem "Brasilia - DF"
    cmbCidadeEmitente.ItemData(cmbCidadeEmitente.NewIndex) = 5300108
End Sub

Private Sub cmbCidadeEmitente_Click()
    Dim cidadeSelecionada As String
    Dim CodigoMunicipio As String
    
    cidadeSelecionada = cmbCidadeEmitente.Text
    CodigoMunicipio = cmbCidadeEmitente.ItemData(cmbCidadeEmitente.ListIndex)
End Sub
