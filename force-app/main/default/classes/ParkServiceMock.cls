@isTest
global class ParkServiceMock implements WebServiceMock {
   global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
        // start - specify the response you want to send
        ParkService.byCountryResponse response_x = 
            new ParkService.byCountryResponse();
        List<String> parks_string_list = new List<String>();
        parks_string_list.add('Shiretoko National Park');
        parks_string_list.add('Oze National Park');
        parks_string_list.add('Hakusan National Park');
        response_x.return_x = parks_string_list;
        // end
       response.put('response_x', response_x); 
   }
}