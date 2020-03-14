public with sharing class CaseTriggerHelper {
	
	private static Map<Id, String> contactsMap = new Map<Id, String>();
	
	public static void updateCustomField(Case oldO, Case newO) {
		// Actualizamos Dummy__c
		if (newO.contactId != null) {
			contactsMap.put(newO.contactId, newO.Dummy__c);
		}
	}

	public static void commitChanges(){
		if (contactsMap.size() > 0){
			List<Contact> contacts = new List<Contact>([Select Id, Dummy__c from Contact where Id in :contactsMap.keySet()]);
			for (Contact contact: contacts) {
				contact.Dummy__c = contactsMap.get(contact.Id);
			}
			update contacts;
		}
	}
}