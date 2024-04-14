from django.shortcuts import render
from rest_framework.generics import CreateAPIView, RetrieveUpdateAPIView, GenericAPIView, RetrieveUpdateDestroyAPIView, RetrieveAPIView, ListAPIView
from django.contrib.auth.models import User
from .serializers import *
from rest_framework.response import Response
from rest_framework import status
from .models import Assets
from .business_logic import update_latest_price, order_queue
from rest_framework.permissions import IsAdminUser, IsAuthenticated


class UserSignUpView(CreateAPIView):
    permission_classes = []
    authentication_classes = []
    queryset = User.objects.all()
    serializer_class = UserSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        inst = None
        if serializer.is_valid():
            inst = User.objects.create_user(**serializer.data)
        
        return Response(self.get_serializer(instance = inst).data if inst != None else {"error":serializer.errors}, 
                        status=status.HTTP_201_CREATED)
        
class RetrieveUpdateDestroyUserView(RetrieveUpdateDestroyAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class Login(RetrieveUpdateAPIView):
    def get(self, request, *args, **kwargs):
        return Response({"status":True, "message":"successfully logged in"}, status=status.HTTP_200_OK)

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
        

class BuySellAsset(CreateAPIView):
    queryset = UserHoldings.objects.all()
    serializer_class = BuySellAssetSerializer
    response_serializer_class = BuySellOutputAssetSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data = request.data)
        serializer.is_valid(raise_exception=True)

        obj = Assets.objects.get(pk=serializer.validated_data["asset"])
        if serializer.validated_data["action"] == "sell":
            queue, quantity = order_queue(request.user, obj)
            if quantity < serializer.validated_data["quantity"]:
                return Response({"status":False,"message":"selected quantity for this asset isn't available"},
                                status=status.HTTP_400_BAD_REQUEST
                                )
        current_object = {
            "action":serializer.validated_data["action"],
            "price":obj.current_price,
            "user":request.user,
            "asset":obj,
            "quantity":serializer.validated_data["quantity"]
        }
        inst = UserHoldings.objects.create(**current_object)
        
        serializer =self.response_serializer_class(inst)
        return Response(serializer.data)

class RetrieveAssets(ListAPIView):
    serializer_class = AssetSerializer
    queryset = Assets.objects.all()
    
class RetrieveSpecificAsset(RetrieveAPIView):
    serializer_class = AssetSerializer
    queryset = Assets.objects.all()



class PortfolioInformation(GenericAPIView):
    serializer_class = PortfolioSerializer
    def get(self, request, *args, **kwargs):
        serializer = self.get_serializer()
        return Response(serializer.data)
