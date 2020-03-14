@isTest
public class TestVerifyDate {
    @isTest static void testCheckDatesWinthin30Days(){
        Date date1 = Date.newInstance(2016, 2, 17);
        Date date2 = Date.newInstance(2016, 2, 29);
        Date date3 = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(date2, date3);
    }
    
    @isTest static void testCheckDatesEndOfTheMonth(){
        Date date1 = Date.newInstance(2016, 3, 17);
        Date date2 = Date.newInstance(2016, 4, 29);
        Date date4 = Date.newInstance(2016, 3, 31);
        Date date3 = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(date4, date3);
    }
}