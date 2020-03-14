public class PersonAccountRelationController {
	@AuraEnabled
    public static id getPersonContactId(Id accountId){
        Account personAccount = [SELECT Id FROM Account];
        return personAccount.Id;
        /*	Account personAccount = [SELECT PersonContactId FROM Account];
        	return personAccount.PersonContactId;
		*/
    }
}