# -*- coding: utf-8 -*-
"""
Created on Wed Mar 29 14:59:51 2023

@author: DYH
"""
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask import render_template

app = Flask(__name__)

# 必須大寫
app.config["SQLALCHEMY_DATABASE_URI"] = 'mssql+pymssql://pyuser:1234567@localhost:1433/Onlineordersys'

db = SQLAlchemy(app)

def cleanup(session):    
    session.close()    
    
@app.route('/')
def index():
    return '資料庫連線成功'

@app.route('/qurey')
def query():
    try:
        sql = "select * from dbo.menu"
        menu = db.engine.execute(sql)
        
    except Exception as err:
        raise err
    finally:
        cleanup(db.session)
        
    menu = list(menu)
    noodles = 'noodles'        
    return render_template("menu.html", **locals())  

if __name__ == "__main__":    
     app.run()
    
