from django.shortcuts import render
from rest_framework.generics import CreateAPIView, RetrieveUpdateAPIView, GenericAPIView, RetrieveAPIView
from django.contrib.auth.models import User
from .serializers import *
from rest_framework.response import Response
from rest_framework import status
from .models import Assets
from .business_logic import update_latest_price

class UserSignUpView(CreateAPIView):
    permission_classes = []
    authentication_classes = []
    queryset = User.objects.all()
    serializer_class = CreateUserSerializer
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        inst = None
        if serializer.is_valid():
            inst = User.objects.create_user(**serializer.data)
        
        return Response(self.get_serializer(instance = inst).data if inst != None else {"error":serializer.errors}, 
                        status=status.HTTP_201_CREATED)
        

class Login(RetrieveUpdateAPIView):
    def get(self, request, *args, **kwargs):
        return Response({"status":True}, status=status.HTTP_200_OK)

class UpdateSpecificCurrentPrice(GenericAPIView):
    def get(self, request, *args, **kwargs):
        obj = Assets.objects.get(pk=kwargs["pk"])
        update_latest_price([obj])
        return Response({"Status": True, "message":"Price Updated"}, status=status.HTTP_200_OK)
class UpdateAllCurrentPrices(GenericAPIView):
    queryset = Assets.objects.all()
    def get(self, request, *args, **kwargs):
        objects = self.get_queryset()
        update_latest_price(objects)
        return Response({"Status": True, "message":"Price Updated"}, status=status.HTTP_200_OK)
        


