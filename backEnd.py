from flask import Flask, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from flask import render_template
import datetime
import pyodbc
import random
import matplotlib.pyplot as plt


app = Flask(__name__)

conn = pyodbc.connect('DRIVER={SQL Server};SERVER=localhost;DATABASE=Onlineordersys;UID=sa;PWD=1234')
cursor = conn.cursor()

app.config["SQLALCHEMY_DATABASE_URI"] = 'mssql+pymssql://sa:1234@localhost:1433/Onlineordersys'

db = SQLAlchemy(app)

def cleanup(session):    
    session.close() 

# 繪製營收分析圖    
def painting(sql):
    A = db.engine.execute(sql)
    Meterial = A.fetchall() # 餐點名稱/類型名稱、總金額
    
    x, y = zip(*Meterial)
    
    plt.rcParams['font.sans-serif'] = ['Microsoft JhengHei']

    plt.figure(figsize=(10, 8))
    
    # 折線圖
    plt.bar(x, y)
    
    plt.title('銷售類型比較圖') #標題   
    plt.ylabel('營業額')       # y軸
    plt.xlabel('品名')         # x軸

    # 下載圖表    
    plt.savefig('C:/Users/DYH/Desktop/OnlineOrderSystem/OnlineOrderSystem/static/images/compare.png') # 不同路徑時需更改
    return Meterial # 為了提供營收分析頁面渲染名稱、總金額

# 確認帳密是否存在於資料庫
def tryAccount(account, pwd):
    try:
        sql = f"select count(*) from staff where Email = '{account}' and PW = '{pwd}'"
        result = db.engine.execute(sql).scalar()
    except:
        return render_template("flaskLoginError.html")
    return result    
   
# 識別碼亂數用    
data = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'
     
@app.route('/', methods=['GET', 'POST'])
def login():
    #POST
    if request.method == 'POST':
        account = request.form["account"] # 取得輸入的帳號
        pwd = request.form["pwd"] # 密碼
        result = tryAccount(account, pwd) # 判斷帳密是否存在
        # 登入失敗：渲染登入失敗頁面
        if result is None or result == 0:
            return render_template("flaskLoginError.html")
        
        # 登入成功：判斷階級
        try:
            sql = f"select personnel from staff where Email = '{account}'"
            cursor.execute(sql)
            personnel = cursor.fetchone()[0] # 取得此帳密的階級
        except Exception as err:
            raise err
        # 如果是老闆則導向修改菜單
        if (personnel == 'Boss'):
            return redirect(url_for('modifyMenu', thisAccount=account, thispwd=pwd))
        
        # 如果是員工則導向新增訂單
        elif personnel == 'Staff':
            return redirect(url_for('createOrder', thisAccount=account, thispwd=pwd))
        
    #GET，渲染登入頁面
    return render_template("flaskLogin.html")

# 為了不讓他人能夠輕易輸入「點餐系統網址/createOrder」就能進入我們的頁面，所以在網址添加帳密確保最低的安全性
@app.route('/createOrder/<string:thisAccount>/<string:thispwd>', methods=['GET', 'POST'])
def createOrder(thisAccount, thispwd):
    # 判斷帳密是否存在
    result = tryAccount(thisAccount, thispwd)
    # 不存在：渲染登入失敗頁面
    if result is None or result == 0:
        return render_template("flaskLoginError.html")
    # 存在：
    # POST
    if request.method == 'POST':
        tableID = int(request.values['tableID']) # 取得桌號
        orderTime = (datetime.datetime.now()) # 訂單產生時間
        orderTimeStr = orderTime.strftime("%Y-%m-%d %H:%M:%S")
        token = '' # 識別碼
        for i in range(10):
            temp = random.choices(random.sample(data, 12))
            token += ''.join(temp)        
        try:
            sql = (f"execute InsertOrderMeterial '{orderTimeStr}', {tableID}, '{token}'") # 新增訂單，insert產生時間、桌號、識別碼
            cursor.execute(sql)
            conn.commit()            
        except Exception as err:
            raise err
        try:        
            sql = "execute SelectOrderInfo" # 找訂單編號以及對應的識別碼
            orderInfo = db.engine.execute(sql)     
        except Exception as err:
            raise err
        finally:            
            cleanup(db.session)
        # 將桌號、訂單編號、識別碼、帳密(用於判斷接下來的route一樣能不被輕易進入)傳送的創建QRcode頁面進行渲染
        return render_template("flaskCreateQRcode.html", tableID=tableID, orderInfo=orderInfo, thisAccount=thisAccount, thispwd=thispwd)                        
    # GET
    try:
        sql = "select TableID from seat"
        tables = db.engine.execute(sql) # 取得桌號             
    except Exception as err:
        raise err
    finally:
        cleanup(db.session)
        
    tables = list(tables)
    
    # 渲染新增訂單頁面
    return render_template("flaskCreateOrder.html", **locals())
    conn.close()
    
