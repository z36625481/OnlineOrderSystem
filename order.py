# -*- coding: utf-8 -*-
"""
Created on Wed Mar 29 14:59:51 2023

@author: DYH
"""
from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from flask import render_template
import datetime
import pyodbc
import json

conn = pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=Onlineordersys;UID=pyuser;PWD=1234567')
cursor = conn.cursor()

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = 'mssql+pymssql://pyuser:1234567@localhost:1433/Onlineordersys'

db = SQLAlchemy(app)

def cleanup(session):    
    session.close()    

     
@app.route('/')
def index():
    return '資料庫連線成功'

@app.route('/menu', methods=['GET', 'POST'])
def menu():      
    if request.method == 'POST':        
        cartListStr = request.form['cartList']
        tableID = int(request.form['tableID'])
        cartList = json.loads(cartListStr)      
        orderTime = (datetime.datetime.now())
        orderTimeStr = orderTime.strftime("%Y-%m-%d %H:%M:%S")
        try:        
            sql = f"execute InsertOrderMeterial '{orderTimeStr}', {tableID}"
            cursor.execute(sql)
            conn.commit()
        except Exception as err:
            raise err
        try:        
            sql = "execute SelectOrderNum"
            orderNum = cursor.execute(sql)
            orderNum = cursor.fetchone()[0]            
            print(orderNum, type(orderNum))
            for cart in cartList:                
                sql = f"select DisherID from menu where dishes = '{cart['name']}'"
                disherID = cursor.execute(sql)
                disherID = cursor.fetchone()[0]                
                print(disherID, type(disherID))
                quantity = int(cart['itemQuantity'])
                print(quantity, type(quantity))
                print(tableID, type(tableID))
                sql = f"execute InsertOrderRecord {orderNum}, {disherID}, {quantity}, {tableID}"
                cursor.execute(sql)                    
        except Exception as err:
            raise err
        finally:
            conn.commit()            
            cleanup(db.session)
        return 'OK'
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

@app.route('/checkorder')
def checkorder():
    try:
        sql = "execute SelectOrder"
        orders = db.engine.execute(sql)              
    except Exception as err:
        raise err
    finally:
        cleanup(db.session)
        
    orders = list(orders)    
    return render_template("flaskOrder.html", **locals())
    
if __name__ == "__main__":    
     app.run()
    
