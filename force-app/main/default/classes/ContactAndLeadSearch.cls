public class ContactAndLeadSearch {
    public static List<List< sObject >> searchContactsAndLeads(string atoken) {
        return [FIND :atoken IN NAME FIELDS
                   RETURNING Contact(FirstName, LastName),Lead(FirstName,LastName)];
    }
}