public class AWSS3_GetService extends AWS {
        public override void init() {
            AWS_Keys__c awsKeySet= AWS_Keys__c.getInstance('media.trex.test');
            String bucketName = awsKeySet.Name;
            accessKey = awsKeySet.AWS_AccessKey_Id__c;
            String secretKey = awsKeySet.AWS_Secret_Key__c;
            endpoint = new Url('https://'+bucketName+'.s3.amazonaws.com/');
            resource = '/';
            region = 'frankfurt';
            service = 's3';
            
            method = HttpMethod.XGET;
            //	Remember to set "payload" here if you need to specify a body
            //	payload = Blob.valueOf('some-text-i-want-to-send');
            //  This method helps prevent leaking secret key, 
            //  as it is never serialized
            createSigningKey(secretKey);
       }
       public String[] getBuckets() {
           HttpResponse response = sendRequest();
           String[] results = new String[0];
           // Read response XML; if we get this far, no exception happened
           // This code was omitted for brevity
           return results;
       }
}