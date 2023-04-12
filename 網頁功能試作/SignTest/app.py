from flask import Flask
from flask import request
from flask import render_template
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text
import matplotlib.pyplot as plt

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'mssql+pymssql://choco:1234@localhost:1433/Onlineordersys'

db = SQLAlchemy(app)

@app.route('/')
def index():
    return render_template('home.html')

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

if __name__ == '__main__':
    app.run(port=8000)
