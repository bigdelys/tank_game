object mf: Tmf
  Left = -4
  Top = -4
  Caption = 'Tank Game: Battle'
  ClientHeight = 584
  ClientWidth = 984
  Color = clBlack
  Font.Charset = ANSI_CHARSET
  Font.Color = clWhite
  Font.Height = -12
  Font.Name = 'Comic Sans MS'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object im: TImage
    Left = 8
    Top = 95
    Width = 977
    Height = 485
  end
  object start: TSpeedButton
    Left = 246
    Top = 44
    Width = 90
    Height = 45
    Caption = 'start'
    Visible = False
    OnClick = startClick
  end
  object SpeedButton1: TSpeedButton
    Left = 334
    Top = 44
    Width = 62
    Height = 45
    Caption = 'Break Soil'
    Visible = False
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 482
    Top = 44
    Width = 54
    Height = 45
    Visible = False
    OnClick = SpeedButton2Click
  end
  object lab_n: TLabel
    Left = 265
    Top = 11
    Width = 80
    Height = 17
    Caption = '                    '
  end
  object SpeedButton3: TSpeedButton
    Left = 132
    Top = 9
    Width = 25
    Height = 24
    Visible = False
    OnClick = SpeedButton3Click
  end
  object lab_money: TLabel
    Left = 62
    Top = 64
    Width = 64
    Height = 18
    Caption = '                '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object lab_wins: TLabel
    Left = 408
    Top = 64
    Width = 64
    Height = 18
    Caption = '                '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object lab_v: TStaticText
    Left = 62
    Top = 7
    Width = 52
    Height = 22
    Caption = '            '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object lab_c: TStaticText
    Left = 62
    Top = 36
    Width = 48
    Height = 21
    Caption = '           '
    TabOrder = 1
  end
  object StaticText1: TStaticText
    Left = 4
    Top = 5
    Width = 49
    Height = 22
    Caption = 'Power :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object StaticText2: TStaticText
    Left = 4
    Top = 34
    Width = 46
    Height = 22
    Caption = 'Angle :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object StaticText3: TStaticText
    Left = 4
    Top = 63
    Width = 51
    Height = 22
    Caption = 'Money :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
end
