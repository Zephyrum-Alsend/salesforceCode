trigger reviewTrigger on Review__c (after insert) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            reviewTriggerHandler.averageReviews(trigger.new);
        }
    }
}