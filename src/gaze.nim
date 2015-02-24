## *io-gaze* - Nim bindings for the Tobii Gaze eye tracking SDK.
##
## This file is part of the `Nim I/O <http://nimio.us>`_ package collection.
## See the file LICENSE included in this distribution for licensing details.
## GitHub pull requests are encouraged. (c) 2015 Headcrash Industries LLC.

{.deadCodeElim: on.}

include
  gazedatatypes,
  gazeerrorcodes,
  gazecallbacktypes


when defined(android):
  const dllname = "libtobiigazecore.so"
elif defined(linux):
  const dllname = "libtobiigazecore.so"
elif defined(windows):
  if defined(amd64):
    const dllname = "TobiiGazeCore64.lib"
  else:
    const dllname = "TobiiGazeCore32.lib"
else:
  {.error: "io-gaze does not support this platform".}


proc tobiigazeCreate*(url: cstring; errorCode: ptr TobiigazeErrorCode):
  ptr TobiigazeEyeTracker
  {.cdecl, dynlib: dllname, importc: "tobiigaze_create".}
  ## Create an eye tracker instance.
  ##
  ## url
  ##   An url identifying the eye tracker. Currently only the tet-tcp protocol
  ##   is defined. Example: "tet-tcp://172.68.195.1".
  ## errorCode
  ##   Will be set to TOBIIGAZE_ERROR_SUCCESS if operation was successful,
  ##   otherwise to an error code (can be `nil`)
  ## result
  ##   An eye tracker instance, or `nil` if creation failed


proc tobiigazeDestroy*(eyeTracker: ptr TobiigazeEyeTracker)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_create".}
  ## Destroy an eye tracker instance. Must NOT be called from a callback.
  ##
  ## eyeTracker
  ##   An eye tracker instance


