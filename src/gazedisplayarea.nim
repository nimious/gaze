# *io-gaze* - Nim bindings for the Tobii Gaze eye tracking SDK.
#
# This file is part of the `Nim I/O <http://nimio.us>`_ package collection.
# See the file LICENSE included in this distribution for licensing details.
# GitHub pull requests are encouraged. (c) 2015 Headcrash Industries LLC.

import gazecallbacktypes, gazedatatypes, gazeerrorcodes


proc tobiigazeGetDisplayAreaAsync*(eyeTracker: ptr TobiigazeEyeTracker; 
  callback: TobiigazeAsyncDisplayAreaCallback; userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_get_display_area_async".}
  ## Get the display area of the device asynchronously.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## callback
  ##   A callback function that will be called on command completion
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##   callback function (can be `nil`)


proc tobiigazeSetDisplayAreaAsync*(eyeTracker: ptr TobiigazeEyeTracker; 
  displayArea: ptr TobiigazeDisplayArea; callback: TobiigazeAsyncCallback; 
  userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_set_display_area_async".}
  ## Set the display area of the device asynchronously.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## displayArea
  ##   A struct containing the display area coordinates
  ## callback
  ##   A callback function that will be called on command completion
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##   callback function (can be `nil`)
  ##
  ## This call will result in a
  ## `TobiigazeErrorCode.fwUnsupportedOperation <#TobiigazeErrorCode>`_ in the
  ## callback if the connected Eye Tracker does not support the operation.


proc tobiigazeGetDisplayArea*(eyeTracker: ptr TobiigazeEyeTracker; 
  displayArea: ptr TobiigazeDisplayArea; errorCode: ptr TobiigazeErrorCode)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_get_display_area".}
  ## Get the display area synchronously.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## configuration
  ##   A struct containing the current display area coordinates (out parameter)
  ## errorCode
  ##   Will be set to `TobiigazeErrorCode.success <#TobiigazeErrorCode>`_ if
  ##   operation was successful, otherwise to an error code (can be `nil`)


proc tobiigazeSetDisplayArea*(eyeTracker: ptr TobiigazeEyeTracker; 
  displayArea: ptr TobiigazeDisplayArea; errorCode: ptr TobiigazeErrorCode)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_set_display_area".}
  ## Sets the display area synchronously.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## configuration
  ##   A struct containing the display area coordinates that should be set
  ## errorCode
  ##   Will be set to `TobiigazeErrorCode.success <#TobiigazeErrorCode>`_ if
  ##   operation was successful, otherwise to an error code (can be `nil`)
  ##
  ## This call will result in a
  ## `TobiigazeErrorCode.fwUnsupportedOperation <#TobiigazeErrorCode>`_ if the
  ## connected Eye Tracker does not support the operation.
