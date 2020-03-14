@isTest
private class AccountTriggerTest {
	
	@isTest
	static void itShould() {

		Test.startTest();

			Account company = new Account(Name='Test Account');
			insert company;

        	        // Update Parent
        	        Account company2 = new Account(Name='Company2');
        	        insert company2;

                	List<Account> branches = new List<Account>();
                	List<Contact> branchesContacts = new List<Contact>();

                	// multiples branches. Insert
                	for(Integer i=0; i<5; i++) {
                		branches.add(new Account(Name='Branch', parentId=company2.Id, type='Branch'));
                		
                	}
                	insert branches;

                	branches = [SELECT Id, Name, ParentId from Account where Id in :branches];
                	
                	for (Account current: branches){
                		System.assertEquals(current.Name, 'Company2-Branch');
                	}

                	// contacts insertion
                	for (Account branch: (List<Account>)branches){
                		branchesContacts.add(new Contact(FirstName='Pepe',
                							LastName='Papa',
                							Branch__c=branch.Id, 
                							AccountId=branch.parentId));	
                	}

                	insert branchesContacts;
                	

                	//multiples branches. Update
                	for (Account current: branches){
                		current.ParentId = company.Id;
                	}

                	update branches;

                	branches = [SELECT Name, ParentId, (Select AccountId, Id from Contacts) from Account where Id in :branches];
        			for (Account current: branches){
                		System.assertEquals(current.Name, 'Test Account-Branch');
                		List<Contact> contacts = current.Contacts;
                		// check the contacts account id were updated correctly
                		for (Contact contact: contacts) {
                			System.assertEquals(contact.accountId, company.id);
                		}
                	}


                Test.stopTest();
	}

}