from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, \
    TextAreaField
from wtforms.validators import ValidationError, DataRequired, Length
from flask_babel import _, lazy_gettext as _l
from app.models import User, Plan


class EditProfileForm(FlaskForm):
    username = StringField(_l('Username'), validators=[DataRequired()])
    about_me = TextAreaField(_l('About me'),
                             validators=[Length(min=0, max=140)])
    submit = SubmitField(_l('Submit'))

    def __init__(self, original_username, *args, **kwargs):
        super(EditProfileForm, self).__init__(*args, **kwargs)
        self.original_username = original_username

    def validate_username(self, username):
        if username.data != self.original_username:
            user = User.query.filter_by(username=self.username.data).first()
            if user is not None:
                raise ValidationError(_('Please use a different username.'))


class PostForm(FlaskForm):
    post = TextAreaField(_l('Say something'), validators=[DataRequired()])
    submit = SubmitField(_l('Submit'))


class CheckLocationForm(FlaskForm):
    loca = StringField(validators=[DataRequired()])
    submit = SubmitField(_l('Submit'))

class PriceListForm(FlaskForm):
    Speed = StringField(_l('What Speed you want? eg.100Mbps'), validators=[DataRequired()])
    submit = SubmitField(_l('Submit'))

class MobPriceListForm(FlaskForm):
    Speed = StringField(_l('What Speed you want? eg.100Mbps'), validators=[DataRequired()])
    submit = SubmitField(_l('Submit'))

class PayForm(FlaskForm):
    planid =  StringField(_l('Please Enter Plan Name'), validators=[DataRequired()])
    submit = SubmitField(_l('Submit'))

class RecordForm(FlaskForm):
    username = StringField(_l('Username'), validators=[DataRequired()])
    about_me = TextAreaField(_l('About me'),
                             validators=[Length(min=0, max=140)])
    submit = SubmitField(_l('Submit'))

class UpgradeForm(FlaskForm):
    planname =  StringField(_l('Please Enter Plan Name'), validators=[DataRequired()])
    submit = SubmitField(_l('Submit'))
