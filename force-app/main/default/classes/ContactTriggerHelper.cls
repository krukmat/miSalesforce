public with sharing class ContactTriggerHelper {
	private static Map<Id,Id> accountsToSwap = new Map<Id,Id>();
	private static List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();

	public static void checkChangeAccountId(Contact oldO, Contact newO) {
		if (oldO.accountId != newO.accountId) {
			accountsToSwap.put(oldO.accountId, newO.accountId);
		}
	}

	public static void updateOpportunities() {
		// El cambio de accountId de contactos
		if (!accountsToSwap.isEmpty()) {
			// Listado de las cuentas viejas
			Set<Id> oldAccounts = accountsToSwap.keySet();
			// Listado de cuentas con sus oportunidades
			List<Account> opportunitiesXAccounts = [SELECT Id, (Select AccountId, Id from Opportunities) from Account where Id in :oldAccounts];
			for (Account account: opportunitiesXAccounts) {
				//Obtengo el listado de Opportunities y actualizo accountId, basado en el mapa accountsToSwap
					List<Opportunity> opportunities = account.Opportunities;
					for (Opportunity opportunity: opportunities){
						// swap entre old y new key
						opportunity.AccountId = accountsToSwap.get(account.Id);
						opportunitiesToUpdate.add(opportunity);
					}
			}
		}
	}

	public static void commitChanges() {
		if (!opportunitiesToUpdate.isEmpty())
			update opportunitiesToUpdate;
	}
}