from django.shortcuts import render
from rest_framework.generics import CreateAPIView, RetrieveUpdateAPIView, GenericAPIView, RetrieveUpdateDestroyAPIView, RetrieveAPIView, ListAPIView
from django.contrib.auth.models import User
from .serializers import *
from rest_framework.response import Response
from rest_framework import status
from .models import Assets
from .business_logic import *
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
            validated_data = serializer.validated_data
            password = validated_data.pop('password')
            inst = User.objects.create_user(**validated_data, password=password) 
        return Response(self.get_serializer(instance = inst).data if inst != None else {"error":serializer.errors}, 
                        status=status.HTTP_201_CREATED)
        
class RetrieveUpdateDestroyUserView(RetrieveUpdateDestroyAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class Login(RetrieveUpdateAPIView):
    def get(self, request, *args, **kwargs):
        return Response(
            {
                "status":True, 
                "message":"successfully logged in",
                "first_name":self.request.user.first_name,
            }, 
            status=status.HTTP_200_OK)

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

class UpdateAllCurrentUserPrices(GenericAPIView):
    queryset = Assets.objects.all()
    def get(self, request, *args, **kwargs):
        all_held_assets = [x[0].asset for x in order_queue(self.request.user)[0]]
        update_latest_price(all_held_assets)
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

    def get_queryset(self):
        queryset = Assets.objects.all()

        asset_type = self.request.query_params.get('asset_type')
        holding_type = self.request.query_params.get('holding_type')

        if asset_type:
            queryset = queryset.filter(asset_type=asset_type)
        if holding_type:
            queryset = queryset.filter(holding_type=holding_type)

        return queryset

    
class RetrieveSpecificAsset(RetrieveAPIView):
    serializer_class = AssetSerializer
    queryset = Assets.objects.all()

class PortfolioInformation(GenericAPIView):
    serializer_class = PortfolioSerializer

    def get(self, request, *args, **kwargs):
        asset_type = request.query_params.get('asset_type', None)
        holding_type= request.query_params.get('holding_type', None)

        if holding_type != None and asset_type == None:
            raise ValidationError({"message":"holding type cannot be defined alone, either define it with asset_type or do not."})
        
        user_order_queue = order_queue(request.user)
                
        if holding_type == None and asset_type != None :
            if asset_type == "equity":
                data_object = {
                **holdings_calculator(user_order_queue[0], "equity"),
                "stock": holdings_calculator(user_order_queue[0], "equity", "stock"),
                "mutual_fund": holdings_calculator(user_order_queue[0], "equity", "mutual_fund"),
                }

                serializer = EquityAssetSerializer(data=data_object)
                
            elif asset_type == "debt":
                data_object = {
                **holdings_calculator(user_order_queue[0], "debt"),
                "mutual_fund": holdings_calculator(user_order_queue[0], "debt", "mutual_fund"),
                }
                serializer = DebtAssetSerializer(data=data_object)
            elif asset_type == "real_estate":
                data_object = {
                **holdings_calculator(user_order_queue[0], "real_estate"),
                "land": holdings_calculator(user_order_queue[0], "real_estate", "land"),
                "property": holdings_calculator(user_order_queue[0], "real_estate", "property"),
                "others": holdings_calculator(user_order_queue[0], "real_estate", "others")
                }
                serializer = RealEstateAssetSerializer(data=data_object)
            elif asset_type == "gold":
                data_object = {
                **holdings_calculator(user_order_queue[0], "gold"),
                "etf": holdings_calculator(user_order_queue[0], "gold", "etf"),
                "mutual_fund": holdings_calculator(user_order_queue[0], "gold", "mutual_fund"),
                "digital_gold": holdings_calculator(user_order_queue[0], "gold", "digital_gold")
                }
                serializer = GoldAssetSerializer(data=data_object)
    
        elif holding_type != None and asset_type != None:
            data_objects = []
            data_objects.extend(individual_object_creator(user_order_queue[0], asset_type, holding_type))
            data_object = holdings_calculator(user_order_queue[0], asset_type, holding_type)
            data_object["stocks"] = data_objects
            serializer = UserStockSerializer(data = data_object)
            
        else:
            data_object = {
            **holdings_calculator(user_order_queue[0]),
            "equity": holdings_calculator(user_order_queue[0], "equity"),
            "debt": holdings_calculator(user_order_queue[0], "debt"),
            "real_estate": holdings_calculator(user_order_queue[0], "real_estate"),
            "gold": holdings_calculator(user_order_queue[0], "gold"),
            }
            serializer = PortfolioSerializer(data=data_object)



        serializer.is_valid(raise_exception=True)
        return Response(serializer.data)

