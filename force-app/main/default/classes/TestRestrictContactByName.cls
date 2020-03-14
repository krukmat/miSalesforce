@isTest
private class TestRestrictContactByName {

    @isTest static void TestRestrictContactByNameWithInvalidName() {
        // Test data setup
        // Create an account with an opportunity, and then try to delete it
        Test.startTest();
        Contact ct = new Contact(LastName='INVALIDNAME');
        Database.SaveResult result = Database.insert(ct);
        Test.stopTest();

        // Verify 
        // In this case the deletion should have been stopped by the trigger,
        // so verify that we got back an error.
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('The Last Name "'+ct.LastName+'" is not allowed for DML',
                             result.getErrors()[0].getMessage());
    }
    
}