# *io-gaze* - Nim bindings for the Tobii Gaze eye tracking SDK.
#
# This file is part of the `Nim I/O <http://nimio.us>`_ package collection.
# See the file LICENSE included in this distribution for licensing details.
# GitHub pull requests are encouraged. (c) 2015 Headcrash Industries LLC.

import gazedatatypes, gazeerrorcodes


proc tobiigazeListUsbEyeTrackers*(deviceInfos: ptr UsbDeviceInfo;
  deviceInfosCap: cint; deviceInfosSize: ptr cint;
  errorCode: ptr TobiigazeErrorCode)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_list_usb_eye_trackers".}
  ## Collect information about all usb eye trackers currently connected to the
  ## machine.
  ##
  ## deviceInfos
  ##   A pre-allocated array that will contain device information about the eye
  ##   trackers
  ## deviceInfosCap
  ##   The capacity of the `deviceInfos` array
  ## deviceInfosSize
  ##   The number of eye trackers found
  ## errorCode
  ##   Will be set to `TobiigazeErrorCode.success <#TobiigazeErrorCode>`_ if
  ##   operation was successful, otherwise to an error code (can be `nil`).


proc tobiigazeGetConnectedEyeTracker*(url: cstring; urlSize: cint; 
  errorCode: ptr TobiigazeErrorCode)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_get_connected_eye_tracker".}
  ## Get the URL to a connected eye tracker. If mutliple eye trackers are
  ## connected, an arbitary eye tracker will be returned.
  ##
  ## url
  ##   Buffer where the url will be written to
  ## urlSize
  ##   Size of the buffer in bytes
  ## errorCode
  ##   Will be set to `TobiigazeErrorCode.success <#TobiigazeErrorCode>`_ if
  ##   operation was successful, otherwise to an error code (can be `nil`)
