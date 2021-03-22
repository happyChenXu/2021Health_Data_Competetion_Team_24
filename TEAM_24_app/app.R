#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#-------- install packages and load package----------
#### Package rdom is not on CRAN but on Github
library("remotes") # download package from github
# install_github("https://github.com/cpsievert/rdom/")
library("rdom")
# install.packages("rvest")
# install.packages("RCurl")
library("rvest")  # For web scraping
library("RCurl")  # For web scraping
library("xml2") # For web scraping
library("dplyr") # For data processing
library("stringr")
# install.packages("xlsx")
library("xlsx") 
library("data.table")

# install_github("Displayr/flipAPI")
library("flipAPI")
# install.packages(c("httr", "jsonlite"))
library("httr")
library("jsonlite") # For API
library("plotly")
library(shiny)
library(tidyverse)


# ----------- dataset ---------------------
#------- COVID-19 Community Profile Report - County-Level --------
# Use API to get the latest dataset
# County_US_COVID<- getURL('https://healthdata.gov/resource/di4u-7yu6.csv', ssl.verifyhost=FALSE, ssl.verifypeer=FALSE)
# County_US_COVID<- read.csv(textConnection(County_US_COVID),header=T)
# write.csv(County_US_COVID,"County_US_COVID_03202021.csv")

# -------- Minnesota Population data ------------

## Source https://www.census.gov/data/tables/time-series/demo/popest/2010s-counties-detail.html
# download.file('https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/asrh/cc-est2019-alldata-27.csv', dest = "Population_by_Selected_All2010_2019.csv")
# Population_by_Selected_All <- read.csv("Population_by_Selected_All2010_2019.csv", header=T)
#--------- Minnesota vaccine data----------------

## Source https://mn.gov/covid19/vaccine/data/index.jsp

# The dataset in the folder is before March 20, use the R code to get the most updated datasets

### People Vaccinated, by County
# download data
# download.file("https://mn.gov/covid19/assets/People%20Vaccinated%2C%20By%20County_tcm1148-467651.csv", dest = "People_by_County03212021.csv")
# People_by_County <- read.csv("People_by_County03212021.csv", header=T)


### Vaccinations by Race and Ethnicity
# download data
# download.file("https://mn.gov/covid19/assets/Vaccinations%20by%20Race%20and%20Ethnicity_tcm1148-470631.csv",dest="Vaccinations_by_Race_and_Ethnicity03212021.csv")
# Vaccinations_by_Race_and_Ethnicity<- read.csv("Vaccinations_by_Race_and_Ethnicity03212021.csv", header=T)

# -----read dataset--------
County_US_COVID<- read.csv("County_US_COVID_03202021.csv", header=T)
Population_by_Selected_All <- read.csv("Population_by_Selected_All2010_2019.csv", header=T)
People_by_County <- read.csv("People_by_County03212021.csv", header=T)
Vaccinations_by_Race_and_Ethnicity<- read.csv("Vaccinations_by_Race_and_Ethnicity03212021.csv", header=T)


# -------Data processing for Population_by_Selected_All--------
Population_by_Selected_All_2019 <-Population_by_Selected_All[which(Population_by_Selected_All$YEAR==10),]



### choose total
Population_by_Selected_All_2019_total_population <- Population_by_Selected_All_2019[which(Population_by_Selected_All_2019$AGEG==0),]

### select all useful variables in age group 0 (that is total population)

Organized_MN_population <-Population_by_Selected_All_2019_total_population%>%select(-"SUMLEV",-"STATE",-"COUNTY",-"STNAME",-"YEAR",-"AGEGRP")


### The variables I am interested in
## "TOT_POP","TOT_MALE","TOT_FEMALE","WA_MALE","WA_FEMALE","BA_MALE","BA_FEMALE","IA_MALE","IA_FEMALE","AA_MALE","AA_FEMALE","NA_MALE","NA_FEMALE"


### choose county name
county_name <- names(table(Population_by_Selected_All_2019$CTYNAME))
Organized_MN_population$county <- Organized_MN_population$CTYNAME


### establish total population for each age group

## establish a matrix
nrow <- length(Organized_MN_population$county)
Matrix <-matrix(nrow=18,ncol=nrow) 

