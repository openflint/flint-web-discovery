#
# Copyright (C) 2013-2014, The OpenFlint Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS-IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

EventEmitter = require 'eventemitter3'
SSDPResponder = require './SSDPResponder'

class SSDPManager extends EventEmitter

    constructor: ->
        @ssdp = new SSDPResponder
            st: 'urn:dial-multiscreen-org:service:dial:1'
        @ssdp.on 'servicefound', (location) =>
            @_fetchDeviceDesc location

    start: ->
        console.log 'start SSDP Manager'
        @ssdp.start()

    stop: ->
        console.log 'stop SSDP Manager'
        @ssdp.stop()

    _fetchDeviceDesc: (url) ->
        xhr = new XMLHttpRequest(mozSystem: true)
        if not xhr
            throw '_fetchDeviceDesc: failed'

        xhr.open 'GET', url
        xhr.onreadystatechange = =>
            if xhr.readyState is 4
                @_parseDeviceDesc xhr.responseText, url
        xhr.send ''

    _parseDeviceDesc: (data, url) ->
        try
            parser = new DOMParser()
            xml = parser.parseFromString data, "text/xml"

            urlBase = null
            urls = xml.querySelectorAll 'URLBase'
            if urls and urls.length > 0
                urlBase = urls[0].innerHTML

            devices = xml.querySelectorAll 'device'
            if devices.length > 0
                @_parseSingleDeviceDesc devices[0], urlBase, url
        catch e
            console.error e

    _parseSingleDeviceDesc: (deviceNode, urlBase, url) ->
        deviceType = deviceNode.querySelector('deviceType').innerHTML
        udn = deviceNode.querySelector("UDN").innerHTML
        friendlyName = deviceNode.querySelector('friendlyName').innerHTML
        manufacturer = deviceNode.querySelector('manufacturer').innerHTML
        modelName = deviceNode.querySelector('modelName').innerHTML
        device =
            uniqueId: udn + url
            location: url
            urlBase: urlBase
            deviceType: deviceType
            friendlyName: friendlyName
            manufacturer: manufacturer
            modelName: modelName
        @emit 'devicefound', device['uniqueId'], device

module.exports = SSDPManager