@app.route('/orderDetail/<string:thisAccount>/<string:thispwd>', methods=['GET', 'POST'])
def orderDetail(thisAccount, thispwd):
    # 判斷帳密是否存在
    result = tryAccount(thisAccount, thispwd)
    # 不存在：渲染登入失敗頁面
    if result is None or result == 0:
        return render_template("flaskLoginError.html")
    # 存在：
    # GET
    try:
        sql = "select OrderNum, tableID from OrderMeterial where PayTime is null"
        orderNum = db.engine.execute(sql) # 訂單編號
        sql = "execute SelectOrderDetail"
        detail = db.engine.execute(sql) # 尚未付費的訂單明細，訂單編號、餐點名稱、數量              
    except Exception as err:
        raise err
    finally:
        cleanup(db.session)
        
    orderNum = list(orderNum)      
    detail = list(detail)  
    # 渲染尚未付費的訂單明細頁面，即廚師觀看的頁面
    return render_template("flaskOrderDetail.html", **locals())
    conn.close()

    
@app.route('/getCheck/<string:thisAccount>/<string:thispwd>', methods=['GET', 'POST'])
def getCheck(thisAccount, thispwd):
    # 判斷帳密是否存在
    result = tryAccount(thisAccount, thispwd)
    # 不存在：渲染登入失敗頁面
    if result is None or result == 0:
        return render_template("flaskLoginError.html")
    # 存在：
    # POST
    if request.method == 'POST':
        payTime = (datetime.datetime.now()) # 付費時間
        payTimeStr = payTime.strftime("%Y-%m-%d %H:%M:%S")
        orderNum = int(request.values['checkNum']) # 訂單編號
        try:
            sql = (f"execute UpdatePayTime {orderNum}, '{payTimeStr}'") # 更新此訂單編號的訂單時間
            cursor.execute(sql)
            conn.commit()
        except Exception as err:
            raise err
        finally:            
            cleanup(db.session)
    # GET                       
    try:
        sql = "execute SelectOrder"
        orders = db.engine.execute(sql) # 尚未付費的訂單編號、訂單產生時間、桌號、總金額             
    except Exception as err:
        raise err
    finally:
        cleanup(db.session)
        
    orders = list(orders)
    # 渲染結帳頁面    
    return render_template("flaskGetCheck.html", **locals())
    conn.close()

@app.route('/modifyMenu/<string:thisAccount>/<string:thispwd>', methods=['GET', 'POST'])
def modifyMenu(thisAccount, thispwd):
    # 判斷帳密是否存在
    result = tryAccount(thisAccount, thispwd)
    # 不存在：渲染登入失敗頁面
    if result is None or result == 0:
        return render_template("flaskLoginError.html")
    # 存在：
    # POST
    if request.method == 'POST':
        originalName = request.values['originalName'] # 修改前的餐點名稱
        modifyName = request.values['modifyName'] # 修改後的餐點名稱
        modifyPrice = int(request.values['modifyPrice']) # 修改後的價格
        try:
            sql = (f"execute UpdateMenu '{originalName}', '{modifyName}','{modifyPrice}'") # 更新菜單資料表中的餐點名稱、價格
            cursor.execute(sql)            
        except:
            return render_template("flaskInsertError.html", **locals())
        finally: 
            conn.commit()
            cleanup(db.session)
    # GET
    try:
        sql = "execute SelectDishType"
        DishType = db.engine.execute(sql) # 餐點類型
        sql = "execute SelectMenu"
        menu = db.engine.execute(sql)     # 菜單：餐點名稱、價格、餐點類型名稱
        sql = "execute SelectMenuPlus"
        choose = db.engine.execute(sql)   # 主食內的選擇       
    except Exception as err:
        raise err
    finally:
        cleanup(db.session)
    
    DishType = list(DishType)    
    menu = list(menu)
    choose = list(choose)
    # 渲染修改菜單頁面            
    return render_template("flaskModifyMenu.html", **locals())
    conn.close()
    
