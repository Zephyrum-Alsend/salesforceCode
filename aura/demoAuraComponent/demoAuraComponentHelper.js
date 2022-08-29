({
	callApexMthod : function(component, event, helper) {
        var action = component.get("c.fetchListAcc");
        action.setCallback(this, function(response){
            component.set("v.lstOfAccounts", response.getReturnValue());
        });
        $A.enqueueAction(action);
	}
})

/*client side--- where the request is made for data---  javascript
server side--- where the data is present ---- Apex--- controller
synchronous --- it executed as requested
asynchronous -- it request is queued and whenever there is server capacity it gets executed
aura component works on async mode
    v. -- component attribute
    c. --- apex class
    get-- we are calling a method on the server side
    callback -- whenever something returns from server, to store the response
    set--- to assign value of the response from the apex method in an aura attribute
    enqueueAction --- Puts the action in the queue of actions to be executed
    */