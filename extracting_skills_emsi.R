
library(httr)
library(jsonlite)
library(tidyverse)

url <- "https://auth.emsicloud.com/connect/token"

# Cred
client_id = "e5yxtgp6blbm9jzt" # replace 'your_client_id' with your client id from your api invite email
client_secret = "KZY2jVOC" # replace 'your_client_secret' with your client secret from your api invite email
scope = "emsi_open" # ok to leave as is, this is the scope we will used

# tokeb
payload <- paste0("client_id=", client_id, "&client_secret=",client_secret,"&grant_type=client_credentials&scope=",scope)
headers <- 'application/x-www-form-urlencoded'
encode <- "form"
response <- VERB("POST", url, body = payload, add_headers(Content_Type = headers), content_type(headers), encode = encode)
access_token <- fromJSON(content(response, "text"))$access_token
access_token

## extract skills
all_skills_endpoint <- "https://emsiservices.com/skills/versions/latest/skills" # List of all skills endpoint
auth <- paste0('Bearer ', access_token) # Auth string including access token from above
response <- VERB("GET", url2, add_headers(Authorization = auth),  content_type("application/octet-stream"),encode = encode)
df <- fromJSON(content(response, "text"))$data 
df %>% write_rds('emsi_skills_extract.rds')




df %>% as_tibble() %>% filter(grepl('Python', name))
