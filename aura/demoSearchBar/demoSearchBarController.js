({
	searchKeyChange: function(component, event, helper) {	
         var myEvent = $A.get("e.c:searchKeyChange");
         myEvent.setParams({"demoEvent": component.get("v.strText")});
         myEvent.fire();
     }
})