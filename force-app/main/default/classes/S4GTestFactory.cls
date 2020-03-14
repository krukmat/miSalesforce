/*
The factory class below instantiates the specified handler and executes the methods defined by the interface. 
It does this using the type of the handler class passed to the static method: createAndExecutHandler.

You will see from the execute method the order in which the interface methods are called and you will note
the methods that are called iteratively passing in the relevant SObjects.
*/

@isTest
public class S4GTestFactory {
    
    

    public static ControlEnabled__c createControlEnabled(string name){
        return new ControlEnabled__c(
           Name = name,
           Enabled__c = true,
           Desctription__c = 'test'
        );
    }
    
    
    public static Account createAccount(){
        return new Account(
           Name = 'AccountTest'
        );
    }
    
    public static Account createAccount(string name){
        return new Account(
           Name = 'AccountTest '+name
        );
    }

    public static Opportunity createOpportunity(String accountId){
        return new Opportunity(Name='OpportunityTest', StageName='Closed Won', CloseDate = date.today(), AccountId = accountId);        
    }
    
    
    public static User createUser(){
        return new User(
          FirstName = 'test',
          LastName = 'test',
          UserName = 'test@s4g.com.develop',
          Email = 'test@s4g.com',
          //ProfileId = [SELECT id FROM Profile where Name = 'System Administrator' limit 1].Id,
          ProfileId = UserInfo.getProfileId(),
          Alias = 'TEST',
          CommunityNickname = 'test.s4g',
          EmailEncodingKey = 'ISO-8859-1',
          LocaleSidKey = 'es_ES',
          LanguageLocaleKey = 'en_US',
          TimeZoneSidKey = 'Europe/Paris',
          IsActive = true
        );
    }

}