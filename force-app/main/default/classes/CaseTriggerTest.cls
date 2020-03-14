@isTest
private class CaseTriggerTest
{
	@isTest
	static void itShould()
	{
        Id pricebookId=Test.getStandardPricebookId();
        system.assertEquals(pricebookId, 'sdasdassd');
    }
}