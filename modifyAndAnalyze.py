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

@app.route('/modifyMenu', methods=['GET', 'POST'])
def modifyMenu():
    '''
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
    '''                       
    try:
        sql = "execute SelectDishType"
        DishType = db.engine.execute(sql)
        sql = "execute SelectMenu"
        menu = db.engine.execute(sql)        
    except Exception as err:
        raise err
    finally:
        cleanup(db.session)
    
    DishType = list(DishType)    
    menu = list(menu)
                
    return render_template("flaskModifyMenu.html", **locals())

@app.route('/insertMenu', methods=['GET', 'POST'])
def insertMenu():
    '''
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
    '''                       
    try:
        sql = "execute SelectDishType"
        DishType = db.engine.execute(sql)
        sql = "execute SelectMenu"
        menu = db.engine.execute(sql)        
    except Exception as err:
        raise err
    finally:
        cleanup(db.session)
    
    DishType = list(DishType)    
    menu = list(menu)
                
    return render_template("flaskInsertMenu.html", **locals())    

@app.route('/checkRevenue', methods=['GET', 'POST'])
def checkRevenue():
    '''
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
    '''                       
    try:
        sql = "execute SelectDishType"
        DishType = db.engine.execute(sql)
        sql = "execute SelectMenu"
        menu = db.engine.execute(sql)        
    except Exception as err:
        raise err
    finally:
        cleanup(db.session)
    
    DishType = list(DishType)    
    menu = list(menu)
                
    return render_template("flaskCheckRevenue.html", **locals())

@app.route('/analyze', methods=['GET', 'POST'])
def analyze():
    '''
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
    '''                       
    try:
        sql = "execute SelectDishType"
        DishType = db.engine.execute(sql)
        sql = "execute SelectMenu"
        menu = db.engine.execute(sql)        
    except Exception as err:
        raise err
    finally:
        cleanup(db.session)
    
    DishType = list(DishType)    
    menu = list(menu)
                
    return render_template("flaskAnalyze.html", **locals())



if __name__ == "__main__":
    app.run()