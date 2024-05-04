import requests
from django.conf import settings
from .models import UserHoldings

def url_builder(stock:bool, obj, latest:bool):
    if latest:
        if stock:
            return settings.STOCK_API + f"/query?function=GLOBAL_QUOTE&symbol={obj.fetch_name}.BSE&apikey={settings.STOCK_API_KEY}"
        else:
            return settings.MUTUAL_FUND_API + f"/mf/{obj.id}/latest"
    else:
        if stock:
            return settings.STOCK_API + f"/query?function=TIME_SERIES_MONTHLY&symbol={obj.fetch_name}.BSE&apikey={settings.STOCK_API_KEY}"
        else:
            return settings.MUTUAL_FUND_API + f"/mf/{obj.id}"

def get_api_info(obj, latest: bool):
    if obj.holding_type == "stock":
        request_obj = requests.get(
            url_builder(
                stock=True,
                obj=obj,
                latest=latest
            )
            )
        
    else:
        request_obj = requests.get(
            url_builder(
                stock=False,
                obj=obj,
                latest=latest
            )
            )
    return request_obj.json()
        
def update_latest_price(objects: list[object]):
    for obj in objects:
        request_object = get_api_info(obj, latest=True)
        if obj.holding_type == "mutual_fund":
            obj.current_price = request_object["data"][0]["nav"]
        else:
            i = 0
            while request_object.get("Global Quote", None) == None and i <= 5:
                request_object = get_api_info(obj, latest=True)
                i+=1
            if request_object.get("Global Quote", None) != None:
                print(1)
                obj.current_price = request_object["Global Quote"]["05. price"]
        obj.save()


def order_queue(user:object, asset=None):
    queue = []
    to_delete = set()
    quantity = 0
    holdings = user.holdings.order_by('date')
    if asset != None:
        holdings = user.holdings.filter(asset=asset).order_by('date')

    for holding in holdings:
        if holding.action == "buy":
            queue.append([holding, holding.quantity])
            quantity += holding.quantity
        else:
            sell_quantity = holding.quantity
            quantity -= sell_quantity

            i = 0
            while sell_quantity != 0 and i < len(queue):
                if queue[i][0].asset_id == holding.asset_id:
                    if queue[i][1] - sell_quantity <= 0:
                        sell_quantity = abs(queue[i][1] - sell_quantity)
                        to_delete.add(i)
                    else:
                        queue[i][1] -= sell_quantity 
                        sell_quantity = 0

                i+=1
            
    new_queue = []

    for i in range(len(queue)):
        if i not in to_delete:
            new_queue.append(queue[i])

                    
    return [new_queue, quantity]

def holdings_calculator(order_queue:list[list], asset_type = None, holding_type = None):
    
    returns_object = {
        "invested": 0,
        "returns_value": 0,
        "current_value": 0, 
        "returns_percentage": 0
    }

    if asset_type != None and asset_type in ["equity", "debt", "real_estate", "gold"]:
        order_queue = [[obj,quantity] for obj,quantity in order_queue if obj.asset.asset_type == asset_type]
    
    if holding_type != None and holding_type in ["stock", "mutual_fund", "etf", "land", "property", "others", "digital_gold"]:
        order_queue = [[obj,quantity] for obj,quantity in order_queue if obj.asset.holding_type == holding_type]

    empty = True
    for obj, quantity in order_queue:
        empty = False
        returns_object["invested"] += round(obj.price * quantity, 2)
        returns_object["current_value"] += round(obj.asset.current_price * quantity, 2)
    if not empty:
        returns_object["returns_value"] = round(returns_object["current_value"] - returns_object["invested"], 2)
        returns_object["returns_percentage"] = round((returns_object["returns_value"] / returns_object["invested"])*100 , 2)

    return returns_object


def individual_holding_object(holding: UserHoldings):
    data_object = {
        "invested": 0,
        "returns_value": 0,
        "current_value": 0, 
        "returns_percentage": 0

    }
    if holding:
        data_object["invested"] += round(holding.price * holding.quantity, 2)
        data_object["current_value"] += round(holding.asset.current_price * holding.quantity, 2)

        data_object["returns_value"] = round(data_object["current_value"] - data_object["invested"], 2)
        data_object["returns_percentage"] = round((data_object["returns_value"] / data_object["invested"])*100 , 2)

    return data_object

def individual_object_creator(order_queue : list, asset_type = None, holding_type = None):
    
    data_objects = []
    for holding_and_quantity in order_queue:
        if holding_and_quantity[0].asset.asset_type == asset_type and holding_and_quantity[0].asset.holding_type == holding_type:
            data_object = {
                "id":holding_and_quantity[0].asset_id,
                "show_name":holding_and_quantity[0].asset.show_name,
                "quantity":holding_and_quantity[1],
                **individual_holding_object(holding_and_quantity[0])
            }
            data_objects.append(data_object)
    
    to_delete = set()
    for i in range(0, len(data_objects)):
        if i not in to_delete:
            for j in range(i+1, len(data_objects)):
                if data_objects[i]["id"] == data_objects[j]["id"]:
                    data_objects[i]["invested"] = round(data_objects[i]["invested"] + data_objects[j]["invested"], 2)
                    data_objects[i]["returns_value"] = round(data_objects[i]["returns_value"] + data_objects[j]["returns_value"], 2)
                    data_objects[i]["returns_percentage"] = round((data_objects[i]["returns_value"] / data_objects[i]["invested"]) * 100, 2)
                    data_objects[i]["quantity"] += data_objects[j]["quantity"]
                    to_delete.add(j)

    new_data_objects = []
    for l in range(len(data_objects)):
        if l not in to_delete:
            new_data_objects.append(data_objects[l])

        
    return new_data_objects
