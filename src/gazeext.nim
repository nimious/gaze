# *gaze* - Nim bindings for the Tobii Gaze eye tracking SDK.
#
# This file is part of the `Nim I/O <http://nimio.us>`_ package collection.
# See the file LICENSE included in this distribution for licensing details.
# GitHub pull requests are encouraged. (c) 2015 Headcrash Industries LLC.

import gazecallbacks, gazedatatypes, gazeerrorcodes


proc tobiigazeSendCustomCommand*(eyeTracker: ptr TobiigazeEyeTracker;
  inData: ptr TobiigazeCustomCommand; outData: ptr TobiigazeCustomCommand;
  errorCode: ptr TobiigazeErrorCode)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_send_custom_command".}
  ## Send a custom command to the eye tracker.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## inData
  ##   Data to send to the eye tracker (must be allocated by the caller)
  ## outData
  ##   Data to receive from the eye tracker
  ## errorCode
  ##   Will be set to `TobiigazeErrorCode.success <#TobiigazeErrorCode>`_ if
  ##   operation was successful, otherwise to an error code (can be `nil`)


proc tobiigazeSendCustomCommandAsync*(eyeTracker: ptr TobiigazeEyeTracker;
  inData: ptr TobiigazeCustomCommand;
  callback: TobiigazeAsyncCustomCommandCallback; userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_send_custom_command_async".}
  ## Send a custom command to the eye tracker asynchronously.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## inData
  ##   Data to send to the eye tracker (must be allocated by the caller)
  ## callback
  ##   A callback function that will be called on command completion
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##   callback function (can be `nil`)


proc tobiigazeSetOption*(eyeTracker: ptr TobiigazeEyeTracker;
  option: TobiigazeOption; value: pointer; errorCode: ptr TobiigazeErrorCode)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_set_option".}
  ## Set an API option. Options are documented in TobiigazeOption.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## option
  ##   The id of the option
  ## value
  ##   A pointer to the value of the option
  ## errorCode
  ##   Will be set to `TobiigazeErrorCode.success <#TobiigazeErrorCode>`_ if
  ##   operation was successful, otherwise to an error code (can be `nil`)


proc tobiigazeGazeDataExtensionToUint32*(
  extension: ptr TobiigazeGazeDataExtension;
  errorCode: ptr TobiigazeErrorCode): cuint
  {.cdecl, dynlib: dllname, importc: "tobiigaze_gaze_data_extension_to_uint32".}
  ## Translate raw extension bytes to an integer.
  ##
  ## extension
  ##   An eye tracker instance
  ## errorCode
  ##   Will be set to `TobiigazeErrorCode.success <#TobiigazeErrorCode>`_ if
  ##   operation was successful, otherwise to an error code (can be `nil`)
  ## result
  ##   The integer value of the extension field
  ##
  ## A type-check will occur, and an error will be returned if the types do not
  ## match.


proc tobiigazeGazeDataExtensionToFloat*(
    extension: ptr TobiigazeGazeDataExtension;
    errorCode: ptr TobiigazeErrorCode): cfloat
  {.cdecl, dynlib: dllname, importc: "tobiigaze_gaze_data_extension_to_float".}
  ## Translate raw extension bytes to a float.
  ##
  ## extension
  ##   An eye tracker instance
  ## errorCode
  ##   Will be set to `TobiigazeErrorCode.success <#TobiigazeErrorCode>`_ if
  ##   operation was successful, otherwise to an error code (can be `nil`)
  ## result
  ##   The float value of the extension field
  ##
  ## A type-check will occur, and an error will be returned if the types do not
  ## match.


proc tobiigazeGazeDataExtensionToString*(
  extension: ptr TobiigazeGazeDataExtension; destination: cstring;
  capacity: cint; errorCode: ptr TobiigazeErrorCode)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_gaze_data_extension_to_string".}
  ## Translate raw extension bytes to a string.
  ##
  ## extension
  ##   An eye tracker instance
  ## destination
  ##   A buffer that will contain the data
  ## capacity
  ##   The capacity of the destination buffer
  ## errorCode
  ##   Will be set to `TobiigazeErrorCode.success <#TobiigazeErrorCode>`_ if
  ##   operation was successful, otherwise to an error code (can be `nil`)
  ##
  ## A type-check will occur, and an error will be returned if the types do not
  ## match.


proc tobiigazeGazeDataExtensionToBlob*(
  extension: ptr TobiigazeGazeDataExtension; destination: ptr char;
  capacity: cint; errorCode: ptr TobiigazeErrorCode)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_gaze_data_extension_to_blob".}
  ## Translate raw extension bytes to a blob.
  ##
  ## extension
  ##   An eye tracker instance
  ## destination
  ##   A buffer that will contain the data
  ## capacity
  ##   The capacity of the destination buffer
  ## errorCode
  ##   Will be set to `TobiigazeErrorCode.success <#TobiigazeErrorCode>`_ if
  ##   operation was successful, otherwise to an error code (can be `nil`)
  ##
  ## A type-check will occur, and an error will be returned if the types do not
  ## match.
