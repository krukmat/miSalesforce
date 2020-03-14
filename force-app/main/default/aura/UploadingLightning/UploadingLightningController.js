({
	doInit : function(component, event, helper) {
    //Load all Showing
    helper.loadShowing(component);
    var media = [];
    component.set("{!v.media}", media);


    /***********************************
     *                                 *
     * Load File to Amazon Via Iframe  *
     *                                 *
     ***********************************/

    //Send LC Host as parameter to VF page so VF page can send message to LC; make it all dynamic
    component.set('v.lcHost', window.location.hostname);
    var frameSrc = 'apex/Document_AWSUpload?lcHost=' + component.get('v.lcHost');
    component.set('v.frameSrc', frameSrc);

    //Add message listener
    window.addEventListener("message", function(e){
      helper.uploadFile(component, e);
    });
    

    /**********************************
    *                                 *
    * End Load File                   *
    *                                 *
    ***********************************/


  },
})