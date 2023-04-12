
from flask import Flask
from flask import request
from flask import render_template
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text
import matplotlib.pyplot as plt

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'mssql+pymssql://pyuser:1234567@localhost:1433/Onlineordersys'

db = SQLAlchemy(app)

@app.route('/')
def home():
    
    return render_template('home.html')

@app.route('/select_data')
def Onlineordersys():
    return render_template('select_data.html')

@app.route('/select_price')
def price():
    return render_template('select_price.html')

@app.route('/try')
def index():
    db.create_all()   # 建立資料表物件
    return '資料庫連線成功'
      
@app.route('/price')
def select():
    dishes = request.args.get('dishes')
    sql = f"select price from menu where Dishes = '{dishes}'"
    a = db.engine.execute(sql)
    price = a.fetchone()   # str沒用
    return render_template('price.html', **locals())
  #  return 'ok'

@app.route('/select')
def YMD():
    Y = request.args.get('Y')
    M = request.args.get('M')
    # D = request.args.get('D')
    # date = f'{Y}'+'-'+f'{M}'+'-'+f'{D}'
    # print(date)
    """"'{Y}-{M}-{D}'"""
    sql = f"Execute SelectMonth '{Y}', '{M}' "
    A = db.engine.execute(sql)
    Meterial = A.fetchall()
    
    x, y = zip(*Meterial)
    
    plt.rcParams['font.sans-serif'] = ['Microsoft JhengHei']

    plt.figure(figsize=(10, 8))
    
    # 折線圖
    plt.bar(x, y)
    
    plt.title('銷售類型比較圖') #標題   
    plt.xlabel('營業額')       # x軸
    plt.ylabel('類型')         # y軸
    
    

    # 下載圖表    
    plt.savefig('C:/Users/DYH/Desktop/OnlineOrderSystem/OnlineOrderSystem/網頁功能試作/SelectTest/static/compare.png')
    
    return render_template('select.html', **locals())
    

@app.route('/detail')
def TYPE():
    Y = request.args.get('Y')
    M = request.args.get('M')
    T = request.args.get('type')
    sql = f"Execute SelectMonthDetail '{Y}', '{M}', '{T}'"
    A = db.engine.execute(sql)
    Meterial = A.fetchall()
    
    x, y = zip(*Meterial)
    
    plt.rcParams['font.sans-serif'] = ['Microsoft JhengHei']

    plt.figure(figsize=(10, 8))
    
    # 折線圖
    plt.bar(x, y)
    
    plt.title('銷售類型比較圖') #標題   
    plt.xlabel('營業額')       # x軸
    plt.ylabel('類型')         # y軸
    
    # 下載圖表
    plt.savefig('C:/Users/DYH/Desktop/OnlineOrderSystem/OnlineOrderSystem/網頁功能試作/SelectTest/static/type.png')
    
    return render_template('detail.html', **locals())


@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/member')
def member():
    return render_template('member.html')

@app.route('/error')
def error():
    message = request.args.get('msg', '請聯繫專員處裡')
    return render_template('error.html',message=message)

@app.route('/signup', methods=["POST"])
def signup():
    N = request.form["N"]
    E = request.form["E"]
    P = request.form["P"]
    sql = f"insert into signup(UserName, Email, PW) values('{N}', '{E}', '{P}')"
    db.engine.execute(sql)
    return render_template('home.html')

@app.route('/signin', methods=["POST"])
def signin():
    E = request.form["E"]
    P = request.form["P"]
    sql = f"select count(*) from signup where Email = '{E}' and PW = '{P}' "
    result = db.engine.execute(sql).scalar()
    if result is None or result == 0:
        return render_template('error.html')
    else:
        return render_template('home.html')


@app.route('/ip')
def get_ip():
    return request.remote_addr

if __name__ == '__main__':
    app.run(port=5000)
