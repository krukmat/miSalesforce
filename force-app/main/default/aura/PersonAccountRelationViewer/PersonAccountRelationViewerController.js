({	doInit: function(component, event, helper){
		var action =  component.get('c.getPersonContactId');  // Calling apex method
        action.setParams({ accountId : component.get("v.recordId") });
    	action.setCallback(this,function(response){
                var state=response.getState();            // getting the state
                if(state==='SUCCESS')
                {
                    component.set('v.personContactId',response.getReturnValue());    // setting the value in attribute
                   
                }
        });
  		$A.enqueueAction(action);    
	},
	handleClick : function (cmp, event, helper) {
        //Find the text value of the component with aura:id set to "address"
        var urlEvent = $A.get("e.force:navigateToURL");
        var personContactId = cmp.get('v.personContactId');
        urlEvent.setParams({
          "url": 'https://unav--fulladm--npe4.cs82.visual.force.com/apex/RelationshipsViewer?id='+personContactId
        });
        urlEvent.fire();
    }
})