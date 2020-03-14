({
	packItem : function(component, event, helper) {
		let item = component.get("v.item");     // get item
		let btnClicked = event.getSource();     // the button
		component.set("v.item.Packed__c", true);
		component.set('v.item', item);
		btnClicked.set("v.disabled", true);//Disable the button
	}
})