library(graphics)
library(stats)
library(shiny)

data <- read.csv("https://www.wien.gv.at/gogv/l9ogdbevoelkerungbl2017", sep=";",encoding = "UTF-8")
data$FEDERAL_STATE = as.character(data$FEDERAL_STATE)
data$FEDERAL_STATE[data$FEDERAL_STATE=="KÃ¤rnten"]="Carinthia"
data$FEDERAL_STATE[data$FEDERAL_STATE=="NiederÃ¶sterreich"]="Lower Austria"
data$FEDERAL_STATE[data$FEDERAL_STATE=="OberÃ¶sterreich"]="Upper Austria"
data$FEDERAL_STATE[data$FEDERAL_STATE=="Steiermark"]="Styria"
data$FEDERAL_STATE[data$FEDERAL_STATE=="Tirol"]="Tyrol"
data$FEDERAL_STATE[data$FEDERAL_STATE=="Wien"]="Vienna"

shinyServer(function(input, output) {
        output$plot1<-renderPlot({
                set.seed(123)
                
                if(input$dataset1==""){
                        jahre <- unique(data$YEAR[which(data$YEAR>=input$slider2[1]&data$YEAR<=input$slider2[2])])
                        datensatz = rep(0,length(jahre))
                        xlab<-ifelse(input$show_xlab,"Considered years","")
                        ylab<-ifelse(input$show_ylab,"Number of Inhabitants","")
                        main<-ifelse(input$show_title,"Development of Austria`s inhabitants separated by provencial states","")
                        barplot(datensatz,xlab = xlab,ylab = ylab, main = main, names.arg=jahre,ylim = c(0,2100000))
                }
                else {
                datensatz <- unique(data$POPULATION[which(data$FEDERAL_STATE==input$dataset1&data$YEAR>=input$slider2[1]&data$YEAR<=input$slider2[2])])
                jahre <- unique(data$YEAR[which(data$YEAR>=input$slider2[1]&data$YEAR<=input$slider2[2])])
               xlab<-ifelse(input$show_xlab,"Considered years","")
                ylab<-ifelse(input$show_ylab,"Number of Inhabitants","")
                main<-ifelse(input$show_title,"Development of Austria`s inhabitants separated by provencial states","")
                barplot(datensatz,xlab = xlab,ylab = ylab, main = main, names.arg=jahre,ylim = c(0,2100000))}
        })
        output$meanOut<-renderText({
                set.seed(123)
                poisson_his<-rpois(input$samples,input$lambda)
                mean(poisson_his)
        })
        output$sdOut<-renderText({
                set.seed(123)
                datensatz <- unique(data$POPULATION[which(data$FEDERAL_STATE==input$dataset1&data$YEAR>=input$slider2[1]&data$YEAR<=input$slider2[2])])

        })
        
        output$help <- renderText({
        "This simple application shows the development of Austrian inhabitants over a period of 30 years.
        The app is quite simple to use.
        The drop-down list on the top includes all provincial states in Austria.
        You can choose for which provincial state you want to see de inhabitant’s development.
        With the slider below, it is possible to define the period, which you want to look at.
        The result of your choice is visualised within the barplot in the main window."
        })
        
})
