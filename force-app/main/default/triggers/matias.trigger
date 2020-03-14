trigger matias on Account (before update, before insert, after update, after insert) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
                System.debug('Account trigger');
        }
    }
}