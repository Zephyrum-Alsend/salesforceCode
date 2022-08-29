({
    callApex: function (cmp, event, helper) {
        var action = cmp.get("c.fetchListAcc2");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                cmp.set("v.data", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    
    callApexDelete: function (cmp, event, helper) {
        var action = cmp.get("c.deleteAccount");
        var val = cmp.get("v.selectedAccount");
        action.setParams({accList : val});
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                cmp.set("v.data", response.getReturnValue());
                window.location.reload;
            }
        });
        $A.enqueueAction(action);
    },
    
    callApexClone: function (cmp, event, helper) {
        console.log('Calling deepClone...');
        var action = cmp.get("c.deepClone");
        var val = cmp.get("v.selectedAccount");
        console.log('Passing selectedAccount: '+JSON.stringify(val));
        action.setParams({accList : val});
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log('Callback state: '+JSON.stringify(state));
            if(state === "SUCCESS"){
                cmp.set("v.data", response.getReturnValue());
                window.location.reload;
            }
        });
        $A.enqueueAction(action);
    }
})