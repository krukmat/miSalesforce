public with sharing class AccountTriggerHelper {
	
	public static Map<String,String> accountNameByAccountId = new Map<String, String>();
	//public static List<Account> accountsToUpdate = new List<Account>();
	public static List<Contact> contactsToUpdate = new List<Contact>();
	public static List<Id> branchesUpdated = new List<Id>();

	public static void updateName(Account oldO, Account newO) {
		if (oldO == null || oldO.parentId != newO.parentId) {
			if (accountNameByAccountId.containsKey(newO.parentId)) {
				String newName = newO.Name;
				if (newName.contains('-'))
					newName = newName.substringAfter('-');
				newO.Name = accountNameByAccountId.get(newO.parentId) + '-' + newName;
				branchesUpdated.add(newO.Id);
			} else {
				// Enviar correo...
				S4GUtils.sendUnexpectedError('Matias-dev', 'UnexpectedError');
			}
		}
		// TODO: Caso en que el Parent.Name cambio aunque sea el mismo Parent

	}

	public static void prepareParentAccounts(){

		if (Trigger.isInsert || Trigger.isUpdate){
			Set<String> parentAccountIds = new Set<String>();
		
			for(Account account:(List<Account>)Trigger.New){
				parentAccountIds.add(account.parentId);
			}

			for(Account account:[SELECT Id, Name FROM Account WHERE Id IN :parentAccountIds]){
				accountNameByAccountId.put(account.Id, account.Name);
			}	
		}

	}


	public static void prepareContacts(){
			// Branches actualizados unicamente
			if (!branchesUpdated.isEmpty()) {
				List<Account> contactsXBranch = [select Id, ParentId, (Select AccountId, Id from Contacts) from Account where Id in :branchesUpdated];
				for (Account account: contactsXBranch){
					//Obtengo el listado de Contacts y actualizo accountId, basado en account.parentId
						List<Contact> contacts = account.Contacts;
						for (Contact contact: contacts){
							contact.AccountId = account.ParentId;
							contactsToUpdate.add(contact);
						}
				}
			}
	}

	public static void commitChanges(){
		if (!contactsToUpdate.isEmpty())
			update contactsToUpdate;
	}
}