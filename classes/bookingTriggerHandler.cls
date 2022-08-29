public class bookingTriggerHandler {
    
    /*
     * Calculates the late penalty fee for bookings.
     */
    public static void calculateLatePenalty(Map<ID, Booking__c> oldBookList, List<Booking__c> newBookList){
        for(Booking__c book : newBookList){
            //If Car_Returned__c has changed value to 'Yes' and Date_of_Return__c has past.
            if(oldBookList.get(book.ID).Car_Returned__c != book.Car_Returned__c && book.Car_Returned__c == 'Yes' && book.Date_of_return__c < Date.today()){
                //Calculate late penalty.
                book.Penalty_for_late_return__c = book.Penalty_per_Day__c * book.Date_of_return__c.daysBetween(Date.today());
            }
        }
        
    }
    
    /*
     * Copies the Email field from the Booking's associated Contact onto the Booking's Email field, for use in Email Alerts.
     */
    public static void copyCustomerEmail(List<Booking__c> bookList){
        //Get the Contact from each Booking.
        Set<ID> contIDSet = new Set<ID>();
        for(Booking__c book : bookList){
            contIDSet.add(book.Contact_Name__c);
        }
        
        //Get the ID and Email of every Contact in contIDSet, returned as a map with ID as key.
        Map<ID, Contact> contMap = new Map<ID, Contact>([SELECT ID, Email FROM Contact WHERE ID in :contIDSet]);
        
        //Use the ID stored in each Booking's Contact_Name field to access the contMap and copy that Contact's Email into Customer_Email field.
        for(Booking__c book : bookList){
            book.Customer_Email__c = contMap.get(book.Contact_Name__c).Email;
        }
    }

}