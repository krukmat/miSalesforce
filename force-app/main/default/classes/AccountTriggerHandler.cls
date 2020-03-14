public with sharing class AccountTriggerHandler implements S4GITrigger{

	public void bulkBefore(){
		AccountTriggerHelper.prepareParentAccounts();
	}

	public void beforeInsert(SObject newO){
		AccountTriggerHelper.updateName(null, (Account)newO);
	}
	
	public void beforeUpdate(SObject oldO, SObject newO){
		AccountTriggerHelper.updateName((Account)oldO, (Account)newO);

	}
	
	public void beforeDelete(SObject oldO){

	}

	public void bulkAfter(){
		AccountTriggerHelper.prepareContacts();	
	}

	public void afterInsert(SObject newO){

	}
	
	public void afterUpdate(SObject oldO, SObject newO) {

	}

	public void afterDelete(Sobject oldO){

	}

	public void afterUndelete(Sobject newO){

	}

	public void andFinally(){
		AccountTriggerHelper.commitChanges();
	}

}