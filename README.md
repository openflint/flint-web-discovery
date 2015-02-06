# flint-web-discovery

## How to use

* ### chrome app
    * copy chrome/discovery/out/flint_discovery.js into your chrome app project, and inclucde flint_discovery.js in your code
    * sample app: chrome/app/
    
* ### firefox addon
    * copy firefox/discovery/ into your firefox addon project, and include FlintDeviceManager.js in your code
    * sample addon: firefox/addon/

* ### firefox os app
    * copy ffos/discovery/out/flint_discovery.js into your chrome app project, and inclucde flint_discovery.js in your code
    
## API

### FlintDeviceManager
#### Methods
* constructor

```
var manager = new FlintDeviceManager(); 
```

* start
    * description
        * start scanning
    * parameter
        * none
    * return value
        * none

* stop
    * description
        * stop scanning
    * parameter
        * none
    * return value
        * none

* getDevices
    * description
        * get all found devices
        * device's properties are list in next section
    * parameter
        * none
    * return value
        * An array contains devices
        
#### Events
* devicefound
    * description
        * fired when a new device found
    * callback
        * function(device)
            * device is an object contains detail information of the device
    * sample
    
        ```
        FlintDeviceManager.on('devicefound', function(device) {
            console.log(device.uniqueId);     // device's ID
            console.log(device.location);     // device's description's location
            console.log(device.urlBase);      // device's service url 
            console.log(device.host);         // device's host
            console.log(device.deviceType);   // device's type
            console.log(device.deviceName);   // device's name
            console.log(device.manufacture);  // device's manufacture 
            console.log(device.modelName);    // device's modelName
        });
        ```
* devicegone
    * description
        * fired when a device offline
    * callback
        * function(device)
            * device is an object contains detail information of the device
    * sample
    
        ```
        FlintDeviceManager.on('devicegone', function(device) {
            console.log(device.uniqueId);     // device's ID
            console.log(device.location);     // device's description's location
            console.log(device.urlBase);      // device's service url 
            console.log(device.host);         // device's host
            console.log(device.deviceType);   // device's type
            console.log(device.deviceName);   // device's name
            console.log(device.manufacture);  // device's manufacture 
            console.log(device.modelName);    // device's modelName
        });
        ```
