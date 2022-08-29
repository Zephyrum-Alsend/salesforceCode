import { LightningElement, api, wire, track } from 'lwc';
import relatedInvoice from '@salesforce/apex/accountInvoiceController.relatedInvoice';
import relatedPurchase from '@salesforce/apex/accountInvoiceController.relatedPurchase';
import savePurchase from '@salesforce/apex/accountInvoiceController.savePurchase';

const invoiceColumns = [
    {label: 'Invoice', fieldName: 'Name', type: 'text'}
]

const purchaseColumns = [
    {label: 'Name', fieldName: 'Name__c', type: 'text', editable: true}
    ,{label: 'Date', fieldName: 'Date__c', type: 'date', editable: true}
]

export default class AccountInvoiceLWC extends LightningElement {
    invoiceColumns = invoiceColumns;
    purchaseColumns = purchaseColumns;
    @api recordId;
    @api objectApiName;

    isModalOpen = false;
    isButtonVisible = false;
    invoiceSelected = [];
    invoices = [];
    purchases = [];
    @track draftValues = [];
    selectedRowsCount = 0;

    @wire(relatedInvoice, {acc : '$recordId'})
    wiredInvoice({error, data}) {
        if (data) {
            window.console.log(JSON.stringify(data));
            this.invoices = data;
        } else if (error) {
            window.console.error(error);
        }
    }

    getPurchases(){
        window.console.log('Entering getPurchases.');
        relatedPurchase({invList : this.invoiceSelected})
            .then(result => {
                this.purchases = result;
                window.console.log("purchases: \n");
                window.console.log(JSON.stringify(this.purchases));
            })
            .catch(error => {
                window.console.error(error);
            })
        window.console.log('Leaving getPurchases.');
    }

    clearPurchases(){
        this.purchases = [];
    }

    openModal(){
        this.getPurchases();
        this.isModalOpen = true;
    }

    closeModal(){
        this.isModalOpen = false;
        this.clearPurchases();
    }

    showOption(){
        this.isButtonVisible = this.selectedRowsCount > 0;
    }

    updateSelectedText(event){
        window.console.log('Entered updateSelectedText.');
        
        const selectedRows = event.detail.selectedRows;
        
        this.selectedRowsCount = selectedRows.length;
        this.showOption();

        //Store objects in selected rows in objectsSelected.
        let setRows = [];
        window.console.log('Adding items to setRows...');
        for( let i = 0; i < this.selectedRowsCount; i++){
            setRows.push(selectedRows[i]);
        }
        window.console.log('Copying setRows to objectsSelected...');
        this.invoiceSelected = setRows;
        window.console.log(JSON.stringify(this.invoiceSelected));

        window.console.log('Leaving updateSelectedText.');
    }

    onSave(event){
        window.console.log("Entering onSave.");
        savePurchase({purList : event.detail.draftValues})
            .then(result => {
                //this.purchases = result;
                window.console.log("savePurchase result: \n");
                window.console.log(JSON.stringify(result));
            })
            .catch(error => {
                window.console.error(error);
            })
        window.console.log("Leaving onSave.");
    }
}