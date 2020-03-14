public class BusScheduleCache {
	private Cache.OrgPartition part;
    public BusScheduleCache() {
        this.part = new Cache.OrgPartition('local.BusSchedule');
    }
    public void putSchedule(String busLine, Time[] schedule) {
        this.part.put(busLine, schedule);
    }
    public Time[] getSchedule(String busLine) {
		// Retrieve cache value from the partition
		Time[] cachedRate = (Time[])this.part.get(busLine);
        if (cachedRate == null) {
            Time[] timeDefault = new List<Time>();
            timeDefault.add(Time.newInstance(8, 0, 0, 0));
            timeDefault.add(Time.newInstance(17, 0, 0, 0));
            return timeDefault;
        }
        return cachedRate;
    }
}