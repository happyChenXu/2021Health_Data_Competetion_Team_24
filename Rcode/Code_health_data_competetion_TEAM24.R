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


#---------Download data and dataset--------

# ----------healthgov Provided dataset-------

## COVID-19 Reported Patient Impact and Hospital Capacity by Facility

# Use API to get the latest dataset
facility<- getURL('https://healthdata.gov/resource/anag-cw7u.csv', ssl.verifyhost=FALSE, ssl.verifypeer=FALSE)
facility_table<- read.csv(textConnection(facility),header=T)
write.csv(facility_table,"hospital_facility_03202021.csv")

## COVID-19 Community Profile Report - County-Level 
# Use API to get the latest dataset
County_US_COVID<- getURL('https://healthdata.gov/resource/di4u-7yu6.csv', ssl.verifyhost=FALSE, ssl.verifypeer=FALSE)
County_US_COVID<- read.csv(textConnection(County_US_COVID),header=T)
write.csv(County_US_COVID,"County_US_COVID_03202021.csv")



# -------- Minnesota Population data ------------

## Source https://mn.gov/admin/demography/data-by-topic/population-data/our-estimates/
population <-DownloadXLSX('https://mn.gov/admin/assets/mn_county_estimates_sdc_2019_tcm36-442553.xlsx')
write.csv(population,"MN_population.csv")
## Source https://www.census.gov/data/tables/time-series/demo/popest/2010s-counties-detail.html
download.file('https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/asrh/cc-est2019-agesex-27.csv', dest = "Population_by_Selected_Age_Sex2010_2019.csv")
Population_by_Selected_Age_Sex <- read.csv("Population_by_Selected_Age_Sex2010_2019.csv", header=T)

download.file('https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/asrh/cc-est2019-alldata-27.csv', dest = "Population_by_Selected_All2010_2019.csv")
Population_by_Selected_All <- read.csv("Population_by_Selected_All2010_2019.csv", header=T)

# View(Population_by_Selected_All)
#--------- Minnesota vaccine data----------------

## Source https://mn.gov/covid19/vaccine/data/index.jsp

# The dataset in the folder is before March 20, use the R code to get the most updated datasets

### Doses Administered, Total
# download data
download.file('https://mn.gov/covid19/assets/Doses%20Administered_tcm1148-462846.csv', dest = "Doses_Total03212021.csv")
Doses_Total <- read.csv("Doses_Total03212021.csv", header=T)


### Doses Administered, by Week
# download data
download.file("https://mn.gov/covid19/assets/Doses%20Administered%20By%20Week_tcm1148-462844.csv", dest = "Doses_by_week03212021.csv")
Doses_by_week <- read.csv("Doses_by_week03212021.csv", header=T)


### Doses Administered, by Age
# download data
download.file("https://mn.gov/covid19/assets/Doses%20Administered%20By%20Age_tcm1148-462840.csv", dest = "Doses_by_Age03212021.csv")
Doses_by_age <- read.csv("Doses_by_Age03212021.csv", header=T)



### Doses Administered, by Gender
# download data
download.file("https://mn.gov/covid19/assets/Doses%20Administered%20By%20Gender_tcm1148-462841.csv", dest = "Doses_by_Gender03212021.csv")
Doses_by_gender <- read.csv("Doses_by_gender03212021.csv", header=T)


### Doses Administered, by Provider
# download data
download.file("https://mn.gov/covid19/assets/Doses%20Administered%20By%20Provider_tcm1148-462843.csv", dest = "Doses_by_Provider03212021.csv")
Doses_by_provider <- read.csv("Doses_by_Provider03212021.csv", header=T)


### People Vaccinated, by County
# download data
download.file("https://mn.gov/covid19/assets/People%20Vaccinated%2C%20By%20County_tcm1148-467651.csv", dest = "People_by_County03212021.csv")
People_by_County <- read.csv("People_by_County03212021.csv", header=T)

### People Vaccinated, by Age
# download data
download.file("https://mn.gov/covid19/assets/People%20Vaccinated%2C%20By%20Age_tcm1148-467653.csv", dest = "People_by_Age03212021.csv")
People_by_Age <- read.csv("People_by_Age03212021.csv", header=T)

### People Vaccinated, by Gender
# download data
download.file("https://mn.gov/covid19/assets/People%20Vaccinated%2C%20By%20Gender_tcm1148-467652.csv", dest = "People_by_Gender03212021.csv")
People_by_Gender <- read.csv("People_by_Gender03212021.csv", header=T)

### Doses Shipped to Minnesota Providers, by Vaccine Product
# download data
download.file("https://mn.gov/covid19/assets/Doses%20shipped%20to%20Minnesota%20providers%2C%20by%20product_tcm1148-462877.csv", dest = "Doses_Shipped_by_Product_MN03212021.csv")
Doses_Shipped_by_Product_MN <- read.csv("Doses_Shipped_by_Product_MN03212021.csv", header=T)


