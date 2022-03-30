from datetime import datetime
from flask import render_template, flash, redirect, url_for, request, g, session, jsonify
from flask_login import current_user, login_required
from flask_babel import _, get_locale
from app import current_app, db, admin
from app.main.forms import EditProfileForm, PostForm, CheckLocationForm, PriceListForm, PayForm , MobPriceListForm, RecordForm, UpgradeForm, BookingForm
from app.models import User, Post, Location, Plan, Pay, MobPlan,GlobalTalk,EService,SupportTel,ReferralRewards, MyTVSuper,permission, governmentfac, facility, booking_record, Roles, UserRoles
from app.main import bp
from flask_admin.contrib.sqla import ModelView

with current_app.app_context():
    adminviewsql = db.engine.execute('SELECT Roles.RolesID FROM UserRoles INNER JOIN Roles ON UserRoles.RolesID=Roles.RolesID WHERE UserID=0;')
    print([row[0] for row in adminviewsql])

#adminviewsql = db.engine.execute('SELECT Roles.RolesID FROM UserRoles INNER JOIN Roles ON UserRoles.RolesID=Roles.RolesID WHERE UserID=0;')
#print(adminviewsql)

#class SuperAdminView(ModelView):
#    def is_accessible(self):
#        return adminviewsql == 0
#    def inaccessible_callback(self, name, **kwergs):
#        return redirect(url_for('auth.login'),next=request.url)


#admin.add_view(SuperAdminView(User, db.session))
#admin.add_view(SuperAdminView(governmentfac, db.session))
#admin.add_view(SuperAdminView(Post, db.session))
#admin.add_view(SuperAdminView(booking_record, db.session))
#admin.add_view(SuperAdminView(Roles, db.session))

@bp.before_request
def before_request():
    if current_user.is_authenticated:
        current_user.last_seen = datetime.utcnow()
        db.session.commit()
    g.locale = str(get_locale())


@bp.route('/', methods=['GET', 'POST'])
@bp.route('/index', methods=['GET', 'POST'])
@login_required
def index():
    form = PostForm()
    if form.validate_on_submit():
        post = Post(body=form.post.data, author=current_user)
        db.session.add(post)
        db.session.commit()
        flash(_('Your post is now live!'))
        return redirect(url_for('main.index'))
    page = request.args.get('page', 1, type=int)
    posts = current_user.followed_posts().paginate(
        page, current_app.config['POSTS_PER_PAGE'], False)
    next_url = url_for('main.index', page=posts.next_num) \
        if posts.has_next else None
    prev_url = url_for('main.index', page=posts.prev_num) \
        if posts.has_prev else None
    return render_template('index.html', title=_('Home'), form=form,
                           posts=posts.items, next_url=next_url,
                           prev_url=prev_url)
                           
@bp.route('/', methods=['GET', 'POST'])
@bp.route('/Community', methods=['GET', 'POST'])
@login_required
def Community():
    form = PostForm()
    if form.validate_on_submit():
        post = Post(body=form.post.data, author=current_user)
        db.session.add(post)
        db.session.commit()
        flash(_('Your post is now live!'))
        return redirect(url_for('main.Community'))
    page = request.args.get('page', 1, type=int)
    posts = current_user.followed_posts().paginate(
        page, current_app.config['POSTS_PER_PAGE'], False)
    next_url = url_for('main.Community', page=posts.next_num) \
        if posts.has_next else None
    prev_url = url_for('main.Community', page=posts.prev_num) \
        if posts.has_prev else None
    return render_template('Community.html', title=_('Community'), form=form,
                           posts=posts.items, next_url=next_url,
                           prev_url=prev_url)


