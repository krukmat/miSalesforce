public class RandomContactFactory {
	public static List<Contact> generateRandomContacts (Integer numContacts, String surname) {
        List<Contact> contacts = new List<Contact>();
        
        for(Integer i=0;i<numContacts;i++) {
            Contact c = new Contact(FirstName='Contact ' + i, LastName = surname);
            contacts.add(c);
        }
 
        return contacts;
    }
}