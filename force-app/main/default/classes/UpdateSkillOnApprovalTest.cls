@isTest
public class UpdateSkillOnApprovalTest {
    @isTest
    static void testSkillUpdate() {
        // Create Employee
        Employee__c emp = new Employee__c(Name='Test Employee', Department__c='IT', Job_Role__c='Developer');
        insert emp;

        // Create Skill
        Skill__c skill = new Skill__c(Skill_Name__c='Apex', Level__c='Beginner');
        insert skill;

        // Create Certification
        Certification__c cert = new Certification__c(
            Employee__c = emp.Id,
            Skill__c = skill.Id,
            Status__c = 'Pending',
            Score__c = 80
        );
        insert cert;

        // Update Certification to Approved
        cert.Status__c = 'Approved';
        update cert;

        // Query updated Skill
        Skill__c updatedSkill = [SELECT Id, Level__c FROM Skill__c WHERE Id = :skill.Id];
        System.assertEquals('Advanced', updatedSkill.Level__c, 'Skill Level should update to Advanced');
    }
}