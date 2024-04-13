from rest_framework import serializers
from django.contrib.auth.models import User
from django.contrib.auth.password_validation import validate_password
from rest_framework.exceptions import ValidationError
from .models import *

class CreateUserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = "__all__"

    def validate_password(self, value):
        validate_password(value)
        return value
    

class BuyAssetSerializer(serializers.Serializer):
    quantity = serializers.IntegerField()
    asset = serializers.IntegerField()

    def validate(self, attrs):
        if attrs.get("asset", None) == None or attrs.get("quantity", None) == None:
            raise ValidationError({"error":"Please correctly provide asset and quantity both"})
        return attrs
    
class ShownBuyAssetSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserHoldings
        fields = "__all__"