### Doses Shipped to Minnesota Providers, by Vaccine Product
# download data
download.file("https://mn.gov/covid19/assets/Doses%20shipped%20for%20CDC%20federal%20pharmacy%20program%2C%20by%20product_tcm1148-468518.csv", dest = "Doses_Shipped_by_Product03212021.csv")
Doses_Shipped_by_Product <- read.csv("Doses_Shipped_by_Product03212021.csv", header=T)

### Provider Sites Receiving Vaccines, by Type
# download data
download.file("https://mn.gov/covid19/assets/Provider%20sites%20receiving%20vaccines_tcm1148-462878.csv", dest = "Provider_by_Type03212021.csv")
Provider_by_Type <- read.csv("Provider_by_Type03212021.csv", header=T)

### Percentage of Doses Administered by Providers, 3-Day Goal 
# download data
download.file("https://mn.gov/covid19/assets/Percentage%20of%20Doses%20Administered%20By%20Providers%2C%203-Day%20Goal_tcm1148-464242.csv", dest = "Percentage_Doses_by_Providers_3Days03212021.csv")
Percentage_Doses_by_Providers_3Days <- read.csv("Percentage_Doses_by_Providers_3Days03212021.csv", header=T)

### Percentage of Doses Administered by Providers, 7-Day Goal 
# download data
download.file("https://mn.gov/covid19/assets/Percentage%20of%20Doses%20Administered%20By%20Providers%2C%207-Day%20Goal_tcm1148-464243.csv",dest = "Percentage_Doses_by_Providers_7Days03212021.csv")
Percentage_Doses_by_Providers_7Days<- read.csv("Percentage_Doses_by_Providers_7Days03212021.csv", header=T)

### People 50+ with at Least One Vaccine Dose, Percent of Age Group Population
# download data
download.file("https://mn.gov/covid19/assets/People%2050%20with%20at%20least%20one%20vaccine%20dose%2C%20Percent%20of%20Age%20Group%20Population_tcm1148-464265.csv",dest="People_50_one_Dose_by_Age03212021.csv")
People_50_one_Dose_by_Age<- read.csv("People_50_one_Dose_by_Age03212021.csv", header=T)

### People by Gender with a Least One Vaccine Dose, Percent of Gender Group Population
# download data
download.file("https://mn.gov/covid19/assets/People%20By%20Gender%20with%20at%20least%20one%20vaccine%20dose%2C%20Percent%20of%20Gender%20Group%20Population_tcm1148-464287.csv",dest="People_one_Dose_by_Gender03212021.csv")
People_one_Dose_by_Gender<- read.csv("People_one_Dose_by_Gender03212021.csv", header=T)

### Vaccinations by Race and Ethnicity
# download data
download.file("https://mn.gov/covid19/assets/Vaccinations%20by%20Race%20and%20Ethnicity_tcm1148-470631.csv",dest="Vaccinations_by_Race_and_Ethnicity03212021.csv")
Vaccinations_by_Race_and_Ethnicity<- read.csv("Vaccinations_by_Race_and_Ethnicity03212021.csv", header=T)
View(Vaccinations_by_Race_and_Ethnicity)

### Vaccination Progress to Date, by Race and Ethnicity
# download data
download.file("https://mn.gov/covid19/assets/Vaccination%20Progress%20to%20Date%2C%20by%20Race%20and%20Ethnicity_tcm1148-470630.csv",dest="Vaccinations_by_Race_and_Ethnicity_Progress_to_Date03212021.csv")
Vaccinations_by_Race_and_Ethnicity_Progress_to_Date<- read.csv("Vaccinations_by_Race_and_Ethnicity_Progress_to_Date03212021.csv", header=T)



#---------web scraping zipcode and corresponding county data----------------
#  scrape from https://www.zipcodestogo.com/Minnesota/

# I have downloaded and organized the zipcode dataset, you can directly use that dataset named zipcode_MN, otherwise you can use the code below to web scraping this dataset and organize it.

content <- "https://www.zipcodestogo.com/Minnesota/"
css_selector <- "#leftCol > table"
zipcode <-content %>% 
  read_html() %>% 
  html_node(css = css_selector)%>% 
  html_table(fill=TRUE) %>% 
  as_tibble()
# choose the useful colunms
zipcode <- zipcode[,1:3]
# delete the first useless rows
zipcode_1 <- zipcode[-c(1,2),]
# make the first row the name of columns
colnames(zipcode_1)<-zipcode_1[1,] 
zipcode_2 <- zipcode_1[-1,]
zipcode_MN <- zipcode_2
# export the dataset
write.csv(zipcode_2,"zipcode_MN.csv")




