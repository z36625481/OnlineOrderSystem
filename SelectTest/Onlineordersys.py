from flask import Flask
from flask import request
from flask import render_template
from flask_sqlalchemy import SQLAlchemy
import matplotlib.pyplot as plt

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'mssql+pymssql://choco:1234@localhost:1433/Onlineordersys'

db = SQLAlchemy(app)

@app.route('/')
def home():
    
    return render_template('Onlineordersys.html')

@app.route('/try')
def index():
    db.create_all()   # 建立資料表物件
    return '資料庫連線成功'
      
@app.route('/HowMuch')
def select():
    dishes = request.args.get('dishes')
    sql = f"select price from menu where Dishes = '{dishes}'"
    a = db.engine.execute(sql)
    HowMuch = a.fetchall()   # str沒用
    return render_template('Howmuch.html', **locals())
  #  return 'ok'

@app.route('/select')
def YMD():
    Y = request.args.get('Y')
    M = request.args.get('M')
    D = request.args.get('D')
    """"'{Y}-{M}-{D}'"""
    sql = f"""select menu.dishtype, sum(menu.price * OrderRecord.Quantity) as Total 
    from OrderMeterial 
    join OrderRecord on OrderMeterial.OrderNum = OrderRecord.OrderNum 
    join menu on OrderRecord.DisherID = menu.DisherID 
    where cast(OrderMeterial.PayTime as date) = '{Y}-{M}-{D}' 
    group by menu.DishType
    """
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
    plt.savefig('C:\\Users\\USER\\Documents\\SelectTest\\static\\compare.png')
    
    return render_template('select.html', **locals())
    
     
@app.route('/test')
def test():
    sql = 'execute Insertseat 7,4'
    db.engine.execute(sql)
    return 'ok'




if __name__ == '__main__':
    app.run()