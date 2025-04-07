from sqlalchemy import create_engine
import pymysql
pymysql.install_as_MySQLdb()
import pandas as pd

def dbconnect() :
    engine = create_engine("mysql+pymysql://root:1234@localhost:3306/stock_info")
    conn = engine.connect() 
    return conn

def stock_codes():
    data = pd.read_sql('stock_company_info_2025_04_04', con=conn)
    stock_code = data['종목코드'].apply(lambda x : x + "0")
    conn.close()
    