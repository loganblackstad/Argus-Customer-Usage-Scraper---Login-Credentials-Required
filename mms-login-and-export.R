
library(RSelenium)


driver <- rsDriver(browser = c("firefox"))
remote_driver <- driver[["client"]]

# fprof <- makeFirefoxProfile(list(browser.download.S = ))

remote_driver$open()


# remote_driver$findElement(By.name("submit")).submit()


remote_driver$navigate("https://metals.argusmedia.com")

username_element <- remote_driver$findElement(using = 'id', value = 'Username')

username_element$sendKeysToElement(list("logan.blackstad@argusmedia.com"))


password_element <- remote_driver$findElement(using = 'id', value = 'Password')

password_element$sendKeysToElement(list("Atl#30306"))

login_element <- remote_driver$findElement(using = 'id', value = 'buttonSubmitLogin')
login_element$clickElement()

remote_driver$navigate("http://metalsmanagement.argusmedia.com/management/UsageTracker/User/novelis")

submit_element <- remote_driver$findElement(using = 'css', value = 'li:nth-child(2) > .btnSubmit')
submit_element$clickElement()


# driver$server$stop() 

