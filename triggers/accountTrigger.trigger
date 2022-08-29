trigger accountTrigger on Account (before insert, before update, after insert, before delete) {
    /*Before Update on same record
	After update on related record
	After update on same causes infinite loop of updating*/
    if(trigger.isBefore){
        if(trigger.isDelete){
            //for(Account acc : trigger.old){ acc.addError('no'); }
        }
        if(trigger.isInsert){
            //accountTriggerHandler.uniqueAccountName(trigger.new);
        }
        if(trigger.isUpdate){
            //accountTriggerHandler.countOpportunities(trigger.newMap);
            //accountTriggerHandler.uniqueAccountName(trigger.new);
            //accountTriggerHandler.updateRating(trigger.new);
            //accountTriggerHandler.updateAnnualRevenue(trigger.new);
        }
    }
    if(trigger.isAFter){
        if(trigger.isInsert){
            //accountTriggerHandler.createRelatedContact(trigger.new);
            //accountTriggerHandler.createRelatedOpportunity(trigger.new);
            //accountTriggerHandler.transferAccountContact(trigger.new);
        }
    }
}