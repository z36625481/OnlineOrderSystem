import datetime
import pyodbc
import random

# 訂單紀錄的起始時間
start_time = datetime.datetime(2022, 6, 1)

# 連接資料庫
conn = pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=Onlineordersys;UID=choco;PWD=1234')
cursor = conn.cursor()

# 新增隨機訂單
for i in range(200):
    # 訂單時間 1-30日
    order_time = start_time + datetime.timedelta(days=random.randint(1, 30))
    # 結帳時間 1-2小時候
    pay_time = order_time + datetime.timedelta(hours=random.randint(1, 2))
    # 桌號
    table_id = random.randint(1, 5)
    
    # insert訂單紀錄
    conn.execute(f"INSERT INTO OrderMeterial (OrderTime, PayTime, TableID) VALUES ('{order_time}', '{pay_time}', {table_id})")
    
    
    
     # 取得訂單編號
    cursor.execute("SELECT SCOPE_IDENTITY()")
    order_num = cursor.fetchone()[0]
    
    # 取得該訂單的桌號
    cursor.execute(f"SELECT TableID FROM OrderMeterial WHERE OrderNum = {order_num}")
    table_ids = cursor.fetchone()[0]
    # 菜單ID
    disher_ids = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51]
    # 權重
    weights =    [10, 10, 10, 10, 10, 20, 20, 20, 20, 15, 20, 8, 5, 5, 5, 15, 10, 8, 8, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 10, 20, 20, 16, 16, 16, 16, 16, 16, 6, 6, 6, 6, 6, 6, 15, 2, 1] # 每個disher_id的權重

    # 訂單明細
    for i in range(random.randint(1, 5)):
        # 產生訂單明細資料
        disher_id = random.choices(disher_ids, weights)[0]
        quantity = random.randint(1, 10)
        
        # insert訂單明細資料
        conn.execute(f"INSERT INTO OrderRecord (OrderNum, DisherID, Quantity, TableID) VALUES ({order_num}, {disher_id}, {quantity}, {table_ids})")

 
    # 提交
    conn.commit()

conn.close()
