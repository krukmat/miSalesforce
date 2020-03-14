global class DailyLeadProcessor implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<Lead> leads = [SELECT LeadSource 
            FROM Lead 
            WHERE LeadSource = '' LIMIT 200];
        // Create a task for each opportunity in the list
        for (Lead lead: leads) {
            lead.LeadSource = 'Dreamforce';
        }
        update leads;
    }
    
}