@isTest
private class ContactTriggerTest
{
	
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
        	List<Opportunity> branchesOpportunities = new List<Opportunity>();

        	// multiples branches. Insert
        	for(Integer i=0; i<5; i++) {
        		branches.add(new Account(Name='Branch', parentId=company2.Id, type='Branch'));
        		
        	}
        	insert branches;

        	// contacts insertion
        	for (Account branch: (List<Account>)branches){
        		branchesContacts.add(new Contact(FirstName='Pepe',
        							LastName='Papa',
        							Branch__c=branch.Id, 
        							AccountId=company2.Id));	
        	}

        	insert branchesContacts;

        	// Opportunities Insertion
        	for (Account branch: (List<Account>)branches){
        		branchesOpportunities.add(new Opportunity(
        							Name='Matias',
        							StageName='Closed',
        							CloseDate=Date.Today(),
        							Branch__c=branch.Id, 
        							AccountId=company2.Id));	
        	}

        	insert branchesOpportunities;
        	

        	// Multiples branches. Update
        	for (Account current: branches){
        		current.ParentId = company.Id;
        	}

        	update branches;

        	branches = [SELECT Name, ParentId, (SELECT Id, AccountId from Opportunities) from Account where Id in :branches];
			
			for (Account current: branches) {

        		// Check oportunidades
        		List<Opportunity> opportunities = current.Opportunities;

        		// Check the contacts account id were updated correctly
        		for (Opportunity opportunity: opportunities) {
        			System.assertEquals(opportunity.accountId, company.id);
        		}
        	}


        Test.stopTest();
	}

}