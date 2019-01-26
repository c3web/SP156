library(shinydashboard)
library(shinycssloaders)
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
              # Dados
              tabPanel("Dados",
                       # Cria o espaco para mostrar a tabela
                       DT::dataTableOutput("table") %>% withSpinner()
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
                                    plotOutput("grafico_orgao") %>% withSpinner()
                                )
                         ),
                         column(6,
                                box(width = NULL, 
                                    status = "warning",
                                    title = "Solicitações Totais",
                                    solidHeader = TRUE, 
                                    background = "black",
                                    plotOutput("pie_orgao") %>% withSpinner()
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
                                    plotOutput("grafico_total") %>% withSpinner()
                                )
                         ),
                         column(6,
                                box(width = NULL, 
                                    status = "success",
                                    title = "Solicitações Totais",
                                    solidHeader = TRUE, 
                                    background = "black",
                                    plotOutput("pie_total") %>% withSpinner()
                                )
                         )
                       )
              )
  )
)


dashboardPage(
  skin = "blue", # blue, black, purple, green, red, yellow
  header,
  dashboardSidebar(disable = TRUE),
  body
)