#---------web scraping ----------------
# scrape from https://www.mncompass.org/profiles/county

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


#------------Organize Population_by_Selected_All_2019 dataset----------------


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

#--------merge final_data_27 and reservation status----------


reservation <-c(0,0,1,1,0,0,0,0,1,0,1,0,0,0,1,1,0,0,0,0,0,0,0,0,1,0,0,0,1,0,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1)
Organized_MN_population$reservation <-reservation



#---------each agegrp meaning-----
# The key for AGEGRP is as follows: 0 = Total 1 = Age 0 to 4 years 2 = Age 5 to 9 years 3 = Age 10 to 14 years 4 = Age 15 to 19 years 5 = Age 20 to 24 years 6 = Age 25 to 29 years 7 = Age 30 to 34 years 8 = Age 35 to 39 years 9 = Age 40 to 44 years 10 = Age 45 to 49 years 11 = Age 50 to 54 years 12 = Age 55 to 59 years 13 = Age 60 to 64 years 14 = Age 65 to 69 years 15 = Age 70 to 74 years 16 = Age 75 to 79 years 17 = Age 80 to 84 years 18 = Age 85 years or older


#--------merge Organized_MN_population and merge_People_by_County_County_COVID_MN----------


Organized_MN_population$County <- tolower(str_sub(Organized_MN_population$county,end =-8))

### 27 data points
final_data_29 <- merge(Organized_MN_population,merge_People_by_County_County_COVID_MN,by="County")
dim(final_data_29)

# --------Merge two datasets and use all points------
final_data_87 <-merge(People_by_County,Organized_MN_population,by="County")
dim(final_data_87)

#View(final_data_87)

# ----------------data processing final_data_29-------------------------
### Choose interesting variables

# county
# select "County" directly

# percentage of vaccine at least one dose
final_data_29$People.with.at.least.one.vaccine.dose.percentage <- 100*final_data_29$People.with.at.least.one.vaccine.dose/final_data_29$TOT_POP

# percentage of 65+
final_data_29$percentage_age_65_ <- 100*final_data_29$age_65_/final_data_29$TOT_POP
#View(final_data_29)

test <- final_data_29%>%select("County","People.with.at.least.one.vaccine.dose","TOT_POP","reservation") 
#View(test)
# percentage of whites
final_data_29$percentage_age_65_ <- 100*final_data_29$age_65_/final_data_29$TOT_POP

# reservation staus

# select "reservation" directly

### Select the variables

final_data_29_select <- final_data_29%>%select("County","People.with.at.least.one.vaccine.dose.percentage","percentage_age_65_","reservation") 

final_data_29_select $reservation <- as.factor(final_data_29_select $reservation)
#------------Data Analysis Indigenous-------------------
Vaccinations_by_Race_and_Ethnicity
#------------Data  Analysis base on 29 counties---------

mod1 <- lm(People.with.at.least.one.vaccine.dose.percentage~percentage_age_65_+reservation,data=final_data_29_select)
summary(mod1)

#----------plot Analysis base on 29 counties---------

final_data_29_select %>% 
  plot_ly(x = ~percentage_age_65_ ,text = ~County)%>% 
  add_markers(y = ~People.with.at.least.one.vaccine.dose.percentage) %>% 
  add_lines(x = ~percentage_age_65_, y = fitted(mod1))

## assign color

final_data_29_select[which(final_data_29_select$reservation==0),]$color <- I("red")
rawdata[1:10,]$color <- rep(I("blue"),10)

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

#------------Data  Analysis base on all counties---------

mod2 <- lm(People.with.at.least.one.vaccine.dose.percentage~percentage_age_65_,data=final_data_87_select)
summary(mod2)

#----------plot Analysis base on all counties---------





## assign color
final_data_87_select$color <- rep("red",87)
final_data_87_select[which(final_data_87_select$reservation==1),]$color <- (as.matrix(rep("blue",dim(final_data_87_select[which(final_data_87_select$reservation==1),])[1])))
final_data_87_select$reservation <- factor(final_data_87_select$reservation)
 
