from datetime import datetime
from hashlib import md5
from time import time
from flask import current_app
from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash
import jwt
from app import db, login

followers = db.Table(
    'followers',
    db.Column('follower_id', db.Integer, db.ForeignKey('user.id')),
    db.Column('followed_id', db.Integer, db.ForeignKey('user.id'))
)

class permission(db.Model):
    userID = db.Column(db.Integer,db.ForeignKey('user.id'), primary_key=True)
    userName = db.Column(db.VARCHAR(50),db.ForeignKey('user.username'))
    permissionLevel = db.Column(db.VARCHAR(50))

class MyTVSuper(db.Model):
    PlanID = db.Column(db.Integer, primary_key=True)
    PlanLevel = db.Column(db.VARCHAR(20))
    channel = db.Column(db.VARCHAR(100))

class Location(db.Model):
    Street = db.Column(db.String(100), primary_key=True)
    support = db.Column(db.Boolean)

    def check_location(self, Street):
        return
class ReferralRewards(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    DesignatedService = db.Column(db.VARCHAR(100))
    Referrers = db.Column(db.Integer)



class GlobalTalk(db.Model):
    Function = db.Column(db.VARCHAR(100),primary_key=True)

class EService(db.Model):
    ServiceID = db.Column(db.Integer, primary_key=True)
    ServiceName = db.Column(db.Integer)


class SupportTel(db.Model):
    Telno = db.Column(db.Integer, primary_key=True)
    Service = db.Column(db.VARCHAR(20))

class Plan(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    Pname = db.Column(db.VARCHAR(20))
    Price = db.Column(db.Integer)
    Speed = db.Column(db.VARCHAR(5))

class MobPlan(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    Pname = db.Column(db.VARCHAR(20))
    Price = db.Column(db.Integer)
    Data = db.Column(db.VARCHAR(10))

class Pay(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    planid = db.Column(db.VARCHAR)
    Paydate = db.Column(db.DateTime)


class User(UserMixin, db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(64), index=True, unique=True)
    email = db.Column(db.String(120), index=True, unique=True)
    password_hash = db.Column(db.String(128))
    posts = db.relationship('Post', backref='author', lazy='dynamic')
    about_me = db.Column(db.String(140))
    last_seen = db.Column(db.DateTime, default=datetime.utcnow)
    followed = db.relationship(
        'User', secondary=followers,
        primaryjoin=(followers.c.follower_id == id),
        secondaryjoin=(followers.c.followed_id == id),
        backref=db.backref('followers', lazy='dynamic'), lazy='dynamic')

    def __repr__(self):
        return '<User {}>'.format(self.username)

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

    def avatar(self, size):
        digest = md5(self.email.lower().encode('utf-8')).hexdigest()
        return 'https://www.gravatar.com/avatar/{}?d=identicon&s={}'.format(
            digest, size)

    def follow(self, user):
        if not self.is_following(user):
            self.followed.append(user)

    def unfollow(self, user):
        if self.is_following(user):
            self.followed.remove(user)

    def is_following(self, user):
        return self.followed.filter(
            followers.c.followed_id == user.id).count() > 0

    def followed_posts(self):
        followed = Post.query.join(
            followers, (followers.c.followed_id == Post.user_id)).filter(
            followers.c.follower_id == self.id)
        own = Post.query.filter_by(user_id=self.id)
        return followed.union(own).order_by(Post.timestamp.desc())

    def get_reset_password_token(self, expires_in=600):
        return jwt.encode(
            {'reset_password': self.id, 'exp': time() + expires_in},
            current_app.config['SECRET_KEY'], algorithm='HS256').decode('utf-8')

    @staticmethod
    def verify_reset_password_token(token):
        try:
            id = jwt.decode(token, current_app.config['SECRET_KEY'],
                            algorithms=['HS256'])['reset_password']
        except:
            return
        return User.query.get(id)


@login.user_loader
def load_user(id):
    return User.query.get(int(id))


class Post(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    body = db.Column(db.String(140))
    timestamp = db.Column(db.DateTime, index=True, default=datetime.utcnow)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))

    def __repr__(self):
        return '<Post {}>'.format(self.body)
