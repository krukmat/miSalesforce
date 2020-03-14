public class MyS4GTrigger implements S4GITrigger{

	public void bulkBefore(){

	}

	public void beforeInsert(SObject object1){

	}
	
	public void beforeUpdate(SObject oldO, SObject newO){

	}
	
	public void beforeDelete(SObject object1){

	}

	public void bulkAfter(){

	}

	public void afterInsert(SObject object1){

	}
	
	public void afterUpdate(SObject oldO, SObject newO) {
		Account oldAct = (Account) oldO;
		Account newAct = (Account) newO;

		if ((oldAct.parentId != newAct.parentId) && ((oldAct.type==newAct.type) && (oldAct.type=='Branch'))){
			Account parent = [select Name from Account where Id = :newAct.parentId];
			newAct.Name = parent.Name + ' ' + newAct.Name;
			update newAct;
		}

	}

	public void afterDelete(Sobject object1){

	}

	public void afterUndelete(Sobject object1){

	}

	public void andFinally(){

	}

}