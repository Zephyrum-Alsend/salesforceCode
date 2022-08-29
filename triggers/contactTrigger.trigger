trigger contactTrigger on Contact (before insert, before update, after insert, after update, after delete) {
    if(trigger.isBefore){
        
        if(trigger.isInsert){
            //contactTriggerHandler.uniqueContact(trigger.new);
            //contactTriggerHandler.onlyOneChild(trigger.new);
            //contactTriggerHandler.assertAccountExists(trigger.new);
        }
        if(trigger.isUpdate){
            //contactTriggerHandler.uniqueContact(trigger.new);
            //contactTriggerHandler.onlyOneChild(trigger.new);
        }
        
    }
    if(trigger.isAfter){
        if(trigger.isInsert){
            //contactTriggerHandler.incrementAccountContactCount(trigger.new, true);
        }
        if(trigger.isUpdate){
            //contactTriggerHandler.offsetAccountContactCount(trigger.old, trigger.new);
        }
        if(trigger.isDelete){
            //contactTriggerHandler.incrementAccountContactCount(trigger.old, false);
        }
    }
}