proc tobiigazeRegisterErrorCallback*(eyeTracker: ptr TobiigazeEyeTracker; 
  callback: TobiigazeAsyncCallback; userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_register_error_callback".}
  ## Register a callback that will return an error code when a spontaneous error
  ## occurs (an error not directly associated with a command). Most likely this
  ## error is related to problems with the eye tracker communication and is
  ## unrecoverable.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## callback
  ##   A callback function that will be called when an error occurs. Set to
  ##   `nil` to unregister a previously registered callback.
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##   callback function (can be `nil`)


proc tobiigazeGetVersion*(): cstring
  {.cdecl, dynlib: dllname, importc: "tobiigaze_get_version".}
  ## Get the version of the library.
  ##
  ## result
  ##   The version of the library of the form "1.0.2"


proc tobiigazeSetLogging*(filename: cstring; logLevel: TobiigazeLogLevel; 
  errorCode: ptr TobiigazeErrorCode)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_get_version".}
  ## Set the logging output filename and verbosity.
  ##
  ## filename
  ##   The filename of the logfile
  ## logLevel
  ##   The verbosity of the logging
  ## errorCode
  ##   Will be set to TOBIIGAZE_ERROR_SUCCESS if operation was successful,
  ##   otherwise to an error code (can be `nil`)


proc tobiigazeConnectAsync*(eyeTracker: ptr TobiigazeEyeTracker; 
  callback: TobiigazeAsyncCallback; userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_connect_async".}
  ## Connect to an eye tracker asynchronously.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## callback
  ##   A callback function that will be called on command completion
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##   callback function (can be `nil`)


proc tobiigazeConnect*(eyeTracker: ptr TobiigazeEyeTracker; 
  errorCode: ptr TobiigazeErrorCode)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_connect".}
  ## Connect to an eye tracker synchronously.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## errorCode
  ##   Will be set to TOBIIGAZE_ERROR_SUCCESS if operation was successful,
  ##   otherwise to an error code (can be `nil`)


proc tobiigazeDisconnectAsync*(eyeEracker: ptr TobiigazeEyeTracker; 
  callback: TobiigazeAsyncBasicCallback; userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_disconnect_async".}
  ## Disonnect from an eye tracker asynchronously.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## callback
  ##   A callback function that will be called on command completion
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##   callback function (can be `nil`)


proc tobiigazeDisconnect*(eyeTracker: ptr TobiigazeEyeTracker)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_disconnect".}
  ## Disconnects from an eye tracker synchronously.
  ##
  ## eyeTracker
  ##   An eye tracker instance


proc tobiigazeRunEventLoop*(eyeTracker: ptr TobiigazeEyeTracker; 
  errorCode: ptr TobiigazeErrorCode)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_run_event_loop".}
  ## Run the event loop.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## errorCode
  ##   Will be set to TOBIIGAZE_ERROR_SUCCESS if operation was successful,
  ##   otherwise to an error code (can be `nil`)
  ##
  ## This is a blocking call and must be called on a dedicated thread.


proc tobiigazeRunEventLoopOnInternalThread*(eyeTracker: ptr TobiigazeEyeTracker;
  callback: TobiigazeAsyncCallback; userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_run_event_loop_on_internal_thread".}
  ## Run the event loop on asynchronously.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## callback
  ##   A callback function that will be called when the run loop exits (can be
  ##   `nil`)
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##   callback function (can be `nil`)
  ##
  ## This function creates a thread internally on which the event loops run.


proc tobiigazeBreakEventLoop*(eyeTracker: ptr TobiigazeEyeTracker)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_break_event_loop".}
  ## Break the event loop.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ##
  ## This will make the blocking
  ## `tobiigazeRunEventLoop <#tobiigazeRunEventLoop>`_ call return. Must NOT be
  ## called from a callback. Any outstanding work is cancelled. If
  ## `runEventLoop <#runEventLoop>`_ was used to start the loop, it is up to the
  ## client to synchronize the thread with join(). If
  ## `runEventLoopAsync <#runEventLoopAsync>`_ was used, the thread is joined in
  ## this call. After this function has been called, it is not possible to start
  ## a new event loop on the same eye tracker instance.


proc tobiigazeStartTrackingAsync*(eyeTracker: ptr TobiigazeEyeTracker; 
  callback: TobiigazeAsyncCallback; gazeCallback: TobiigazeGazeListener; 
  userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_start_tracking_async".}
  ## Start gaze tracking asynchronously.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## callback
  ##   A callback function that will be called on command completion (note that
  ##   this is not the callback that will provide the actual gaze data)
  ## gazeCallback
  ##   A callback function that will be called asynchronously when gaze data is
  ##   available
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##   callback function (can be `nil`)


proc tobiigazeStartTracking*(eyeTracker: ptr TobiigazeEyeTracker; 
  gazeCallback: TobiigazeGazeListener; errorCode: ptr TobiigazeErrorCode; 
  userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_start_tracking".}
  ## Start gaze tracking synchronously.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## gazeCallback
  ##   A callback function that will be called asynchronously when gaze data is
  ##   available
  ## errorCode
  ##   Will be set to TOBIIGAZE_ERROR_SUCCESS if operation was successful,
  ##   otherwise to an error code (can be `nil`)
  ## userData
  ##  Optional user supplied data that will be passed unmodified to the callback
  ##  function (can be `nil`)


proc tobiigazeStopTrackingAsync*(eyeTracker: ptr TobiigazeEyeTracker; 
  callback: TobiigazeAsyncCallback; userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_start_tracking".}
  ## Stop gaze tracking asynchronously.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## callback
  ##   A callback function that will be called on command completion
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##   callback function (can be `nil`)


proc tobiigazeStopTracking*(eyeTracker: ptr TobiigazeEyeTracker; 
  errorCode: ptr TobiigazeErrorCode)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_stop_tracking".}
  ## Stop gaze tracking synchronously.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## errorCode
  ##   Will be set to TOBIIGAZE_ERROR_SUCCESS if operation was successful,
  ##   otherwise to an error code (can be `nil`)


proc tobiigazeGetDeviceInfoAsync*(eyeTracker: ptr TobiigazeEyeTracker; 
    callback: tobiigazeAsyncDeviceInfoCallback; userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_get_device_info_async".}
  ## Get the device info, such as platform, versions etc, asynchronously.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## callback
  ##   A callback function that will be called on command completion
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##  callback function (can be `nil`)


proc tobiigazeGetDeviceInfo*(eyeTracker: ptr TobiigazeEyeTracker; 
  deviceInfo: ptr TobiigazeDeviceInfo; errorCode: ptr TobiigazeErrorCode)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_get_device_info".}
  ## Get the device info, such as platform, versions etc, synchronously.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## deviceInfo
  ##   Device information out parameter
  ## errorCode
  ##   Will be set to TOBIIGAZE_ERROR_SUCCESS if operation was successful,
  ##   otherwise to an error code (can be `nil`)


proc tobiigazeGetTrackBoxAsync*(eyeTracker: ptr TobiigazeEyeTracker; 
  callback: TobiigazeAsyncTrackboxCallback; userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_get_track_box_async".}
  ## Get the track box asynchronously.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## callback
  ##   A callback function that will be called on command completion
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##   callback function (can be `nil`)


proc tobiigazeGetTrackBox*(eyeTracker: ptr TobiigazeEyeTracker;
  trackBox: ptr TobiigazeTrackBox; errorCode: ptr TobiigazeErrorCode)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_get_track_box".}
  ## Get the track box synchronously.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## trackBox
  ##   Track box information out parameter
  ## errorCode
  ##   Will be set to TOBIIGAZE_ERROR_SUCCESS if operation was successful,
  ##   otherwise to an error code (can be `nil`)


proc tobiigazeGetGeometryMounting_async*(eyeTracker: ptr TobiigazeEyeTracker;
  callback: TobiigazeAsyncGeometryMountingCallback; userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_get_geometry_mounting_async".}
  ## Get the geometry mounting asynchronously.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## callback
  ##   A callback function that will be called on command completion
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##   callback function (can be `nil`)


proc tobiigazeGetGeometryMounting*(eyeTracker: ptr TobiigazeEyeTracker; 
  geometryMounting: ptr TobiigazeGeometryMounting;
  errorCode: ptr TobiigazeErrorCode)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_get_geometry_mounting".}
  ## Get the geometry mounting.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## geometryMounting
  ##   Geometry mounting out parameter
  ## errorCode
  ##   Will be set to TOBIIGAZE_ERROR_SUCCESS if operation was successful,
  ##   otherwise to an error code (can be `nil`)


proc tobiigazeRegisterKeyProvider*(eyeTracker: ptr TobiigazeEyeTracker; 
  callback: TobiigazeKeyProviderCallback; errorCode: ptr TobiigazeErrorCode; 
  userData: pointer)
  {.cdecl, dynlib: dllname, importc: "tobiigaze_register_key_provider".}
  ## Register a callback providing a key for unlocking the eye tracker.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## callback
  ##   A callback function. Set to `nil` to unregister a previously registered
  ##   callback, that is, use the default key provider.
  ## errorCode
  ##   Will be set to TOBIIGAZE_ERROR_SUCCESS if operation was successful,
  ##   otherwise to an error code (can be `nil`)
  ## userData
  ##   Optional user supplied data that will be passed unmodified to the
  ##   callback function (can be `nil`)
  ##
  ## The Tobii Gaze Core library unlocks developer edition eye trackers
  ## automatically; this function can be used to unlock other eye trackers.
  ## Registering a key provider disables the built-in default key.


proc tobiigazeGetUrl*(eyeTracker: ptr TobiigazeEyeTracker; 
                        errorCode: ptr TobiigazeErrorCode): cstring
  {.cdecl, dynlib: dllname, importc: "tobiigaze_get_url".}
  ## Get the URL associated with the eye tracker instance.
  ##
  ## eyeTracker
  ##   An eye tracker instance
  ## errorCode
  ##   Will be set to TOBIIGAZE_ERROR_SUCCESS if operation was successful,
  ##   otherwise to an error code (can be `nil`)
  ## result
  ##   A string containing the URL


proc tobiigazeIsConnected*(eyeTracker: ptr TobiigazeEyeTracker): cint
  {.cdecl, dynlib: dllname, importc: "tobiigaze_is_connected".}
  ## Return the connection status to the eye tracker.
  ##
  ## result
  ##   - `1` if the eye tracker is connected
  ##   - `0` otherwise


proc tobiigazeGetErrorMessage*(errorCode: TobiigazeErrorCode): cstring
  {.cdecl, dynlib: dllname, importc: "tobiigaze_get_error_message".}
  ## Return the meaning of an error code.
  ##
  ## errorCode
  ##   An error code returned from TobiiGazeCore
  ## result
  ##   A string description of the specified error code
