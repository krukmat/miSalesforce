/**
 *   Static Class to include helpers
 *
 * @author      S4G
 * @version     1.0                 
 * @since       2013-11-14
 */
global class S4GUtils {
    
    /**
    * Generic Exception class
    */
    global class wsException extends Exception {}
    
    /**
    * Email address to send the unexpected errors.
    */
    public static String EMAIL_ERROR_TO = 'sflog+error@s4g.es';
    
    /**
    * Email subject to send the unexpected errors.
    */
    private static String EMAIL_ERROR_PRESUBJECT = '[REPLACE_ME_BY_ORG_NAME]Unexpected Error -';

    /**
    * Custom Setting Name that we use to save the email address to send the errors
    */
    public static String EMAIL_ERROR_ADDRESSES_NAME = 'Error Emails';
   
    /**
    * Get Exception information and send this by email.
    */     
    global static void sendExceptionError(String subject,Exception e){
        
        system.debug('Exception catched:');
        system.debug(e.getMessage());
        system.debug('line:'+e.getLineNumber());
        system.debug(e.getStackTraceString());
    
        S4GUtils.sendUnexpectedError(subject,'Exception catched:'+e.getMessage()+'line:'+e.getLineNumber()+','+e.getStackTraceString()+'\n User: '+UserInfo.getUserName());
           
    }
    
    global static void sendExceptionError(String subject,Exception e, String log){
        
        system.debug('Exception catched:');
        system.debug(e.getMessage());
        system.debug('line:'+e.getLineNumber());
        system.debug(e.getStackTraceString());
    
        S4GUtils.sendUnexpectedError(subject,'Exception catched:'+e.getMessage()+'line:'+e.getLineNumber()+','+e.getStackTraceString()+'\n User: '+UserInfo.getUserName()+'\n'+log);
           
    }
    
    /**
    * Send Error information by email.
    */
    global static void sendUnexpectedError(String subject, String body){
        
        SystemDevelopEmailAddresses__c sdea = SystemDevelopEmailAddresses__c.getInstance(EMAIL_ERROR_ADDRESSES_NAME);

        String targetEmails = sdea!= null ? EMAIL_ERROR_TO +','+ sdea.Email_Addresses__c : EMAIL_ERROR_TO;
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setReplyTo('sflog@s4g.es');
        mail.setPlainTextBody(body);
        mail.saveAsActivity = false;
        mail.setSenderDisplayName('Unexpected Error');
        mail.setSubject(EMAIL_ERROR_PRESUBJECT + subject);
        mail.setToAddresses(targetEmails.split(','));
        Messaging.sendEmail(new Messaging.SingleEmailmessage[] {mail});
    
    }
    
   
    /**
    * Returns if the functionality is setted enabled in the custom setting
    *
    * @name String the name of the custom setting record
    */
    public static boolean checkEnabled(String name){
        
        boolean res = false;
        
        try{
            ControlEnabled__c c = ControlEnabled__c.getInstance(name);
            if(c != null){
                res = (boolean)c.get('Enabled__c');
            }
            
        }catch(Exception e){
            S4GUtils.sendExceptionError('checkWSConsumerEnabled', e);
        }
        return Test.isRunningTest() || res;
    }

    /**
     * This method returns a query result containing the whole fields from an object
     *
     * @objectName String object name to be queried
     * @additionalFilters String this should be the where, limit or sort clause
     *
     * @return SObject[] the list of object queried
     */
    public static SObject[] selectByName(String objectName,  String additionalFilters){
        
        //get object fields
        List<String> fieldList = new List<String>(Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap().keySet());
        String fields = String.join(fieldList,',');
        
        system.debug('SELECT '+fields+' FROM '+objectName+ ' '+additionalFilters);
        
        return (SObject[])Database.query('SELECT '+fields+' FROM '+objectName+ ' '+additionalFilters);
    }  
    
    public static void manageUpdateResult(Database.SaveResult[] results){
        
        String[] erros = new String[]{};

        for(Database.SaveResult result : results){
            if(!result.isSuccess()){
                erros.add(S4GUtils.joinErrors(result.getErrors()));
            }
        }

        if(!erros.isEmpty()){
            throw new S4GUtils.wsException(String.join(erros, '.\n'));
        }
    }

    public static String joinErrors(Database.Error[] errors){
        String[] errorList = new String[]{};

        for(Database.Error er : errors){
            errorList.add(er.getMessage());
        }

        return String.join(errorList, ' ');
    }  

    /**
    * Check if a value field has changed
    * @param SObject, old SObject, FieldName
    * @return Boolean
    */
    public static Boolean isChangedField(SObject so, SObject oldSo, String fieldName){
        return oldSo == null || (so.get(fieldName) != oldSo.get(fieldName));
    }

    public static Boolean isChangedField(Sobject so, Sobject oldSo, String[] fieldNames){
        for(String field : fieldNames){
            if(isChangedField(so,oldSo,field)){
                return true;
            }
        }

        return false;
    }
  
}