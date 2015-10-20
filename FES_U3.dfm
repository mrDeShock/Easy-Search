object Form3: TForm3
  Left = 192
  Top = 122
  Width = 654
  Height = 302
  Caption = 'Easy Search'
  Color = clGradientActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 168
    Top = 112
    Width = 40
    Height = 19
    Caption = #1060#1072#1081#1083':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 224
    Top = 174
    Width = 9
    Height = 15
    Caption = '...'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsItalic]
    ParentFont = False
    Visible = False
  end
  object Label3: TLabel
    Left = 224
    Top = 204
    Width = 9
    Height = 15
    Caption = '...'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsItalic]
    ParentFont = False
    Visible = False
  end
  object Label4: TLabel
    Left = 144
    Top = 168
    Width = 68
    Height = 19
    Caption = #1055#1088#1086#1075#1088#1072#1084#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label5: TLabel
    Left = 168
    Top = 200
    Width = 40
    Height = 19
    Caption = #1054#1087#1080#1089':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label6: TLabel
    Left = 216
    Top = 232
    Width = 9
    Height = 15
    Caption = '...'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsItalic]
    ParentFont = False
    Visible = False
  end
  object EFileName: TEdit
    Left = 216
    Top = 112
    Width = 297
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 528
    Top = 112
    Width = 75
    Height = 25
    Caption = #1042#1080#1073#1088#1072#1090#1080
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=extension.mdb;Persi' +
      'st Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
  end
  object MainMenu1: TMainMenu
    Left = 32
    object Selectfile1: TMenuItem
      Caption = '&'#1060#1072#1081#1083
      object Open1: TMenuItem
        Caption = #1042#1110#1076#1082#1088#1080#1090#1080
        OnClick = Button1Click
      end
      object Close1: TMenuItem
        Caption = #1042#1080#1081#1090#1080
      end
    end
    object Help1: TMenuItem
      Caption = #1044#1086#1087#1086#1084#1086#1075#1072
      object About1: TMenuItem
        Caption = #1055#1088#1086' '#1087#1088#1086#1075#1088#1072#1084#1091
      end
    end
  end
end
