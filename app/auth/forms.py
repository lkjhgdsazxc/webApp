from flask_babel import lazy_gettext as _l, _
from flask_wtf import FlaskForm, RecaptchaField
from wtforms import StringField, PasswordField, BooleanField, SubmitField, ValidationError
from wtforms.validators import DataRequired, Email, EqualTo, Length, Regexp
import re
from app.models import User


class LoginForm(FlaskForm):
    username = StringField(_l('username'), validators=[DataRequired()])
    password = PasswordField(_l('password'), validators=[DataRequired()])
    remember_me = BooleanField(_l('Remember Me'))
    #recaptcha = RecaptchaField()
    submit = SubmitField(_l('Sign In'))


class RegistrationForm(FlaskForm):
    username = StringField(_l('username'), validators=[DataRequired(), Regexp("^[a-zA-Z\d]{4,20}$", message="Only accept letter, number and contain 4 - 20 in username")],render_kw={"placeholder": "Type your Username here"})
    email = StringField(_l('Email'), validators=[DataRequired(), Email()],render_kw={"placeholder": "Type your Email here"})
    password = PasswordField(_l('password'), validators=[DataRequired(), Length(min=8, max=20, message="Password must contain 8 - 20 characters")],render_kw={"placeholder": "Notice above password requirement"})
    password2 = PasswordField(
        _l('Repeat Password'), validators=[DataRequired(),
                                           EqualTo('password')], render_kw={"placeholder": "Type your password again in here"})
    #recaptcha = RecaptchaField()
    submit = SubmitField(_l('Register'))

    def validate_username(self, username):
        user = User.query.filter_by(username=username.data).first()
        if user is not None:
            raise ValidationError(_('Please use a different username.'))

    def validate_email(self, email):
        user = User.query.filter_by(email=email.data).first()
        if user is not None:
            raise ValidationError(_('Please use a different email address.'))
            
    def validate_password(self, password):
        password = password.data
        if re.search(r"[A-Z]", password) is None :
            raise ValidationError(_('Must contain at least 1 uppercase letter'))
        elif re.search(r"[a-z]", password) is None:
            raise ValidationError(_('Must contain at least 1 lowercase letter'))
        elif re.search(r"\W", password) is None:
            raise ValidationError(_('Must contain at least 1 special character'))
        elif re.search(r"\d", password) is None:
            raise ValidationError(_('Must contain at least 1 number'))


class ResetPasswordRequestForm(FlaskForm):
    email = StringField(_l('Email'), validators=[DataRequired(), Email()])
    submit = SubmitField(_l('Request Password Reset'))


class ResetPasswordForm(FlaskForm):
    password = PasswordField(_l('password'), validators=[DataRequired(), Length(min=8, max=20, message="Password must contain 8 - 20 characters")],render_kw={"placeholder": "Notice above password requirement"})
    password2 = PasswordField(
        _l('Repeat Password'), validators=[DataRequired(),
                                           EqualTo('password')], render_kw={"placeholder": "Type your password again in here"})
    #recaptcha = RecaptchaField()                                       
    submit = SubmitField(_l('Request Password Reset'))
    
    def validate_password(self, password):
        password = password.data
        if re.search(r"[A-Z]", password) is None :
            raise ValidationError(_('Must contain at least 1 uppercase letter'))
        elif re.search(r"[a-z]", password) is None:
            raise ValidationError(_('Must contain at least 1 lowercase letter'))
        elif re.search(r"\W", password) is None:
            raise ValidationError(_('Must contain at least 1 special character'))
        elif re.search(r"\d", password) is None:
            raise ValidationError(_('Must contain at least 1 number'))
