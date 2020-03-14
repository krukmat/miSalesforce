@isTest
public class AddPrimaryContactTest {

    @testSetup 
    static void setup() {
        List<Account> accounts = new List<Account>();
       
        // add 50 accounts with BillingState = 'NY'
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(
                Name = 'NY',
                BillingState='NY'
            ));
        }
        
        // add 50 accounts with BillingState = 'CA'
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(
                Name = 'CA',
                BillingState ='CA'
            ));
        }
        insert accounts;
    }
    
    static testmethod void testQueueable() {
        // query for test data to pass to queueable class
        Contact contact = new Contact(LastName = 'Kruk');
        // Create our Queueable instance
        AddPrimaryContact updater = new AddPrimaryContact(contact, 'CA');
        // startTest/stopTest block to force async processes to run
        Test.startTest();        
        System.enqueueJob(updater);
        Test.stopTest();        
        // Validate the job ran. Check if record have correct parentId now
        System.assertEquals(50, [select count() from contact where LastName = 'Kruk']);
    }
    
}