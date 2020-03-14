public class ExternalOrgEndPoint {
	private static String clientId = '3MVG9HxRZv05HarTKbdXpaLOTyRvrUA3u7ZgKVrS74pW3AeoiqA.IB1XQ0bSOhWeDzeAK6lb29UginVGHgEfm';
	private static String clientSecret = '5654190568942838832';

	private static String username = 'krukmat_666@s4g.com';
	private static String password = 'KrukMatias78mnr7RMyvgZYGp5j8JayHNLcqA';  // Password + Token Key
	private static String apexEndPoint = 'https://eu11.salesforce.com/';


	public static String login () {
		String reqbody = 'grant_type=password&client_id='+ExternalOrgEndPoint.clientId+'&client_secret='+ExternalOrgEndPoint.clientSecret+'&username='+ExternalOrgEndPoint.username+'&password='+ ExternalOrgEndPoint.password;

		Http http = new Http();
		HttpRequest req = new HttpRequest();
		req.setBody(reqbody);
		req.setMethod('POST');
		req.setEndPoint('https://login.salesforce.com/services/oauth2/token');

		HttpResponse response = http.send(req);
		Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
		String sessionId = (String)results.get('access_token');
		return sessionId;
	}

	public static HttpResponse syncContact(HttpRequest req, Contact contact) {

		req.setEndpoint( ExternalOrgEndPoint.apexEndPoint + 'services/apexrest/Contacts');
		req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');

        // Definition of the main attributes to be send to the Partner org.
		ContactBean contactBean = new ContactBean(contact);

        req.setBody(JSON.serialize(contactBean));

        Http http = new Http();

        HttpResponse response = http.send(req);

        return response;
	}
	public static HttpResponse makeOrgEndpointCall(Contact contact) {

		HttpRequest req = new HttpRequest();  

		// In order to use the SOAP to extract the sessionId, is necessary the code should not be run in Test.
		if (!Test.isRunningTest()) {
			String sessionId = ExternalOrgEndPoint.login();
			// Encabezado de seguridad
			req.setHeader('Authorization','Bearer ' + sessionId);
		}

        return ExternalOrgEndPoint.syncContact(req, contact);
	}
}