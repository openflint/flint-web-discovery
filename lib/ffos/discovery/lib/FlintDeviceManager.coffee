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
FlintDevice = require './FlintDevice'
SSDPManager = require './SSDPManager'

class FlintDeviceManager extends EventEmitter

    constructor: ->
        @devices = {}
        @ssdpManager = new SSDPManager()
        @ssdpManager.on 'devicefound', (uniqueId, device) =>
            if not @devices[uniqueId]
                @_onDeviceFound uniqueId, device
            else
                @devices[uniqueId].triggerTimer()

    _onDeviceFound: (uniqueId, device) ->
        _device = new FlintDevice(device)
        @devices[uniqueId] = _device
        _device.on 'devicegone', (_uniqueId) =>
            @_onDeviceGone _uniqueId
        @emit 'devicefound', _device.toJson()

    _onDeviceGone: (uniqueId) ->
        if @devices[uniqueId]
            @emit 'devicegone', @devices[uniqueId].toJson()
            delete @devices[uniqueId]

    start: ->
        @ssdpManager?.start()

    stop: ->
        @ssdpManager?.stop()

    getDeviceList: ->
        dList = []
        for _, value of @devices
            dList.push value
        return dList

module.exports = FlintDeviceManager
