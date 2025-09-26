trigger UpdateSkillOnApproval on Certification__c (after update) {
    List<Skill__c> skillsToUpdate = new List<Skill__c>();

    for(Certification__c cert : Trigger.new){
        Certification__c oldCert = Trigger.oldMap.get(cert.Id);

        // Check if Status changed to Approved
        if(cert.Status__c == 'Approved' && oldCert.Status__c != 'Approved'){
            try {
                Skill__c skill = [SELECT Id, Level__c FROM Skill__c WHERE Id = :cert.Skill__c LIMIT 1];
                skill.Level__c = 'Advanced'; // simple update for demo
                skillsToUpdate.add(skill);
            } catch(Exception e){
                System.debug('Error updating skill: ' + e.getMessage());
            }
        }
    }

    if(!skillsToUpdate.isEmpty()){
        update skillsToUpdate;
    }
}