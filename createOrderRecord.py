import datetime
import pyodbc
import random

# 連接資料庫
conn = pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=Onlineordersys;UID=sa;PWD=1234')
cursor = conn.cursor()

# 訂單紀錄的起始時間
start_time = datetime.datetime(2022, 1, 1)
data = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'

# 新增隨機訂單
for i in range(500):
    # 訂單時間 整年 從 8~18 時 下單
    order_time = start_time + datetime.timedelta(days=random.randint(1, 365), hours=random.randint(8, 18), minutes=random.randint(1, 59))
    # 結帳時間 20 ~ 120分
    pay_time = order_time + datetime.timedelta(minutes=random.randint(20, 120))
    # 桌號
    table_id = random.randint(1, 5)
    
    # token
    token = ''
    for i in range(10):
        temp = random.choices(random.sample(data, 12))
        token += ''.join(temp)  
    
    # insert訂單紀錄
    conn.execute(f"INSERT INTO OrderMeterial (OrderTime, PayTime, TableID, token) VALUES ('{order_time}', '{pay_time}', {table_id}, '{token}')")
    
    
     # 取得訂單編號
    cursor.execute("SELECT SCOPE_IDENTITY()")
    order_num = cursor.fetchone()[0]
    
    # 取得該訂單的桌號
    cursor.execute(f"SELECT TableID FROM OrderMeterial WHERE OrderNum = {order_num}")
    table_ids = cursor.fetchone()[0]
    # 菜單ID
    disher_ids = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51]
    
    # 權重          1    2    3    4    5    6    7    8    9   10   11   12   13   14   15  16  17   18  19  20   21   22  23  24  25  26  27  28  29   30   31  32  33  34   35   36   37   38   39  40   41   42   43  44  45  46  47  48  49  50  51 
    weights =    [300, 300, 300, 300, 300, 200, 120, 180, 200, 180, 200, 120, 150, 150, 30, 30, 100, 20, 15, 100, 100, 50, 80, 100, 50, 50, 80, 30, 60, 100, 40, 60, 20, 150, 150, 150, 100, 120, 80, 120, 120, 120, 60, 40, 80, 80, 80, 60, 150, 5, 2] # 每個disher_id的權重
    
    #  一筆訂單的消費數量權重
    NW = [40, 50, 30, 10, 9, 7, 5, 3, 2, 1]
    #  生成1-10筆訂消費紀錄
    num = random.choices(range(1, 11), weights=NW, k=1)[0]

    # 數量權重
    Q =[66, 33, 1]
    
    # 訂單明細                 
    for i in range(num):
        # 產生訂單明細資料
        disher_id = random.choices(disher_ids, weights)[0]
        quantity =  random.choices(range(1, 4), Q)[0]
        
        # insert訂單明細資料
        conn.execute(f"INSERT INTO OrderRecord (OrderNum, DisherID, Quantity, TableID) VALUES ({order_num}, {disher_id}, {quantity}, {table_ids})")

 
    # 提交
    conn.commit()

conn.close()