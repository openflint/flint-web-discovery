"use strict";

var self = require('sdk/self');
var buttons = require('sdk/ui/button/action');
var tabs = require('sdk/tabs');

const { FlintDeviceManager } = require('./discovery/FlintDeviceManager');

var button = buttons.ActionButton({
    id: 'flint-web-discovery',
    label: 'Flint Web Discovery',
    icon: {
        '16': './img/icon-16.png',
        '32': './img/icon-32.png',
        '64': './img/icon-64.png'
    },
    onClick: launchAddon
});

var deviceManager = null;

function launchAddon(state) {
    tabs.open({
        url: self.data.url('index.html'),
        onOpen: function (tab) {
            console.log('tab is open!!!');
            _onOpen();
        },

        onReady: function (tab) {
            console.log('tab is ready!!!');
            _onReady();
        },
        onClose: function (tab) {
            console.warn('tab is close!!!');
            _onClose();
        }
    });
}

function _onOpen() {
}

function _onReady() {
    deviceManager = new FlintDeviceManager();

    deviceManager.on('devicefound', function (device) {
        console.log('found device: -> ', device.deviceName);
    });

    deviceManager.on('devicegone', function (device) {
        console.log('gone device: -> ', device.deviceName);
    });

    deviceManager.start();
}

function _onClose() {
    deviceManager.stop();
}
