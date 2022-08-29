import { LightningElement } from 'lwc';
export default class SearchBarLWC extends LightningElement {
    searchTerm = '';

    handleChange(event){
        this.searchTerm = event.detail.value;
        console.log(JSON.stringify(this.searchTerm));
        const newEvent = new CustomEvent('search', {detail : this.searchTerm});
        this.dispatchEvent(newEvent);
    }
}