({
	doinit : function(cmp, event, helper) {
		cmp.set('v.columns', [
            {label: 'Invoice', fieldName: 'Name', type: 'text'}
        ]);
        
        cmp.set('v.columnsBox', [
            {label: 'Name', fieldName: 'Name__c', type: 'text', editable: true},
            {label: 'Date', fieldName: 'Date__c', type: 'date', editable: true}
        ])

        helper.callApexGet(cmp, event, helper);
	},
    
    updateSelectedText: function (cmp, event) {
        var selectedRows = event.getParam('selectedRows');
        cmp.set('v.selectedRowsCount', selectedRows.length);
        
        var setRows = [];
        for(var i = 0 ; i < selectedRows.length ; i++){
            setRows.push(selectedRows[i]);
        }
        cmp.set('v.selectedInvoice', setRows);
    },
    
    openDialog : function (cmp, event, helper) {
        helper.callApexSubDisplay(cmp, event, helper);
    },
    
    closeDialog : function (cmp, event, helper) {
        cmp.set('v.dialogOpen', false);
    },
    
    saveChanges : function (cmp, event, helper) {
        helper.callApexSave(cmp, event, helper);
        cmp.set('v.dialogOpen', false);
    }
})