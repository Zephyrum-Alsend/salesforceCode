({
	doinit: function (cmp, event, helper) {
        cmp.set('v.columns', [
            {label: 'Account Name', fieldName: 'Name', type: 'text', editable: true},
            {label: 'Account Number', fieldName: 'AccountNumber', type: 'text', editable: true},
            {label: 'Phone', fieldName: 'Phone', type: 'text', editable: true}
        ]);

        helper.callApex(cmp, event, helper);
    },

    updateSelectedText: function (cmp, event) {
        var selectedRows = event.getParam('selectedRows');
        cmp.set('v.selectedRowsCount', selectedRows.length);
        
        var setRows = [];
        for(var i = 0 ; i < selectedRows.length ; i++){
            setRows.push(selectedRows[i]);
        }
        cmp.set('v.selectedAccount', setRows);
    },
    
    handleClick : function (cmp, event, helper) {
        helper.callApexDelete(cmp, event, helper);
    },
    
    handleClick2 : function (cmp, event, helper) {
        console.log('handleClick2 calling helper...');
        helper.callApexClone(cmp, event, helper);
    }
})