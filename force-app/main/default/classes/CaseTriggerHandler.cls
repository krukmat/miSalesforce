public with sharing class CaseTriggerHandler implements S4GITrigger{

	public void bulkBefore(){
	}

	public void beforeInsert(SObject newO){
	}
	
	public void beforeUpdate(SObject oldO, SObject newO){
	}
	
	public void beforeDelete(SObject oldO){

	}

	public void bulkAfter(){	
	}

	public void afterInsert(SObject newO){
		CaseTriggerHelper.updateCustomField(null, (Case) newO);
	}
	
	public void afterUpdate(SObject oldO, SObject newO) {
		CaseTriggerHelper.updateCustomField((Case) oldO, (Case) newO);
	}

	public void afterDelete(Sobject oldO){

	}

	public void afterUndelete(Sobject newO){

	}

	public void andFinally(){
		CaseTriggerHelper.commitChanges();
	}

}