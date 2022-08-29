public class userActiveToggleController {
	@auraEnabled(cacheable=true)
    public static List<User> getInActiveUser(boolean active, boolean inactive){
        String soqlQuery = 'SELECT Name, Email, IsActive FROM User';
        List<User> userList = new List<User>();
        
        if( !(active && inactive) ){
            if( (!active) && (!inactive) ){ return userList; }
            soqlQuery += ' WHERE IsActive = :active';
        }
        
        userList = Database.query(soqlQuery);
        
        return userList;
    }
    
    @auraEnabled
    public static List<User> toggleUser(String uID){
        system.debug(uID);
        List<User> users = new List<User>();
        String soqlQuery = 'SELECT ID, IsActive FROM User WHERE ID = :uID';
        
        users = Database.query(soqlQuery);
        system.debug(users);
        
        for(User u : users){
	        u.IsActive = !u.IsActive;   
        }
        
        Update users;
        return users;
    }
}