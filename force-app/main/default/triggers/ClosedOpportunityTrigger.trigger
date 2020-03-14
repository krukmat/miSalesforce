trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {

    List<Task> taskList = new List<Task>();
    
    // Add an opportunity for each account if it doesn't already have one.
    // Iterate over accounts that are in this trigger but that don't have opportunities.
    for (Opportunity o : Trigger.New) {
        // Add a default opportunity for this account
        if (o.StageName == 'Closed Won'){
          taskList.add(new Task(Subject='Follow Up Test Task', WhatId=o.Id)); 
        }
    }
    
    if (taskList.size() > 0) {
        insert taskList;
    }
}