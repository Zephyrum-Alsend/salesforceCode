@isTest
public class bookingTriggerHandlerTest {
    
    @testSetup static void populateRecords(){
        Car__c c = new Car__c();
        c.Car_Name__c = 'Test';
        c.Model_Name__c = 'Test';
        c.Number_of_car_Available__c = 6;
        
        Contact con = new Contact();
        con.LastName = 'McTest';
        con.Driving_Experience__c = 1;
        con.Driving_License__c = 'A';
        con.Email = 'McTest@Test.com';
        
        Insert con;
        Insert c;
    }
    
    @isTest static void calculateLatePenaltyTest(){
        Contact con = [SELECT ID FROM Contact WHERE LastName = 'McTest'];
        Car__c c = [SELECT ID FROM Car__c WHERE Car_Name__c = 'Test'];
        
        Booking__c book = new Booking__c();
        book.Contact_Name__c = con.ID;
        book.Car_Name__c = c.ID;
        book.Date_of_hire__c = date.today() - 8;
        book.Date_of_return__c = date.today() - 1;
        
        Insert book;
        
        book.Car_Returned__c = 'Yes';
        Update book;
        
        book = [SELECT Penalty_for_late_return__c FROM Booking__c WHERE ID = :book.ID];
        system.debug(book.Penalty_for_late_return__c);
    }
    
    @isTest static void copyCustomerEmailTest(){
        Contact con = [SELECT ID FROM Contact WHERE LastName = 'McTest'];
        Car__c c = [SELECT ID FROM Car__c WHERE Car_Name__c = 'Test'];
        
        Booking__c book = new Booking__c();
        book.Contact_Name__c = con.ID;
        book.Car_Name__c = c.ID;
        book.Date_of_hire__c = date.today();
        book.Date_of_return__c = date.today() + 7;
        
        Insert book;
        
        book = [SELECT Customer_Email__c FROM Booking__c WHERE ID = :book.ID];
        system.debug(book.Customer_Email__c);
    }

}