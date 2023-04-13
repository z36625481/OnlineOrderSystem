from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from flask import render_template
import datetime
import pyodbc
import json

conn = pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=Onlineordersys;UID=sa;PWD=1234')
cursor = conn.cursor()

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = 'mssql+pymssql://sa:1234@localhost:1433/Onlineordersys'

db = SQLAlchemy(app)

def cleanup(session):    
    session.close()    

     
@app.route('/')
def index():
    return '資料庫連線成功'

@app.route('/menu/<int:thisOrderNum>/<int:thisTableID>', methods=['GET', 'POST'])
def menu(thisOrderNum, thisTableID):      
    if request.method == 'POST':              
        cartListStr = request.form['cartList']        
        total = int(request.form['total'])
        cartList = json.loads(cartListStr) 
        try:            
            for cart in cartList:
                sql = f"select DisherID from menu where dishes = '{cart['name']}'"
                cursor.execute(sql)
                disherID = cursor.fetchone()[0]
                quantity = int(cart['itemQuantity'])                
                sql = f"execute InsertOrderRecord {thisOrderNum}, {disherID}, {quantity}, {thisTableID}"
                cursor.execute(sql)
                conn.commit()
        except Exception as err:
            raise err
        try:            
            sql = f"execute SelectCartList {thisOrderNum}"
            sumCartList = db.engine.execute(sql)
            sql = f"execute calTotal {thisOrderNum}"
            cursor.execute(sql)
            sumTotal = cursor.fetchone()[0]
        except Exception as err:
            raise err
        finally:       
            cleanup(db.session)  
        
        sumCartList =list(sumCartList)
        
        return render_template("flaskOrder.html", orderNum=thisOrderNum, cartList=sumCartList, tableID=thisTableID, total=sumTotal)
        conn.close()
                       
    try:
        sql = "execute SelectDishType"
        DishType = db.engine.execute(sql)
        sql = "execute SelectMenu"
        menu = db.engine.execute(sql)
        sql = "execute SelectSideDish"
        sideDish = db.engine.execute(sql)
        sql = "select TableID from dbo.seat"
        tables = db.engine.execute(sql)
    except Exception as err:
        raise err    
    
    DishType = list(DishType)    
    menu = list(menu)
    sideDish = list(sideDish)
    tables = list(tables) 
           
    return render_template("flaskMenu.html", **locals())
    conn.close()

@app.route('/checkOrder')
def checkorder():
    return render_template("flaskOrder.html", **locals())
    
if __name__ == "__main__":    
     app.run()
    