# --------set age---------
## Age 0 to 4 years
Matrix[1,]<-Organized_MN_population$age_0_4 <- Population_by_Selected_All_2019[which(Population_by_Selected_All_2019$AGEGRP==1),]$TOT_POP
## Age 5 to 9 years
Matrix[2,]<-Organized_MN_population$age_5_9 <- Population_by_Selected_All_2019[which(Population_by_Selected_All_2019$AGEGRP==2),]$TOT_POP
## Age 10 to 14 years
Matrix[3,]<-Organized_MN_population$age_10_14 <- Population_by_Selected_All_2019[which(Population_by_Selected_All_2019$AGEGRP==3),]$TOT_POP
## Age 15 to 19 years
Matrix[4,]<-Organized_MN_population$age_15_19 <- Population_by_Selected_All_2019[which(Population_by_Selected_All_2019$AGEGRP==4),]$TOT_POP
## Age 20 to 24 years
Matrix[5,]<-Organized_MN_population$age_20_24 <- Population_by_Selected_All_2019[which(Population_by_Selected_All_2019$AGEGRP==5),]$TOT_POP
## Age 25 to 29 years
Matrix[6,]<-Organized_MN_population$age_25_29 <- Population_by_Selected_All_2019[which(Population_by_Selected_All_2019$AGEGRP==6),]$TOT_POP
## Age 30 to 34 years
Matrix[7,]<-Organized_MN_population$age_30_34 <- Population_by_Selected_All_2019[which(Population_by_Selected_All_2019$AGEGRP==7),]$TOT_POP
## Age 35 to 39 years
Matrix[8,]<-Organized_MN_population$age_35_39 <- Population_by_Selected_All_2019[which(Population_by_Selected_All_2019$AGEGRP==8),]$TOT_POP
## Age 40 to 44 years
Matrix[9,]<-Organized_MN_population$age_0_4 <- Population_by_Selected_All_2019[which(Population_by_Selected_All_2019$AGEGRP==9),]$TOT_POP
## Age 45 to 49 years
Matrix[10,]<-Organized_MN_population$age_45_49 <- Population_by_Selected_All_2019[which(Population_by_Selected_All_2019$AGEGRP==10),]$TOT_POP
## Age 50 to 54 years
Matrix[11,]<-Organized_MN_population$age_0_4 <- Population_by_Selected_All_2019[which(Population_by_Selected_All_2019$AGEGRP==11),]$TOT_POP
## Age 55 to 59 years
Matrix[12,]<-Organized_MN_population$age_55_59 <- Population_by_Selected_All_2019[which(Population_by_Selected_All_2019$AGEGRP==12),]$TOT_POP
## Age 60 to 64 years
Matrix[13,]<-Organized_MN_population$age_60_64 <- Population_by_Selected_All_2019[which(Population_by_Selected_All_2019$AGEGRP==13),]$TOT_POP
## Age 65 to 69 years
Matrix[14,]<-Organized_MN_population$age_65_69 <- Population_by_Selected_All_2019[which(Population_by_Selected_All_2019$AGEGRP==14),]$TOT_POP
## Age 70 to 74 years
Matrix[15,]<-Organized_MN_population$age_70_74 <- Population_by_Selected_All_2019[which(Population_by_Selected_All_2019$AGEGRP==15),]$TOT_POP
## Age 75 to 79 years
Matrix[16,]<-Organized_MN_population$age_75_79 <- Population_by_Selected_All_2019[which(Population_by_Selected_All_2019$AGEGRP==16),]$TOT_POP
## Age 80 to 84 years
Matrix[17,]<-Organized_MN_population$age_80_84 <- Population_by_Selected_All_2019[which(Population_by_Selected_All_2019$AGEGRP==17),]$TOT_POP
## Age 85 years or older
Matrix[18,]<-Organized_MN_population$age_85_<- Population_by_Selected_All_2019[which(Population_by_Selected_All_2019$AGEGRP==18),]$TOT_POP
# ---------divide age group---------
### now we can use Matrix to divide our age

### First try divide by 65


Organized_MN_population$age_0_65 <- rowSums(t(Matrix[1:13,]))

Organized_MN_population$age_65_ <- rowSums(t(Matrix[14:18,]))



# ---------Merge datasets and data processing----------------

### People_by_County
### Population_by_Selected_All
### County_US_COVID

# choose 2019 population of counties data

Population_by_Selected_All_2019 <-Population_by_Selected_All[which(Population_by_Selected_All$YEAR==10),]
write.csv(Population_by_Selected_All_2019,"Population_by_Selected_All_2019.csv")
### Select MN from County_US_COVID 

County_COVID_MN <- County_US_COVID[which(County_US_COVID$state=="MN"),]




