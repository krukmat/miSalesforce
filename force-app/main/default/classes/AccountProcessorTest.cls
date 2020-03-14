@IsTest
private class AccountProcessorTest {
  @IsTest
  private static void testCountContacts() {
    Account account = new Account(name='Lalala');
    insert account;
    for (Integer i=0;i<10;i++){
        Contact ct = new Contact( LastName = 'Lolo');
        ct.accountId = account.Id;
        insert ct;
    }
    List<Id> accounts = new List<Id>();
    accounts.add(account.Id);
    Test.setMock(HttpCalloutMock.class, new AccountProcessorMockCall());
    Test.startTest();
      AccountProcessor.countContacts(accounts);
    Test.stopTest();
    // runs callout and check results
    account = [Select Number_of_Contacts__c from Account where Id=:account.Id];
    System.assertEquals(account.Number_of_Contacts__c, 10);
  }
}