@bp.route('/explore')
@login_required
def explore():
    page = request.args.get('page', 1, type=int)
    posts = Post.query.order_by(Post.timestamp.desc()).paginate(
        page, current_app.config['POSTS_PER_PAGE'], False)
    next_url = url_for('main.explore', page=posts.next_num) \
        if posts.has_next else None
    prev_url = url_for('main.explore', page=posts.prev_num) \
        if posts.has_prev else None
    return render_template('index.html', title=_('Explore'),
                           posts=posts.items, next_url=next_url,
                           prev_url=prev_url)


@bp.route('/user/<username>')
@login_required
def user(username):
    permis = permission.query.get(current_user.id)
    user = User.query.filter_by(username=username).first_or_404()
    page = request.args.get('page', 1, type=int)
    posts = user.posts.order_by(Post.timestamp.desc()).paginate(
        page, current_app.config['POSTS_PER_PAGE'], False)
    next_url = url_for('main.user', username=user.username, page=posts.next_num) \
        if posts.has_next else None
    prev_url = url_for('main.user', username=user.username, page=posts.prev_num) \
        if posts.has_prev else None
    return render_template('user.html', user=user, posts=posts.items,
                           next_url=next_url, prev_url=prev_url,permis=permis)


@bp.route('/edit_profile', methods=['GET', 'POST'])
@login_required
def edit_profile():
    form = EditProfileForm(current_user.username)
    if form.validate_on_submit():
        current_user.username = form.username.data
        current_user.about_me = form.about_me.data
        db.session.commit()
        flash(_('Your changes have been saved.'))
        return redirect(url_for('main.edit_profile'))
    elif request.method == 'GET':
        form.username.data = current_user.username
        form.about_me.data = current_user.about_me
    return render_template('edit_profile.html', title=_('Edit Profile'),
                           form=form)


@bp.route('/follow/<username>')
@login_required
def follow(username):
    user = User.query.filter_by(username=username).first()
    if user is None:
        flash(_('User %(username)s not found.', username=username))
        return redirect(url_for('main.index'))
    if user == current_user:
        flash(_('You cannot follow yourself!'))
        return redirect(url_for('main.user', username=username))
    current_user.follow(user)
    db.session.commit()
    flash(_('You are following %(username)s!', username=username))
    return redirect(url_for('main.user', username=username))


@bp.route('/unfollow/<username>')
@login_required
def unfollow(username):
    user = User.query.filter_by(username=username).first()
    if user is None:
        flash(_('User %(username)s not found.', username=username))
        return redirect(url_for('main.index'))
    if user == current_user:
        flash(_('You cannot unfollow yourself!'))
        return redirect(url_for('main.user', username=username))
    current_user.unfollow(user)
    db.session.commit()
    flash(_('You are not following %(username)s.', username=username))
    return redirect(url_for('main.user', username=username))


@bp.route('/check_location', methods=['GET', 'POST'])
@login_required
def check_location():
    form = CheckLocationForm()
    location = bool(Location.query.filter_by(Street=form.loca.data).first())
    if form.validate_on_submit():
        print(location)
        if location == True :
            flash(_('Choose your plan!'))
            return redirect(url_for('main.planlist'))
            endif
        elif location == False:
            flash(_('Sorry, There not service support'))
            return redirect(url_for('main.check_location'))
    return render_template('check_location.html',
                           form=form)


@bp.route('/planlist', methods=['GET', 'POST'])
@login_required
def planlist():
    form = PriceListForm()
    list = Plan.query.all()
    listone = Plan.query.get(1)
    listtwo = Plan.query.get(2)
    listthree = Plan.query.get(3)
    return render_template('plan.html', form=form, list=list, listone=listone, listtwo=listtwo, listthree=listthree)

