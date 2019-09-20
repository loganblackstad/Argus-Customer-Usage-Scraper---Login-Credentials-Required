
  library(RSelenium)
  library(KeyboardSimulator)
  
  rm(list=ls())
  
  userList <- read.csv("C:/Users/logan.blackstad/Desktop/mms-test-export.csv")
 
  
  
  driver <- rsDriver(verbose = FALSE,port=4444L, browser = c("firefox"))
  remote_driver <- driver[["client"]]
  
  #fprof <- makeFirefoxProfile(list(browser.helperApps.neverAsk.saveToDisk = "text/plain,text/x-csv,text/csv,application/vnd.ms-excel,application/csv,application/x-csv,text/csv,text/comma-separated-values,text/x-comma-separated-values,text/tab-separated-values,application/pdf"))
  #remote_driver <- remoteDriver(extraCapabilities = fprof)
  remote_driver$open()
  
  
  # remote_driver$findElement(By.name("submit")).submit()
  
  
  remote_driver$navigate("https://metals.argusmedia.com")
  
  username_element <- remote_driver$findElement(using = "id", value = "Username")
  
  username_element$sendKeysToElement(list(" %%USERNAME%% "))
  
  
  password_element <- remote_driver$findElement(using = "id", value = "Password")
  
  password_element$sendKeysToElement(list(" %%PASSWORD%% "))
  
  login_element <- remote_driver$findElement(using = "id", value = "buttonSubmitLogin")
  login_element$clickElement()
  
 
  
  
  Pull_UsageData <- function(userName){
  print(paste("http://metalsmanagement.argusmedia.com/management/UsageTracker/User/",userName,sep=""))
  remote_driver$navigate(paste("http://metalsmanagement.argusmedia.com/management/UsageTracker/User/",userName,sep=""))
  
  submit_element <- remote_driver$findElement(using = "css", value = "li:nth-child(2) > .btnSubmit")
  submit_element$clickElement()
  
  keybd.press('Alt+s')
  Sys.sleep(1)
  keybd.press('enter')
  Sys.sleep(2)
  
  }
  
  
  for (variable in userList$UserName) {
    print(variable[1])
    Pull_UsageData(variable[1])
  }
  
  

  
  # generate subscriber list file
  # append csv files
  # add Username and company 
  # save file to Desktop
  
  
driver$server$stop()



files <- list.files(path = "C:/Users/logan.blackstad/Downloads", pattern ="._2019-User_ ", full.names = TRUE)

curFile <-  read.csv(files[1], header = TRUE)


i <- 1
curFile <-  read.csv(files[i], header = TRUE)
myDF = curFile[FALSE,]

for (myFile in files) {
  curFile <-  read.csv(myFile, header = TRUE)
  if(nrow(curFile) == 0)
  {
    # add a row that keeps username and detail but adds "No Usage Data" in the column "Last.Visit" 
    curFile[nrow(curFile) + 1,] = "No Usage Data"
  }
  curFile["UserName"] <- userList$UserName[i]
  curFile["Company"] <- userList$Company[i]
  curFile["First"] <- userList$First.Name[i]
  curFile["Last"] <- userList$Last.Name[i]
  curFile["Email"] <- userList$Email.Address[i]
  curFile["IsPrimary"] <- userList$IsPrimary[i]
  
  myDF <- rbind(myDF,curFile)
  i <- i+1

}

# myDF = curFile[FALSE,]



outputFolderPath <- "C:/Users/logan.blackstad/Desktop/"
outputFileName <- paste0("Usage_Data_", userList$Company[1], ".csv", sep="")

write.csv(myDF, file = paste0(outputFolderPath, outputFileName, sep=""), row.names=FALSE)

# View(files)




# Delete downloaded files from Downloads Folder

for (myFile in files) {
file.remove(myFile)
}

# clear console
cat("\014")  
