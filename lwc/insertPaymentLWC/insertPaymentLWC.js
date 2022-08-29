import { LightningElement, wire, api } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
/*
import AMOUNT from '@salesforce/schema/Payment.Amount';
import STATUS from '@salesforce/schema/Payment.Status';
import TYPE from '@salesforce/schema/Payment.Type';
import PROCESSING_MODE from '@salesforce/schema/Payment.ProcessingMode';
import PAYMENT_DATE from '@salesforce/schema/Payment.Payment_Date__c';
import CREDIT_CARD_NUMBER from '@salesforce/schema/Payment.Credit_Card_Number__c';
import CARD_EXPIRY_DATE from '@salesforce/schema/Payment.Card_Expiry_Date__c';
import CVV from '@salesforce/schema/Payment.CVV__c';
import CARD_OWNER_NAME from '@salesforce/schema/Payment.Card_Owner_Name__c';
import CAR_ID from '@salesforce/schema/Payment.Car_Id__c';
import CUSTOMER_ID from '@salesforce/schema/Payment.Customer_Id__c';
import BOOKING_ID from '@salesforce/schema/Payment.Booking_Id__c';*/
export default class InsertPaymentLWC extends LightningElement {

    @api objectApiName = 'Payment';

    @wire(getObjectInfo, {objectApiName : 'Payment'})
    wiredObj;

/*    fields = [AMOUNT
    , BOOKING_ID
    , CAR_ID
    , CUSTOMER_ID
    , CREDIT_CARD_NUMBER
    , CARD_EXPIRY_DATE
    , CVV
    , CARD_OWNER_NAME
    , PAYMENT_DATE
    , STATUS
    , TYPE
    , PROCESSING_MODE];
*/

    get fields(){
        let val = [this.wiredObj.data.fields.Name.apiName];
        console.log(JSON.stringify(val));
        return val;
    }

    handleSubmit(event) {
        event.preventDefault();
        const fields = event.detail.fields;
        this.template.querySelector('lightning-record-form').submit(fields);
    }

}