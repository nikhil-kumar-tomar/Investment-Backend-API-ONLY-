import requests
from django.conf import settings

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
            while sell_quantity != 0:
                if queue[0][1] - sell_quantity <= 0:
                    sell_quantity = abs(queue[0][1] - sell_quantity)
                    queue.pop(0)
                else:
                    queue[0][1] -= sell_quantity 
                    sell_quantity = 0
                    
    return [queue, quantity]

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