### First turn uppercase to lowercase for People_by_County
People_by_County$County <-tolower(People_by_County$County)
County_COVID_MN$county <-tolower(County_COVID_MN$county)
### delete all the extra words
County_COVID_MN$County <-str_sub(County_COVID_MN$county, end = -12)

### Merge People_by_County and County_COVID_MN

merge_People_by_County_County_COVID_MN <-merge(County_COVID_MN,People_by_County,by="County")

#--------merge final_data_29 and reservation status----------


reservation <-c(0,0,1,1,0,0,0,0,1,0,1,0,0,0,1,1,0,0,0,0,0,0,0,0,1,0,0,0,1,0,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1)
Organized_MN_population$reservation <-reservation



#---------each agegrp meaning-----
# The key for AGEGRP is as follows: 0 = Total 1 = Age 0 to 4 years 2 = Age 5 to 9 years 3 = Age 10 to 14 years 4 = Age 15 to 19 years 5 = Age 20 to 24 years 6 = Age 25 to 29 years 7 = Age 30 to 34 years 8 = Age 35 to 39 years 9 = Age 40 to 44 years 10 = Age 45 to 49 years 11 = Age 50 to 54 years 12 = Age 55 to 59 years 13 = Age 60 to 64 years 14 = Age 65 to 69 years 15 = Age 70 to 74 years 16 = Age 75 to 79 years 17 = Age 80 to 84 years 18 = Age 85 years or older


#--------merge Organized_MN_population and merge_People_by_County_County_COVID_MN----------


Organized_MN_population$County <- tolower(str_sub(Organized_MN_population$county,end =-8))

### 29 data points
final_data_29 <- merge(Organized_MN_population,merge_People_by_County_County_COVID_MN,by="County")
dim(final_data_29)
# --------Merge two datasets and use all points------
final_data_87 <-merge(People_by_County,Organized_MN_population,by="County")
dim(final_data_87)

# ----------------data processing final_data_29-------------------------
### Choose interesting variables

# county
# select "County" directly

# percentage of vaccine at least one dose
final_data_29$People.with.at.least.one.vaccine.dose.percentage <- 100*final_data_29$People.with.at.least.one.vaccine.dose/final_data_29$TOT_POP

# percentage of 65+
final_data_29$percentage_age_65_ <- 100*final_data_29$age_65_/final_data_29$TOT_POP
#View(final_data_29)

final_data_29$percentage_age_65_ <- 100*final_data_29$age_65_/final_data_29$TOT_POP

# reservation staus

# select "reservation" directly

### Select the variables

final_data_29_select <- final_data_29%>%select("County","People.with.at.least.one.vaccine.dose.percentage","percentage_age_65_","reservation","total_cases","total_deaths") 

final_data_29_select$reservation <- as.factor(final_data_29_select$reservation)

# --------Merge two datasets and use all points------
final_data_87 <-merge(People_by_County,Organized_MN_population,by="County")
# ----------------data processing final_data_87-------------------------
### Choose interesting variables

# county
# select "County" directly

# percentage of vaccine at least one dose
final_data_87$People.with.at.least.one.vaccine.dose.percentage <- 100*final_data_87$People.with.at.least.one.vaccine.dose/final_data_87$TOT_POP

# percentage of 65+
final_data_87$percentage_age_65_ <- 100*final_data_87$age_65_/final_data_87$TOT_POP
#View(final_data_87)

#test <- final_data_29%>%select("County","People.with.at.least.one.vaccine.dose","TOT_POP","reservation") 
#View(test)
# percentage of whites
final_data_87$percentage_age_65_ <- 100*final_data_87$age_65_/final_data_87$TOT_POP

# reservation staus

# select "reservation" directly

### Select the variables

final_data_87_select <- final_data_87%>%select("County","People.with.at.least.one.vaccine.dose.percentage","percentage_age_65_","reservation") 

#final_data_29_select $reservation <- as.factor(final_data_29_select $reservation)


#----------plot of indigenous and other races---------

## change character into number

