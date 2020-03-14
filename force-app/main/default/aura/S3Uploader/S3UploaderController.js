{
    	doInit : function(component, event, helper) {
        	var media = component.get("c.getPolicy");
         	action.setCallback(this,function(response){
                if (response.getState() === "SUCCESS"){
                    component.set("{!v.policy}",response.getReturnValue());
                }
            });
        	$A.enqueueAction(action);
    },
})