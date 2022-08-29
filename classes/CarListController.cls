public class CarListController {
	@AuraEnabled(cacheable=true)
    public static List<Car__c> getCars(String carName){
        String name = '%' + carName + '%';
        system.debug(name);
        List<Car__c> cars = [SELECT ID, Name, Car_Name__c FROM Car__c WHERE Car_Name__c LIKE :name];
        system.debug(cars);
        return cars;
    }
}