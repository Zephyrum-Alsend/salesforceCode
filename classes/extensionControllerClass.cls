public class extensionControllerClass {
    public Account acc{get;set;}
    
    public extensionControllerClass(ApexPages.StandardController controller){
        acc= (Account)controller.getRecord();
    }
    public void createAccnCon(){
        
        insert acc;
        Contact con= new Contact();
        con.AccountId=acc.id;
        con.LastName=acc.Name+' Contact';
        insert con;
    }

}