@bp.route('/Mobplanlist', methods=['GET', 'POST'], defaults={"page": 1})
@bp.route('/Mobplanlist/<int:page>', methods=['GET', 'POST'])
@login_required
def Mobplanlist(page):
    page = page
    pages = 10
    form = MobPriceListForm()
    group = governmentfac.query.group_by(governmentfac.District).all()
    group2 = governmentfac.query.group_by(governmentfac.Category).all()
    govlist = governmentfac.query.order_by(governmentfac.govid.asc()).paginate(page,pages,error_out=False)
    if request.method == 'POST' and 'searchbar' in request.form:
        searchbar = request.form["searchbar"]
        Search = "%{}%".format(searchbar)
        searchbar1 = request.form["searchbar1"]
        Search1 = "%{}%".format(searchbar1)
        searchbar2 = request.form["searchbar2"]
        Search2 = "%{}%".format(searchbar2)
        govlist = governmentfac.query.filter(governmentfac.Venue_Name.like(Search),governmentfac.Category.like(Search1),governmentfac.District.like(Search2)).paginate(per_page=pages, error_out=False) # LIKE: query.filter(User.name.like('%ednalan%'))
        return render_template('MobPlan.html', govlist=govlist, searchbar=searchbar,searchbar1=searchbar1,searchbar2=searchbar2,group2=group2, group=group)
    return render_template('MobPlan.html', form=form, govlist=govlist,group2=group2, group=group)

@bp.route('/', methods=['GET', 'POST'])
@bp.route("/booking",methods=["POST","GET"])
def booking():
    if request.method == 'POST':
        faclist = facility.query.all()
        govid = request.form['govid']
        popup = governmentfac.query.get(govid)
    return jsonify({'htmlresponse': render_template('booking.html',popup=popup,faclist=faclist)})
    
@bp.route('/book_insert', methods=['GET', 'POST'])
def book_insert():
    if request.method == 'POST': 
        center = request.form['center']
        faclists = request.form['faclists']
        date = request.form['date']
        stime = request.form['stime']
        etime = request.form['etime']
        results = db.engine.execute('SELECT STATUS FROM booking_record WHERE center=%s AND faclists=%s AND bdate=%s AND starttime BETWEEN %s AND %s AND endtime BETWEEN %s AND %s AND status="active";',center, faclists, date,stime,etime,stime,etime)
        checkatc = [row[0] for row in results]
        if checkatc:
            print("wrong")
            return jsonify('rejected')
        else:
            print(checkatc)
            BookingRc = booking_record(id=current_user.id, center=center,faclists=faclists, bdate=date, starttime=stime,endtime=etime,status="active")
            db.session.add(BookingRc)
            db.session.commit()
            return jsonify('success')


    
@bp.route('/TEST', methods=['GET', 'POST'])
def Test():
    date = '2022-03-20'
    stime = '13:34'
    etime = '14:34'
    results = db.engine.execute('SELECT STATUS FROM booking_record WHERE bdate=%s AND starttime BETWEEN %s AND %s AND endtime BETWEEN %s AND %s;',date,stime,etime,stime,etime)
    adminviewsql = db.engine.execute('SELECT Roles.RolesID FROM UserRoles INNER JOIN Roles ON UserRoles.RolesID=Roles.RolesID WHERE UserID=0;')
    print([row[0] for row in adminviewsql])
    print([row[0] for row in results])
    check_datetime= booking_record.query.filter(booking_record.starttime.between(stime, etime))
    return render_template('TEST.html',check_datetime=check_datetime)

@bp.route('/', methods=['GET', 'POST'])
def Adminpg():
    adminviewsql = db.engine.execute('SELECT Roles.RolesID FROM UserRoles INNER JOIN Roles ON UserRoles.RolesID=Roles.RolesID WHERE UserID=0;')
    print([row[0] for row in adminviewsql])
    print("Test")
    return redirect(url_for('/'))



@bp.route("/cancelbook",methods=["POST","GET"])
def cancelbook():
    cancelbook = request.form['string']
    print(cancelbook)
    cancel = booking_record.query.get(cancelbook)
    cancel.status = 'Canceled'
    db.session.commit()
    return render_template('Record.html')



