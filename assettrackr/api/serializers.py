from rest_framework import serializers
from django.contrib.auth.models import User
from django.contrib.auth.password_validation import validate_password
from rest_framework.exceptions import ValidationError
from .models import *
from django.conf import settings
from .business_logic import order_queue

class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = "__all__"

    def validate(self, attrs):
        attrs = super().validate(attrs)
        password = attrs.get('password')
        try:
            validate_password(password=password, user=self.instance)
        except Exception as e:
            raise ValidationError({"password":e.messages})

        return attrs
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
    quantity = serializers.SerializerMethodField()
    class Meta:
        model = Assets
        fields = ['id', 'show_name', 'asset_type', 'holding_type','current_price','quantity']

    def get_quantity(self, obj):
        total_queue = order_queue(self.context["request"].user, obj)
        return total_queue[1]
    
class BaseAssetSerializer(serializers.Serializer):
    invested = serializers.DecimalField(max_digits=100, decimal_places=2)
    returns_value = serializers.DecimalField(max_digits=100, decimal_places=2)
    current_value = serializers.DecimalField(max_digits=100, decimal_places=2) 
    returns_percentage = serializers.DecimalField(max_digits=100, decimal_places=2)


class EquityAssetSerializer(BaseAssetSerializer):
    stock = BaseAssetSerializer()
    mutual_fund = BaseAssetSerializer()

class DebtAssetSerializer(BaseAssetSerializer):
    mutual_fund = BaseAssetSerializer()

class RealEstateAssetSerializer(BaseAssetSerializer):
    land = BaseAssetSerializer()
    property = BaseAssetSerializer()
    others = BaseAssetSerializer()

class GoldAssetSerializer(BaseAssetSerializer):
    etf = BaseAssetSerializer()

class StockSerializer(BaseAssetSerializer):
    id = serializers.IntegerField()
    show_name = serializers.CharField(max_length = 500)
    quantity = serializers.IntegerField()
    

class MutualFundSerializer(BaseAssetSerializer):
    pass

class ETFSerializer(BaseAssetSerializer):
    pass

class PortfolioSerializer(BaseAssetSerializer):
    equity = BaseAssetSerializer()
    debt = BaseAssetSerializer()
    real_estate = BaseAssetSerializer()
    gold = BaseAssetSerializer()
