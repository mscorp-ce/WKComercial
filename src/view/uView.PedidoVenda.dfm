object frmPedidoVenda: TfrmPedidoVenda
  Left = 0
  Top = 0
  Caption = 'WK - Pedido de vendas'
  ClientHeight = 455
  ClientWidth = 993
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object stbRodape: TStatusBar
    Left = 607
    Top = 425
    Width = 285
    Height = 28
    Align = alNone
    Panels = <
      item
        Text = 'Total do pedido:'
        Width = 100
      end>
    OnDrawPanel = stbRodapeDrawPanel
  end
  object grbPedido: TGroupBox
    Left = 0
    Top = 0
    Width = 993
    Height = 80
    Align = alTop
    Caption = '[ Pedido ] '
    TabOrder = 0
    object lblCliente: TLabel
      Left = 230
      Top = 26
      Width = 39
      Height = 13
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblStartDate: TLabel
      Left = 111
      Top = 26
      Width = 62
      Height = 13
      Caption = 'Start Date '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 5
      Top = 26
      Width = 85
      Height = 13
      Caption = 'N'#250'mero Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnCarregarPedido: TButton
      Left = 732
      Top = 43
      Width = 120
      Height = 25
      Caption = 'Carregar Pedido'
      ImageIndex = 7
      Images = ImgLista
      TabOrder = 5
    end
    object edtCliente: TEdit
      Left = 230
      Top = 45
      Width = 100
      Height = 23
      TabOrder = 2
      OnChange = edtClienteChange
      OnKeyPress = edtClienteKeyPress
    end
    object edtClienteDesc: TEdit
      Left = 358
      Top = 45
      Width = 369
      Height = 23
      ReadOnly = True
      TabOrder = 4
    end
    object btnCancelarPedido: TButton
      Left = 857
      Top = 43
      Width = 120
      Height = 25
      Caption = 'Cancelar Pedido'
      ImageIndex = 5
      Images = ImgLista
      TabOrder = 6
      OnClick = btnCancelarPedidoClick
    end
    object btnClientes: TButton
      Left = 333
      Top = 44
      Width = 23
      Height = 25
      ImageIndex = 0
      Images = ImgLista
      TabOrder = 3
      OnClick = btnClientesClick
    end
    object capStartDate: TCalendarPicker
      Left = 109
      Top = 46
      Width = 118
      Height = 21
      CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
      CalendarHeaderInfo.DaysOfWeekFont.Height = -13
      CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
      CalendarHeaderInfo.DaysOfWeekFont.Style = []
      CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.Font.Color = clWindowText
      CalendarHeaderInfo.Font.Height = -20
      CalendarHeaderInfo.Font.Name = 'Segoe UI'
      CalendarHeaderInfo.Font.Style = []
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TextHint = 'select a date'
    end
    object edtNumeroPedido: TEdit
      Left = 5
      Top = 45
      Width = 100
      Height = 23
      ReadOnly = True
      TabOrder = 0
    end
  end
  object grdItens: TDBGrid
    Left = 0
    Top = 160
    Width = 993
    Height = 265
    Align = alTop
    DataSource = dsPedido
    DrawingStyle = gdsGradient
    GradientEndColor = clBlack
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnKeyDown = grdItensKeyDown
    OnKeyPress = grdItensKeyPress
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'autoincrem'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'codigo_produto'
        Title.Alignment = taCenter
        Title.Caption = 'Produto'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nome_produto'
        Title.Caption = 'Descri'#231#227'o'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Width = 350
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'quantidade'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'valor_unitario'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Unit'#225'rio'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'valor_total'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWhite
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end>
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 80
    Width = 993
    Height = 80
    Align = alTop
    Caption = '[ Produtos ] '
    TabOrder = 1
    object lblCodProduto: TLabel
      Left = 5
      Top = 29
      Width = 72
      Height = 13
      Caption = 'C'#243'd. Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDescProduto: TLabel
      Left = 133
      Top = 29
      Width = 55
      Height = 13
      Caption = 'Descri'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblQuantidade: TLabel
      Left = 494
      Top = 29
      Width = 65
      Height = 13
      Caption = 'Quantidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblValorUnit: TLabel
      Left = 588
      Top = 29
      Width = 77
      Height = 13
      Caption = 'Valor Unit'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotal: TLabel
      Left = 741
      Top = 29
      Width = 29
      Height = 13
      Caption = 'Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnInserir: TButton
      Left = 775
      Top = 46
      Width = 100
      Height = 25
      Caption = 'Inserir'
      ImageIndex = 1
      Images = ImgLista
      TabOrder = 6
      OnClick = btnInserirClick
    end
    object edtCodProduto: TEdit
      Left = 5
      Top = 48
      Width = 100
      Height = 23
      TabOrder = 0
      OnChange = edtCodProdutoChange
      OnKeyPress = edtCodProdutoKeyPress
    end
    object edtQuantidade: TEdit
      Left = 459
      Top = 48
      Width = 100
      Height = 23
      Alignment = taRightJustify
      TabOrder = 3
      OnChange = edtQuantidadeChange
      OnKeyPress = edtQuantidadeKeyPress
    end
    object edtValorUnitatio: TEdit
      Left = 565
      Top = 48
      Width = 100
      Height = 23
      Alignment = taRightJustify
      TabOrder = 4
      OnChange = edtValorUnitatioChange
      OnKeyPress = edtValorUnitatioKeyPress
    end
    object edtTotal: TEdit
      Left = 670
      Top = 48
      Width = 100
      Height = 23
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 5
    end
    object edtDescricao: TEdit
      Left = 134
      Top = 48
      Width = 319
      Height = 23
      ReadOnly = True
      TabOrder = 2
    end
    object btnGravarPedido: TButton
      Left = 880
      Top = 46
      Width = 100
      Height = 25
      Caption = 'Gravar Pedido'
      ImageIndex = 3
      Images = ImgLista
      TabOrder = 7
      OnClick = btnGravarPedidoClick
    end
    object btnProdutos: TButton
      Left = 108
      Top = 47
      Width = 23
      Height = 25
      ImageIndex = 0
      Images = ImgLista
      TabOrder = 1
      OnClick = btnProdutosClick
    end
  end
  object ImgLista: TImageList
    Left = 552
    Top = 240
    Bitmap = {
      494C01010A001800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      80008080800080808000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      80008080800080808000FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      8000FFFFFF000000000080808000000000008080800000000000000000008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF000000000000000000808080000000000000000000000000008080
      8000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      800000000000FFFFFF000000000000000000FFFFFF0000000000000000008080
      800000000000000000000000000000000000000000000000000000000000FFFF
      FF0080808000808080008080800000000000FFFFFF0080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008080800000000000FFFFFF008080800000000000FFFFFF00808080000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000000000000000000000000000808080008080800080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000FFFFFF008080800080808000000000000000
      0000000000000000000000000000000000000000000080808000FFFFFF000000
      00000000000000000000FFFFFF00000000000000000080808000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000808080008080800080808000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000080808000000000000000
      00000000000080808000FFFFFF0000000000000000008080800000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000808080008080800080808000FFFFFF00FFFF
      FF000000000000000000000000000000000080808000FFFFFF00000000000000
      0000FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF000000000080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000808080000000000080808000808080008080800080808000FFFF
      FF00FFFFFF0000000000000000000000000080808000FFFFFF00000000008080
      800080808000808080008080800080808000000000000000000080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF0000000000808080000000000080808000FFFFFF00808080008080
      8000FFFFFF000000000000000000000000008080800000000000FFFFFF000000
      00000000000080808000FFFFFF00000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF008080
      8000FFFFFF000000000000000000000000008080800080808000808080008080
      8000FFFFFF00FFFFFF00FFFFFF00000000000000000080808000FFFFFF000000
      0000000000008080800000000000000000000000000080808000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      80008080800080808000FFFFFF0000000000000000008080800000000000FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF0080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      80008080800080808000FFFFFF00000000000000000000000000808080008080
      800000000000FFFFFF00FFFFFF00808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000FFFFFF000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF008080800080808000808080008080800080808000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      00008000000080000000000000000000000080808000FFFFFF00000000000000
      00000000000080808000FFFFFF0000000000FFFFFF00FFFFFF00000000008080
      8000FFFFFF000000000080808000FFFFFF000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000008080
      8000808080008080800000000000000000000000000080808000808080008080
      8000FFFFFF00FFFFFF0000000000000000000000000080000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF00000080000000000000000000000080808000FFFFFF00000000000000
      00000000000080808000FFFFFF008080800080808000FFFFFF00000000008080
      8000FFFFFF000000000080808000FFFFFF0000000000000000000000FF000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000808080008080
      8000FFFFFF00FFFFFF0000000000000000000000000000000000000000008080
      800080808000FFFFFF00FFFFFF00000000000000000080000000800000008000
      0000C0C0C000C0C0C0000000800000FFFF0000008000C0C0C000C0C0C0008000
      00008000000080000000000000000000000080808000FFFFFF00000000000000
      00000000000080808000FFFFFF008080800080808000FFFFFF00FFFFFF008080
      8000FFFFFF000000000080808000FFFFFF00000000000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000080808000808080008080
      800080808000FFFFFF00FFFFFF00000000000000000000000000000000000000
      00008080800080808000FFFFFF00000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C00000008000FFFFFF00FFFFFF00808080000000
      00000000000000000000000000000000000080808000FFFFFF00000000000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000000000000000000080808000FFFFFF00000000000000FF00000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000000080808000FFFFFF008080
      80008080800080808000FFFFFF00FFFFFF000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C00000FFFF00FFFFFF0080808000808080000000
      00000000000000000000000000000000000080808000FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000FFFFFF000000FF000000FF00000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF00000000008080800080808000FFFFFF000000
      0000808080008080800080808000FFFFFF00FFFFFF0000000000000000000000
      0000000000008080800080808000FFFFFF000000000000000000000000000000
      000000000000C0C0C000C0C0C00000008000FFFFFF0080808000000000000000
      00000000000000000000000000000000000080808000FFFFFF00808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000FFFFFF0080808000FFFFFF000000FF000000FF00000000000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000FF000000FF00000000008080800080808000FFFFFF000000
      000000000000808080008080800080808000FFFFFF00FFFFFF00000000000000
      0000000000008080800080808000FFFFFF000000000000000000000000000000
      00000000000000000000C0C0C00000FFFF008080800000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF0080808000FFFFFF000000FF000000FF00000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000FF000000FF00000000008080800080808000FFFFFF000000
      00000000000000000000808080008080800080808000FFFFFF00FFFFFF000000
      0000000000008080800080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000C0C0C0000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF0080808000FFFFFF000000FF000000FF00000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000FF000000FF00000000008080800080808000FFFFFF000000
      0000000000000000000000000000808080008080800080808000FFFFFF00FFFF
      FF00000000008080800080808000FFFFFF000000000000000000000000000000
      0000000000000000000000008000FFFFFF000000800000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF0080808000FFFFFF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000000000000000FF000000FF00000000008080800080808000FFFFFF00FFFF
      FF0000000000000000000000000000000000808080008080800080808000FFFF
      FF00FFFFFF008080800080808000000000000000000000000000000000000000
      0000000000000000800000FFFF0000008000FFFFFF0000008000000000000000
      00000000000000000000000000000000000080808000FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF0080808000FFFFFF00000000000000FF000000FF000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00000000000000FF000000000000000000000000008080800000000000FFFF
      FF00FFFFFF000000000000000000000000000000000080808000808080008080
      8000FFFFFF0080808000FFFFFF00000000000000000000000000000000000000
      0000C0C0C000C0C0C0000000800000FFFF00FFFFFF0000FFFF00808080000000
      00000000000000000000000000000000000080808000FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF0080808000FFFFFF00000000000000FF000000FF000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF0000000000000000000000000080808000808080000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C00000008000FFFFFF00808080000000
      00000000000000000000000000000000000080808000FFFFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000FFFFFF0000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF000000FF000000000000000000000000000000000000000000808080008080
      800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      8000808080000000000000000000000000000000000080000000800000008000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0008000
      000080000000800000000000000000000000808080000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF0080808000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000008080
      8000808080008080800000000000000000000000000080808000808080008080
      8000000000000000000000000000000000000000000080000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF0000008000000000000000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000808080008080800080808000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000FFFFFF00FFFF
      FF000000000000000000000000000000000080808000FFFFFF00000000000000
      00000000000000000000FFFFFF00808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      000080808000808080008080800000FFFF0000FFFF0080808000808080008080
      80008080800000FFFF0000FFFF0000000000000000008080800080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008080800080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008080800080808000000000000000000000000000000000000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      00000000000080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000008080800000000000000000000000000000000000000000008080
      8000FFFFFF000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF0000000000000000000000000000000000000000000000
      00000000000080808000C0C0C0000000000000000000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000008080800000000000000000000000000000000000000000008080
      8000FFFFFF000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF0000000000000000000000000000000000000000000000
      00000000000080808000C0C0C0000000000000000000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000808080000000000000FFFF00808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000008080800000000000000000000000000000000000000000008080
      8000FFFFFF000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF0000000000000000000000000000000000000000000000
      00000000000080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000008080
      800080808000808080008080800080808000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000080808000000000000000000000000000FFFFFF00FFFFFF008080
      8000FFFFFF000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00C0C0C000FFFFFF00C0C0C000FFFFFF008080800000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF00000000008080800080808000808080008080
      8000FFFFFF000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000FFFFFF00C0C0
      C000FFFFFF000000FF00FFFFFF00C0C0C000FFFFFF0080808000808080000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF000000000080808000808080008080
      8000FFFFFF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF0080808000808080008080800080808000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000080808000C0C0C000FFFF
      FF00C0C0C0000000FF00C0C0C000FFFFFF00C0C0C00080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF000000000000000000000000008080800080808000808080008080
      800080808000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000080808000FFFFFF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF0080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF0000000000000000000000000080808000FFFFFF00000000008080
      8000FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000080808000C0C0C000FFFF
      FF00C0C0C0000000FF00C0C0C000FFFFFF00C0C0C00080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF0000000000000000000000000080808000FFFFFF00808080008080
      8000FFFFFF00FFFFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000008080800080808000FFFFFF00C0C0
      C000FFFFFF000000FF00FFFFFF00C0C0C000FFFFFF0080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF008080800080808000000000008080
      800080808000FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000080808000FFFF
      FF00C0C0C000FFFFFF00C0C0C000FFFFFF008080800000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000000000000000000000000000000000808080008080
      80008080800080808000808080008080800080808000FFFFFF00000000000000
      00008080800080808000FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000008080800000000000000000000000000000000000000000008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000080808000808080000000
      0000000000000000000000000000808080008080800000000000000000000000
      000000000000808080008080800000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000808080000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000FFFF008080800000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF0000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF00C001FFF8000000008001FFF000000000
      8001FFE1000000008563FFC300000000E6E7F88700000000EB6FE10F00000000
      F49FCE1F00000000FA3F9D9F00000000FC1FB9AF00000000F80F304F00000000
      F20720CF00000000E50759DF00000000C7019B9F000000008001A73F00000000
      8001C87F000000008003F1FF00000000C001FFFFFC1FFFFF8002F83FF0078003
      3924E00FE38380033824CFC7C3E18003380487E381F1E00F380CA3F380F8E00F
      200031F91078F01F000038F91838F83F0FF03C791C18FC7F0FF03E391E08F83F
      0FF03F190F01F01F0FF09F8BA781E00F0FF08FC393C3E00F0FF0C7E7C8078003
      4001E00FE38F80038003F83FF83F8003FFFDFF7ECF3CFFFFFFF8900180018003
      FFF1C003C0030001FFE3E003E7F30001FFC7E003E7F30001E08FE003E7F30001
      C01FE00387F00001803F000107F00001001F800087800001001FE007E7070001
      001FE00FE7270001001FE00FE7030001001FE027E0210001803FC073C0300001
      C07F9E799E790001E0FF7EFE7EFE800300000000000000000000000000000000
      000000000000}
  end
  object dsPedido: TDataSource
    Left = 480
    Top = 232
  end
end
