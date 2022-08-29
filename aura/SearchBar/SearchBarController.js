({
	searchKeyChange : function(component, event, helper) {
        var myEvent = $A.get("e.c:searchKeyChange");
        myEvent.setParams({"evtSearchKey": component.get("v.strText")});
        myEvent.fire();
	}
})