#!/bin/sh

grunt

rm -rf ../app/js/discovery/FlintDeviceManager.js
cp out/FlintDeviceManager.js ../app/js/discovery/