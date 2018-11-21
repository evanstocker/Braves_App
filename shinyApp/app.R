# Load needed libraries
library(shiny)
library(ggplot2)

# Load functions
source("scripts/GetBatterStats.R")
source("scripts/QueryData.R")
source('scripts/Global.R', local = FALSE)

# Define UI ----
ui <- fluidPage(
  

  titlePanel(""),
  sidebarLayout(position = "left",
                
                sidebarPanel(h1("Select Data"),align = "center", style = "font-family: 'times'; font-si16pt",
                             br(),img(src = "BravesImg.gif", 
                                      height = 100,width = 160, align = "center"),br(),
                             br(),sliderInput("SpinRate",label = "Hit Spin Rate",min = 0,
                                              max = 7500,value =c(0,7500),step = 500),ticks = TRUE,
                             br(),br(),sliderInput("LaunchAngle",label = "Launch Angle",
                                                   min = -90, max = 90,value = c(-90,90),step = 10,ticks = TRUE),br(),br(),
                             selectInput("BatterName",label = "Batter",choices = unique(BattedBallData_$BATTER),selectize = FALSE)),
                
                mainPanel(h1(strong("Batted Ball Data Visualization")),align = "center", style = "font-family: 'times'; font-si16pt",
                          h4(strong("Batter Name:"), em(textOutput("selected_batter"))),
                          h4(strong("Avg: "), em(textOutput("selected_batteravg"))),
                          h4(strong("SLG: "),em(textOutput("selected_batterslg"))),
                          h4(strong("Sample Size:"), em(textOutput("selected_samplesize"))),
                          
                          br(),
                          
                          plotOutput("selected_plot"))
  )  
)

# Define server logic ----
server <- function(input, output) {

  # Return Batter
  output$selected_batter = renderText({ 
    SelectedData = QueryData(SpinRateMin = input$SpinRate[1],SpinRateMax = input$SpinRate[2],
                             LaunchAngleMin = input$LaunchAngle[1],LaunchAngleMax = input$LaunchAngle[2],SelectedBatter = input$BatterName)
    
    paste(SelectedData$BATTER[1]) 
  })
  
  # Return Batting Avg
  output$selected_batteravg = renderText({
    SelectedData = QueryData(SpinRateMin = input$SpinRate[1],SpinRateMax = input$SpinRate[2],
                             LaunchAngleMin = input$LaunchAngle[1],LaunchAngleMax = input$LaunchAngle[2],SelectedBatter = input$BatterName)
    
    paste(format(round(GetStats(SelectedData$PLAY_OUTCOME)[1],3),nsmall=3))
  })
  
  # Return Slugging %
  output$selected_batterslg = renderText({
    SelectedData = QueryData(SpinRateMin = input$SpinRate[1],SpinRateMax = input$SpinRate[2],
                             LaunchAngleMin = input$LaunchAngle[1],LaunchAngleMax = input$LaunchAngle[2],SelectedBatter = input$BatterName)
    paste(format(round(GetStats(SelectedData$PLAY_OUTCOME)[2],3),nsmall=3))
  })
  
  # Return Sample Size
  output$selected_samplesize = renderText({
    SelectedData = QueryData(SpinRateMin = input$SpinRate[1],SpinRateMax = input$SpinRate[2],
                             LaunchAngleMin = input$LaunchAngle[1],LaunchAngleMax = input$LaunchAngle[2],SelectedBatter = input$BatterName)
    paste(length(SelectedData$PLAY_OUTCOME))
  })
  
  # Create Bar Graph with ggplot2
  output$selected_plot = renderPlot({
    SelectedData = QueryData(SpinRateMin = input$SpinRate[1],SpinRateMax = input$SpinRate[2],
                             LaunchAngleMin = input$LaunchAngle[1],
                             LaunchAngleMax = input$LaunchAngle[2],SelectedBatter = input$BatterName)
    ggplot(SelectedData, aes(x=factor(PLAY_OUTCOME))) +
      geom_bar(width = .7,fill="springgreen3") +
      xlab("\nPlay Outcome")+
      ylab("Quantity\n")+
      theme(text = element_text(family = "serif"),
            axis.text=element_text(size=18),
            axis.title = element_text(size=32))+
      scale_x_discrete(limits=c("Single", "Double", "Triple","HomeRun","Out"))
    
  })
  
}

# Run the app ----
shinyApp(ui = ui, server = server)
