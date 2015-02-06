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

class UdpSocket

    @ab2str: (buf) =>
        return String.fromCharCode.apply null, new Uint8Array(buf)

    @str2ab: (str) =>
        buf = new ArrayBuffer str.length
        bufView = new Uint8Array buf
        for i, _ of str
            bufView[i] = str.charCodeAt i
        return buf

    constructor: (options) ->
        @socket_ = new UDPSocket(options)
        @socket_.onmessage = (event) =>
            console.log '@@@@@@@@@@@@@@@'
            if @onPacket
                data = UdpSocket.ab2str event.data
                console.log '####### ', data
                @onPacket data

    joinMulticastGroup: (addr) ->
        @socket_.joinMulticastGroup addr

    send: (data, addr, port) ->
        console.log '$$$$$$$$$', data
        @socket_.send data, addr, port

    close: ->
        @socket_.close()

module.exports = UdpSocket
