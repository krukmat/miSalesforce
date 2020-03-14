public class ParkLocator {
    public static List<String> country(String ctry){
        ParkService.ParksImplPort service = new ParkService.ParksImplPort();  
        return service.byCountry(ctry);
    }
}