public class NewCaseListController {
    
    private String status = 'NEW';

	public List<Case> getNewCases() {
        List<Case> results = Database.query(
            'SELECT Id, CaseNumber ' +
            'FROM Case'
        );
        return results;
    }
}