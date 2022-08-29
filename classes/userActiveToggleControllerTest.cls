@isTest
private class userActiveToggleControllerTest {
    
    @testSetup static void insertUsers(){
        List<User> userList = new List<User>();
        Id systemAdminProfileId = [SELECT ID FROM Profile WHERE Name = 'System Administrator' LIMIT 1].Id;
        for(integer i = 0; i < 2; i++){
            User u = new User();
            u.LastName = 'User' + i;
            u.Alias = u.LastName;
            u.Email = 'Email' + i + '@fake.com';
            u.Username = u.Email;
            u.TimeZoneSidKey = 'America/New_York';
            u.LocaleSidKey = 'en_US';
            u.EmailEncodingKey = 'ISO-8859-1';
            u.ProfileId = systemAdminProfileId;
            u.LanguageLocaleKey = 'en_US';
            //TimeZoneSidKey, LocaleSidKey, EmailEncodingKey, ProfileId, LanguageLocaleKey
            userList.add(u);
            
            if(math.mod(i, 2) == 0){
                u.IsActive = true;
            }
            else{
                u.IsActive = false;
            }
        }
        
        Insert userList;
    }
    
    @isTest static void testFunc(){
        List<User> users = new List<User>();
        
        users = userActiveToggleController.getInActiveUser(true, true);
        system.debug(users);
        
        users = userActiveToggleController.getInActiveUser(true, false);
        system.debug(users);
        
        users = userActiveToggleController.getInActiveUser(false, true);
        system.debug(users);
        
        users = userActiveToggleController.getInActiveUser(false, false);
        system.debug(users);
        
        users = userActiveToggleController.getInActiveUser(false, true);
        for(User u : users){
            userActiveToggleController.toggleUser(u.Id);
        }
        
        users = userActiveToggleController.getInActiveUser(false, true);
        system.debug(users);
    }

}