'''
前台：點餐、查詢自身訂單功能
'''
from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from flask import render_template
import pyodbc
import json

conn = pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=Onlineordersys;UID=sa;PWD=1234')
cursor = conn.cursor() 

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = 'mssql+pymssql://sa:1234@localhost:1433/Onlineordersys'

db = SQLAlchemy(app)

def cleanup(session):    
    session.close()  

@app.route('/menu/<int:thisOrderNum>/<int:thisTableID>/<string:thisToken>', methods=['GET', 'POST'])
def menu(thisOrderNum, thisTableID, thisToken):
    # POST
    if request.method == 'POST':              
        cartListStr = request.form['cartList'] # 購物車清單      
        total = int(request.form['total']) # 總金額
        cartList = json.loads(cartListStr) # 由於傳過來為object list轉成的json檔，所以用json.loads接收
        try:            
            for cart in cartList:
                sql = f"select DisherID from menu where dishes = '{cart['name']}'"
                cursor.execute(sql)
                disherID = cursor.fetchone()[0]
                quantity = int(cart['itemQuantity'])
                # 將訂單編號、餐點ID、數量、桌號寫入訂單明細                
                sql = f"execute InsertOrderRecord {thisOrderNum}, {disherID}, {quantity}, {thisTableID}"
                cursor.execute(sql)
                conn.commit()
        except Exception as err:
            raise err
        try:            
            sql = f"execute SelectCartList {thisOrderNum}"
            sumCartList = db.engine.execute(sql) # 找此訂單編號的購物車清單：餐點名稱、價格、此訂單在同餐點的總數量
            sql = f"execute calTotal {thisOrderNum}"
            cursor.execute(sql)
            sumTotal = cursor.fetchone()[0] # 總金額
        except Exception as err:
            raise err
        finally:       
            cleanup(db.session)  
        
        sumCartList =list(sumCartList)
        # 將訂單編號、購物車資訊、桌號、總金額、識別碼傳回查詢自身訂單的頁面做顯示
        return render_template("flaskOrder.html", orderNum=thisOrderNum, cartList=sumCartList, tableID=thisTableID, total=sumTotal, token=thisToken)
        conn.close()
        
    # GET
    # 先確保訂單編號以及識別碼跟資料庫存放的是否一致，不一致則顯示錯誤
    try:
        sql = f"select orderNum from OrderMeterial where token = '{thisToken}'"
        cursor.execute(sql)
        checkOrderNum = cursor.fetchone()[0]
    except Exception:
        return render_template("flaskMenuError.html")
    
    if (thisOrderNum != checkOrderNum):
        return render_template("flaskMenuError.html")    
    else:                   
        try:
            sql = "execute SelectDishType"
            DishType = db.engine.execute(sql) # 餐點類型
            sql = "execute SelectMenu"
            menu = db.engine.execute(sql)     # 菜單：餐點名稱、價格、餐點類型名稱
            sql = "execute SelectSideDish"
            sideDish = db.engine.execute(sql) # 主食內的選擇
            sql = "select TableID from dbo.seat"
            tables = db.engine.execute(sql)   # 桌號
        except Exception as err:
            raise err    
        
        DishType = list(DishType)    
        menu = list(menu)
        sideDish = list(sideDish)
        tables = list(tables) 
        
        # 渲染菜單頁面
        return render_template("flaskMenu.html", **locals())
        conn.close()

@app.route('/checkOrder/<int:thisOrderNum>/<int:thisTableID>/<string:thisToken>')
def checkorder(thisOrderNum, thisTableID, thisToken):
    try:            
        sql = f"execute SelectCartList {thisOrderNum}"
        sumCartList = db.engine.execute(sql) # 找此訂單編號的購物車清單：餐點名稱、價格、此訂單在同餐點的總數量
        sql = f"execute calTotal {thisOrderNum}"
        cursor.execute(sql) 
        sumTotal = cursor.fetchone()[0] # 總金額，由於只回傳一個值所以用fetchone()
    except Exception as err:
        raise err
    finally:       
        cleanup(db.session)  
    
    sumCartList =list(sumCartList)
    
    # 將訂單編號、購物車資訊、桌號、總金額、識別碼傳回查詢自身訂單的頁面做顯示
    return render_template("flaskOrder.html", orderNum=thisOrderNum, cartList=sumCartList, tableID=thisTableID, total=sumTotal, token=thisToken)
    
if __name__ == "__main__":    
     app.run()
    
