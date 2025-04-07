from sqlalchemy import create_engine
import pymysql
pymysql.install_as_MySQLdb()
import pandas as pd
from bs4 import BeautifulSoup as bs
import time
import requests
from datetime import datetime

url = f"https://finance.naver.com/item/main.naver?code={code}"
r = requests.get(url)
soup = bs(r.content, "lxml")

def year_month() :
    from datetime import datetime
    today = datetime.today()
    return today.year, today.month

def dbconnect() :
    engine = create_engine("mysql+pymysql://root:1234@localhost:3306/stock_info")
    conn = engine.connect() 
    return conn

data = pd.read_sql('stock_company_info_2025_04_04', con=conn)
today = datetime.today()
date = f"{today.year}{today.month:02d}"
stock_code = data['종목코드'].apply(lambda x : x + "0")



# final_result = []
for idx, code in enumerate(stock_code) :
    url = f"https://finance.naver.com/item/main.naver?code={code}"
    r = requests.get(url)
    soup = bs(r.content, "lxml")
    print(r.status_code, f"{idx+1}/{len(stock_code)} {code} 작업중", end="\r")
    
    
    # 종목명
    stock_name = soup.select_one("dl.blind > dd:nth-child(3)").text[4:]
    # 현재가
    today_price = int(soup.select_one("dl.blind > dd:nth-child(5)").text.split(" ")[1].replace(",",""))
    # 변동금액
    change = soup.select_one("dl.blind > dd:nth-child(5)").text.split(" ")[3:5]
    change = -int(change[1].replace(",","").replace("\n","")) if change[0] == "하락" else int(change[1].replace(",","").replace("\n",""))
    # 변동률
    percent = "".join(soup.select_one("dl.blind > dd:nth-child(5)").text.split(" ")[16:30])
    percent = percent.replace("마이너스","-").replace("퍼센트","%").replace("\n","")
    # 전일가
    yester_price = int(soup.select_one("dl.blind > dd:nth-child(6)").text[4:].replace(",", ""))
    # 고가
    hi = soup.select_one("dl.blind > dd:nth-child(8)").text[3:].replace(",","")                                                               
    # 상한가
    top = soup.select_one("dl.blind > dd:nth-child(9)").text[4:].replace(",","")
    # 저가                                                               
    low = soup.select_one("dl.blind > dd:nth-child(10)").text[3:].replace(",","")
    # 하한가                                                                
    bottom = soup.select_one("dl.blind > dd:nth-child(11)").text[4:].replace(",","")
    # 거래량                                                                
    volume = soup.select_one("dl.blind > dd:nth-child(12)").text[4:].replace(",","")
    
    result = (code, stock_name, today_price, change, percent, yester_price, hi, top, low, bottom, volume)
    columns = ["종목코드", "종목명", "현재가", "변동금액", "변동률", "전일가", "고가", "상한가", "저가", "하한가", "거래량"]  
    df = pd.DataFrame(final_result, columns=columns)
    
    # 오늘 기준 연도, 달 출력
    year, month = year_month()
    # DataFrame 쿼리창 오픈
    conn = dbconnect()
    df.to_sql(f"stock_price_{year}_{month:02d}", con=conn, if_exists='append', index=False)
    conn.close()
    
    print(f"{idx+1}/{len(stock_code)} {stock_name} DB_저장완료", end="\r")
    
#     display(df)
    
#     final_result.append(result)
    time.sleep(5)