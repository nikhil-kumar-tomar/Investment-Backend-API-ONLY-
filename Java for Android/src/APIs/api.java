package APIs;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import model.Models;
import java.util.Base64;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;


public class api
{
    private static String getEncodedCredentials(JsonObject User)
    {
        String credentials = User.get("username").getAsString() + ":" + User.get("password").getAsString();
        String encodedCredentials = Base64.getEncoder().encodeToString(credentials.getBytes(StandardCharsets.UTF_8));
        String authHeaderValue = "Basic " + encodedCredentials;

        return authHeaderValue;
    }

    private static String urlBuilder(String resource, String queryParams, String id) throws Exception
    {
        String url = "http://127.0.0.1:8000/api" + '/' + resource + '/';
        if (queryParams != null && id != null)
        {
            throw new Exception("queryParams and id both cannot have value at the same time.");
        }

        if (queryParams != null)
        {
            url = url + "?" + queryParams;
        }

        else if (id != null)
        {
            url = url + id;
        }

        return url;
    }

    private static JsonElement jsonConverter(String responseBody) {
        Gson gson = new Gson();
        JsonElement jsonElement = gson.fromJson(responseBody, JsonElement.class);
        return jsonElement;
    }
 
    private static JsonElement getApiCaller(String url, String authHeaderValue) throws Exception
    {
        HttpClient httpClient = HttpClient.newHttpClient();
        HttpRequest.Builder requestBuilder = HttpRequest.newBuilder().uri(URI.create(url));

        if (authHeaderValue != null)
        {
            requestBuilder.header("Authorization", authHeaderValue);
        }

        HttpRequest request = requestBuilder.build();
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        String responseBody = response.body();
        JsonElement jsonElement = jsonConverter(responseBody);
        return jsonElement;
    }

    private static JsonElement postApiCaller(String url, String authHeaderValue, String requestBody) throws Exception
    {

        HttpClient httpClient = HttpClient.newHttpClient();
        HttpRequest.Builder requestBuilder = HttpRequest.newBuilder().uri(URI.create(url));
        if (authHeaderValue != null)
        {
            requestBuilder.header("Authorization", authHeaderValue);
        }
        requestBuilder.header("Content-Type", "application/json");
        if (requestBody != null)
        {
            requestBuilder.POST(HttpRequest.BodyPublishers.ofString(requestBody));
        }
        HttpRequest request = requestBuilder.build();
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        String responseBody = response.body();
        JsonElement jsonElement = jsonConverter(responseBody);
        return jsonElement;
    }


    public static JsonElement callGenericApi(JsonObject User, String resource, String requestMethod, String queryParams, String id, String requestBody)
    {
        String authHeaderValue = getEncodedCredentials(User);
        JsonElement json = null;

        try
        {
            String url = urlBuilder(resource, queryParams, id);     
            if (requestMethod == "get")
            {
                json = getApiCaller(url, authHeaderValue);
            }
            else if (requestMethod == "post")
            {
                json = postApiCaller(url, authHeaderValue, requestBody);
            }
        }
        catch (Exception e)
        {
            System.out.println(e);
        }
        System.out.println(json);

        return json;
    }

    public static JsonElement callRegisterLogin(JsonObject User, String resource, String requestBody)
    {

        String requestMethod=null;
        JsonElement json = null;
        String authHeaderValue=null;
        if (resource == "register")
        {
            requestMethod = "post";
        }
        else if (resource == "login")
        {
            requestMethod = "get";
            authHeaderValue = getEncodedCredentials(User);
        }


        try
        {
            String url = urlBuilder(resource, null, null);     
            if (requestMethod == "get")
            {
                json = getApiCaller(url, authHeaderValue);
            }
            else if (requestMethod == "post")
            {
                
                json = postApiCaller(url, authHeaderValue, requestBody);
            }
        }
        catch (Exception e)
        {
            System.out.println(e);
        }

        System.out.println(json);

        return json;

    }

}