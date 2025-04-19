
ui <- fluidPage(
  
  shinyjs::useShinyjs(),
  
  # App title ----
  titlePanel(tags$b('Monthly Report generator App'), windowTitle = 'Report app'),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Side Panel
    sidebarPanel(
      fileInput(inputId = 'upload_pt', label = h3('Upload Product Tracker here')),
      # br(),
      fileInput(inputId = 'upload_don', label = h3('Upload DON tracker here')),
      # br(),
      fileInput(inputId = 'upload_eios', label = h3('Upload EIOS metrics here')),
      br(),
      fileInput(inputId = 'upload_sig', label = h3('Upload Signal Characterisation tracker here')),
      br(),
      h2('Select specific WHO country regions to add to the report:'),
      checkboxInput("afro_cb", label = "AFRO", value = FALSE),
      checkboxInput("amro_cb", label = "AMRO", value = FALSE),
      checkboxInput("emro_cb", label = "EMRO", value = FALSE),
      checkboxInput("euro_cb", label = "EURO", value = FALSE),
      checkboxInput("searo_cb", label = "SEARO", value = FALSE),
      checkboxInput("wpro_cb", label = "WPRO", value = FALSE),
      checkboxInput("global_cb", label = "Global", value = FALSE)
    ),
    
    # Main Panel
    mainPanel(
      h2('INSTRUCTIONS'),
      tags$ol(
        tags$li('Upload the latest version of the', tags$b('PRODUCT TRACKER.XLSX'), 'file.'),
        tags$li('Upload the latest version of the', tags$b('DON TRACKER.XLSX'), 'file.'),
        tags$li('Upload the latest version of the', tags$b('EIOS_PHI_metrics.XLSX'), 'file.'),
        tags$li('Upload the latest version of the', tags$b('Signal characterization tracker.XLSX'), 'file.'),
        tags$li('All files should be in .xlsx format.'),
        tags$li('Choose the specific WHO regions to add to the report (by default, the report is produced only for all the regions together.'),
        # tags$li('Examine the report parameters detailed on the screen.'),
        tags$li('Download slides after processing')
      ),
      p(tags$b('NB: ensure file is not open while uploading')),
      hr(),
      # h3('CONSOLE OUTPUT: for debugging failed uploads'),
      # verbatimTextOutput('console_output'),
      # insert console output
      # h3('Table status:'),
      # tableOutput("contents"),
      hr(),
      # h3('Signals:'),
      # DTOutput('signals_table')
      br(),
      
      downloadButton("downloadData", "Download")
    )
    
  )
  
  
)

server <- function(input, output) {
  # Issues with the dataset
  
  
  # Download Button
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("PHI_Report_", Sys.Date(), ".pptx", sep="")
    },
    content = function(file) {
      
      shinyalert::shinyalert(
        title = "Preparing Slides...",
        text = "\nThis may take several minutes",
        closeOnClickOutside = FALSE,
        showConfirmButton = FALSE,
        showCancelButton = FALSE,
        imageUrl = "https://upload.wikimedia.org/wikipedia/commons/7/7a/Ajax_loader_metal_512.gif",
        closeOnEsc = FALSE)
      
      rmarkdown::render(
        'phi_report_files/slides_overall_all_regions.Rmd', 
        output_file=file, 
        params = list(
          product_tracker = input$upload_pt$datapath,
          eios = input$upload_eios$datapath,
          don_tracker = input$upload_don$datapath,
          sig_tracker = input$upload_sig$datapath,
          afro = input$afro_cb,
          amro = input$amro_cb,
          emro = input$emro_cb,
          euro = input$euro_cb,
          searo = input$searo_cb,
          wpro = input$wpro_cb,
          global = input$global_cb))
      
      shinyjs::runjs("swal.close();")
    }
  )
}

shinyApp(ui, server)
