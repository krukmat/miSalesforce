@isTest
private class ExternalOrgEndPointTest {

    @testSetup 
    static void setup() {
        List<Contact> contacts = new List<Contact>();
        // insert 1000 contacts
        for (Integer i=0;i<1000;i++) {
            contacts.add(new Contact(firstname='first', 
                lastname='last', email='email'+String.valueOf(i)+'@mail.com', phone='1234-000-3344'));
        }
        insert contacts;
    }

    @isTest static void testCallout() {
        /*
           Testing a single callout to ExternalOrgEndPoint.makeOrgEndpointCall
        */
    	Test.startTest();
    	Test.setMock(HttpCalloutMock.class, new MockApexWebService());
    	Contact contact = [ SELECT Id, FirstName, LastName, Email, Phone from Contact ][0]; 
    	HttpResponse response = ExternalOrgEndPoint.makeOrgEndpointCall(contact);
    	Test.stopTest();
    	System.assertEquals(200, response.getStatusCode(), 'The status code is not 201.');

   	}

}