# *gaze* - Nim bindings for the Tobii Gaze eye tracking SDK.
#
# This file is part of the `Nim I/O <http://nimio.us>`_ package collection.
# See the file LICENSE included in this distribution for licensing details.
# GitHub pull requests are encouraged. (c) 2015 Headcrash Industries LLC.

import gazecallbacktypes, gazedatatypes, gazeerrorcodes


proc tobiigazeCalibrationStartAsync*(eyeTracker: ptr TobiigazeEyeTracker;
  callback: TobiigazeAsyncCallback; userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_calibration_start_async".}
  ## Acquire the calibration state and clears the temporary calibration buffer.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## callback
  ##   A callback function that will be called on command completion
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##   callback function (can be `nil`)


proc tobiigazeCalibrationStopAsync*(eyeTracker: ptr TobiigazeEyeTracker;
  callback: TobiigazeAsyncCallback; userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_calibration_stop_async".}
  ## Release the calibration state. This should always be done when the
  ## calibration is completed.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## callback
  ##   A callback function that will be called on command completion
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##   callback function (can be `nil`)


proc tobiigazeCalibrationAddPointAsync*(eyeTracker: ptr TobiigazeEyeTracker;
  point: ptr  TobiigazePoint2d; callback: TobiigazeAsyncCallback;
  userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_calibration_add_point_async".}
  ## Add data to the temporary calibration buffer for the specified calibration
  ## point which the user is assumed to be looking at.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## point
  ##   A two dimensional point specified in the ADCS coordinate system (screen
  ##   size percentage) where the users gaze is expected to be looking
  ## callback
  ##   A callback function that will be called on command completion
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##   callback function (can be `nil`)


proc tobiigazeCalibrationRemovePointAsync*(eyeTracker: ptr TobiigazeEyeTracker;
  point: ptr  TobiigazePoint2d; callback: TobiigazeAsyncCallback;
  userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_calibration_remove_point_async".}
  ## Remove the data associated with the specified calibration point from the
  ## temporary calibration buffer.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## point
  ##   A two dimensional point specified in the ADCS coordinate system (screen
  ##   size percentage) which has previously been added to the calibration
  ## callback
  ##   A callback function that will be called on command completion
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##   callback function (can be `nil`)
  ##
  ## This is normally done when recalibrating a point with bad quality data
  ## preceding a new call to
  ## `tobiigazeCalibrationAddPointAsync <#tobiigazeCalibrationAddPointAsync>`_
  ## with the same point.


proc tobiigazeCalibrationComputeAndSetAsync*(
  eyeTracker: ptr TobiigazeEyeTracker; callback: TobiigazeAsyncCallback;
  userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_calibration_compute_and_set_async".}
  ## Compute a calibration based on data in the temporary calibration buffer.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## callback
  ##   A callback function that will be called on command completion
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##   callback function (can be `nil`)
  ##
  ## If this operation succeeds the temporary calibration buffer will be copied
  ## to the active calibration buffer. If there is insufficient data to compute
  ## a calibration, `TobiigazeErrorCode.fwOperationFailed <#TobiigazeErrorCode>`_
  ## will be returned via the callback.


proc tobiigazeGetCalibrationAsync*(eyeTracker: ptr TobiigazeEyeTracker;
  callback: TobiigazeAsyncCalibrationCallback; userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_get_calibration_async".}
  ## Get current calibration from the active calibration buffer.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## callback
  ##   A callback function that will be called on command completion
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##   callback function (can be `nil`)


proc tobiigazeSetCalibrationAsync*(eyeTracker: ptr TobiigazeEyeTracker;
  calibration: ptr TobiigazeCalibration; callback: TobiigazeAsyncCallback;
  userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_set_calibration_async".}
  ## Set the specified calibration as the active calibration.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## calibration
  ##   A struct containing calibration data
  ## callback
  ##   A callback function that will be called on command completion
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##   callback function (can be `nil`)
  ##
  ## The calibration data is copied both to the active and the temporary
  ## calibration buffers.


proc tobiigazeGetCalibration*(eyeTracker: ptr TobiigazeEyeTracker;
  calibration: ptr TobiigazeCalibration; errorCode: ptr TobiigazeErrorCode)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_get_calibration".}
  ## Get current calibration from the active calibration buffer.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## calibration
  ##   Calibration out parameter
  ## errorCode
  ##   Will be set to `TobiigazeErrorCode.success <#TobiigazeErrorCode>`_ if
  ##   operation was successful, otherwise to an error code (can be `nil`)


proc tobiigazeSetCalibration*(eyeTracker: ptr TobiigazeEyeTracker;
                                calibration: ptr TobiigazeCalibration;
                                errorCode: ptr TobiigazeErrorCode)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_set_calibration".}
  ## Set the specified calibration as the active calibration.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## calibration
  ##   A struct containing the calibration
  ## errorCode
  ##   Will be set to `TobiigazeErrorCode.success <#TobiigazeErrorCode>`_ if
  ##   operation was successful, otherwise to an error code (can be `nil`)
  ##
  ## The calibration data is copied both to the active and the temporary
  ## calibration buffers.


proc tobiigazeGetCalibrationPointDataItems*(
  calibration: ptr tobiigaze_calibration;
  pointDataItems: ptr TobiigazeCalibrationPointData;
  pointDataItemsCapacity: cint; pointDataItemsSize: ptr cint;
  errorCode: ptr TobiigazeErrorCode)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_get_calibration_point_data_items".}
  ## Retrieve individual calibration point data from the specified calibration.
  ##
  ## calibration
  ##   A struct containing the calibration data
  ## pointDataItems
  ##   An array to be filled with point data entries
  ## pointDatasItemsCapacity
  ##   The capacity of the point data array (maximum number of entries)
  ## pointDatasItemsSize
  ##   The number of point data entries written to the array. Max items is
  ##   TOBIIGAZE_MAX_CALIBRATION_POINT_DATA_ENTRIES.
  ## errorCode
  ##   Will be set to `TobiigazeErrorCode.success <#TobiigazeErrorCode>`_ if
  ##   operation was successful, otherwise to an error code (can be `nil`)
