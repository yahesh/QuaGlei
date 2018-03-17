object HinweisForm: THinweisForm
  Left = 184
  Top = 165
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Hinweise zu | Shorei | - Quadratische Gleichungen - Berechner'
  ClientHeight = 217
  ClientWidth = 526
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Hinweis1Label: TLabel
    Left = 0
    Top = 0
    Width = 526
    Height = 33
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'Hinweise zu | Shorei | - Quadratische Gleichungen - Berechner'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object SchliessenSpeedButton: TSpeedButton
    Left = 440
    Top = 184
    Width = 79
    Height = 25
    Caption = '&Schließen'
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = ButtonBeenden
  end
  object HinweisMemo: TMemo
    Left = 0
    Top = 33
    Width = 526
    Height = 137
    Align = alTop
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Lines.Strings = (
      
        '  I.) Dieses Programm ist ein Programm zur Berechnung quadratisc' +
        'her'
      
        '      Gleichungen und ist sogar im Stande, im komplexen Zahlenbe' +
        'reich'
      '      zu rechnen.'
      '      '
      
        ' II.) '#39' Sqr( ... ) '#39' ist in diesem Programm die Schreibweise für' +
        ':'
      '      '#39' Quadratwurzel aus ... '#39'.'
      '      '
      
        'III.) '#39' i '#39' ist in diesem Programm die imaginäre Konstante für d' +
        'as Ergebnis'
      '      von '#39' Sqr( -1 ) '#39'.'
      '       '
      
        'IV.) Für Lob, Kritik und Anregungen zu diesem Programm wäre ich ' +
        'sehr'
      '      dankbar unter :      '
      '                                   '
      
        '                                                                ' +
        '         ShiKai@gmx.de')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    OnKeyPress = MemoBeenden
  end
end
