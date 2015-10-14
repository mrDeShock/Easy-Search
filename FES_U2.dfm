object Form2: TForm2
  Left = 438
  Top = 255
  Width = 1000
  Height = 500
  Caption = 'Search File Extension'
  Color = clGradientActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 424
    Top = 344
    Width = 153
    Height = 41
    Caption = 'Open File'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 300
    Top = 0
    Width = 361
    Height = 217
    Lines.Strings = (
      '')
    TabOrder = 1
  end
  object Button2: TButton
    Left = 424
    Top = 400
    Width = 153
    Height = 41
    Caption = 'Extension Library'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object OpenDialog1: TOpenDialog
  end
end
