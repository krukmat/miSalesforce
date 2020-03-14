@isTest
private class ParkLocatorTest {
    @isTest static void testCallout() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        // Call the method that invokes a callout
        List<String> result = ParkLocator.country('Japan');
        // Verify that a fake result is returned
        List<String> japan_parks = new List<String>();
        japan_parks.add('Shiretoko National Park');
        japan_parks.add('Oze National Park');
        japan_parks.add('Hakusan National Park');
        
        System.assertEquals(japan_parks, result); 
    }
}