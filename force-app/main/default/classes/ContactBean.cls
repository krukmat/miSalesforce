/* ContactBean: 
		Helper class for extract the information relevant to syncing up with the partner org 
*/

public class ContactBean {
    public String firstName;
    public String lastName;
    public String email;
    public String phone;

    public ContactBean(Contact sob) {
       this.firstName = (String) sob.firstName;
       this.lastName = (String) sob.lastName;
       this.email = (String) sob.email;
       this.phone = (String)sob.phone;
    }
}