final_data_87_select$reservation2 <- final_data_87_select$reservation
final_data_87_select$reservation2 <-as.character(final_data_87_select$reservation2 )
final_data_87_select$reservation2[which(final_data_87_select$reservation==1)] <- 'Yes'
final_data_87_select$reservation2[which(final_data_87_select$reservation==0)] <- "No"
## set plotly axis
axis_x_1 <- list( showgrid = TRUE,   # 是否显示网格线
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
## plot


final_data_87_select %>% 
  plot_ly(x = ~percentage_age_65_ ,text = ~County)%>% 
  add_markers(y = ~People.with.at.least.one.vaccine.dose.percentage,color =~reservation2) %>% 
  add_lines(x = ~percentage_age_65_, y = fitted(mod2),color="fitted line")%>% layout(xaxis = axis_x_1)%>% layout(yaxis = axis_y_1)%>%
  layout(title = 'Percentage of Age 65+ vs Vaccinations Percentage (at least one dose) of Minnesota Counties')


#----------plot of indigenous and other races---------

## change character into number

Vaccinations_by_Race_and_Ethnicity$Black.African.American <- as.numeric(str_sub(Vaccinations_by_Race_and_Ethnicity$Black.African.American,end =-2))
Vaccinations_by_Race_and_Ethnicity$White <- as.numeric(str_sub(Vaccinations_by_Race_and_Ethnicity$White,end =-2))
Vaccinations_by_Race_and_Ethnicity$American.Indian <- as.numeric(str_sub(Vaccinations_by_Race_and_Ethnicity$American.Indian,end =-2))
Vaccinations_by_Race_and_Ethnicity$Asian.Pacific.Islander <- as.numeric(str_sub(Vaccinations_by_Race_and_Ethnicity$Asian.Pacific.Islander,end =-2))
Vaccinations_by_Race_and_Ethnicity$Multiracial<- as.numeric(str_sub(Vaccinations_by_Race_and_Ethnicity$Multiracia,end =-2))
Vaccinations_by_Race_and_Ethnicity$Hispanic<- as.numeric(str_sub(Vaccinations_by_Race_and_Ethnicity$Hispanic,end =-2))

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

# ------### 65+--------


Vaccinations_by_Race_and_Ethnicity_65_onedose <-filter(Vaccinations_by_Race_and_Ethnicity, Age.group == "65+" & case_definition == 'At least one vaccine dose')

## plot

Vaccinations_by_Race_and_Ethnicity_65_onedose[1:10,] %>% 
  plot_ly(x = ~week )%>% 
  add_lines(y = ~Black.African.American,color='Black.African.American') %>% 
  add_lines(y = ~White,color='White') %>% 
  add_lines(y = ~American.Indian,color='American.Indian')%>% 
  add_lines(y = ~Asian.Pacific.Islander,color='Asian.Pacific.Islander')%>% 
  add_lines(y = ~Multiracial,color='Multiracial')%>% 
  add_lines(y = ~Hispanic,color='Hispanic')%>% layout(xaxis = axis_x)%>% layout(yaxis = axis_y)%>%
  layout(title = 'Week vs Vaccinations Percentage for age group 65+')

# find one point weird and replace it with the mean value nearby two points

Vaccinations_by_Race_and_Ethnicity_65_onedose$Black <-Vaccinations_by_Race_and_Ethnicity_65_onedose$Black.African.American
Vaccinations_by_Race_and_Ethnicity_65_onedose$Black[7] <- (Vaccinations_by_Race_and_Ethnicity_65_onedose$Black[6]+Vaccinations_by_Race_and_Ethnicity_65_onedose$Black[8])/2
Vaccinations_by_Race_and_Ethnicity_65_onedose[1:10,] %>% 
  plot_ly(x = ~week )%>% 
  add_lines(y = ~Black,color='Black.African.American') %>% 
  add_lines(y = ~White,color='White') %>% 
  add_lines(y = ~American.Indian,color='American.Indian')%>% 
  add_lines(y = ~Asian.Pacific.Islander,color='Asian.Pacific.Islander')%>% 
  add_lines(y = ~Multiracial,color='Multiracial')%>% 
  add_lines(y = ~Hispanic,color='Hispanic')%>% layout(xaxis = axis_x)%>% layout(yaxis = axis_y)%>%
  layout(title = 'Week vs Vaccinations Percentage for age group 65+')


# ------### 45-64--------


Vaccinations_by_Race_and_Ethnicity_45_64_onedose <-filter(Vaccinations_by_Race_and_Ethnicity, Age.group == "45-64" & case_definition == 'At least one vaccine dose')


Vaccinations_by_Race_and_Ethnicity_45_64_onedose[1:10,] %>% 
  plot_ly(x = ~week )%>% 
  add_lines(y = ~Black.African.American,color='Black.African.American') %>% 
  add_lines(y = ~White,color='White') %>% 
  add_lines(y = ~American.Indian,color='American.Indian')%>% 
  add_lines(y = ~Asian.Pacific.Islander,color='Asian.Pacific.Islander')%>% 
  add_lines(y = ~Multiracial,color='Multiracial')%>% 
  add_lines(y = ~Hispanic,color='Hispanic')%>% layout(xaxis = axis_x)%>% layout(yaxis = axis_y)%>%
  layout(title = 'Week vs Vaccinations Percentage for age group 45-64')

