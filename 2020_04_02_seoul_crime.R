library(devtools)
library(ggmap) 
library(ggplot2)

#####################################################
# 2. 관서 데이터 가공하기

#-------------------------------------------------------
# 2-1. 원시 데이터 가져오기
# csv 파일을 가져와서 station_data 변수에 할당

seoul_data <- read.csv("./data/crime_in_Seoul_address.csv")

# seoul_data "구주소"컬럼 속성 : Factor
# seoul_data 속성 확인

str(seoul_data) 

#-------------------------------------------------------
# 2-2. 관서 좌표 정보 구하기

# as.character() 함수로 문자형으로 변환한 후 station_code에 할당
seoul_code <- as.character(seoul_data$주소)

# google api key 등록
googleAPIkey <- "AIzaSyDrukGXGw3S_tIfEFMvdpaOVcI9FVzvXUY"
register_google(googleAPIkey)

# geocode() 함수로 station_code 값을 위도와 경도로 변환
seoul_code <- geocode(seoul_code) # 여기가 5분정도 시간 걸리는 부분

# station_code 데이터 앞부분 확인
head(seoul_code) 

#------------------------------------------------------
# 일부데이터가 NA값으로 나올 경우에는 아래처럼 인코딩을 변경하여 다시 좌표정보를 구한다.

# 문자형으로 변환하고 utf8로 변환한 후 위도와 경도로 변환
seoul_code <- as.character(seoul_data$주소) %>% enc2utf8() %>% geocode()

head(seoul_code)

#------------------------------------------------------
# 기존 seoul_data에 위도/경도 정보를 추가

# seoul_data와 seoul_code를 합친 후 seoul_code_final에 할당
seoul_code_final <- cbind(seoul_data, seoul_code)

head(seoul_code_final)

######################################################
# 3. 범죄 데이터 가공하기

#------------------------------------------------------
# 3-1. 관서별 범죄

# csv 파일을 가져와서 crime_data 변수에 할당
crime_data <- read.csv("./data/crime_in_Seoul.csv")

# crime_data 앞부분 확인
head(crime_data)

crime_data$절도.발생 <- gsub(",", "", crime_data$절도.발생)
crime_data$절도.검거 <- gsub(",", "", crime_data$절도.검거)
crime_data$폭력.발생 <- gsub(",", "", crime_data$폭력.발생)
crime_data$폭력.검거 <- gsub(",", "", crime_data$폭력.검거)

head(crime_data)

crime_data <- crime_data %>% 
  mutate(crime_occ_sum=살인.발생+강도.발생+강간.발생+as.integer(crime_data$절도.발생)+as.integer(crime_data$폭력.발생))

crime_data <- crime_data %>% 
  mutate(crime_arr_sum=살인.검거+강도.발생+강간.검거+as.integer(crime_data$절도.검거)+as.integer(crime_data$폭력.검거))

crime_data$all <- crime_data$crime_occ_sum + crime_data$crime_arr_sum
summary(crime_data)

crime_data$occ <- round(crime_data$crime_occ_sum / crime_data$all * 100)
summary(crime_data)

crime_data$arr <- round(crime_data$crime_arr_sum / crime_data$all * 100)
summary(crime_data)

crime_data_final <- cbind(crime_data, seoul_code) %>%
  select("관서명",
         "occ",
         "arr",
         lon, lat)



######################################################
# 4. 구글 지도에 지하철역과 아파트 가격 표시하기
#------------------------------------------------------

# 4-1. 서울시 지도 가져오기

seoul_map <- get_googlemap("seoul",
                          maptype = "roadmap",
                          zoom = 12)

ggmap(seoul_map)

# 경찰서 위치 표시
ggmap(seoul_map) +
  geom_point(data = seoul_code_final,
             aes(x = lon, y = lat),
             colour = "red",
             size = 2) +
  geom_text(data = seoul_code_final,
            aes(label = 관서명, vjust = -1))

# 서울 지도에 경찰서 및 발생율, 검거율 일괄 표시
ggmap(seoul_map) +
  geom_point(data = seoul_code_final,
             aes(x = lon, y = lat),
             colour = "blue",
             size = 3) +
  geom_point(data = crime_data_final,
             aes(x = lon, y = lat)) +
  geom_text(data = crime_data_final,
            aes(label = 관서명, vjust = -1), colour = "black") +
  geom_text(data = crime_data_final,
            aes(label = occ, vjust = 1.2), colour = "red") +
  geom_text(data = crime_data_final,
            aes(label = "발생률", vjust = 1.2, hjust = 1.3), colour = "red") +
  geom_text(data = crime_data_final,
            aes(label = arr, vjust = 2.2), colour = "blue") +
  geom_text(data = crime_data_final,
            aes(label = "검거율", vjust = 2.2, hjust = 1.3), colour = "blue")





