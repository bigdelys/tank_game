object mf2: Tmf2
  Left = -4
  Top = -4
  Caption = 'Tank Game: Menu'
  ClientHeight = 476
  ClientWidth = 627
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWhite
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 110
  TextHeight = 13
  object Start_game: TSpeedButton
    Left = 228
    Top = 133
    Width = 177
    Height = 68
    Caption = 'Start a Game'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    OnClick = Start_gameClick
  end
  object lab_names: TLabel
    Left = 16
    Top = 104
    Width = 146
    Height = 17
    Caption = 'Please Enter your Names :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 235
    Top = 216
    Width = 192
    Height = 17
    Caption = 'Please Enter  Number of  Players :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object Exit: TSpeedButton
    Left = 228
    Top = 344
    Width = 177
    Height = 73
    Caption = 'Exit'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    OnClick = ExitClick
  end
  object Edit_n1: TEdit
    Left = 56
    Top = 128
    Width = 90
    Height = 25
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = 'Player 1'
    OnChange = Edit_n1Change
  end
  object edit_n2: TEdit
    Left = 56
    Top = 192
    Width = 90
    Height = 25
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = 'Player 2'
    OnChange = edit_n2Change
  end
  object edit_n3: TEdit
    Left = 56
    Top = 256
    Width = 90
    Height = 25
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Text = 'Player 3'
    Visible = False
    OnChange = edit_n3Change
  end
  object edit_n4: TEdit
    Left = 56
    Top = 320
    Width = 90
    Height = 25
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = 'Player 4'
    Visible = False
    OnChange = edit_n4Change
  end
  object edit_n5: TEdit
    Left = 56
    Top = 384
    Width = 90
    Height = 25
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Text = 'Player 5'
    Visible = False
    OnChange = edit_n5Change
  end
  object edit_n6: TEdit
    Left = 480
    Top = 128
    Width = 90
    Height = 25
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    Text = 'Player 6'
    Visible = False
    OnChange = edit_n6Change
  end
  object edit_n7: TEdit
    Left = 480
    Top = 192
    Width = 90
    Height = 25
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    Text = 'Player 7'
    Visible = False
    OnChange = edit_n7Change
  end
  object edit_n8: TEdit
    Left = 480
    Top = 256
    Width = 90
    Height = 25
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    Text = 'Player 8'
    Visible = False
    OnChange = edit_n8Change
  end
  object edit_n9: TEdit
    Left = 480
    Top = 320
    Width = 90
    Height = 25
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    Text = 'Player 9'
    Visible = False
    OnChange = edit_n9Change
  end
  object edit_n10: TEdit
    Left = 480
    Top = 384
    Width = 90
    Height = 25
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 9
    Text = 'Player 10'
    Visible = False
    OnChange = edit_n10Change
  end
  object Spin_E_N: TSpinEdit
    Left = 288
    Top = 248
    Width = 53
    Height = 27
    EditorEnabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    MaxValue = 10
    MinValue = 2
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 10
    Value = 2
    OnChange = Spin_E_NChange
  end
  object StaticText1: TStaticText
    Left = 132
    Top = 16
    Width = 376
    Height = 75
    Caption = 'Tank  Game'
    Font.Charset = ANSI_CHARSET
    Font.Color = clLime
    Font.Height = -55
    Font.Name = 'Lucida Handwriting'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object StaticText2: TStaticText
    Left = 176
    Top = 88
    Width = 275
    Height = 20
    Caption = 'By Kamran and Nima Bigdely Shomloo'
    Font.Charset = ANSI_CHARSET
    Font.Color = clYellow
    Font.Height = -12
    Font.Name = 'Lucida Handwriting'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
  end
  object StaticText3: TStaticText
    Left = 235
    Top = 280
    Width = 182
    Height = 21
    Caption = 'Please Enter Number of Games :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
  end
  object Spin_e_Level: TSpinEdit
    Left = 288
    Top = 304
    Width = 53
    Height = 27
    EditorEnabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    Increment = 5
    MaxValue = 1000
    MinValue = 5
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 14
    Value = 25
    OnChange = Spin_E_NChange
  end
  object spin_ver: TStaticText
    Left = 291
    Top = 112
    Width = 57
    Height = 17
    Caption = 'Versoin 1.0'
    TabOrder = 15
  end
end
