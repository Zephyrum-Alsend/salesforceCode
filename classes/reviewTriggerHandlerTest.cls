@isTest
public class reviewTriggerHandlerTest {
    
    @testSetup static void createRecords(){
        Car__c c = new Car__c();
        c.Car_Name__c = 'Test';
        c.Model_Name__c = 'Test';
        c.Number_of_car_Available__c = 6;
        
        Contact con = new Contact();
        con.LastName = 'McTest';
        con.Driving_Experience__c = 1;
        con.Driving_License__c = 'A';
        
        Insert con;
        Insert c;
    }
    
    @isTest static void averageReviewsTest(){
        Contact con = [SELECT ID FROM Contact WHERE LastName = 'McTest'];
        Car__c c = [SELECT ID FROM Car__c WHERE Car_Name__c = 'Test'];
        
        Review__c rev = new Review__c();
        rev.Car_Id__c = c.ID;
        rev.Customer_Name__c = con.ID;
        rev.Rating__c = '5';
        
        Insert rev;
        
        c = [SELECT Avg_Rating__c FROM Car__c WHERE ID = :c.ID];
        system.debug(c.Avg_Rating__c);
        
        rev = new Review__c();
        rev.Car_Id__c = c.ID;
        rev.Customer_Name__c = con.ID;
        rev.Rating__c = '3';
        
        Insert rev;
        
        c = [SELECT Avg_Rating__c FROM Car__c WHERE ID = :c.ID];
        system.debug(c.Avg_Rating__c);
    }

}