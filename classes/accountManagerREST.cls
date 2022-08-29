@RestResource(urlMapping='/Account/*')
global with sharing class accountManagerREST {
    
    @HttpGet
    global static Account doGet(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountID = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        
        Account result = [SELECT ID, Name, Phone, Website FROM Account WHERE ID = :accountID];
        
        return result;
    }

    @HttpDelete
    global static void doDelete(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountID = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        
        Account markForDeath = [SELECT ID FROM Account WHERE ID = :accountID];
        Delete markForDeath;
    }
    
    @HttpPost
    global static String doPost(String name, String phone, String website){
        Account acc = new Account();
        acc.Name = name;
        acc.Phone = phone;
        acc.Website = website;
        insert acc;
        
        return acc.ID;
    }
}