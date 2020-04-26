public class AccountHandler {
    public static Boolean isStatic = True;
    public static Account insertNewAccount(string name) {
        try {
            Account acct = new Account(Name=name);
            insert acct;
            return acct;
        }
        catch(DmlException e){
            return null;
        }
    }
    public void aMethod(){
        isStatic = False;
    }
}