public class customControllerClass {
    public Account acc{get;set;}
    
    public customControllerClass(){
        acc = new Account();
    }
    public void saveRecord(){
        insert acc;
    }

}