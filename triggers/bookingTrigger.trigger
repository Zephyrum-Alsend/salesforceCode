trigger bookingTrigger on Booking__c (before insert, before update) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            bookingTriggerHandler.copyCustomerEmail(trigger.new);
        }
        if(trigger.isUpdate){
            bookingTriggerHandler.copyCustomerEmail(trigger.new);
            bookingTriggerHandler.calculateLatePenalty(trigger.oldMap, trigger.new);
        }
    }
}