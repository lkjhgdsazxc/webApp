from datetime import datetime
from flask import render_template, flash, redirect, url_for, request, g, session
from flask_login import current_user, login_required
from flask_babel import _, get_locale
from app import current_app, db
from app.main.forms import EditProfileForm, PostForm, CheckLocationForm, PriceListForm, PayForm , MobPriceListForm, RecordForm, UpgradeForm
from app.models import User, Post, Location, Plan, Pay, MobPlan,GlobalTalk,EService,SupportTel,ReferralRewards, MyTVSuper,permission
from app.main import bp

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

@bp.route('/Mobplanlist', methods=['GET', 'POST'])
@login_required
def Mobplanlist():
    form = MobPriceListForm()
    moblist = MobPlan.query.all()
    moblistone = MobPlan.query.get(11)
    moblisttwo = MobPlan.query.get(12)
    moblistthree = MobPlan.query.get(13)
    print(moblistone)
    return render_template('MobPlan.html', form=form, moblist=moblist, moblistone=moblistone, moblisttwo=moblisttwo, moblistthree=moblistthree)

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
    form = RecordForm()
    Record = Pay.query.get(current_user.id)
    if Record is not None:
        flash(_('You have purchase Record!'))
    elif Record is None:
        flash(_('You are not purchase Record'))
        return redirect(url_for('main.index'))
    return render_template('Record.html',form=form, Record=Record)

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