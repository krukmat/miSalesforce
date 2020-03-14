@isTest
public class WahrehouseSyncScheduleTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    static testmethod void testScheduledJob() {
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        Test.startTest();
        String jobId = System.schedule('Update Inventory 2',
                CRON_EXP,
                new WarehouseSyncSchedule());
        Test.stopTest();
    }
}