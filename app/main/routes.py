from datetime import datetime
from flask import render_template, flash, redirect, url_for, request, g, session, jsonify
from flask_login import current_user, login_required
from flask_babel import _, get_locale
from app import current_app, db, admin, mail
from app.main.forms import EditProfileForm, PostForm, CheckLocationForm, PriceListForm, PayForm , MobPriceListForm, RecordForm, UpgradeForm, BookingForm
from app.models import User, Post, Pay, MobPlan,GlobalTalk,EService,SupportTel,ReferralRewards, Announcement,permission, governmentfac, facility, booking_record, Roles, UserRoles, collection,likecount
from app.main import bp
from flask_admin.contrib.sqla import ModelView
from flask_mail import Message

#adminviewsql = db.engine.execute('SELECT Roles.RolesID FROM UserRoles INNER JOIN Roles ON UserRoles.RolesID=Roles.RolesID WHERE UserID=0;')
#print(adminviewsql[0])

class SuperAdminView(ModelView):
    def is_accessible(self):
        adminviewsql = db.engine.execute('SELECT Roles.RolesID FROM UserRoles INNER JOIN Roles ON UserRoles.RolesID=Roles.RolesID WHERE UserID=%s;',current_user.id)
        checkatc1 = [row[0] for row in adminviewsql]
        SuperAdmin = 0
        return checkatc1[0] == SuperAdmin
    def inaccessible_callback(self, name, **kwergs):
        return redirect(url_for('auth.login'),next=request.url)

admin.add_view(SuperAdminView(User, db.session))
admin.add_view(SuperAdminView(governmentfac, db.session))
admin.add_view(SuperAdminView(facility, db.session))
admin.add_view(SuperAdminView(Post, db.session))
admin.add_view(SuperAdminView(booking_record, db.session))
admin.add_view(SuperAdminView(Announcement, db.session))
admin.add_view(SuperAdminView(UserRoles, db.session))
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
    allposts = Post.query.all()
    posts = current_user.followed_posts().paginate(
    #posts = post.query.all(
        page, current_app.config['POSTS_PER_PAGE'], False)
    next_url = url_for('main.Community', page=posts.next_num) \
        if posts.has_next else None
    prev_url = url_for('main.Community', page=posts.prev_num) \
        if posts.has_prev else None
    return render_template('Community.html', title=_('Community'), form=form,
                           posts=posts.items, next_url=next_url,
                           prev_url=prev_url, allposts=allposts)


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
    user = User.query.filter_by(username=username).first_or_404()
    page = request.args.get('page', 1, type=int)
    posts = user.posts.order_by(Post.timestamp.desc()).paginate(
        page, current_app.config['POSTS_PER_PAGE'], False)
    next_url = url_for('main.user', username=user.username, page=posts.next_num) \
        if posts.has_next else None
    prev_url = url_for('main.user', username=user.username, page=posts.prev_num) \
        if posts.has_prev else None
    return render_template('user.html', user=user, posts=posts.items,
                           next_url=next_url, prev_url=prev_url)


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
    
    
@bp.route('/collection', methods=['GET', 'POST'])
def collectionfc():
    if request.method == 'POST':
        #_collid = request.form['TESTCOLL']
        _collid=request.form.get('TESTCOLL')
        #_collid2 = "%{}%".format(_collid)
        print(_collid)
        iscoll = db.engine.execute('SELECT uid, fid FROM collection WHERE uid=%s AND fid=%s;',current_user.id,_collid)
        checkiscoll = [row[0] for row in iscoll]
        if checkiscoll:
            print("wrong")
            flash('This cneter already in your collection')
        else:
            print(checkiscoll)
            incollection = collection(uid=current_user.id, fid=_collid)
            db.session.add(incollection)
            db.session.commit()
            flash('Collectioned')
        return redirect(request.referrer)
    return redirect(request.referrer)
    
@bp.route('/Like', methods=['GET', 'POST'])
def Likee():
    if request.method == 'POST':
        #_collid = request.form['TESTCOLL']
        _collid=request.form.get('TESTCOLL')
        #_collid2 = "%{}%".format(_collid)
        print(_collid)
        iscoll = db.engine.execute('SELECT uid, fid FROM likecount WHERE uid=%s AND fid=%s;',current_user.id,_collid)
        likeresult = db.engine.execute('SELECT Likes FROM governmentfac WHERE govid=%s;',_collid)
        checkiscoll = [row[0] for row in iscoll]
        likess = [row[0] for row in likeresult]
        if checkiscoll:
            print("not success")
            likessplus = likess[0] - 1
            likesspluss = governmentfac.query.get(_collid)
            likesspluss.Likes = likessplus
            incollection = likecount(uid=current_user.id, fid=_collid)
            likecount.query.filter_by(uid=current_user.id, fid=_collid).delete()
            db.session.add(likesspluss)
            db.session.commit()
            return redirect(request.referrer)
        else:
            print("success")
            likessplus = likess[0] + 1
            likesspluss = governmentfac.query.get(_collid)
            likesspluss.Likes = likessplus
            incollection = likecount(uid=current_user.id, fid=_collid)
            db.session.add(incollection, likesspluss)
            db.session.commit()
        return redirect(request.referrer)
    return redirect(request.referrer)

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

@bp.route('/Sendmail', methods=['GET', 'POST'])
def Sendmail():
   msg = Message('Hello', sender = 'nineho3@gmail.com', recipients = ['lkjhgdsazxc@gmail.com'])
   msg.body = "This is the email body"
   mail.send(msg)
   print('sent mail!!')
   return render_template('CONTACT.html', success=True)

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


@bp.route("/RemoveColl",methods=["POST","GET"])
def RemoveColl():
    RemoveColl = request.form['string']
    print(RemoveColl)
    collection.query.filter_by(cid=RemoveColl).delete()
    db.session.commit()
    return redirect(request.referrer)

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

@bp.route('/CheckLike',methods=['GET', 'POST'])
@login_required
def CheckLike():
    cid = collection.query.filter(collection.cid.like(current_user.id))
    Testlike = db.engine.execute('SELECT governmentfac.*, cid FROM collection INNER JOIN governmentfac ON collection.fid=governmentfac.govid WHERE uid=%s;',current_user.id)
                   #            ('SELECT Roles.RolesID FROM UserRoles INNER JOIN Roles ON UserRoles.RolesID=Roles.RolesID WHERE UserID=%s;',current_user.id)
    likels = [row for row in Testlike]
    return render_template('CheckLike.html', cid=cid,likels=likels)

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


@bp.route('/CONTACT', methods=['GET', 'POST'])
@login_required
def CONTACT():
    form = MobPriceListForm()
    return render_template('CONTACT.html')

@bp.route('/aboutus', methods=['GET', 'POST'])
@login_required
def aboutus():
    return render_template('aboutus.html')


@bp.route('/Referral', methods=['GET', 'POST'])
@login_required
def Referral():
    form = MobPriceListForm()
    Plan1 = ReferralRewards.query.get(1)
    Plan2 = ReferralRewards.query.get(2)
    return render_template('Referral.html', form=form,Plan1=Plan1,Plan2=Plan2)

@bp.route('/announcement', methods=['GET', 'POST'])
@login_required
def announcement():
    announcements = Announcement.query.all()
    return render_template('Announcement.html',announcements=announcements)
    