@isTest
private class LeadProcessorTest {

    @testSetup 
    static void setup() {
        List<Lead> leads = new List<Lead>();
        // insert 200 accounts
        for (Integer i=0;i<200;i++) {
            leads.add(new Lead(LeadSource='Web', LastName='Kruk', Company='Kruk'));
        }
        insert leads;
    }

    static testmethod void test() {        
        Test.startTest();
        LeadProcessor uca = new LeadProcessor();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();
        System.assertEquals(200, [select count() from Lead where LeadSource = 'DreamForce']);
    }
    
}