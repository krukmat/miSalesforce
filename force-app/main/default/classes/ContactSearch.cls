public class ContactSearch {
    public static List<Contact> searchForContacts(string last_name, string postal_code){
        return [select id, name from Contact where LastName=:last_name and MailingPostalCode=:postal_code];
    }
}