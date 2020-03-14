@IsTest
public class AccountBuilderTest  {

	@IsTest
    private static void easyTestDataCreation() {

        // Setup
        Contact_t jack = new Contact_t().first('Jack').last('Harris');
        new Account_t()
                .name('Acme Corp')
                .add( new Opportunity_t()
                                .amount(1000)
                                .closes(2019, 12)
                                .contact(jack))
                .add(jack)
                .persist();
        // Exercise
        Account acc = [SELECT Id FROM Account WHERE Name = 'Acme Corp'];
        Contact ct = [SELECT Account.Name FROM Contact];
        system.assertEquals('Acme Corp', ct.Account.Name);
        Opportunity opp = [SELECT Id FROM Opportunity WHERE AccountId = :acc.Id];
        system.assertNotEquals(null, opp);
        // Verify
        
    }
}