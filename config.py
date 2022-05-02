import os

basedir = os.path.abspath(os.path.dirname(__file__))


class Config(object):
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'you-will-never-guess'
    SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://root:rootroot@fyp-database.czk7gbc2rlgh.us-east-1.rds.amazonaws.com/FYP_DATABASE'
    RECAPTCHA_PUBLIC_KEY = "6LcKzeseAAAAAJRtKNAVnH8Hb1DFKI4mWBZaUzML"
    RECAPTCHA_PRIVATE_KEY = "6LcKzeseAAAAAGnvjQF1yFCUEb16qtkUl9mBwWZF"
    SQLALCHEMY_TRACK_MODIFICATIONS = True
    MAIL_SERVER='smtp.gmail.com'
    MAIL_PORT = 465
    MAIL_USERNAME = 'nineho3@gmail.com'
    MAIL_PASSWORD = '##'
    MAIL_USE_TLS = False
    MAIL_USE_SSL = True
    ADMINS = ['nineho@gmail.com']
    LANGUAGES = ['en', 'es', 'zh']
    POSTS_PER_PAGE = 25
