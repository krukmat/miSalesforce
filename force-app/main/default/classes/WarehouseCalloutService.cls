public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    @future(callout=true)
    public static void runWarehouseEquipmentSync() {
        System.debug('acasssssss');
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WarehouseCalloutService.WAREHOUSE_URL);
        request.setMethod('GET');
        request.setTimeout(120000);
        HttpResponse response = http.send(request);
        System.debug('acasssssss2');
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserializes the JSON string into collections of primitive data types.
            List<Object> equipments = (List<Object>) JSON.deserializeUntyped(response.getBody());
            List<Product2> apex_equipments;
            Product2 apex_equipment;
            // Cast the values in the 'animals' key as a list
            System.debug('Received the following equipments:');
            for (Object equipment: equipments) {
                // {_id=55d66226726b611100aaf741, cost=5000, lifespan=120, maintenanceperiod=365, name=Generator 1000 kW, quantity=5, replacement=false, sku=100003}
                Map<String, Object> map_values = (Map<String, Object>)equipment;
        		// buscar si existe el Equipment buscando por Warehouse_SKU__c
        		String sku_id = String.valueOf(map_values.get('sku'));
                apex_equipments = [ Select Name, Cost__c, Current_Inventory__c, Lifespan_Months__c, Maintenance_Cycle__c, Replacement_Part__c,Warehouse_SKU__c FROM Product2 WHERE Warehouse_SKU__c=:sku_id ];
                
                if (apex_equipments.size() == 0)
                	apex_equipment = new Product2();
                if (apex_equipments.size() > 0)
                    apex_equipment = apex_equipments.get(0);
                apex_equipment.name = String.valueOf(map_values.get('name'));
                apex_equipment.Cost__c = Double.valueOf(map_values.get('cost'));
                apex_equipment.Current_Inventory__c = Integer.valueOf(map_values.get('quantity'));
                apex_equipment.Lifespan_Months__c = Integer.valueOf(map_values.get('lifespan'));
                apex_equipment.Maintenance_Cycle__c = Integer.valueOf(map_values.get('maintenanceperiod'));
                apex_equipment.Replacement_Part__c = Boolean.valueOf(map_values.get('replacement'));
                apex_equipment.Warehouse_SKU__c = String.valueOf(map_values.get('sku'));
            	upsert apex_equipment;
            }
            
            
        }
    }
}