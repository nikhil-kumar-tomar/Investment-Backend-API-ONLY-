package APIs;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import model.Models;
import java.util.Base64;
import java.nio.charset.StandardCharsets;



public class api
{
    private static String getEncodedCredentials(Models User)
    {
        String credentials = User.username + ":" + User.password;
        String encodedCredentials = Base64.getEncoder().encodeToString(credentials.getBytes(StandardCharsets.UTF_8));
        String authHeaderValue = "Basic " + encodedCredentials;

        return authHeaderValue;
    }

    private static String urlBuilder(String resource)
    {
        String url = "http://127.0.0.1:8000/api" + '/' + resource + '/';
        return url;
    }

    private static JsonElement jsonConverter(String responseBody) {
        Gson gson = new Gson();
        JsonElement jsonElement = gson.fromJson(responseBody, JsonElement.class);
        return jsonElement;
    }
 
    private static JsonElement apiCaller(String resource, String authHeaderValue) throws Exception
    {
        HttpClient httpClient = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(urlBuilder(resource)))
                .header("Authorization", authHeaderValue)
                .build();
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        String responseBody = response.body();
        JsonElement jsonElement = jsonConverter(responseBody);
        return jsonElement;
    }

    public static JsonElement callApi(Models User)
    {
        String authHeaderValue = getEncodedCredentials(User);
        JsonElement json = null;
        try
        {
            json = apiCaller("assets", authHeaderValue);
        }
        catch (Exception e)
        {
            System.out.println(e);
        }

        return json;
    }

}