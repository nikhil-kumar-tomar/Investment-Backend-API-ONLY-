import APIs.api;
import model.Models;
import com.google.gson.JsonElement;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
class main
{
    public static void main(String args[])
    {
        JsonObject user1 = new JsonObject();
        // user1.addProperty("username", "admin");
        // user1.addProperty("password", "123456789");
        user1.addProperty("username","nikhil931");
        user1.addProperty("password","Nikhil@931");
        // JsonObject share_buy = new JsonObject();
        // share_buy.addProperty("action","sell");
        // share_buy.addProperty("asset",1);
        // share_buy.addProperty("quantity",10);

        // api.callGenericApi(user1, "assets", "get", null, null, null);
        // System.out.println(user1.toString());
        api.callRegisterLogin(user1, "login", null);
        // JsonArray json = (JsonArray) api.callApi(user1, "asset", null, "1");
        
    //     for (JsonElement element: json)
    //     {
    //         if (element.isJsonObject()) {
    //         JsonObject jsonObject = element.getAsJsonObject();

    //         JsonElement value = jsonObject.get("show_name");
    //         System.out.println(value.getAsString());

    //     }
    // }
}
}