public class demoAura2 {
	@auraEnabled(cacheable=true)
    public static List<Account> fetchListAcc(){
        List<Account> lstAcc = [Select ID, Name from Account];
        return lstAcc;
    }
    
    @auraEnabled(cacheable=true)
    public static List<Contact> fetchRelatedContacts(List<Account> accList){
       	List<Contact> conList = [SELECT ID, Name, AccountID, Account.Name FROM Contact WHERE AccountID in :accList];
        system.debug(conList);
        return conList;
    }
    
    @auraEnabled
    public static List<Contact> transferContacts(List<Contact> conList, string acc){
        system.debug('transferContacts details:');
        system.debug(conList);
        system.debug(acc);
        for(Contact con : conList){
            con.AccountId = acc;
        }
        
        Update conList;
        return conList;
    }
    
    @auraEnabled
    public static List<Account> fetchListAcc2(){
        return [Select ID, Name, AccountNumber, Phone from Account];
    }
    
    @auraEnabled
    public static List<Account> deleteAccount(List<Account> accList){
        system.debug(accList);
        Delete accList;
        return fetchListAcc2();
    }
    
    @auraEnabled
    public static List<Account> deepClone(List<Account> accList){
        Map<ID, Account> accMap = new Map<ID, Account>();
        List<Contact> conList = new List<Contact>();
        accList = [SELECT FIELDS(STANDARD), (SELECT FIELDS(STANDARD), Driving_License__c FROM Contacts) FROM Account WHERE ID in :accList];
        
        for(Account acc : accList){
            accMap.put(acc.ID, acc.clone(false, true));
        }
        System.debug(accMap.values());
        if(accMap.values().size() == 0){return fetchListAcc2();}
        
        Insert accMap.values();
        
        for(Account acc : accList){
            for(Contact con : acc.Contacts){
                Contact cont = con.clone(false, true);
                cont.AccountId = accMap.get(acc.ID).ID;
                conList.add(cont);
            }
        }
        system.debug(conList);
        if(conList.size() == 0){return fetchListAcc2();}
        
        Insert conList;
        
        return fetchListAcc2();
    }
}