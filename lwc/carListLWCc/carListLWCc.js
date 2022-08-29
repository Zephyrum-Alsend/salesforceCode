import { LightningElement } from 'lwc';
import getCars from '@salesforce/apex/CarListController.getCars';
export default class CarListLWCc extends LightningElement {
    cars = []
    search = '';
    
    handleCarSearch(event){
        console.log('Entering handleCarSearch.');
        console.log(JSON.stringify(event.detail));
        this.search = event.detail;
        getCars({carName : this.search})
            .then(result => {
                this.cars = result;
                console.log(JSON.stringify(this.cars));
            })
            .catch(error => {
                console.error(error);
                this.error = error;
            })
        console.log('Leaving handleCarSearch.');
    }
}