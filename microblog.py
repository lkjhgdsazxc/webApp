from app import create_app, db, cli
from app.models import User, Post, Location, Plan, MobPlan, Pay, EService, SupportTel,GlobalTalk,ReferralRewards,MyTVSuper,permission

app = create_app()
cli.register(app)


@app.shell_context_processor
def make_shell_context():
    return {'db': db, 'User': User, 'Post': Post, 'Location': Location, 'Plan': Plan, 'MobPlan': MobPlan, 'Pay': Pay,
            'EService': EService, 'SupportTel':SupportTel,'GlobalTalk':GlobalTalk,'ReferralRewards':ReferralRewards
            ,'MyTVSuper':MyTVSuper,'permission':permission}
