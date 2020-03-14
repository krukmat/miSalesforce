public with sharing class ContactTriggerHandler implements S4GITrigger{

	public void bulkBefore(){

	}

	public void beforeInsert(SObject newO){

	}
	
	public void beforeUpdate(SObject oldO, SObject newO){
		
	}
	
	public void beforeDelete(SObject oldO){

	}

	public void bulkAfter(){
		ContactTriggerHelper.updateOpportunities();
	}

	public void afterInsert(SObject newO){

	}
	
	public void afterUpdate(SObject oldO, SObject newO) {
		ContactTriggerHelper.checkChangeAccountId((Contact)oldO, (Contact)newO);
	}

	public void afterDelete(Sobject oldO){

	}

	public void afterUndelete(Sobject newO){

	}

	public void andFinally(){
		ContactTriggerHelper.commitChanges();
	}

}