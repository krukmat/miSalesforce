public with sharing class CovidIntegrationCallout {
    public final static String URL = 'https://googlecovid.herokuapp.com/api/scrape/?email=%1&firstname=%2&lastname=%3';  
    public List<IntegrationResponse> results = new List<IntegrationResponse>();

    public class IntegrationResponse {
        public String url;
        public Map<String, Integer> cloud;
    }
    public  void  doCallout(String email, String firstname, String lastname) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setTimeout(120000);
            String url = URL.replace('%1', email);
            url = url.replace('%2', firstname);
            url = url.replace('%3', lastname);
            request.setEndpoint(url);
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            // If the request is successful, parse the JSON response.
            if (response.getStatusCode() == 200) {
                // Deserialize the JSON string into collections of primitive data types.
                results = (List<IntegrationResponse>) JSON.deserialize(response.getBody(), List<IntegrationResponse>.class);                
                system.debug(results);
            }
    }
}


