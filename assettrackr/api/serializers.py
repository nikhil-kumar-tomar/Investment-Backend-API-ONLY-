from rest_framework import serializers
from django.contrib.auth.models import User
from django.contrib.auth.password_validation import validate_password

class CreateUserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = "__all__"

    def validate_password(self, value):
        validate_password(value)
        return value
    
    
