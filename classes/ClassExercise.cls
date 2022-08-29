public class ClassExercise {
    public ClassExercise(string name){
        createAccount(name);
        createContact(acc);
    }
    
    public void createAccount(string name){
        acc = new Account(Name = name);
        insert acc;
    }
    
    public void createContact(Account a){
        Contact c = new Contact(LastName = a.Name, accountID = a.ID);
        insert c;
    }
    
    private Account acc;
}