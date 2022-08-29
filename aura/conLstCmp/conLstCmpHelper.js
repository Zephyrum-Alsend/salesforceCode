({	
    //To fetch all the contacts
	fetchContacts : function(component, event, helper) {
		var action = component.get("c.findAll");
         action.setCallback(this, function(a) {
             component.set("v.contacts", a.getReturnValue());
         });
         $A.enqueueAction(action);
	},
    // To fetch the searched or requested contacts
    fetchRelatedContacts : function(component, event, helper) {
		var evtval = event.getParam("evtSearchKey");
        console.log('Event Value === '+ evtval);
        var action = component.get("c.findByName");	
        action.setParams({	
            "methodSearchKey": evtval	
        });	
        action.setCallback(this, function(a) {	
            component.set("v.contacts", a.getReturnValue());
        });	
        $A.enqueueAction(action);
	}
    // Event -- attribute-- searchKey
    // searchBar -- searchKey<--- strText
    // getting the value of event in helper var name == evtval
    // calling paramaterised method from apex class
    // parameter in method <---- value from the event
})