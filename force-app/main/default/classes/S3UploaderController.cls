public class S3UploaderController {
	
    @AuraEnabled
    public static String getPolicy(){
       AWS_Keys__c awsKeySet= AWS_Keys__c.getInstance('media.trex.test3');
       String Content_Type ='multipart/form-data';
       String acessType ='private';
        
       String appParentId = ApexPages.currentPage().getParameters().get('parentIdForRedirect');
       String ForRedirect = URL.getSalesforceBaseUrl().toExternalForm()+'/'+'apex/AWS_SucessRedirectPage?parentIdForRedirect='+appParentId; 
        
       Datetime expire = system.now().addDays(1);
       String formattedexpire = expire.formatGmt('yyyy-MM-dd')+'T'+ expire.formatGmt('HH:mm:ss')+'.'+expire.formatGMT('SSS')+'Z';           
          
      return '{ "expiration": "'+formattedexpire+'","conditions": [ {"bucket": "'+
         awsKeySet.Name +'" } ,{ "acl": "'+acessType+'" },'+
        '{"content-type":"'+Content_Type+'"},'+
        '{"success_action_redirect": "'+ForRedirect+'"},' +
        '["starts-with", "$key", ""] ]}';   
    }
}