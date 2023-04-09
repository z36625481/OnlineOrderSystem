# -*- coding: utf-8 -*-
"""
Created on Wed Mar 29 14:59:51 2023

@author: DYH
"""
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask import render_template

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = 'mssql+pymssql://pyuser:1234567@localhost:1433/Onlineordersys'

db = SQLAlchemy(app)

def cleanup(session):    
    session.close()    

     
@app.route('/')
def index():
    return '資料庫連線成功'

@app.route('/menu')
def menu():
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
                
    return render_template("flaskMenu.html", **locals())

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
    
