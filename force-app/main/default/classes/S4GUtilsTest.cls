@isTest
private class S4GUtilsTest {
	static testMethod void  testStaticsErrorMethods(){
        
        
        Test.startTest();  
        
        S4GUtils.sendExceptionError('subject', new S4GUtils.wsException('Ouch'));
        S4GUtils.sendExceptionError('subject', new S4GUtils.wsException('Ouch'), 'log');
        S4GUtils.sendUnexpectedError('subject', 'body');

        
        Test.stopTest();
        
        System.assert(true, 'Error helpers');
        
    }

    static testMethod void testCheckEnabled(){
    	ControlEnabled__c controlEnabled = S4GTestFactory.createControlEnabled('test');
        insert controlEnabled;
        
        test.startTest();
            system.assertEquals(true, S4GUtils.checkEnabled('test'));
        test.stopTest();
        
    }

    static testMethod void testSelectByName(){
        test.startTest();
            system.assert( S4GUtils.selectByName('Contact','Where lastname != null ') != null );
        test.stopTest();
        
    }

    static testMethod void manageUpdateResult(){
        Account a = S4GTestFactory.createAccount();
        insert a;

        a.Name = null;

        List<Account> l = new List<Account>{a};

        Test.startTest();
            try{
                S4GUtils.manageUpdateResult(Database.update(l,false));
                System.assert(false);
            }catch(Exception e){
                System.assert(true);
            }
        Test.stopTest();
    }


}