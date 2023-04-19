

library(shiny)
library(shinythemes)



ui <- fluidPage(theme = shinytheme("cosmo"),
                
                
                titlePanel("Check Your Patient's Progress"),
                tabsetPanel(
                    tabPanel("About",
                             h1("This ShinyApp is made to help those working with patients with communicative disorders. For instance, ABA therapists must track the progress of words each child is making."),
                             h1("It may be of interest to look at Mean Length of Utterance (MLU) or number of syllables stuttered and time of therapy session in weeks, to see the progress of a patient. On this app, you can modify the data to how you see fit"),
                             h1("Users can upload a CSV file and can manipulate how the data appears in the table. Please make sure you upload a CSV file. It will not work for any other file type"),
                             h1("Users can create a graph from their uploaded CSV file and pick what variable what they will like to see on both the x-axis and y-axis. Please make sure you select variables with a NUMERIC value or else the graph will not work. The graph will be a scatter plot")
                    ),
                    tabPanel("Upload File",
                             titlePanel("Uploading Files"),
                             sidebarLayout(
                                 sidebarPanel(
                                     fileInput('file1', 'Choose CSV File',
                                               accept=c('text/csv', 
                                                        'text/comma-separated-values,text/plain', 
                                                        '.csv')),
                                     
                                     tags$br(),
                                     checkboxInput('header', 'Header', TRUE),
                                     radioButtons('sep', 'Separator',
                                                  c(Comma=',',
                                                    
                                                    Tab='\t'),
                                                  ','),
                                     
                                     h1("'Header' uses the same subtitles from your CSV Files for each column. If you do not want to see the titles, do not select header."),
                                     
                                 ),
                                 mainPanel(
                                     tableOutput('contents')
                                 )
                             )
                    ),
                    
                    
                    tabPanel("Visualise results",
                             pageWithSidebar(
                                 headerPanel('My First Plot'),
                                 sidebarPanel(
                                     
                                     
                                     selectInput('xcol', 'X Variable', ""),
                                     selectInput('ycol', 'Y Variable', "", selected = "")
                                     
                                 ),
                                 mainPanel(
                                     plotOutput('MyPlot')
                                 )
                             )
                    )
                    
                )
)


server <- shinyServer(function(input, output, session) {
    
    
    
    data <- reactive({ 
        req(input$file1) 
        
        inFile <- input$file1 
        
        write.csv(iris, "iris.csv")
        df <- read.csv(inFile$datapath, header = input$header, sep = input$sep,
                       quote = input$quote)
        
        
        updateSelectInput(session, inputId = 'xcol', label = 'X Variable',
                          choices = names(df), selected = names(df))
        updateSelectInput(session, inputId = 'ycol', label = 'Y Variable',
                          choices = names(df), selected = names(df)[2])
        
        return(df)
    })
    
    output$contents <- renderTable({
        data()
    })
    
    output$MyPlot <- renderPlot({
        
        x <- data()[, c(input$xcol, input$ycol)]
        plot(x)
        
    })
})

shinyApp(ui, server)