@isTest
private class WarehouseCalloutServiceTest {
    @isTest static  void testRunWarehouseEquipmentSync() {
        // Create the mock response based on a static resource
       	Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        // Call method to test
        Test.startTest();
        WarehouseCalloutService.runWarehouseEquipmentSync();
        Test.stopTest();
        // Verify mock response is not null
        Integer count = [SELECT count() from Product2];
        System.assertEquals(count, 1);  
    }
    
    @isTest static  void testRunWarehouseEquipmentSyncOne() {
        // Create the mock response based on a static resource
       	Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        // Call method to test
        Product2 equipment = new Product2();
        equipment.Warehouse_SKU__c = '100003';
        equipment.Name = 'Generator 1000 kW';
        insert equipment;
        Test.startTest();
        WarehouseCalloutService.runWarehouseEquipmentSync();
        Test.stopTest();
        // Verify mock response is not null
        Integer count = [SELECT count() from Product2];
        System.assertEquals(count, 1);  
    }
}