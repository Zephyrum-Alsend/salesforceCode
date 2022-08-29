({
	doInit : function(component, event, helper) {
        helper.helperMethod(component);
    },
    getCheckboxStatus : function(component, event, helper){
        helper.helperMethod(component);
    },
    setUserStatus : function(component, event, helper){
       var Element = event.getSource();
        var UId = Element.get('v.name');
        console.log('######## : '+UId);
        helper.updateUserStatus(component,UId);
    }
})