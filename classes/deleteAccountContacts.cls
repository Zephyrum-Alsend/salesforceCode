public class deleteAccountContacts {
	@AuraEnabled
    public static void deleteContacts(List<Account> accList){
        String soqlQuery = 'SELECT ID FROM Contact WHERE AccountID IN :accList';
        List<Contact> conList = Database.query(soqlQuery);
        Delete conList;
    }
}