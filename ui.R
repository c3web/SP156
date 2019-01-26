library(shinydashboard)
library(leaflet)


#------------------------------------------------------------------------
# Header
header <- dashboardHeader(
  title = "SP156 - Prefeitura de São Paulo",
  titleWidth = 400
)

#------------------------------------------------------------------------
# Body
body <- dashboardBody(

  #------------------------------------------------------------------------
  # Style para o subtitulo
  tags$head(tags$style("#norgao{color: #806600;}")),
  #------------------------------------------------------------------------
  # Subtitulo - Orgao
  fluidRow(column(12, h3(strong(textOutput("norgao"))))),
  #------------------------------------------------------------------------
  # Boxes Select
  fluidRow(
    #------------------------------------------------------------------------
    # Box Orgaos
    column(4,
           box(width = NULL, status = "primary",
               selectInput("sorgaos", 
                           "Órgão", 
                           c("Selecione")
               )
           )
    ),
    #------------------------------------------------------------------------
    # Box Distrito
    column(4,
           box(width = NULL, status = "success",
               selectInput("sdistrito", 
                           "Distrito", 
                           c("Selecione")
               )
           )
    ),
    #------------------------------------------------------------------------
    # Box Status
    column(4,
           box(width = NULL, status = "info",
               selectInput("sstatus", 
                           "Status", 
                           c("Selecione")
               )
           )
    )
  ),
  #------------------------------------------------------------------------
  # TABS
  tabsetPanel(id = "sp156",
              #------------------------------------------------------------------------
              # Arquivo
              tabPanel("Arquivo", 
                       fluidRow(
                         column(6,
                                box(width = NULL, status = "warning",
                                    fileInput("arquivo", "Selecione o arquivo CSV", 
                                              multiple = FALSE, 
                                              accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")
                                    ),
                                    actionButton("processar","Processar")
                                )                         )
                       )
              ),
              #------------------------------------------------------------------------
              # Dados
              tabPanel("Dados",
                       # Cria o espaco para mostrar a tabela
                       DT::dataTableOutput("table")
              ),
              #------------------------------------------------------------------------
              # Graficos
              tabPanel("Gráficos",
                       fluidRow(
                         column(6,
                                box(width = NULL, 
                                    status = "warning",
                                    title = "Solicitações por Órgão",
                                    solidHeader = TRUE, 
                                    background = "black",
                                    plotOutput("grafico_orgao")
                                )
                         ),
                         column(6,
                                box(width = NULL, 
                                    status = "warning",
                                    title = "Solicitações Totais",
                                    solidHeader = TRUE, 
                                    background = "black",
                                    plotOutput("pie_orgao")
                                )
                         )
                       ),
                       hr(),
                       fluidRow(
                         column(6,
                                box(width = NULL, 
                                    status = "success",
                                    title = "Solicitações Totais",
                                    solidHeader = TRUE, 
                                    background = "black",
                                    plotOutput("grafico_total")
                                )
                         ),
                         column(6,
                                box(width = NULL, 
                                    status = "success",
                                    title = "Solicitações Totais",
                                    solidHeader = TRUE, 
                                    background = "black",
                                    plotOutput("pie_total")
                                )
                         )
                       )
              )
  )
)


dashboardPage(
  skin = "yellow", # blue, black, purple, green, red, yellow
  header,
  dashboardSidebar(disable = TRUE),
  body
)