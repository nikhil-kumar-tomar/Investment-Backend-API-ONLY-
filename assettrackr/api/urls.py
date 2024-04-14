from django.urls import path
from .views import *
urlpatterns = [
    path('register/', UserSignUpView.as_view()),
    path('login/', Login.as_view()),
    path('update_specific/<int:pk>', UpdateSpecificCurrentPrice.as_view()),
    path('update_all/', UpdateAllCurrentPrices.as_view()),
    path("buy_asset/", BuySellAsset.as_view()),
    path("user/<int:pk>",RetrieveUpdateDestroyUserView.as_view()),
    path("assets/",RetrieveAssets.as_view()),
    path("asset/<int:pk>",RetrieveSpecificAsset.as_view()),
    path("portfolio_information/",PortfolioInformation.as_view()),
    
]
