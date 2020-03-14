@isTest
private class SyncContactsTest {

    @testSetup 
    static void setup() {
        List<Contact> contacts = new List<Contact>();
        // insert 100 contacts
        for (Integer i=0;i<100;i++) {
            contacts.add(new Contact(firstname='first', 
                lastname='last', email='email'+String.valueOf(i)+'@mail.com'));
        }
        insert contacts;
    }

    static testmethod void testSync() {
        /*
           Testing the batch call SyncContacts
        */

    	Test.startTest();
    	Test.setMock(HttpCalloutMock.class, new MockApexWebService());
        SyncContacts batchJob = new SyncContacts();
        Id batchId = Database.executeBatch(batchJob, 100);
        Test.stopTest();
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob where Id = :batchId];
		System.assertEquals(job.Id, batchId);
    }
    
}