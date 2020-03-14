@isTest
global class MockApexWebService implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // TODO: Devolver algo
        response.setBody('{}');
        response.setStatusCode(200);
        return response; 
    }
}