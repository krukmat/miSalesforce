public with sharing class CampingListController {
	@AuraEnabled
	public static List<Camping_Item__c> getItems() {
	    
	    // OK, they're cool, let 'em through
	    return [SELECT Id, Name, Packed__c, Price__c, Quantity__c, CreatedDate 
	            FROM Camping_Item__c];
	}

	@AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c item) {
        // Perform isUpdatable() checking first, then
        upsert item;
        return item;
    }
}