@app.route('/insertMenu/<string:thisAccount>/<string:thispwd>', methods=['GET', 'POST'])
def insertMenu(thisAccount, thispwd):
    # 判斷帳密是否存在
    result = tryAccount(thisAccount, thispwd)
    # 不存在：渲染登入失敗頁面
    if result is None or result == 0:
        return render_template("flaskLoginError.html")
    # 存在：
    # POST
    if request.method == 'POST':
        insertName = request.values['insertName'] # 新增的餐點名稱
        insertPrice = request.values['insertPrice'] # 新增的價格
        typeID = int(request.values['typeID']) # 此餐點的類型
        try:
            sql = (f"execute InsertMenu '{insertName}', '{insertPrice}','{typeID}'") # 新增進菜單資料表
            cursor.execute(sql)            
        except:
            return render_template("flaskInsertError.html", **locals())
        finally:
            conn.commit()            
            cleanup(db.session)
    # GET
    try:
        sql = "select * from MenuType ORDER BY TypeID"
        DishType = db.engine.execute(sql) # 所有類型
        sql = "execute SelectMenuPlus"
        choose = db.engine.execute(sql) # 可用配對名稱
    except Exception as err:
        raise err
    finally:
        cleanup(db.session)
        
    DishType = list(DishType)
    choose = list(choose)
    # 渲染新增菜單頁面        
    return render_template("flaskInsertMenu.html", **locals()) 

@app.route('/analyze/<string:thisAccount>/<string:thispwd>', methods=['GET', 'POST'])
def analyze(thisAccount, thispwd):
    # 判斷帳密是否存在
    result = tryAccount(thisAccount, thispwd)
    # 不存在：渲染登入失敗頁面
    if result is None or result == 0:
        return render_template("flaskLoginError.html")
    # 存在：
    # POST
    if request.method == 'POST':
        T = ""
        Y = request.values['year'] # 輸入的年
        M = request.values['month'] # 月
        D = request.values['day'] # 日
        
        # 只輸入年
        if (M == "" and D == ""):
            try:
                sql = f"Execute calRevenue {Y}"
                Meterial = painting(sql)                
            except:
                return render_template('flaskAnalyzeError.html', **locals())
        # 只輸入年、月
        elif (D == ""):
            try:
                sql = f"Execute calRevenue {Y}, {M} "
                Meterial = painting(sql)                
            except:
                return render_template('flaskAnalyzeError.html', **locals())
        # 只輸入年、日則渲染輸入錯誤頁面
        elif (M == "" and D != ""):
            return render_template('flaskAnalyzeError.html', **locals())
        # 輸入年、月、日
        else:            
            try:
                sql = f"Execute calRevenue {Y}, {M}, {D} "
                Meterial = painting(sql)
            except:
                return render_template('flaskAnalyzeError.html', **locals())      
            
        # 將查詢到的訂單資料傳給營收分析頁面進行渲染
        return render_template('flaskAnalyzeResult.html', **locals())                       
    # 渲染輸入年、月、日的頁面                  
    return render_template("flaskAnalyze.html", **locals())

@app.route('/analyzeDetail/<string:thisAccount>/<string:thispwd>')
def analyzeDetail(thisAccount, thispwd):
    # 判斷帳密是否存在
    result = tryAccount(thisAccount, thispwd)
    # 不存在：渲染登入失敗頁面
    if result is None or result == 0:
        return render_template("flaskLoginError.html")
    # 存在：
    # GET
    T = request.args.get('type')  # 餐點類型
    Y = request.args.get('year')  # 年
    M = request.args.get('month') # 月
    D = request.args.get('day')   # 日
    
    # 只輸入年
    if (M == "" and D == ""):
        try:
            sql = f"Execute calRevenueDetail {T}, {Y}"
            Meterial = painting(sql)                
        except:
            return render_template('flaskAnalyzeError.html')
    # 只輸入年、月
    elif (D == ""):
        try:
            sql = f"Execute calRevenueDetail {T}, {Y}, {M} "
            Meterial = painting(sql)                
        except:
            return render_template('flaskAnalyzeError.html')
    # 只輸入年、日則渲染輸入錯誤頁面
    elif (M == "" and D != ""):
        return render_template('flaskAnalyzeError.html')
    # 輸入年、月、日
    else:            
        try:
            Meterial = painting(sql)
            sql = f"Execute calRevenueDetail {T}, {Y}, {M}, {D}"                
        except:
            return render_template('flaskAnalyzeError.html')  
    # 將查詢到的訂單資料傳給營收分析頁面進行渲染
    return render_template('flaskAnalyzeResult.html', **locals())  

    
if __name__ == "__main__":
    # 跟前台使用的port進行區隔
    app.run(port="50001")