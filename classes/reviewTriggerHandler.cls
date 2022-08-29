public class reviewTriggerHandler {

    /*
     * Updates the Avg Rating field on the Review's related Car object.
     */
    public static void averageReviews(List<Review__c> revList){
        Set<ID> carID = new Set<ID>();
        List<Car__c> carRev = new List<Car__c>();
        double sum, count;
        
        //Get the Cars associated with each Review.
        for(Review__c rev : revList){
            carID.add(rev.Car_Id__c);
        }
        if(carID.size() == 0){return;}
        
        //Get each Car and their associated Ratings.
        carRev = [SELECT ID, Avg_Rating__c, (SELECT ID, Rating__c FROM Reviews__r) FROM Car__c WHERE ID in :carID];
        
        //Recalculate the Avg Rating for each Car.
        for(Car__c car : carRev){
            sum = 0;
            count = 0;
            for(Review__c rev : car.Reviews__r){
                count++;
                
                //Picklist value checks have to be hardcoded.
                switch on rev.Rating__c{
                    when '5'{sum += 5;}
                    when '4'{sum += 4;}
                    when '3'{sum += 3;}
                    when '2'{sum += 2;}
                    when '1'{sum += 1;}
                    when else{sum += 0;}
                }
            }
            if(count == 0){continue;}
            
            car.Avg_Rating__c = sum / count;
        }
        
        Update carRev;
    }
}