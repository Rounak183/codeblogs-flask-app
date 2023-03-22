import pymysql
import json
import math
import os

from datetime import datetime
from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
from werkzeug.utils import secure_filename

pymysql.install_as_MySQLdb()

with open('config.json', 'r') as c:
    params = json.load(c)['params']

app = Flask(__name__)
app.secret_key = 'super-secret-key'
app.config['UPLOAD_FOLDER'] = params['upload_location']
local_server = params['local_server']

if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']

app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params["gmail_id"],
    MAIL_PASSWORD=params["gmail_password"]
)
mail = Mail(app)

db = SQLAlchemy(app)


class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    phone_num = db.Column(db.String(12), nullable=False)
    msg = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    email = db.Column(db.String(20), nullable=False)


class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    tagline = db.Column(db.String(100), nullable=False)
    slug = db.Column(db.String(50), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    img_filename = db.Column(db.String(50), nullable=True)


@app.route("/dashboard", methods=['GET', 'POST'])
def dashboard():
    if "user" in session and session["user"] == params["admin_user"]:
        posts = Posts.query.all()
        return render_template("dashboard.html", params=params, posts=posts)

    if request.method == "POST":
        username = request.form.get('uname')
        password = request.form.get('password')
        if username == params['admin_user'] and password == params['admin_password']:
            # set the session variable
            session['user'] = username
            posts = Posts.query.all()
            return render_template("dashboard.html", params=params, posts=posts)
    else:
        return render_template("login.html", params=params)


@app.route("/")
def home():
    posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts) / int(params['no_of_posts']))
    page = request.args.get('page')
    if not str(page).isnumeric():
        page = 1
    page = int(page)
    posts = posts[(page - 1) * int(params['no_of_posts']):(page - 1) * int(params['no_of_posts']) + int(params['no_of_posts'])]
    if page == 1:
        prev_page = "#"
        next_page = "/?page=" + str(page + 1)
    elif page == last:
        prev_page = "/?page=" + str(page - 1)
        next_page = "#"
    else:
        prev_page = "/?page=" + str(page - 1)
        next_page = "/?page=" + str(page + 1)

    return render_template('index.html', params=params, posts=posts, prev=prev_page, next=next_page)


# @app.route("/index")
# def index():
    # posts = Posts.query.filter_by().all()
    # # last = math.ceil(len(posts)/int(params['no_of_posts']))
    # page = request.args.get('page')
    # if not str(page).isnumeric():
    #     page = 1
    # page = int(page)
    # posts = posts[(page-1)*int(params['no_of_posts']):(page-1)*int(params['no_of_posts']) + int(params['no_of_posts'])]
    # if page == 1:
    #     prev_page = "#"
    #     next_page = "/?page=" + str(page + 1)
    #     print("next_page = ", next_page)
    # elif page == last:
    #     prev_page = "/?page=" + str(page-1)
    #     next_page = "#"
    #     print("next_page = ", next_page)
    # else:
    #     prev_page = "/?page=" + str(page-1)
    #     next_page = "/?page=" + str(page + 1)
    #     print("next_page = ", next_page)
    # return render_template('index.html', params=params, posts=posts, prev=prev_page, next=next_page)


@app.route("/about")
def about():
    return render_template('about.html', params=params)


@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=params, post=post)


@app.route("/add", methods=['POST', 'GET'])
def add():
    if 'user' in session and session['user'] == params['admin_user'] and request.method == 'POST':
        box_title = request.form.get('title')
        tagline = request.form.get('tagline')
        slug = request.form.get('slug')
        content = request.form.get('content')
        img_file = request.form.get('img_file')
        date = datetime.now()

        post = Posts(title=box_title, tagline=tagline, slug=slug, content=content, img_filename=img_file, date=date)
        db.session.add(post)
        db.session.commit()
        return redirect('/add')

    return render_template('add.html', params=params)


@app.route("/edit/<string:sno>", methods=['GET', 'POST'])
def edit(sno):
    if 'user' in session and session['user'] == params['admin_user'] and request.method == 'POST':
        box_title = request.form.get('title')
        tagline = request.form.get('tagline')
        slug = request.form.get('slug')
        content = request.form.get('content')
        img_file = request.form.get('img_file')
        date = datetime.now()

        post = Posts.query.filter_by(sno=sno).first()
        post.title = box_title
        post.tagline = tagline
        post.slug = slug
        post.content = content
        post.img_filename = img_file
        post.date = date
        db.session.commit()
        return redirect('/edit/' + sno)

    post = Posts.query.filter_by(sno=sno).first()
    return render_template('edit.html', params=params, post=post)


@app.route("/uploader", methods=['GET', 'POST'])
def upload():
    if "user" in session and session['user'] == params['admin_user']:
        if request.method == 'POST':
            if 'file' not in request.files:
                return redirect('/dashboard')
            else:
                f = request.files['file']
                if f.filename == '':
                    return redirect('/dashboard')
                else:
                    f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
                    return "Uploaded successfully!"


@app.route('/logout')
def logout():
    session.pop('user')
    return redirect('/dashboard')


@app.route('/delete/<string:sno>', methods=["GET", "POST"])
def delete(sno):
    if 'user' in session and session['user'] == params['admin_user']:
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')


@app.route("/contact", methods=['GET', 'POST'])
def contact():
    if request.method == 'POST':
        name = request.form.get('name')
        email = request.form.get('email')
        phone_num = request.form.get('phone_num')
        msg = request.form.get('msg')

        entry = Contacts(name=name, phone_num=phone_num, email=email, msg=msg, date=datetime.now())
        db.session.add(entry)
        db.session.commit()

        # mail.send_message('New message from ' + name,
        #                   sender=email,
        #                   recipients=[params['gmail_id']],
        #                   body=msg + "\n" + phone_num
        #                   )

    return render_template('contact.html', params=params)


app.run(debug=True)
