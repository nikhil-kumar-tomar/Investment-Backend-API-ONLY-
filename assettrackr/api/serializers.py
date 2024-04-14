from rest_framework import serializers
from django.contrib.auth.models import User
from django.contrib.auth.password_validation import validate_password
from rest_framework.exceptions import ValidationError
from .models import *

class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = "__all__"

    def validate_password(self, value):
        validate_password(value)
        return value
    

class BuySellAssetSerializer(serializers.Serializer):
    action = serializers.CharField()
    quantity = serializers.IntegerField()
    asset = serializers.IntegerField()

    def validate(self, attrs):
        if attrs.get("action") not in ["buy","sell"]:
            raise ValidationError({"action":"Please either choose buy or sell only"})
        if attrs.get("quantity") <= 0:
            raise ValidationError({"quantity":"Please Choose value higher than or equal to 1"})
        return attrs
    
class BuySellOutputAssetSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserHoldings
        fields = "__all__"

class AssetSerializer(serializers.ModelSerializer):
    class Meta:
        model = Assets
        fields = ['id', 'show_name', 'asset_type', 'holding_type','current_price']

class BaseAssetSerializer(serializers.Serializer):
    invested = serializers.DecimalField(max_digits=100, decimal_places=2)
    returns_value = serializers.DecimalField(max_digits=100, decimal_places=2)
    current_value = serializers.DecimalField(max_digits=100, decimal_places=2) 
    returns_percentage = serializers.DecimalField(max_digits=100, decimal_places=2)


class EquityAssetSerializer(BaseAssetSerializer):
    stocks = BaseAssetSerializer()
    mutual_funds = BaseAssetSerializer()

class DebtAssetSerializer(BaseAssetSerializer):
    pass

class RealEstateAssetSerializer(BaseAssetSerializer):
    pass

class GoldAssetSerializer(BaseAssetSerializer):
    pass

class StockSerializer(BaseAssetSerializer):
    pass

class MutualFundSerializer(BaseAssetSerializer):
    pass

class ETFSerializer(BaseAssetSerializer):
    pass

class PortfolioSerializer(BaseAssetSerializer):
    equity = BaseAssetSerializer()
    debt = BaseAssetSerializer()
    real_estate = BaseAssetSerializer()
    gold = BaseAssetSerializer()
