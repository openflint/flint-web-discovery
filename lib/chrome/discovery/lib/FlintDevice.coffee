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

class FlintDevice extends EventEmitter

    constructor: (device) ->
        @timeoutId_ = null

        @urlBase_ = device.urlBase
        @host_ = @urlBase_.replace 'http://', ''
        @host_ = @host_.replace ':9431', ''

        @friendlyName_ = device.friendlyName
        @uniqueId_ = device.uniqueId
        @deviceType_ = device.deviceType
        @manufacture_ = device.manufacturer
        @modelName_ = device.modelName
        @location_ = device.location

    getUrlBase: ->
        return @urlBase_

    getHost: ->
        return @host_

    getName: ->
        return @friendlyName_

    getUniqueId: ->
        return @uniqueId_

    toJson: ->
        json =
            uniqueId: @uniqueId_,
            location: @location_,
            urlBase: @urlBase_,
            host: @host_,
            deviceType: @deviceType_,
            deviceName: @friendlyName_,
            manufacture: @manufacturer_,
            modelName: @modelName_
        return json

    triggerTimer: ->
        @_clearTimer()
        @timeoutId_ = setTimeout (=>
            @_onTimeout()
        ), 60 * 1000

    clear: ->
        @_clearTimer()

    _clearTimer: ->
        if @timeoutId_
            clearTimeout @timeoutId_

    _onTimeout: ->
        @emit 'devicegone', @uniqueId_

module.exports = FlintDevice
