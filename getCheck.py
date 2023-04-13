# -*- coding: utf-8 -*-
"""
Created on Sun Apr  9 13:20:34 2023

@author: DYH
"""

from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from flask import render_template
import datetime
import pyodbc

conn = pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=Onlineordersys;UID=sa;PWD=1234')
cursor = conn.cursor()

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = 'mssql+pymssql://sa:1234@localhost:1433/Onlineordersys'

db = SQLAlchemy(app)

def cleanup(session):    
    session.close()    

     
@app.route('/')
def index():
    return 'log in'

@app.route('/createOrder', methods=['GET', 'POST'])
def createOrder():
    if request.method == 'POST':
        tableID = int(request.values['tableID'])
        orderTime = (datetime.datetime.now())
        orderTimeStr = orderTime.strftime("%Y-%m-%d %H:%M:%S")        
        try:
            sql = (f"execute InsertOrderMeterial '{orderTimeStr}', {tableID}")
            cursor.execute(sql)
            conn.commit()            
        except Exception as err:
            raise err
        try:        
            sql = "execute SelectOrderNum"
            orderNum = cursor.execute(sql)
            orderNum = cursor.fetchone()[0]
        except Exception as err:
            raise err
        finally:            
            cleanup(db.session)
            
        return render_template("flaskCreateQRcode.html", tableID=tableID, orderNum=orderNum)                        
    try:
        sql = "select TableID from seat"
        tables = db.engine.execute(sql)              
    except Exception as err:
        raise err
    finally:
        cleanup(db.session)
        
    tables = list(tables)
    
    return render_template("flaskCreateOrder.html", **locals())
    conn.close()
    
@app.route('/getCheck', methods=['GET', 'POST'])
def getCheck():
    if request.method == 'POST':
        payTime = (datetime.datetime.now())
        payTimeStr = payTime.strftime("%Y-%m-%d %H:%M:%S")
        orderNum = int(request.values['checkNum'])
        try:
            sql = (f"execute UpdatePayTime {orderNum}, '{payTimeStr}'")
            cursor.execute(sql)
            conn.commit()
        except Exception as err:
            raise err
        finally:            
            cleanup(db.session)                       
    try:
        sql = "execute SelectOrder"
        orders = db.engine.execute(sql)              
    except Exception as err:
        raise err
    finally:
        cleanup(db.session)
        
    orders = list(orders)    
    return render_template("flaskGetCheck.html", **locals())
    conn.close()
    
if __name__ == "__main__":
    app.run(port="50001")