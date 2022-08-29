@isTest
public class accountTriggerTest {
    @isTest public static void accountTriggerTest(){
        Account acc = new Account(Name = 'ABC', Industry = 'Energy', Type = 'Customer - Direct');
        insert acc;
        Opportunity opp = new Opportunity(Name = 'ABC Opp', AccountID = acc.ID, StageName = 'Prospecting', CloseDate = Date.today());
        Contact con = new Contact(LastName = 'ABC Con', AccountID = acc.ID, Driving_License__c = 'A');
        insert opp;
        insert con;
        
        acc.Industry = 'Banking';
        update acc;
        
        Account acc1 = new Account(Name = 'ABC');
        insert acc1;
        
        acc1.Industry = 'Engineering';
        update acc1;
        
        Account acc2 = new Account(Name = 'ABC', Industry = 'Engineering');
        try{
            insert acc2;
        }
        catch(Exception E){
            System.debug('Error: '+E);
        }
    }

}