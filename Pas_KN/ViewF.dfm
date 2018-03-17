object ViewForm: TViewForm
  Left = 168
  Top = 67
  Width = 504
  Height = 446
  Caption = 'Ansichtsfenster'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = GetKeyDown
  OnResize = GetRenewed
  PixelsPerInch = 96
  TextHeight = 13
  object ViewImage: TImage
    Left = 0
    Top = 0
    Width = 496
    Height = 267
    Align = alClient
  end
  object OptionsPanel: TPanel
    Left = 0
    Top = 267
    Width = 496
    Height = 133
    Align = alBottom
    TabOrder = 0
    object XZoomLabel: TLabel
      Left = 200
      Top = 56
      Width = 48
      Height = 13
      Caption = 'X: Zoom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object YZoomLabel: TLabel
      Left = 360
      Top = 56
      Width = 48
      Height = 13
      Caption = 'Y: Zoom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object XMoveLabel: TLabel
      Left = 200
      Top = 8
      Width = 48
      Height = 13
      Caption = 'X: Move'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object YMoveLabel: TLabel
      Left = 360
      Top = 8
      Width = 48
      Height = 13
      Caption = 'Y: Move'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object InfoLabel: TLabel
      Left = 64
      Top = 112
      Width = 414
      Height = 13
      Caption = 
        'Die Taste "F5" dr'#252'cken, um diese Optionen aus- beziehunsgweise w' +
        'ieder einzublenden'
    end
    object DrawLinesCheckBox: TCheckBox
      Left = 16
      Top = 32
      Width = 145
      Height = 17
      Caption = 'Einteilung anzeigen'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = GetRenewed
      OnKeyDown = GetKeyDown
    end
    object XIncZoomButton: TButton
      Left = 304
      Top = 72
      Width = 17
      Height = 17
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 13
      OnClick = XIncZoomButtonClick
      OnKeyDown = GetKeyDown
    end
    object XDecZoomButton: TButton
      Left = 176
      Top = 72
      Width = 17
      Height = 17
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
      OnClick = XDecZoomButtonClick
      OnKeyDown = GetKeyDown
    end
    object YIncZoomButton: TButton
      Left = 464
      Top = 72
      Width = 17
      Height = 17
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 16
      OnClick = YIncZoomButtonClick
      OnKeyDown = GetKeyDown
    end
    object YDecZoomButton: TButton
      Left = 336
      Top = 72
      Width = 17
      Height = 17
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 15
      OnClick = YDecZoomButtonClick
      OnKeyDown = GetKeyDown
    end
    object XDecMoveButton: TButton
      Left = 176
      Top = 24
      Width = 17
      Height = 17
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = XDecMoveButtonClick
      OnKeyDown = GetKeyDown
    end
    object XIncMoveButton: TButton
      Left = 304
      Top = 24
      Width = 17
      Height = 17
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      OnClick = XIncMoveButtonClick
      OnKeyDown = GetKeyDown
    end
    object YIncMoveButton: TButton
      Left = 464
      Top = 24
      Width = 17
      Height = 17
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      OnClick = YIncMoveButtonClick
      OnKeyDown = GetKeyDown
    end
    object YDecMoveButton: TButton
      Left = 336
      Top = 24
      Width = 17
      Height = 17
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      OnClick = YDecMoveButtonClick
      OnKeyDown = GetKeyDown
    end
    object DrawAxesCheckBox: TCheckBox
      Left = 16
      Top = 16
      Width = 145
      Height = 17
      Caption = 'Achsen anzeigen'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = DrawAxesCheckBoxClick
      OnKeyDown = GetKeyDown
    end
    object XMoveEdit: TEdit
      Left = 200
      Top = 24
      Width = 97
      Height = 21
      TabOrder = 5
      Text = '0'
      OnChange = XMoveEditChange
      OnKeyDown = GetKeyDown
    end
    object YMoveEdit: TEdit
      Left = 360
      Top = 24
      Width = 97
      Height = 21
      TabOrder = 8
      Text = '0'
      OnChange = YMoveEditChange
      OnKeyDown = GetKeyDown
    end
    object DrawMoveCheckBox: TCheckBox
      Left = 16
      Top = 64
      Width = 145
      Height = 17
      Caption = 'Move-Werte anzeigen'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = GetRenewed
      OnKeyDown = GetKeyDown
    end
    object DrawZoomCheckBox: TCheckBox
      Left = 16
      Top = 80
      Width = 145
      Height = 17
      Caption = 'Zoom-Werte anzeigen'
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = GetRenewed
      OnKeyDown = GetKeyDown
    end
    object DrawFunctionCheckBox: TCheckBox
      Left = 16
      Top = 48
      Width = 145
      Height = 17
      Caption = 'Funktionswerte anzeigen'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = GetRenewed
      OnKeyDown = GetKeyDown
    end
    object XZoomEdit: TEdit
      Left = 200
      Top = 72
      Width = 97
      Height = 21
      TabOrder = 11
      Text = '0'
      OnChange = XZoomEditChange
      OnKeyDown = GetKeyDown
    end
    object YZoomEdit: TEdit
      Left = 360
      Top = 72
      Width = 97
      Height = 21
      TabOrder = 14
      Text = '0'
      OnChange = YZoomEditChange
      OnKeyDown = GetKeyDown
    end
  end
  object MainMenu: TMainMenu
    Left = 8
    Top = 8
    object DateiMenuItem: TMenuItem
      Caption = '&Datei'
      object SpeichernMenuItem: TMenuItem
        Caption = '&Speichern'
        ShortCut = 16467
        OnClick = SpeichernMenuItemClick
      end
    end
  end
  object SavePictureDialog: TSavePictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 40
    Top = 8
  end
end
