import { LightningElement, track, wire, api } from 'lwc';
import getInActiveUser from '@salesforce/apex/userActiveToggleController.getInActiveUser';
import toggleUser from '@salesforce/apex/userActiveToggleController.toggleUser';

export default class UserDetailLWC extends LightningElement {

    @track users = [];
    @track isUserActive = true;
    @track isUserInactive = true;
    @api userID;

    @wire(getInActiveUser, {active : true, inactive : true})
    wiredUsers({error, data}) {
        if (data) {
            console.log(JSON.stringify(data));
            this.users = data;
        } else if (error) {
            console.error(error);
        }
    }

    updateUsers(){
        getInActiveUser({active : this.isUserActive, inactive : this.isUserInactive})
            .then(result => {
                this.users = result;
                console.log(JSON.stringify(this.users));
            })
            .catch(error => {
                console.error(error);
            })
    }

    displayActive(){
        this.isUserActive = !this.isUserActive;
        this.updateUsers();
    }

    displayInactive(){
        this.isUserInactive = !this.isUserInactive;
        this.updateUsers();
    }

    toggleUserActivity(event){
        console.log("Entering toggleUserActivity.");
        this.userID = event.currentTarget.id.substring(0, event.currentTarget.id.indexOf("-"));
        console.log(JSON.stringify(this.userID));
        console.log(JSON.stringify(event.currentTarget.name));
        console.log("Reached toggleUser.");
        toggleUser({uID : this.userID})
            .then(result => {
                console.log(JSON.stringify(result));
            })
            .catch(error => {
                console.error(error);
            })

        console.log("Leaving toggleUserActivity.");
    }
}