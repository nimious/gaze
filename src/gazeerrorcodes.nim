# *io-gaze* - Nim bindings for the Tobii Gaze eye tracking SDK.
#
# This file is part of the `Nim I/O <http://nimio.us>`_ package collection.
# See the file LICENSE included in this distribution for licensing details.
# GitHub pull requests are encouraged. (c) 2015 Headcrash Industries LLC.

type
  tobiigaze_error_code* {.pure, size: sizeof(cint).} = enum
    success = 0, ## Success

    # Generic errors
    unknown = 1,
    outOfMemory = 2,
    bufferTooSmall = 3,
    invalidParameter = 4,

    # Sync function errors
    timeout = 100,
    operationAborted = 101,

    # Transport errors
    invalidUrl = 200,
    endpointNameLookupFailed = 201,
    endpointConnectFailed = 202,
    deviceCommunicationError = 203,
    alreadyConnected = 204,
    notConnected = 205,
    timesyncCommunicationError = 206,

    # Protocol errors
    protocolDecodingError = 300,
    protocolVersionError = 301,

    # Errors from eye tracker firmware
    fwUnknownOperation = 0x20000500,
    fwUnsupportedOperation = 0x20000501,
    fwOperationFailed = 0x20000502,
    fwInvalidPayload = 0x20000503,
    fwUnknownId = 0x20000504, 
    fwUnauthorized = 0x20000505, 
    fwExtensionRequired = 0x20000506, 
    fwInternalError = 0x20000507, 
    fwStateError = 0x20000508, 
    fwInvalidParameter = 0x20000509, 
    fwOperationAborted = 0x2000050A
