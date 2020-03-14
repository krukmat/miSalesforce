@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
	@HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String querystring = request.requestURI;
        String accountId = querystring.substring(querystring.lastIndexOf('/Accounts/')+10,
        querystring.lastIndexOf('/'));
        Account account = [SELECT Id, Name, (SELECT Id, Name FROM Contacts)
                           FROM Account 
                           WHERE Id = :accountId];
        return account;
    }
}