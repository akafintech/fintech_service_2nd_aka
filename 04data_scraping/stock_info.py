import requests
import time
import pandas as pd
from datetime import datetime
from bs4 import BeautifulSoup as bs
from sqlalchemy import create_engine, text
import pymysql
pymysql.install_as_MySQLdb()



com_result = {}
url = "https://kind.krx.co.kr/corpgeneral/corpList.do"
payload = dict(method="searchCorpList", pageIndex=1, currentPageSize=15, orderMode=3, orderStat="D", searchType=13, fiscalYearEnd="all", location="all")
r = requests.post(url, data=payload)
print(r.status_code)
soup = bs(r.content, 'lxml')
com_list = soup.select("tbody > tr")
key_list = ["회사명", "업종", "주요제품", "상장일", "결산월", "대표자명", "홈페이지", "지역"]

for i in com_list:
    key_index = 0
    for j in i.contents:
        if not j.name :
            continue
        else :
            com_result.setdefault(key_list[key_index],[]).append(j.text)
            key_index+=1
for key,value in com_result.items():
    print(f"{key} len : {len(value)}")
result = pd.DataFrame(com_result)

result.to_csv(f"상장기업정보_.csv", encoding="utf-8-sig", index=False)

# localhost = 127.0.0.1
engine = create_engine("mysql+pymysql://root:1234@localhost:3306/stock_info")
# engine.connect : create_engine에 있는 정보로 db 접속
conn = engine.connect()

# 데이터프레임을 db에 저장하기
# 데이터프레임.to_sql("테이블명")
df.to_sql(f"stock_company_info_", con=conn, if_exists = 'replace', index=False )
conn.close()