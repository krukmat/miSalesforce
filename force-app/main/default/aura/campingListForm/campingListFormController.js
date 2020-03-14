({
	submitForm: function(component, event, helper) {

        // Simplistic error checking
        var validItem = true;

        // Name must not be blank
        var nameField = component.find("clname");
        var clname = nameField.get("v.value");
        if ($A.util.isEmpty(clname)){
            validItem = false;
            nameField.set("v.errors", [{message:"Camping list name can't be blank."}]);
        }
        else {
            nameField.set("v.errors", null);
        }
        // quantity
        var quantityField = component.find("quantity");
        var quantity = quantityField.get("v.value");
        if ($A.util.isEmpty(quantity)){
            validItem = false;
            quantityField.set("v.errors", [{message:"Quantity can't be blank."}]);
        }
        else {
            quantityField.set("v.errors", null);
        }
        // price
		var priceField = component.find("price");
        var price = priceField.get("v.value");
        if ($A.util.isEmpty(price)){
            validItem = false;
            priceField.set("v.errors", [{message:"Price can't be blank."}]);
        }
        else {
            priceField.set("v.errors", null);
        }
        // ... hint: more error checking here ...

        // If we pass error checking, do some real work
        if(validItem) {
            console.log('validItem in submitForm');
            // Create the new expense
            var newItem = component.get("v.newItem");
            helper.createItem(component, item);
            // reseteo el newItem
        }
    }
})