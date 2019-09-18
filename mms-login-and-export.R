
  library(RSelenium)
  
  
  
  userList <- read.csv("C:/Users/logan.blackstad/Desktop/mms-test-export.csv")
 
  
  
  driver <- rsDriver(browser = c("firefox"))
  remote_driver <- driver[["client"]]
  
  #fprof <- makeFirefoxProfile(list(browser.helperApps.neverAsk.saveToDisk = "text/plain,text/x-csv,text/csv,application/vnd.ms-excel,application/csv,application/x-csv,text/csv,text/comma-separated-values,text/x-comma-separated-values,text/tab-separated-values,application/pdf"))
  #remote_driver <- remoteDriver(extraCapabilities = fprof)
  remote_driver$open()
  
  
  # remote_driver$findElement(By.name("submit")).submit()
  
  
  remote_driver$navigate("https://metals.argusmedia.com")
  
  username_element <- remote_driver$findElement(using = "id", value = "Username")
  
  username_element$sendKeysToElement(list("###USERNAME###"))
  
  
  password_element <- remote_driver$findElement(using = "id", value = "Password")
  
  password_element$sendKeysToElement(list("###PASSWORD###"))
  
  login_element <- remote_driver$findElement(using = "id", value = "buttonSubmitLogin")
  login_element$clickElement()
  
 
  
  
  Pull_UsageData <- function(userName){
  print(paste("http://metalsmanagement.argusmedia.com/management/UsageTracker/User/",userName,sep=""))
  remote_driver$navigate(paste("http://metalsmanagement.argusmedia.com/management/UsageTracker/User/",userName,sep=""))
  
  submit_element <- remote_driver$findElement(using = "css", value = "li:nth-child(2) > .btnSubmit")
  submit_element$clickElement()
  
  keybd.press('Alt+s')
  keybd.press('enter')
  }
  
  
  for (variable in userList$UserName) {
    print(variable[1])
    Pull_UsageData(variable[1])
  }
  
  
  Pull_UsageData("trisha.dooley")
  
  
  # loop through csv by username
  
  
  
  # append csv files
  # add Username and company 
  # save file
  
  
  
  
# driver$server$stop() 

