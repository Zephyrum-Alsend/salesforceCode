({
	callApexGet: function (cmp, event, helper) {
        var action = cmp.get("c.relatedInvoice");
        var val = cmp.get("v.recordId");
        action.setParams({acc : val});
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                cmp.set("v.data", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    
    callApexSubDisplay: function (cmp, event, helper) {
        var action = cmp.get("c.relatedPurchase");
        var val = cmp.get("v.selectedInvoice");
        action.setParams({invList : val});
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                cmp.set("v.dataPurchase", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
        cmp.set('v.dialogOpen', true);
    },
    
    callApexSave: function (cmp, event, helper) {
        console.log("Prepping for savePurchase...");
        var action = cmp.get("c.savePurchase");
        var val = event.getParam('draftValues');
        console.log(JSON.stringify(val));
        action.setParams({purList : val});
        console.log("Calling savePurchase...");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                cmp.set("v.dataPurchase", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})