public class accountInvoiceController {
    @AuraEnabled(cacheable=true)
    public static List<InvoiceC__c> relatedInvoice(ID acc){
        system.debug('accID: '+acc);
        return [SELECT ID, Name FROM InvoiceC__c WHERE Account__c = :acc];
    }
    
    @AuraEnabled
    public static List<Purchase__c> relatedPurchase(List<InvoiceC__c> invList){
        system.debug('invList: '+invList);
        return [SELECT ID, Name__c, Date__c FROM Purchase__c WHERE Invoice__c in :invList];
    }
    
    @AuraEnabled
    public static List<Purchase__c> savePurchase(List<Purchase__c> purList){
        system.debug('purList: '+purList);
        Update purlist;
        return purList;
    }

}