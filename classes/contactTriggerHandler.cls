public class contactTriggerHandler {
    
    //Checks if each Contact has a related Account object.
    public static void assertAccountExists(List<Contact> contList){
        for(Contact cont : contList){
            //Show an error for each Contact with NULL related Account.
        	if(cont.accountID == NULL){
                cont.addError('Contact requires an associated Account to create.');
            }
        }
    }
    
    public static void uniqueContact(List<Contact>contList){
        //Declare variables.
        //Map<String, List<String>> contMap = new Map<String, List<String>>();
        Set<String> contEmail = new Set<String>();
        Set<String> contPhone = new Set<String>();
        List<Contact> duplContList = new List<Contact>();
        Map<String, List<String>> duplCont = new Map<String, List<String>>();
        
        //Capture Email and Phone pairs in sets.
        for(Contact cont : contList){
            if(cont.Email != NULL && cont.Phone != NULL){
                /*List<String> temp = new List<String>();
                if(contMap.containsKey(cont.Email)){
                    temp = contMap.get(cont.Email);
                }
                temp.add(cont.Phone);
            	contMap.put(cont.Email, temp);*/
                contEmail.add(cont.Email);
                contPhone.add(cont.Phone);
            }
        }
        
        //Return early if no data captured.
        if(contEmail.size() == 0 || contPhone.size() == 0) {return;}
        
        duplContList = [SELECT Email, Phone FROM Contact WHERE Email in :contEmail AND Phone in :contPhone];
        
        if(duplContList.size() == 0){return;}
        
        for(Contact cont : duplContList){
            List<String> temp = new List<String>();
            if(duplCont.containsKey(cont.Email)){
                temp = duplCont.get(cont.Email);
            }
            temp.add(cont.Phone);
            duplCont.put(cont.Email, temp);
        }
        
        for(Contact cont : contList){
            if(duplCont.containsKey(cont.Email) && (duplCont.get(cont.Email)).contains(cont.Phone) ){
                cont.addError('Email and Phone must be unique.');
            }
        }
    }
    
    /*
     * Enforces a one-to-one relationship between Account and Contact.
     * 
     */
    public static void onlyOneChild(List<Contact> contList){
        Set<ID> accSet = new Set<ID>();
        List<Contact> badCont = new List<Contact>();
        List<Contact> duplCont = new List<Contact>();
        String errMsg = 'Account already has an associated Contact.';
        
        //Record all related Accounts in accSet
        for(Contact cont : contList){
            if(cont.AccountId != NULL){
                //If contList has duplicates in it, throw an error early.
                if(accSet.contains(cont.AccountId)){
                    cont.addError(errMsg);
                    badCont.add(cont); //Record for removal later (don't want to risk offsetting the iterator).
                    continue;
                }
                
                accSet.add(cont.AccountId);
            }
        }
        
        //Remove duplicates from contList.
        for(Contact cont : badCont){
            contList.remove(contList.indexOf(cont));
        }
        
        //Return early if there's no related Accounts.
        if(accSet.size() == 0){return;}
        
        //Get all pre-existing Contacts with matching related Accounts.
        duplCont = [SELECT AccountID FROM Contact WHERE AccountID in :accSet];
        
        //Return early if there's no matches.
        if(duplCont.size() == 0){return;}
        
        //Transfer duplCont.AccountID to accSet, overwriting.
        accSet = new Set<ID>();
        for(Contact cont : duplCont){
            accSet.add(cont.AccountId);
        }
        
        //Throw an error for every Contact with a match in accSet.
        for(Contact cont : contList){
            if(accSet.contains(cont.AccountId)){
                cont.addError(errMsg);
            }
        }
        
    }
    
    //[Select ID,NumberofLocations__c,(Select ID from Contacts) from Account where ID in:accID]
    /*
     * 
     * 
     */
    public static void incrementAccountContactCount(List<Contact> contList, boolean add){
        Map<ID, integer> accMap = new Map<ID, integer>();
        List<Account> accList = new List<Account>();
        
        for(Contact cont : contList){
            if(cont.AccountId != NULL){
                if(accMap.containsKey(cont.AccountId)){
                    accMap.put(cont.AccountId, accMap.get(cont.AccountId) + 1);
                }
                else{
                    accMap.put(cont.AccountId, 1);
                }
            }
        }
        
        if(accMap.size() == 0){return;}
        
        accList = [SELECT ID, Number_of_Contacts__c FROM Account WHERE ID in :accMap.keySet()];
        
        if(accList.size() == 0){return;}
        
        if(add){
            for(Account acc : accList){
                acc.Number_of_Contacts__c += accMap.get(acc.ID);
            }
        }
        else{
            for(Account acc : accList){
                acc.Number_of_Contacts__c -= accMap.get(acc.ID);
            }
        }
        
        Update accList;
    }
    
    /*
     * 
     * 
     */
    public static void offsetAccountContactCount(List<Contact> oldContList, List<Contact> newContList){
        Map<ID, integer> accMap = new Map<ID, integer>();
        List<Account> accList = new List<Account>();
        ID accID;
        
        for(Contact cont : oldContList){
            accID = (newContList.get(newContList.indexOf(cont))).AccountId;
            if(cont.AccountId != accID ){
                //Subtract old from the count.
                if(accMap.containsKey(cont.AccountId)){
                    accMap.put(cont.AccountId, accMap.get(cont.AccountId) - 1);
                }
                else{
                    accMap.put(cont.AccountId, -1);
                }
                
                //Add new to the count.
                if(accMap.containsKey(accID)){
                    accMap.put(accID, accMap.get(accID) + 1);
                }
                else{
                    accMap.put(accID, 1);
                }
            }
        }
        
        accMap.remove(NULL);
        
        if(accMap.size() == 0){return;}
        
        accList = [SELECT ID, Number_of_Contacts__c FROM Account WHERE ID in :accMap.keySet()];
        
        if(accList.size() == 0){return;}
        
        for(Account acc : accList){
        	acc.Number_of_Contacts__c += accMap.get(acc.ID);
        }
        
        Update accList;
    }
}