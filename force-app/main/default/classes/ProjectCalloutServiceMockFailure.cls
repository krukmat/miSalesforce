@isTest
global class ProjectCalloutServiceMockFailure implements HttpCalloutMock {   	
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(400);
        response.setStatus('Bad Request');
        return response; 
	}
}