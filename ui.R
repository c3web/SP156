library(shinydashboard)
library(shinycssloaders)
library(leaflet)
#------------------------------------------------------------------------
# Header
header <- dashboardHeader(
  title = "SP156 - Prefeitura de São Paulo",
  titleWidth = 400
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Dados", tabName = "Dados", icon = icon("list-alt")),
    menuItem("Indicadores", tabName = "Indicadores", icon = icon("chart-bar")),
    menuItem("Mapas", tabName = "Mapas", icon = icon("globe"), 
             badgeLabel = "new", badgeColor = "green"),
    hr(),
    menuItem(
      box(width = NULL, status = "primary", background = "black",
          selectInput("sorgaos", "Órgão", c("Selecione"))
      )
    ),
    menuItem(
      box(width = NULL, status = "success", background = "black",
          selectInput("sdistrito", "Distrito", c("Selecione"))
      )
    ),
    menuItem(
      box(width = NULL, status = "danger", background = "black",
          selectInput("sstatus", "Status", c("Selecione"))
      )
    )
  )
)

#------------------------------------------------------------------------
# Body
body <- dashboardBody(

  #------------------------------------------------------------------------
  # Style para o subtitulo
  tags$head(
    tags$style("#norgao{color: #b38f00;}"),
    tags$style("#desc_orgao table {background-color: white; color: #000000 }"),
    tags$style("#desc_total_f table {background-color: white; color: #000000 }"),
    tags$style("#new {border-top: 1px solid white;}"),
    media="screen", type="text/css"),
  
  #------------------------------------------------------------------------
  # Subtitulo - Orgao
  fluidRow(column(12, h3(strong(textOutput("norgao"))))),
  hr(id = "new"),
  #------------------------------------------------------------------------
  # TABS
  tabItems(
    tabItem(tabName = "Dados",
            # Cria o espaco para mostrar a tabela
            DT::dataTableOutput("table") %>% withSpinner()
    ),
    tabItem(tabName = "Indicadores",
            fluidRow(
              column(6,
                     box(width = NULL,
                         status = "info",
                         title = "Solicitações por Órgão",
                         solidHeader = TRUE,
                         #background = "black",
                         plotOutput("grafico_orgao") %>% withSpinner()
                     ),
                     box(width = NULL,
                         status = "info",
                         title = "TOP 10 - Tipos de serviços mais solicitados por Órgão",
                         solidHeader = TRUE,
                         #background = "black",
                         tableOutput("desc_orgao") %>% withSpinner()
                     )
              ),
              column(6,
                     box(width = NULL,
                         status = "danger",
                         title = "Solicitações Totais",
                         solidHeader = TRUE,
                         #background = "black",
                         plotOutput("grafico_total") %>% withSpinner()
                     ),
                     box(width = NULL,
                         status = "danger",
                         title = "TOP 10 - Tipos de serviços mais solicitados",
                         solidHeader = TRUE,
                         #background = "black",
                         tableOutput("desc_total_f") %>% withSpinner()
                     )
              )
            )
    ),
    tabItem(tabName = "Mapas",
            fluidRow(
              column(6,
                     box(width = "auto",
                         status = "info",
                         title = "Localização por Órgão (Disponíveis somente para CET, SMPR e SPTrans)",
                         solidHeader = TRUE,
                         #background = "black",
                         leafletOutput("mapa_orgao") %>% withSpinner()
                     )
              ),
              column(6,
                      box(width = "auto",
                          status = "danger",
                          title = "Localizações dos 50 serviços mais solicitados",
                          solidHeader = TRUE,
                          #background = "black",
                          leafletOutput("mapa_total") %>% withSpinner()
                      )
              )
            )
    )
  )
)

dashboardPage(
  skin = "yellow", # blue, black, purple, green, red, yellow
  #dashboardHeader(disable = TRUE)
  header,
  #dashboardSidebar(disable = TRUE),
  sidebar,
  body
)