#@bp.route("/timecounting",methods=["POST","GET"])
#def timecounting():
 #   stime = request.form["stime"]
  #  etime = request.form["stime"]
   # FMT = '%H:%M'
    #tdelta = datetime.strptime(etime, FMT) - datetime.strptime(stime, FMT)


@bp.route('/PaySite',methods=['GET', 'POST'])
@login_required
def PaySite():
    form = PayForm()
    if form.validate_on_submit():
        now = datetime.now()
        Payinfo = Pay(id=current_user.id, planid=form.planid.data, Paydate=now)
        db.session.add(Payinfo)
        db.session.commit()
        flash(_('Thanks for your purchase!'))
        return redirect(url_for('main.index'))
    return render_template('PaySite.html', form=form)

@bp.route('/CheckRecord',methods=['GET', 'POST'])
@login_required
def CheckRecord():
    Record = booking_record.query.filter(booking_record.id.like(current_user.id))
    return render_template('Record.html', Record=Record)

@bp.route('/Upgrade',methods=['GET', 'POST'])
@login_required
def Upgrade():
    form = UpgradeForm()
    Record = Pay.query.get(current_user.id)
    if Record is not None:
        flash(_('Enter the plan name you want to upgrade'))
        if form.validate_on_submit():
            now = datetime.now()
            user = Pay.query.get(current_user.id)
            db.session.delete(user)
            Payinfo = Pay(id=current_user.id, planid=form.planname.data, Paydate=now)
            db.session.add(Payinfo)
            db.session.commit()
            flash(_('Upgrade successful'))
            return redirect(url_for('main.Upgrade'))
    else:
        flash(_('You not have any plan, please choose one'))
        return redirect(url_for('main.planlist'))
    return render_template('Upgrade.html',form=form)


@bp.route('/GlobalTalk', methods=['GET', 'POST'])
@login_required
def GlobalSite():
    form = MobPriceListForm()
    Globfun1 = GlobalTalk.query.get('Save the global call fee')
    Globfun2 = GlobalTalk.query.get('High security')
    Globfun3 = GlobalTalk.query.get('Call Hong Kong number is free!')
    return render_template('Global.html', form=form,Globfun1=Globfun1,Globfun2=Globfun2,Globfun3=Globfun3)


@bp.route('/Service', methods=['GET', 'POST'])
@login_required
def Service():
    form = MobPriceListForm()
    Servies = EService.query.all()
    Ser1 = EService.query.get(1)
    Ser2 = EService.query.get(2)
    Ser3 = EService.query.get(3)
    Ser4 = EService.query.get(4)
    Ser5 = EService.query.get(5)
    Ser6 = EService.query.get(6)
    return render_template('Service.html', form=form,Servies=Servies
                           ,Ser1=Ser1,Ser2=Ser2,Ser3=Ser3,Ser4=Ser4,
                           Ser5=Ser5,Ser6=Ser6)

@bp.route('/aboutus', methods=['GET', 'POST'])
@login_required
def aboutus():
    form = MobPriceListForm()
    Tel1 = SupportTel.query.get(11112222)
    Tel2 = SupportTel.query.get(22223333)
    Tel3 = SupportTel.query.get(33334444)

    return render_template('aboutus.html', form=form,Tel1=Tel1,Tel2=Tel2,Tel3=Tel3)


@bp.route('/Referral', methods=['GET', 'POST'])
@login_required
def Referral():
    form = MobPriceListForm()
    Plan1 = ReferralRewards.query.get(1)
    Plan2 = ReferralRewards.query.get(2)
    return render_template('Referral.html', form=form,Plan1=Plan1,Plan2=Plan2)

@bp.route('/entertainment', methods=['GET', 'POST'])
@login_required
def entertainment():
    form = MobPriceListForm()
    Plan1 = MyTVSuper.query.get(1)
    Plan2 = MyTVSuper.query.get(2)
    return render_template('MyTVSuper.html', form=form,Plan1=Plan1,Plan2=Plan2)
    