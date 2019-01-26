#------------------------------------------------------------------------
#------------------------------------------------------------------------
#arquivo <- "https://c3web.github.io/SP156/data/dados-do-sp156.csv"
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
    #print(dim(dados))
    #summary(dados$Status.da.solicitação)
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
  # Grafico de Solicitacoes por Orgao
  output$grafico_orgao <- renderPlot({
    
    data <- getData()
    orgao <- input$sorgaos
    
    org <- subset(data, Órgão == orgao)
    s <- table(org$Status.da.solicitação)
    
    borg <- barplot(s, 
                    col = c("gold", "red", "darkturquoise"), 
                    ylab = "Quantidade", 
                    ylim = c(0, max(table(org$Status.da.solicitação)) + 1000),
                    font.main=4,
                    main=paste("Solicitações por Órgão - ", input$sorgaos))
    text(borg, 
         table(org$Status.da.solicitação) + 200, 
         paste(summary(org$Status.da.solicitação)),
         font=2,
         cex=1) 
  })
  #----------------------------------------------------------------------------
  # Grafico de Solicitacoes por Orgao
  # Pie
  output$pie_orgao <- renderPlot({
    #boxplot(dados$Status.da.solicitação, table(dados$Status.da.solicitação))
  })
  
  #----------------------------------------------------------------------------
  # Grafico de Solicitacoes Totais
  # Barra
  output$grafico_total <- renderPlot({
    
    # #dados <- dados #getData()
    # bar = barplot(summary(dados$Status.da.solicitação),
    #               col = c("gold", "red", "darkturquoise"), 
    #               ylab = "Quantidade", 
    #               main="Solicitações Totais dos Órgãos/Secretarias")
    #dados <- dados #getData()
    btot = barplot(table(dados$Status.da.solicitação),
                   col = c("gold", "red", "darkturquoise"), 
                   ylab = "Quantidade", 
                   ylim = c(0, max(table(dados$Status.da.solicitação)) + 3000),
                   font.main=4,
                   main="Solicitações Totais dos Órgãos/Secretarias")
    text(btot, 
         table(dados$Status.da.solicitação) + 2000, 
         paste(summary(dados$Status.da.solicitação)),
         font=2,
         cex=1) 
  })
  #----------------------------------------------------------------------------
  # Grafico de Solicitacoes Totais
  # Pie
  output$pie_total <- renderPlot({
    #boxplot(dados$Status.da.solicitação, table(dados$Status.da.solicitação))
  })
  
}
