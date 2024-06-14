from typing import Any
from django import forms
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm

from users.models import User


class RegisterUserForm(UserCreationForm):
    username = forms.CharField(label='Логин', widget=forms.TextInput(attrs={'class': 'form-input'}))
    email = forms.CharField(label='Почта', widget=forms.TextInput(attrs={'class': 'form-input'}))
    password1 = forms.CharField(label='Пароль', widget=forms.PasswordInput(attrs={'class': 'form-input'}))
    password2 = forms.CharField(label='Подтверждение пароля', widget=forms.PasswordInput(attrs={'class': 'form-input'}))

    def __init__(self, *args: Any, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['username'].widget.attrs.update({

            'class': 'register_input',

        })
        self.fields["email"].widget.attrs.update({

            'class': 'register_input',

        })
        self.fields["password1"].widget.attrs.update({

            'class': 'register_input',

        })
        self.fields["password2"].widget.attrs.update({

            'class': 'register_input',

        })


    class Meta:
        model = User
        fields = ('username', 'email', 'password1', 'password2')
        widgets = {
            'username': forms.TextInput(attrs={'class': 'form-input'}),
            'email': forms.EmailInput(attrs={'class': 'form-input'}),
            'password1': forms.PasswordInput(attrs={'class': 'form-input'}),
            'password2': forms.PasswordInput(attrs={'class': 'form-input'})
        }



class LoginUserForm(AuthenticationForm):
    username = forms.CharField(label='Логин', widget=forms.TextInput(attrs={'class': 'form-input'}))
    password = forms.CharField(label='Пароль', widget=forms.PasswordInput(attrs={'class': 'form-input'}))

    def __init__(self, *args: Any, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['username'].widget.attrs.update({

            'class': 'login_input',

        })
        self.fields["password"].widget.attrs.update({

            'class': 'login_input',

        })


    class Meta:
        model = User
        fields = ('username', 'password')
        widgets = {
            'username': forms.TextInput(attrs={'class': 'form-input'}),
            'password': forms.PasswordInput(attrs={'class': 'form-input'})
        }