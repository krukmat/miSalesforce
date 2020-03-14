@isTest
private class AnimalLocatorTest {
    @isTest static  void testGetAnimalNameByIdOk() {
        // Create the mock response based on a static resource
       	Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        // Call method to test
        String result = AnimalLocator.getAnimalNameById(1);
        // Verify mock response is not null
        System.assertEquals('chicken', result);  
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('AnimalLocatorMock');
        mock.setStatusCode(404);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Call method to test
        result = AnimalLocator.getAnimalNameById(1);
        // Verify mock response is not null
        System.assertEquals('', result); 
    }
}