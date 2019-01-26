#------------------------------------------------------------------------
library(plyr)
#------------------------------------------------------------------------
arquivo <- "data/dados-do-sp156.csv"
#
dados <- read.csv(arquivo, sep = ",", encoding = "UTF-8")
#
#------------------------------------------------------------------------
#
# Define a logica de servidor para mostrar a tabela com os dados
function(input, output, session) {
  
  hideTab(inputId = "sp156", target = "Dados")
  hideTab(inputId = "sp156", target = "Gráficos")
  
  showTab(inputId = "sp156", target = "Dados", select = TRUE)
  showTab(inputId = "sp156", target = "Gráficos")
  #----------------------------------------------------------------------------
  # Tabela
  output$table <- DT::renderDataTable(DT::datatable({
    data <- getData()
  }))
  #----------------------------------------------------------------------------
  # Grafico de Solicitacoes Totais
  output$summary <- renderPrint({
    summary(dados$Órgão)
  })
  #----------------------------------------------------------------------------
  updateSelectInput(session, "sorgaos",
                    choices = c("Selecione",
                                sort(unique(as.character(dados$Órgão))))
  )
  #----------------------------------------------------------------------------
  updateSelectInput(session, "sdistrito",
                    choices = c("Selecione",
                                sort(unique(as.character(dados$Distrito))))
  )
  #----------------------------------------------------------------------------
  updateSelectInput(session, "sstatus",
                    choices = c("Selecione",
                                sort(unique(as.character(dados$Status.da.solicitação))))
  )

  #------------------------------------------------------------------------
  # Preenche na tela o nome do orgao selecionado
  output$norgao <- renderText({getOrgao()})
  
  #------------------------------------------------------------------------
  # Seleciona os dados de acordo com o selecionado nos combos
  getData <- reactive({
    
    data <- dados
    if (input$sorgaos != "Selecione") {
      #print(input$sorgaos)
      data <- data[data$Órgão == input$sorgaos,]
      #data <- subset(data, Órgão == input$sorgaos)
    }
    if (input$sstatus != "Selecione") {
      #print(input$sstatus)
      data <- data[data$Status.da.solicitação == input$sstatus,]
      #data <- subset(data, Status.da.solicitação == input$sstatus)
    }
    if (input$sdistrito != "Selecione") {
      #print(input$sdistrito)
      data <- data[data$Distrito == input$sdistrito,]
      #data <- subset(data, Distrito == input$sdistrito)
    }
    data
    
  })
  
  #------------------------------------------------------------------------
  # Captura o Orgao selecionado no combo
  getOrgao <- reactive({
    
    if (input$sorgaos == "AMLURB") {
      paste(input$sorgaos, " - Autoridade Municipal de Limpeza Urbana")
    }
    else if (input$sorgaos == "CET") {
      paste(input$sorgaos, " - Companhia de Engenharia de Tráfego")
    }
    else if (input$sorgaos == "COVISA-DVZ") {
      paste(input$sorgaos, " - Coordenadoria de Vigilância em Saúde - Divisão de Vigilância de Zoonoses")
    }
    else if (input$sorgaos == "COVISA-UVIS") {
      paste(input$sorgaos, " - Coordenadoria de Vigilância em Saúde - Unidades de Vigilância em Saúde")
    }
    else if (input$sorgaos == "DTP") {
      paste(input$sorgaos, " - Departamento de Transportes Públicos")
    }
    else if (input$sorgaos == "GCM") {
      paste(input$sorgaos, " - Guarda Civil Metropolitana")
    }
    else if (input$sorgaos == "ILUME") {
      paste(input$sorgaos, " - Departamento de Iluminação Pública")
    }
    else if (input$sorgaos == "OGM") {
      paste(input$sorgaos, " - Ouvidoria Geral do Município")
    }
    else if (input$sorgaos == "SEHAB") {
      paste(input$sorgaos, " - Secretaria Municipal de Habitação")
    }
    else if (input$sorgaos == "SF") {
      paste(input$sorgaos, " - Secretaria da Fazenda")
    }
    else if (input$sorgaos == "SF-DIATE") {
      paste(input$sorgaos, " - Secretaria da Fazenda",
            " - Divisão de Atendimento da Receita Municipal")
    }
    else if (input$sorgaos == "SMADS") {
      paste(input$sorgaos, " - Secretaria Municipal de Assistência e Desenvolvimento Social")
    }
    else if (input$sorgaos == "SMC") {
      paste(input$sorgaos, " - Secretaria Municipal de Cultura")
    }
    else if (input$sorgaos == "SMDHC") {
      paste(input$sorgaos, " - Secretaria Municipal de Direitos Humanos e Cidadania")
    }
    else if (input$sorgaos == "SME") {
      paste(input$sorgaos, " - Secretaria Municipal de Educação")
    }
    else if (input$sorgaos == "SMIT") {
      paste(input$sorgaos, " - Secretaria Municipal de Inovação e Tecnologia")
    }
    else if (input$sorgaos == "SMIT-CASP") {
      paste(input$sorgaos, " - Secretaria Municipal de Inovação e Tecnologia",
            "- Coordenadoria de Atendimento ao Cidadão e Modernização em Serviços Públicos")
    }
    else if (input$sorgaos == "SMIT-CCD") {
      paste(input$sorgaos, " - Secretaria Municipal de Inovação e Tecnologia",
            " - Coordenadoria de Convergência Digital")
    }
    else if (input$sorgaos == "SMPED") {
      paste(input$sorgaos, " - Secretaria Municipal da Pessoa com Deficiência")
    }
    else if (input$sorgaos == "SMPR") {
      paste(input$sorgaos, " - Secretaria Municipal de Prefeituras Subprefeituras")
    }
    else if (input$sorgaos == "SMS") {
      paste(input$sorgaos, " - Secretaria Municipal da Saúde")
    }
    else if (input$sorgaos == "SMSO") {
      paste(input$sorgaos, " - Secretaria Municipal de Serviços e Obras")
    }
    else if (input$sorgaos == "SMSU/Defesa Civil") {
      paste(input$sorgaos, " - Secretaria Municipal de Segurança Urbana")
    }
    else if (input$sorgaos == "SMT/DTP") {
      paste(input$sorgaos, " - Secretaria Municipal de Mobilidade e Transportes",
            " - Departamento de Transportes Público")
    }
    else if (input$sorgaos == "SMTE") {
      paste(input$sorgaos, " - Secretaria Municipal de Trabalho e Empreendedorismo")
    }
    else if (input$sorgaos == "SMUL") {
      paste(input$sorgaos, " - Secretaria Municipal de Urbanismo e Licenciamento")
    }
    else if (input$sorgaos == "SPOBRAS") {
      paste(input$sorgaos, " - São Paulo Obras")
    }
    else if (input$sorgaos == "SPTRANS") {
      paste(input$sorgaos, " - São Paulo Transporte")
    }
    else if (input$sorgaos == "SVMA") {
      paste(input$sorgaos, " - Secretaria do Verde e do Meio Ambiente")
    }
    
  })
  
  #----------------------------------------------------------------------------
  # TABELAS
  #----------------------------------------------------------------------------
  # Tabela de Serviços mais solicitados filtrado por órgão
  # Table
  output$desc_orgao <- renderTable({
    data <- getData()
    orgao <- input$sorgaos
    
    org <- subset(data, Órgão == orgao)
    if (!nrow(org) > 0) {
      return("Se um Órgão estiver selecionado, altere o Distrito ou o Status")
    }
    
    counts_orgao <- ddply(subset(org, org$Status.da.solicitação != "CANCELADA"), 
                          .(Distrito, Órgão, Serviço, Status.da.solicitação), nrow)
    names(counts_orgao) <- c("Distrito", "Órgão", "Serviço", "Status.da.solicitação", "Qtde.Solicitações")
    counts_orgao <- counts_orgao[order(counts_orgao$Qtde.Solicitações, decreasing = TRUE, na.last = TRUE), ]
    counts_orgao <- head(counts_orgao, 20)
    #
    head(counts_orgao, 10)
  }, width = '100%', bordered = TRUE, striped = TRUE, hover = TRUE, na = "NA")
  #----------------------------------------------------------------------------
  # Tabela de Serviços mais solicitados
  # Table
  counts_total <- ddply(subset(dados, dados$Status.da.solicitação != "CANCELADA"), 
                        .(Distrito, Órgão, Serviço, Status.da.solicitação), nrow)
  names(counts_total) <- c("Distrito", "Órgão", "Serviço", "Status.da.solicitação", "Qtde.Solicitações")
  counts_total <- counts_total[order(counts_total$Qtde.Solicitações, decreasing = TRUE, na.last = TRUE), ]
  counts_total <- head(counts_total, 20)
  #
  output$desc_total_f <- renderTable({
    head(counts_total, 10)
  }, width = 'auto', striped = TRUE, hover = TRUE, na = "NA")

    
  #----------------------------------------------------------------------------
  # Graficos
  #----------------------------------------------------------------------------
  # Grafico de Solicitacoes por Orgao
  output$grafico_orgao <- renderPlot({
    
    data <- getData()
    orgao <- input$sorgaos
    
    org <- subset(data, Órgão == orgao)
    s <- table(org$Status.da.solicitação)

    m = mean(table(org$Status.da.solicitação))
    #print(m)

    tb = 0
    if (m == 0) {
      tb = 0
    } else if (m < 1) {
      tb = 0.085
    } else if (m <= 5) {
      tb = 0.2
    } else if (m <= 10) {
      tb = 0.6
    } else if (m <= 25) {
      tb = 2.6
    } else if (m <= 50) {
      tb = 4
    } else if (m <= 100) {
      tb = 10
    } else if (m <= 250) {
      tb = 25
    } else if (m <= 500) {
      tb = 50
    } else if (m <= 1500) {
      tb = 120
    } else if (m <= 2500) {
      tb = 220
    } else if (m <= 5000) {
      tb = 500
    } else if (m <= 10000) {
      tb = 1000
    } else {
      tb = 2000
    }

    borg <- barplot(s, 
                    col = c("gold", "red", "darkturquoise"), 
                    ylab = "Quantidade",
                    xlab = "Status",
                    ylim = c(0, max(table(org$Status.da.solicitação)) * 1.4),
                    font.main=4,
                    main=paste("Solicitações por Órgão - ", input$sorgaos))
    text(borg, 
         table(org$Status.da.solicitação) + tb,
         paste(summary(org$Status.da.solicitação)),
         font=2,
         cex=1) 
    
  })
  #----------------------------------------------------------------------------
  # Grafico de Solicitacoes Totais
  # Barra
  output$grafico_total <- renderPlot({
    
    btot = barplot(table(dados$Status.da.solicitação),
                   col = c("gold", "red", "darkturquoise"), 
                   ylab = "Quantidade",
                   xlab = "Status",
                   ylim = c(0, max(table(dados$Status.da.solicitação)) + 5000),
                   font.main=4,
                   main="Solicitações Totais dos Órgãos/Secretarias")
    text(btot,
         table(dados$Status.da.solicitação) + 3000, 
         paste(summary(dados$Status.da.solicitação)),
         font=2,
         cex=1) 
  })
  
}
