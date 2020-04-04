global class CovidIntegrationBatch implements Database.Batchable<sObject>, Database.AllowsCallouts{

    private static final string query = 'SELECT ID, email__c, first__c, last__c,Processed__c FROM Health_professional__c WHERE Processed__c = False LIMIT 100';
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
     }
  
     global void execute(Database.BatchableContext BC,  List<sObject> scope){
        List<Health_professional_reference__c> referencesToUpsert = new List<Health_professional_reference__c>(); 
        for (Health_professional__c prof : (List<Health_professional__c>) scope){
            if (String.isNotBlank(prof.email__c) && String.isNotBlank(prof.first__c) && String.isNotBlank(prof.last__c)){
                CovidIntegrationCallout callout = new CovidIntegrationCallout();
                callout.doCallout(prof.email__c, prof.first__c, prof.last__c);
                //TODO: Guardar lo que esta en CovidIntegrationCallout.results
                //Health_professional_reference__c
                //TODO: Health_professional_reference_word_count__c
                Map<String, Health_professional_reference__c> mapReferences = new Map<String, Health_professional_reference__c> ();
                for(CovidIntegrationCallout.IntegrationResponse reference: callout.results){
                    Health_professional_reference__c referenceSF = new Health_professional_reference__c();
                    Map<String, Integer>  wordsCloud = reference.cloud;
                    referenceSF.url__c = reference.url;
                    String wordCloudsText = '';
                    for (String word: wordsCloud.keySet()){
                        wordCloudsText += word + ' : '+ wordsCloud.get(word) + ';';
                    }
                    referenceSF.words_cloud__c = wordCloudsText;
                    referenceSF.Health_professional__c = prof.Id;
                    referencesToUpsert.add(referenceSF);
                }
                
            }
            //try{
                
            /*}
            catch(Exception exc){
            }*/
        }      
        upsert referencesToUpsert;
        update scope;
     }
  
     global void finish(Database.BatchableContext BC){
     }
}
