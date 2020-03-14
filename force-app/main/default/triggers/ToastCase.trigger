trigger ToastCase on Case (after insert) {
    for(Case c : Trigger.new){
        if(c.Priority == 'High'){
            New_Case__e caseEvent = new New_Case__e(
                Number__c = c.CaseNumber);
            Database.SaveResult sr = EventBus.publish(caseEvent);
            if(sr.isSuccess()){
                System.debug('Event sent');
                System.debug(caseEvent);
            } else{
                 for(Database.Error err : sr.getErrors()) {
      			 	System.debug('Error returned: ' +
                 	err.getStatusCode() +
                    ' - ' +
                    err.getMessage());
            	}
            }
        }
	}
}