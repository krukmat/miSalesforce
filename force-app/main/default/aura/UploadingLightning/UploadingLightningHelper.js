({
    loadShowing: function(cmp){
        var spinner = cmp.find('globalSpinner');
        var action = cmp.get('c.getOptionsShowing');
        $A.util.removeClass(spinner, "slds-hide");

        action.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
              cmp.set("{!v.optionsShowing}", response.getReturnValue());
              $A.util.addClass(spinner, "slds-hide");
            }else if(response.getState() === "INCOMPLETE"){
                //Show Error
                console.log(response.getError());
            }else{
                //Show Error
                console.log(response.getError());
            }
        });    

        $A.enqueueAction(action);

    },
    uploadFile: function(component, e){
     var self = this;
     var media = component.get("{!v.media}");

     console.log(e);

    //Handle message
    if(e.data.state == 'LOADED'){ console.log('aaaaaa');
      //Set visualforce Host which will be used later to send message
      component.set('v.vfHost', e.data.vfHost);
    }

    if(e.data.state == 'uploadFileSelected'){
      //Insert in media Date
      console.log(e.data.files);
      listFile = e.data.files;
      var resultFile = self.addFiles(listFile);
    }

    },
    /**
     * Checking file list precondition is valid
     * @param [File] File List
     * @return [File] Array to File Object 
     */
    addFiles: function(fileList){
        files = new Array();        
        for(var key in fileList) {
            if (!fileList.hasOwnProperty(key)) continue;
            //TODO:check size Or other types properties this file
            //TODO: Remove is example error....
   			
            var e = fileList[key];
                var file = new Object();
               	file.name = e.name;
            	if(key == 3){
            		file.status = "415";
            		file.textStatus = "Error file name: "+e.name+" (Unsupported Media Type)";
                }else{
                    file.status = "201";
            		file.textStatus = "Created";
                }

            files.push(file);
		}
		return files;
	},
    

    /**
     * saveMediaItem in SF
     * @param  {[type]} cmp [description]
     * @param  {[type]} index     [description]
     * @return {[type]}           [description]
     */
    saveMediaItem : function(cmp, mediaList){
        //mediaItem
        var action = cmp.get("c.saveMedia");
        var self = this;
        //Prepare Media item
        var mediaFiltered = new Array();
        mediaList.forEach(function(e, i){
            //prepare Object to upload
            //TODO: Save Status??
            mediaFiltered.push(e);
        });
        
        return new Promise(function(resolve, reject){
            /*
            window.setTimeout(function(){
                console.log(mediaList);
                mediaList.forEach(function(e, i){
                    e.status_upload = 1;
                    e.status_upload_text = "Save in SF Success";
                });
                resolve(mediaList);
            }, 2000);
            */
            
            action.setParams(mediaFiltered);
            action.setCallback(self, function (response){
               var state = response.getState();
               self.callSomeHelpeMethodFromPromise();
               if (state === "SUCCESS"){
                 resolve(action.getReturnValue());
               }else{
                console.log("-------------");
                console.log(response);
                reject(state);
               }
            });
            $A.enqueueAction(action);
            
        });
    },
    /**
     * Upload Media Item to Media Cloud
     * @param  {[type]} cmp [description]
     * @param  {[type]} index     [description]
     * @return {[type]}           [description]
     */
    uploadMediaItem : function(cmp, media){
        return new Promise(function(resolve, reject){
            //TODO: EXAMPLE Response
            window.setTimeout(function(){
                console.log(media);
                 media.forEach(function(e, i){
                    e.status_upload = 2; 
                    e.status_upload_text = "Upload Success";
                });
                resolve(media);
            }, 2000);
        });

    },
   
    /**
     * showToast
     * --------------------------------
     * String title; 
     * String message;
     * *String type (error, warning, success, or info);
     * *Integer duration;
     * *String Mode (dismissible, pester, sticky);
     * *String key (icon) https://www.lightningdesignsystem.com/icons/#utility
     */
    showToast: function(title, message, type, duration, mode, key){
        //Preset
        type = (type != null ? type : 'info');
        duration = (duration != null ? duration : 5000);
        mode = (mode != null ? mode : 'dismissible');
        key = (key != null ? key : 'info_alt');
        
        //Function
        var toast = $A.get("e.force:showToast");
        toast.setParams({ title: title, message: message, type: type, duration: duration, mode: mode, key: key});
        toast.fire();
    }
})