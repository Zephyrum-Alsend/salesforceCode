public class editUserUtil {
    public static User toggleIsActive(User u){
        u.IsActive = !u.IsActive;
        return u;
    }
}