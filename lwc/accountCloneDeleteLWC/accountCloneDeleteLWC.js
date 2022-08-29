import { LightningElement, wire, track, api } from 'lwc';
import fetchListAcc from '@salesforce/apex/demoAura2.fetchListAcc';
import deleteAccount from '@salesforce/apex/demoAura2.deleteAccount';
import deepClone from '@salesforce/apex/demoAura2.deepClone';
import fetchRelatedContacts from '@salesforce/apex/demoAura2.fetchRelatedContacts';
import transferContacts from '@salesforce/apex/demoAura2.transferContacts';

//Columns for Account datatable.
const columns = [
    { label: 'Name', fieldName: 'Name', type: 'text' }
]

//Columns for related Contacts datatable.
const contColumns = [
    { label: 'Name', fieldName: 'Name', type: 'text' }
    ,{ label: 'AccountId', fieldName: 'AccountId', type: 'text' }
    //,{ label: 'Account', fieldName: 'Account.Name', type: 'text' }
]

//Main
export default class AccountCloneDeleteLWC extends LightningElement {
    columns = columns;
    contColumns = contColumns;
    accounts = [];
    contacts = [];
    objectsSelected = [];
    contactSelected = [];
    selectedRowsCount = 0;
    isModalOpen = false;
    isEditContact = false;

    @api childObjectApiName = 'Contact';
    @api targetFieldApiName = 'AccountId';
    @api fieldLabel = 'Your field label here';
    @api disabled = false;
    @api value;
    @api required = false;
    @api selectedContactId;

    //Get Accounts via Apex
    @wire(fetchListAcc)
    wiredAccounts({error, data}) {
        if (data) {
            console.log(JSON.stringify(data));
            this.accounts = data;
        } else if (error) {
            console.log(JSON.stringify(error));
        }
    }

    //When an Account is selected, run this.
    updateSelectedText(event){
        console.log('Entered updateSelectedText.');
        
        const selectedRows = event.detail.selectedRows;
        console.log('Reached selectedRows');
        console.log(JSON.stringify(selectedRows));
        console.log(JSON.stringify(selectedRows.length));
        
        this.selectedRowsCount = selectedRows.length;
        console.log('Reached selectedRowsCount');
        console.log(JSON.stringify(this.selectedRowsCount));

        //Store objects in selected rows in objectsSelected.
        let setRows = [];
        console.log('Adding items to setRows...');
        for( let i = 0; i < this.selectedRowsCount; i++){
            setRows.push(selectedRows[i]);
        }
        console.log('Copying setRows to objectsSelected...');
        this.objectsSelected = setRows;
        console.log(JSON.stringify(this.objectsSelected));

        console.log('Leaving updateSelectedText.');
    }

    //Dummy handler for related Contacts datatable.
    updateSelectedText2(event){
        console.log('Entered updateSelectedText2.');
        
        const selectedRows = event.detail.selectedRows;
        console.log('Reached selectedRows');
        console.log(JSON.stringify(selectedRows));
        console.log(JSON.stringify(selectedRows.length));

        //Store objects in selected rows in contactSelected.
        let setRows = [];
        console.log('Adding items to setRows...');
        for( let i = 0; i < selectedRows.length; i++){
            setRows.push(selectedRows[i]);
        }
        console.log('Copying setRows to contactSelected...');
        this.contactSelected = setRows;
        console.log(JSON.stringify(this.contactSelected));

        console.log('Leaving updateSelectedText2.');
    }

    //If an Account(s) is selected, show buttons.
    get showButtons(){
        console.log('showButtons check: ');
        console.log(JSON.stringify(this.selectedRowsCount));
        return (this.selectedRowsCount > 0);
    }

    //When Delete button is clicked, run this.
    //Call Apex to delete objectsSelected.
    handleClick(){
        console.log('Entering handleClick.');
        deleteAccount({accList : this.objectsSelected})
            .then(result => {
                this.accounts = result;
            })
            .catch(error => {
                console.error(error);
            })
        console.log('Leaving handleClick.');
    }

    //When Clone button is clicked, run this.
    //Call Apex to clone objectsSelected.
    handleClick2(){
        console.log('Entering handleClick2.');
        deepClone({accList : this.objectsSelected})
            .then(result => {
                this.accounts = result;
            })
            .catch(error => {
                console.error(error);
            })
        console.log('Leaving handleClick2.');
    }

    //Call Apex to get all Contacts related to Accounts in objectsSelected.
    requestContacts(){
        console.log('Entering requestContacts.');
        fetchRelatedContacts({accList : this.objectsSelected})
            .then(result => {
                this.contacts = result;
                console.log(JSON.stringify(this.contacts));
            })
            .catch(error => {
                console.error(error);
            })
        console.log('Leaving requestContacts.');
    }

    //When Transfer Contact is clicked, run this.
    openModal(){
        this.requestContacts();
        this.isModalOpen = true;
    }

    //When the modal's X is clicked, run this.
    closeModal(){
        this.isModalOpen = false;
        this.contacts = [];
    }

    //Unused toggle for showing the modal.
    showModal(){
        this.isModalOpen = !this.isModalOpen;
    }

    editContact(){
        this.isEditContact = !this.isEditContact;
    }

    handleChange(event){
        this.value = event.detail.value;
        console.log(JSON.stringify(this.value));
    }

    submitEditContact(){
        console.log('Entering submitEditContact.');
        console.log(JSON.stringify(this.value));
        transferContacts({conList : this.contactSelected, acc : this.value[0]})
            .then(result => {
                this.contacts = result;
                console.log(JSON.stringify(this.contacts));
            })
            .catch(error => {
                console.error(error);
            })
        this.isEditContact = false;
        console.log('Leaving submitEditContact.');
    }
}