Vaccinations_by_Race_and_Ethnicity$Black.African.American <- as.numeric(str_sub(Vaccinations_by_Race_and_Ethnicity$Black.African.American,end =-2))
Vaccinations_by_Race_and_Ethnicity$White <- as.numeric(str_sub(Vaccinations_by_Race_and_Ethnicity$White,end =-2))
Vaccinations_by_Race_and_Ethnicity$American.Indian <- as.numeric(str_sub(Vaccinations_by_Race_and_Ethnicity$American.Indian,end =-2))
Vaccinations_by_Race_and_Ethnicity$Asian.Pacific.Islander <- as.numeric(str_sub(Vaccinations_by_Race_and_Ethnicity$Asian.Pacific.Islander,end =-2))
Vaccinations_by_Race_and_Ethnicity$Multiracial<- as.numeric(str_sub(Vaccinations_by_Race_and_Ethnicity$Multiracia,end =-2))
Vaccinations_by_Race_and_Ethnicity$Hispanic<- as.numeric(str_sub(Vaccinations_by_Race_and_Ethnicity$Hispanic,end =-2))

# ------### 65+--------


Vaccinations_by_Race_and_Ethnicity_65_onedose <-filter(Vaccinations_by_Race_and_Ethnicity, Age.group == "65+" & case_definition == 'At least one vaccine dose')


## set plotly axis
axis_x <- list( showgrid = TRUE,   # 是否显示网格线
                zeroline = TRUE,   # 是否绘制x=0,y=0的直线
                nticks = 10 ,      # 坐标轴刻度的最大数目
                showline = TRUE ,  # 是否绘制绘图区边框
                title = 'week (start from the first week of 2021)',
                mirror = 'all')

axis_y <- list( showgrid = TRUE,   # 是否显示网格线
                zeroline = TRUE,   # 是否绘制x=0,y=0的直线
                nticks = 20 ,      # 坐标轴刻度的最大数目
                showline = FALSE , # 是否绘制绘图区边框
                title = 'Vaccinations Percentage(%)',
                mirror = 'all')

# find one point weird and replace it with the mean value nearby two points
Vaccinations_by_Race_and_Ethnicity_65_onedose$Black <-Vaccinations_by_Race_and_Ethnicity_65_onedose$Black.African.American
Vaccinations_by_Race_and_Ethnicity_65_onedose$Black[7] <- (Vaccinations_by_Race_and_Ethnicity_65_onedose$Black[6]+Vaccinations_by_Race_and_Ethnicity_65_onedose$Black[8])/2



## assign color
final_data_87_select$color <- rep("red",87)
final_data_87_select[which(final_data_87_select$reservation==1),]$color <- (as.matrix(rep("blue",dim(final_data_87_select[which(final_data_87_select$reservation==1),])[1])))
final_data_87_select$reservation <- factor(final_data_87_select$reservation)

final_data_87_select$reservation2 <- final_data_87_select$reservation
final_data_87_select$reservation2 <-as.character(final_data_87_select$reservation2 )
final_data_87_select$reservation2[which(final_data_87_select$reservation==1)] <- 'Reservation Yes'
final_data_87_select$reservation2[which(final_data_87_select$reservation==0)] <- "Reservation No"

## set plotly axis
axis_x_1 <- list(showgrid = TRUE,   # 是否显示网格线
                 zeroline = TRUE,   # 是否绘制x=0,y=0的直线
                 nticks = 10 ,      # 坐标轴刻度的最大数目
                 showline = TRUE ,  # 是否绘制绘图区边框
                 title = 'Percentage of Age 65+',
                 mirror = 'all')

axis_y_1 <- list( showgrid = TRUE,   # 是否显示网格线
                  zeroline = TRUE,   # 是否绘制x=0,y=0的直线
                  nticks = 20 ,      # 坐标轴刻度的最大数目
                  showline = FALSE , # 是否绘制绘图区边框
                  title = 'Vaccinations Percentage % (at least one dose)',
                  mirror = 'all')
#------------Data  Analysis base on all counties---------
mod2 <- lm(People.with.at.least.one.vaccine.dose.percentage~percentage_age_65_,data=final_data_87_select)
summary(mod2)

## set plotly axis
axis_x_1 <- list(showgrid = TRUE,   # 是否显示网格线
                 zeroline = TRUE,   # 是否绘制x=0,y=0的直线
                 nticks = 10 ,      # 坐标轴刻度的最大数目
                 showline = TRUE ,  # 是否绘制绘图区边框
                 title = 'Percentage of Age 65+',
                 mirror = 'all')

axis_y_1 <- list( showgrid = TRUE,   # 是否显示网格线
                  zeroline = TRUE,   # 是否绘制x=0,y=0的直线
                  nticks = 20 ,      # 坐标轴刻度的最大数目
                  showline = FALSE , # 是否绘制绘图区边框
                  title = 'Vaccinations Percentage % (at least one dose)',
                  mirror = 'all')
