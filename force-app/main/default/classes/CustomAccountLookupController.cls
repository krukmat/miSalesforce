public with sharing class CustomAccountLookupController {

  public Account account {get;set;} // new account to create
  public List<Account> results{get;set;} // search results
  public string searchString{get;set;} // search keyword


  public CustomAccountLookupController() {
    account = new Account();
    // get the current search string
    searchString = System.currentPageReference().getParameters().get('lksrch');
    
    runSearch();  
  }

  // performs the keyword search
  public PageReference search() {
    runSearch();
    return null;
  }

  // prepare the query and issue the search command
  private void runSearch() {
    // TODO prepare query string for complex serarches & prevent injections
    results = performSearch(searchString);               
  } 

  // run the search and return the records found. 
  private List<Account> performSearch(string searchString) {

    String searchCity = System.currentPageReference().getParameters().get('city');
    String searchCountry = System.currentPageReference().getParameters().get('country');
    String soql = 'SELECT id, name FROM Account WHERE Type!=\'Branch\'';
    if(searchString != '' && searchString != null)
      soql = soql +  ' AND name LIKE \'%' + searchString +'%\'';
    soql = soql + ' AND BillingCity = \'' + searchCity + '\'';
    //soql = soql + ' AND BillingCity = \'Barcelona\'';
    soql = soql + ' limit 25';
    return database.query(soql); 

  }

  // save the new account record
  public PageReference saveAccount() {
    insert account;
    // reset the account
    account = new Account();
    return null;
  }

  // used by the visualforce page to send the link to the right dom element
  public string getFormTag() {
    return System.currentPageReference().getParameters().get('frm');
  }

  // used by the visualforce page to send the link to the right dom element for the text box
  public string getTextBox() {
    return System.currentPageReference().getParameters().get('txt');
  }

}