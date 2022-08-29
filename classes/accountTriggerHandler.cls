public class accountTriggerHandler {
    
    //Updates Rating (picklist) field of passed Account objects.
    public static void updateRating(List<Account> accList){
        for(Account acc : accList){
            //Updates Rating if Industry is Engineering.
            if(acc.Industry == 'Engineering'){
                acc.Rating = 'Hot';
            }
        }
    }
    
    //Updates Annual Revenue (currency) field of passed Account objects.
    public static void updateAnnualRevenue(List<Account> accList){
        for(Account acc : accList){
            //Updates Annual Revenue if Industry is Banking.
            if(acc.Industry == 'Banking'){
                acc.AnnualRevenue = 50000;
            }
        }
    }
    
    //Creates a related Contact object.
    public static void createRelatedContact(List<Account> accList){
        List<Contact> contList = new List<Contact>();
        
        for(Account acc : accList){
            for(integer i = 0 ; i < acc.NumberofLocations__c ; i++ ){
                contList.add(new Contact(LastName = acc.Name, accountID = acc.Id, Driving_License__c = 'A'));
            }
        }
        
        if(contList.size() > 0) insert contList;
    }
    
    //Creates a related Opportunity object.
    public static void createRelatedOpportunity(List<Account> accList){
        List<Opportunity> oppoList = new List<Opportunity>();
        
        for(Account acc : accList){
            if(acc.Industry == 'Energy' && (acc.Type == 'Customer - Direct' || acc.Type == 'Customer - Channel')){
                oppoList.add(new Opportunity(Name = acc.Name + ' Account Opportunity', StageName = 'Prospecting', CloseDate = date.today() ));
            }
        }
        
        if(oppoList.size() > 0) insert oppoList;
    }
    
    //Enforces unique Account Name and Industry
    public static void uniqueAccountName(List<Account> accList){
        //Extract names and industries from accList into accMap
        Map<String, String> accMap = new Map<String, String>();
        for(Account acc : accList){
            if(acc.Industry != NULL){
                accMap.put(acc.Name, acc.Industry);
            }
        }
        
        //Return early if there's 0 names.
        if(accMap.size() <= 0) return;
        
        //SOQL all accounts with names in accNames
        List<Account> duplNames = [SELECT Name, Industry FROM Account WHERE Name in :accMap.keySet() AND Industry in :accMap.values()];
        
        //Return early if there's 0 duplicates.
        if(duplNames.size() <= 0) return;
        
        //Transfer SOQL result to a map
        Map<String, List<String>> duplAcc = new Map<String, List<String>>();
        for(Account acc : duplNames){
            List<String> temp = new List<String>();
            //Append the list if there's a duplicate Name with a different Industry
            if(duplAcc.containsKey(acc.Name)){
                temp = duplAcc.get(acc.Name);
            }
            temp.add(acc.Industry);
            duplAcc.put(acc.Name, temp);
        }
        
        //Compare accList to duplAcc and throw error on duplicates
        for(Account acc : accList){
            if(duplAcc.containsKey(acc.Name) && (duplAcc.get(acc.Name)).contains(acc.Industry) ){
                acc.addError('Name and Industry must be unique.');
            }
        }      
    }
    
    /*
     * If an Account with the same name as an existing Account is inserted, transfer all related Contacts from old to new and delete old.
     */
    public static void transferAccountContact(List<Account> accList){
        Map<String, ID> accName = new Map<String, ID>();
        List<Account> accToTrn = new List<Account>();
        List<Account> accToDel = new List<Account>();
        List<Contact> contToTrn = new List<Contact>();
        
        //Store new Accounts' names and IDs in a map.
        for(Account acc : accList){
            accName.put(acc.Name, acc.ID);
        }
        if(accName.size() == 0){return;}
        
        //Get all existing Accounts with matching Names.
        //Be sure to exclude matching IDs, as this trigger runs AFTER insert.
        accToTrn = [SELECT ID, Name, (SELECT ID, AccountID FROM Contacts) FROM Account WHERE Name in :accName.keySet() AND ID Not in :accName.values()];
        if(accToTrn.size() == 0){return;}
        System.debug('accToTrn: '+accToTrn);
        
        //Update related Contacts.
        for(Account acc : accToTrn){
            for(Contact cont : acc.Contacts){
                cont.AccountID = accName.get(acc.Name);
                contToTrn.add(cont);
            }
            //Transfer acc.ID to it's own list to be safe, removing associated Contact IDs.
            accToDel.add(new Account(ID = acc.ID));
        }
        
        //Update Contacts and delete old Accounts.
        System.debug('contToTrn: '+contToTrn);
        System.debug('accToDel: '+accToDel);
        if(contToTrn.size() > 0){Update contToTrn;}
        if(accToDel.size() > 0){Delete accToDel;}
    }
    
    /*
     * 
     */
    public static void countOpportunities(Map<ID, Account> accMap){
        //Zero out values b/c AggregateResult won't fetch an ID with 0 Opportunities.
        for(Account acc : accMap.values()){
            acc.Total_Opportunity_Amount__c = 0;
        }
        
        //Fetch a count of all Opportunities associated with Accounts in accMap.
        for(AggregateResult agr : [SELECT COUNT(ID) numOpp, AccountID accID FROM Opportunity WHERE AccountID in :accMap.keySet() GROUP BY AccountID]){
            //Set Total Opportunity Amount to the count of Opportunities for each Account.
            accMap.get( (ID)agr.get('accID') ).Total_Opportunity_Amount__c = (integer)agr.get('numOpp');
        }
        
    }
}