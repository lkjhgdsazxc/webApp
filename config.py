import os

basedir = os.path.abspath(os.path.dirname(__file__))


class Config(object):
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'you-will-never-guess'
    SQLALCHEMY_DATABASE_URI = 'mysql://root:rootroot@fyp-db.c5ytzphcj872.us-east-1.rds.amazonaws.com/FYP_DATABASE'
    SQLALCHEMY_TRACK_MODIFICATIONS = True
    MAIL_SERVER='smtp.gmail.com'
    MAIL_PORT = 465
    MAIL_USERNAME = 'nineho3@gmail.com'
    MAIL_PASSWORD = 'asdghjkl456'
    MAIL_USE_TLS = False
    MAIL_USE_SSL = True
    ADMINS = ['nineho@gmail.com']
    LANGUAGES = ['en', 'es', 'zh']
    POSTS_PER_PAGE = 25