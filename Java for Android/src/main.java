import APIs.api;
import model.Models;
import com.google.gson.JsonElement;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
class main
{
    public static void main(String args[])
    {
        Models user1 = new Models();
        user1.username = "admin";
        user1.password = "123456789";
        JsonArray json = (JsonArray) api.callApi(user1);
        
        for (JsonElement element: json)
        {
            if (element.isJsonObject()) {
            JsonObject jsonObject = element.getAsJsonObject();

            JsonElement value = jsonObject.get("show_name");
            System.out.println(value.getAsString());

        }
    }
}
}