public class customController {
    Account[] acctList = new List<Account>{new Account()};
   
    public string cString { get; set;}
    
    public string getStringMethod1(){
    	return cString;
    }
    
    public string getStringMethod2(){
        if(cString == null)
        	cString = 'Method2';
    	return cString;
    }
}