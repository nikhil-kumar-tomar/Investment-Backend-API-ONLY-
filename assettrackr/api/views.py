from django.shortcuts import render
from rest_framework.authentication import TokenAuthentication
from rest_framework.generics import CreateAPIView, RetrieveUpdateAPIView, GenericAPIView
from django.contrib.auth.models import User
from .serializers import CreateUserSerializer
from rest_framework.response import Response
from rest_framework import status

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
    

    