# model it

mod_29 <- lm( People.with.at.least.one.vaccine.dose.percentage~percentage_age_65_,data=final_data_29_select)

final_data_29_select$reservation2 <- final_data_29_select$reservation
final_data_29_select$reservation2 <-as.character(final_data_29_select$reservation2 )
final_data_29_select$reservation2[which(final_data_29_select$reservation==1)] <- 'Reservation Yes'
final_data_29_select$reservation2[which(final_data_29_select$reservation==0)] <- "Reservation No"
# -------shiny app------------

ui <- fluidPage(
    # App title ----
    titlePanel("TEAM 24 data visualization --- Vaccination Percentage among MN counties"),
    
    # Sidebar layout with input and output definitions ----
    
    # Main panel for displaying outputs ----
    mainPanel(
        
        # Output: Tabset w/ plot, summary, and table ----
        tabsetPanel(type = "tabs",
                    tabPanel("All Minnesota Counties", plotlyOutput("All")),
                    tabPanel("Minnesota Counties contained in community profile", plotlyOutput("Part")),
                    tabPanel("Timeseries different race in 65+ ", plotlyOutput("Race"))
                    
        )
        
    ),
    sidebarPanel(
        
        # Input: Selector for the third variable to plot  ----
        selectInput("variable", "Choose the third Variable:",
                    c("Reservation" = "Reservation",
                      "Population" = "Population",
                      "Percentage of ethnically white Americans"="White",
                      "Total COVID deaths      (Only available for Counties contained in community profile)" = "deaths" ,
                      "Total COVID cases       (Only available for Counties contained in community profile)"="cases"  )
                       
                    )
        
       
        
    ),
)





