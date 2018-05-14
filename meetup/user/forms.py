
from django import forms


class AuthForm(forms.Form):
    id = forms.IntegerField(label='Your id')
    first = forms.CharField(label='Your first name')
    last = forms.CharField(label='Your last name')
