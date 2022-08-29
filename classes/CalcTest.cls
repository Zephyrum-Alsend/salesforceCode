public class CalcTest {
    public CalcTest(integer a, integer b){
        //calcSubtract(calcMultiply(calcSum(a, b)));
        calcSum2(a, b);
        calcMultiply2(sum);
        calcSubtract2(sum);
        system.debug(sum);
    }
    
    public integer calcSum(integer x, integer y){
        sum = x + y;
        system.debug(sum);
        return sum;
    }
    public integer calcMultiply(integer x){
        sum = x *= 10;
        system.debug(sum);
        return sum;
    }
    public integer calcSubtract(integer x){
        sum = x -= 100;
        system.debug(sum);
        return sum;
    }
    
    public void calcSum2(integer x, integer y){
        sum = x + y;
        system.debug(sum);
    }
    public void calcMultiply2(integer x){
        sum = x *= 10;
        system.debug(sum);
    }
    public void calcSubtract2(integer x){
        sum = x -= 100;
        system.debug(sum);
    }
    
    private integer sum;
}