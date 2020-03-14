public class StringArrayTest {
    public static List<String> generateStringArray(Integer n){
        // Create a list and add elements to it in one step
		List<String> tempStringList = new List<String>();
        for (Integer i=0;i<n;i++){
            tempStringList.add('Test '+String.valueOf(i));
        }
        System.debug(tempStringList);
        return tempStringList;
    }
}