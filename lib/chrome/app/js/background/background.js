chrome.app.runtime.onLaunched.addListener(function () {
    var deviceManager = new FlintDeviceManager();
    deviceManager.on('devicefound', function (device) {
        console.log('background found: ', device.deviceName);
    });

    deviceManager.on('devicegone', function (device) {
        console.log('background gone: ', device.deviceName);
    });
    deviceManager.start();
});