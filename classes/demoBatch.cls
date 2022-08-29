public class demoBatch implements Database.Batchable<sObject>  {
    // Query the records to be executed
    public Database.QueryLocator start(Database.BatchableContext bc){
        string soql = 'SELECT Id, NextStep FROM Opportunity';
        return database.getQueryLocator(soql);
    }
    //200 records by default it can process at a single time
    public void execute(Database.BatchableContext bc, List<Opportunity> newList){
       List<Opportunity> oppList = new List<Opportunity>();
        for(Opportunity opp: newList){
            opp.NextStep = 'Close the deal';
            oppList.add(opp);
        }
        if(oppList.size() > 0){
            update oppList;
        }
    }
    //POST Processing work done here
    // Like create task to the owner saying job done or sending emails to the owner saying work done
    public void finish(database.BatchableContext bc){
    }
}