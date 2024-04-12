from django.urls import path
from .views import *
urlpatterns = [
    path('register/', UserSignUpView.as_view()),
    path('login/', Login.as_view()),
    path('update_specific/<int:pk>', UpdateSpecificCurrentPrice.as_view()),
    path('update_all/', UpdateAllCurrentPrices.as_view())
]
