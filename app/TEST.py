from datetime import datetime
from flask import render_template, flash, redirect, url_for, request, g
from flask_login import current_user, login_required
from flask_babel import _, get_locale
from app import current_app, db
from app.main.forms import EditProfileForm, PostForm, CheckLocationForm
from app.models import User, Post, Location, Plan
from app.main import bp
from datetime import datetime
from flask import render_template, flash, redirect, url_for, request, g, session
from flask_login import current_user, login_required
from flask_babel import _, get_locale
from app import current_app, db
from app.main.forms import EditProfileForm, PostForm, CheckLocationForm, PriceListForm, PayForm , MobPriceListForm, RecordForm, UpgradeForm
from app.models import User, Post, Location, Plan, Pay, MobPlan,GlobalTalk,EService,SupportTel,ReferralRewards, MyTVSuper,permission, Governmentfac
from app.main import bp

































































































