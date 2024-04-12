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
