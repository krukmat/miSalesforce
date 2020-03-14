global class AccountProcessor {
  @future
  public static void countContacts (List<Id> recordIds) {
    List<Account> accounts = [Select Id, Number_of_Contacts__c from Account Where Id IN :recordIds];
    for (Account acct : accounts) {
          List<Contact> contacts = [Select Id from Contact Where AccountId = :acct.Id ];
          acct.Number_of_Contacts__c = contacts.size();
    }
    update accounts;
  }
}