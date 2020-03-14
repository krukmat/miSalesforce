public with sharing class MyCustomLookupController {

  public Contact contact {get;set;}
  public Lead lead {get;set;}

  public MyCustomLookupController() {
    contact = new Contact();
    // TODO: Lead levantar los datos de uno creado previamente
    lead = [Select Id, Company, City, Country FROM Lead WHERE Id='00Q0Y000003aw1j'][0];
  }

}