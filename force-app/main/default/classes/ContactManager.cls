/*
    ContactManager: REST Endpoint in partner org which has the objective to syncing up the Org's contacts.
    Crear la clase en la cuenta donde se debe sincronizar los contactos
*/
@RestResource(urlMapping='/Contacts/*')
global with sharing class ContactManager {
    
    @HttpPost
    global static ID upsertContact(String firstName, String lastName, String email, String phone) {
        // Creates the Contact instance
        Contact thisContact = new Contact(
            firstName=firstName,
            lastName=lastName,
            email=email,
            phone=phone);
        // upsert the contact
        upsert thisContact;
        // returns the contact's id
        return thisContact.Id;
    }
}