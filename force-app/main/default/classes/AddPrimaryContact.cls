public class AddPrimaryContact implements Queueable {
    
    private Contact contact;
    private String state_abbr;
    
    public AddPrimaryContact(Contact contact, String state_abbr) {
        this.contact = contact;
        this.state_abbr = state_abbr;
    }
    public void execute(QueueableContext context) {
        List<Account> accounts = [Select Id from Account where BillingState=:this.state_abbr LIMIT 200];
        List<Contact> toInsert = new List<Contact>();
        Contact current;
        for (Account account : accounts) {
          current = this.contact.clone();
          current.AccountId = account.Id;
          toInsert.add(current);
        }
        insert toInsert;
    }
    
}