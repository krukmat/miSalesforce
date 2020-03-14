({
    onInit: function(component,event,helper) {
        // Register error listener for the empApi component.
        const empApi = component.find("empApi");
        // Error handler function that prints the error to the console.
        const errorHandler = function (message) {
            console.error("Received error ", JSON.stringify(message));
        };
        // Register error listener and pass in the error handler function.
        empApi.onError(errorHandler);
        
        // Get the channel from the input box.
        const channel = component.get('v.channel');
        const replayId = -1;
        
 
        var callback = function (message) {
             console.log("Event Received : " + JSON.stringify(message));
             var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        mode:'sticky',
                    title: "Success!",
                    message: "Congrats, it works!",
                    type: "success"
            });
            toastEvent.fire();
        }.bind(this);
        
        empApi.subscribe(channel, replayId, callback).then(function(newSubscription) {
              console.log("Subscribed to channel " + channel);
        });
    },
    
    test: function(component,event,helper) {
        	var toastEvent = $A.get("e.force:showToast");
				toastEvent.setParams({
                    mode:'sticky',
   				title: "Success!",
   				message: "Congrats, it works!",
   				type: "success"
			});
		toastEvent.fire();
    },
})