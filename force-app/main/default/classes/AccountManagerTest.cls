@IsTest
private class AccountManagerTest {
	@isTest static void testGetCaseById() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.salesforce.com/services/apexrest/Accounts/'
            + recordId+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        System.assert(thisAccount != null);
        System.assertEquals('Test record', thisAccount.Name);
        System.assertEquals(2, thisAccount.contacts.size());
    }
    
    // Helper method
    static Id createTestRecord() {
        // Create test record
        Account accountTest = new Account(
            Name='Test record');
        insert accountTest;
        Contact contact1 = new Contact(LastName = 'Pepe', AccountId = accountTest.Id);
		Contact contact2 = new Contact(LastName = 'Papa', AccountId = accountTest.Id);        
        insert contact1;
        insert contact2;
        return accountTest.Id;
        
    } 
}