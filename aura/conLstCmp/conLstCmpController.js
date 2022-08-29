({
	doInit : function(component, event, helper) {
		helper.fetchContacts(component, event, helper);
	},
    searchKeyChange : function(component, event, helper) {
        helper.fetchRelatedContacts(component, event, helper);
    }
})