global class SyncContacts implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
	
	global String query = 'SELECT FirstName, LastName, Email, Phone from Contact'; 
	
	global Integer recordsProcessed = 0;
	global Integer recordsFailed = 0;


	/**
	*  sync2Account: Bool function that conects through POST REST-API to Second org 
	*  which creates the contact. 
	*/
	global Boolean sync2Account(Contact contact) {
		HttpResponse response = ExternalOrgEndPoint.makeOrgEndpointCall(contact);
		return response.getStatusCode() == 200 || response.getStatusCode() == 201;
	}
	
	global SyncContacts() {
		
	}
	

	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

	/**
	* execute: For every contact in the query, it calls the POST REST-API.  
	**/
   	global void execute(Database.BatchableContext BC, List<Contact> scope) {
		for (Contact contact : scope) {
            if (sync2Account(contact)){
            	// increment the instance member counter
            	recordsProcessed = recordsProcessed + 1;
            } else {
            	recordsFailed = recordsFailed + 1;
            }    
    	}
	}
	
	/**
	* finish: It's sent the number of records inserted and the records failed.  
	**/
	global void finish(Database.BatchableContext BC) {
		String messageEmail = recordsProcessed + ' records processed OK';
		messageEmail += recordsFailed + ' records failed :( '; 
	}
	
}