public class contactListController {
     @AuraEnabled
     public static List<Contact> findAll() {
         return [SELECT id, name, phone FROM Contact LIMIT 50];
     }
     @AuraEnabled
     public static List<Contact> findByName(String methodSearchKey){
         String name = '%' + methodSearchKey + '%';
         List<Contact> lstCon = [SELECT id, name, phone FROM Contact WHERE name LIKE :name LIMIT 50];
         system.debug('Contact === '+ lstCon);
         return lstCon;
     }
}