server <- function(input, output, session){
    
    output$Race  <- renderPlotly({

        Vaccinations_by_Race_and_Ethnicity_65_onedose[1:10,] %>% 
            plot_ly(x = ~week )%>% 
            add_lines(y = ~Black,color='Black.African.American') %>% 
            add_lines(y = ~White,color='White') %>% 
            add_lines(y = ~American.Indian,color='American.Indian')%>% 
            add_lines(y = ~Asian.Pacific.Islander,color='Asian.Pacific.Islander')%>% 
            add_lines(y = ~Multiracial,color='Multiracial')%>% 
            add_lines(y = ~Hispanic,color='Hispanic')%>% layout(xaxis = axis_x)%>% layout(yaxis = axis_y)%>%
            layout(title = 'Age group 65+')
        
    })

        output$All <- renderPlotly({
            if(input$variable=="Reservation"){
            final_data_87_select %>% 
                plot_ly(x = ~percentage_age_65_ ,text = ~County)%>% 
                add_markers(y = ~People.with.at.least.one.vaccine.dose.percentage,color =~reservation2) %>% 
                add_lines(x = ~percentage_age_65_, y = fitted(mod2),color="fitted line")%>% layout(xaxis = axis_x_1)%>% layout(yaxis = axis_y_1)
            }
            else{
            if(input$variable=="White"){
                
                final_data_87_select$white_percentage <- 100*(final_data_87$WA_MALE+final_data_87$WA_FEMALE)/final_data_87$TOT_POP
                final_data_87_select %>% 
                    plot_ly(x = ~percentage_age_65_ ,text = ~County)%>% 
                    add_markers(y = ~People.with.at.least.one.vaccine.dose.percentage,color="size represent relative white percentage",size =~white_percentage-40) %>% 
                    add_lines(x = ~percentage_age_65_, y = fitted(mod2),color="fitted line")%>% layout(xaxis = axis_x_1)%>% layout(yaxis = axis_y_1)%>%
                    layout(title = 'Percentage of Age 65+ vs Vaccinations Percentage with white precentage')
                
                
            }
                else{
            if(input$variable=="Population"){
                
                final_data_87_select$Total.population <- final_data_87$TOT_POP
                final_data_87_select %>% 
                    plot_ly(x = ~percentage_age_65_ ,text = ~County)%>% 
                    add_markers(y = ~People.with.at.least.one.vaccine.dose.percentage,color="size represent relative population",size=~Total.population) %>% 
                    add_lines(x = ~percentage_age_65_, y = fitted(mod2),color="fitted line")%>% layout(xaxis = axis_x_1)%>% layout(yaxis = axis_y_1)%>%
                    layout(title = 'Percentage of Age 65+ vs Vaccinations Percentage with total population')
                
            }
                }
                }
            #%>%layout(title = 'Percentage of Age 65+ vs Vaccinations Percentage (at least one dose) of Minnesota Counties')
            
            #plot_ly(data=proj,x=x,y=y,color=proj$color)
            #plot_ly(iris, x = ~get(input$choice), y = ~Sepal.Length, type = 'scatter', mode = 'markers')
        })
        output$Part <- renderPlotly({
            if(input$variable=="Reservation"){
                final_data_29_select %>% 
                    plot_ly(x = ~percentage_age_65_ ,text = ~County)%>% 
                    add_markers(y = ~People.with.at.least.one.vaccine.dose.percentage,color =~reservation2) %>% 
                    add_lines(x = ~percentage_age_65_, y = fitted(mod_29),color="fitted line")%>% layout(xaxis = axis_x_1)%>% layout(yaxis = axis_y_1)
            }
            else{
                if(input$variable=="White"){
                    
                    final_data_29_select$white_percentage <- 100*(final_data_29$WA_MALE+final_data_29$WA_FEMALE)/final_data_29$TOT_POP
                    final_data_29_select %>% 
                        plot_ly(x = ~percentage_age_65_ ,text = ~County)%>% 
                        add_markers(y = ~People.with.at.least.one.vaccine.dose.percentage,color="size represent relative white percentage",size =~white_percentage-40) %>% 
                        add_lines(x = ~percentage_age_65_, y = fitted(mod_29),color="fitted line")%>% layout(xaxis = axis_x_1)%>% layout(yaxis = axis_y_1)%>%
                        layout(title = 'Percentage of Age 65+ vs Vaccinations Percentage with white precentage')
                    
                    
                }
                else{
                    if(input$variable=="Population"){
                        
                        final_data_29_select$Total.population <- final_data_29$TOT_POP
                        final_data_29_select %>% 
                            plot_ly(x = ~percentage_age_65_ ,text = ~County)%>% 
                            add_markers(y = ~People.with.at.least.one.vaccine.dose.percentage,color="size represent relative population",size=~Total.population) %>% 
                            add_lines(x = ~percentage_age_65_, y = fitted(mod_29),color="fitted line")%>% layout(xaxis = axis_x_1)%>% layout(yaxis = axis_y_1)%>%
                            layout(title = 'Percentage of Age 65+ vs Vaccinations Percentage with total population')
                        
                    }
                    else{
                        if(input$variable=="deaths"){
                            mod_29 <- lm( People.with.at.least.one.vaccine.dose.percentage~percentage_age_65_,data=final_data_29_select)
                            
                            
                            # plot it
                            final_data_29_select %>% 
                                plot_ly(x = ~percentage_age_65_ ,text = ~County)%>% 
                                add_markers(y = ~People.with.at.least.one.vaccine.dose.percentage,color="size represent relative total_deaths",size=~total_deaths) %>% 
                                add_lines(x = ~percentage_age_65_, y = fitted(mod_29),color="fitted line")%>% layout(xaxis = axis_x_1)%>% layout(yaxis = axis_y_1)%>%
                                layout(title = 'Percentage of Age 65+ vs Vaccinations Percentage with total deaths')
                            
                            
                        }
                        else{
                            if(input$variable=="cases"){
                                mod_29 <- lm( People.with.at.least.one.vaccine.dose.percentage~percentage_age_65_,data=final_data_29_select)
                                final_data_29_select %>% 
                                    plot_ly(x = ~percentage_age_65_ ,text = ~County)%>% 
                                    add_markers(y = ~People.with.at.least.one.vaccine.dose.percentage,color="size represent relative total_cases",size=~total_cases) %>% 
                                    add_lines(x = ~percentage_age_65_, y = fitted(mod_29),color="fitted line")%>% layout(xaxis = axis_x_1)%>% layout(yaxis = axis_y_1)%>%
                                    layout(title = 'Percentage of Age 65+ vs Vaccinations Percentage with total cases')
                            }
                        }
                    }
                }
            }
            #%>%layout(title = 'Percentage of Age 65+ vs Vaccinations Percentage (at least one dose) of Minnesota Counties')
            
            #plot_ly(data=proj,x=x,y=y,color=proj$color)
            #plot_ly(iris, x = ~get(input$choice), y = ~Sepal.Length, type = 'scatter', mode = 'markers')
        })
    
    
}

shinyApp(ui, server)