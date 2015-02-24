# *io-gaze* - Nim bindings for the Tobii Gaze eye tracking SDK.
#
# This file is part of the `Nim I/O <http://nimio.us>`_ package collection.
# See the file LICENSE included in this distribution for licensing details.
# GitHub pull requests are encouraged. (c) 2015 Headcrash Industries LLC.

type 
  TobiigazeGazeListener* = proc (gazeData: ptr TobiigazeGazeData;
    gazeDataExtensions: ptr TobiigazeGazeDataExtensions; userData: pointer)
    ## This type is used for the callback function that is registered with
    ## `tobiigazeAddGazeDataListener <#tobiigazeAddGazeDataListener>`_.
    ##
    ## gazeData
    ##   The received Gaze Data
    ## gazeDataExtensions
    ##   Contains optional extension data. Does not contain any data on standard
    ##   eye trackers
    ## userData
    ##   Optional user supplied data that will be passed unmodified to the
    ##   callback function (can be `nil`)
    ##
    ## The callback function will be called when gaze data is received from the
    ## eye tracker.


  TobiigazeAsyncCallback* = proc (errorCode: TobiigazeErrorCode;
    userData: pointer)
    ## This type is used for callback functions that are registered with several
    ## asynchronous commands that do not have any return data.
    ##
    ## errorCode
    ##   Will be set to TOBIIGAZE_ERROR_SUCCESS if operation was successful,
    ##   otherwise to an error code (can be `nil`)
    ## userData
    ##   Optional user supplied data that will be passed unmodified to the
    ##   callback function (can be `nil`)
    ##
    ## The callback function will be called when the command is completed.


  TobiigazeAsyncBasicCallback* = proc (userData: pointer)
    ## This type is used for callback functions that are registered with several
    ## asynchronous commands that do not have any return data or an error code.
    ##
    ## userData
    ##   Optional user supplied data that will be passed unmodified to the
    ##   callback function (can be `nil`)
    ##
    ## The callback function will be called when the command is completed.


  TobiigazeAsyncDisplay_areaCallback* = proc (
    displayArea: ptr TobiigazeDisplayArea; errorCode: TobiigazeErrorCode;
    userData: pointer)
    ## This type is used for the callback function that is registered with
    ## `tobiigazeGetDisplayAreaAsync <#tobiigazeGetDisplayAreaAsync>`_.
    ##
    ## displayArea
    ##   The retrieved Display Area
    ## errorCode
    ##   Will be set to TOBIIGAZE_ERROR_SUCCESS if operation was successful,
    ##   otherwise to an error code (can be `nil`)
    ## userData
    ##   Optional user supplied data that will be passed unmodified to the
    ##   callback function (can be `nil`)
    ##
    ## The callback function will be called when the command is completed.


  TobiigazeAsyncDeviceInfoCallback* = proc (
    deviceInfo: ptr TobiigazeDeviceInfo; errorCode: TobiigazeErrorCode; 
    userData: pointer)
    ## This type is used for the callback function that is registered with
    ## `tobiigazeGetDeviceInfoAsync <#tobiigazeGetDeviceInfoAsync>`_.
    ##
    ## deviceInfo
    ##   The retrieved device info
    ## errorCode
    ##   Will be set to TOBIIGAZE_ERROR_SUCCESS if operation was successful,
    ##   otherwise to an error code (can be `nil`)
    ## userData
    ##   Optional user supplied data that will be passed unmodified to the
    ##   callback function (can be `nil`)
    ##
    ## The callback function will be called when the command is completed.


   TobiigazeAsyncTrackboxCallback* = proc (trackBox: ptr TobiigazeTrackBox;
    errorCode: TobiigazeErrorCode; userData: pointer)
    ## This type is used for the callback function that is registered with
    ## `tobiigazeGetTrackBoxAsync <#tobiigazeGetTrackBoxAsync>`_.
    ##
    ## trackBox
    ##   The retrieved Track Box
    ## errorCode
    ##   Will be set to TOBIIGAZE_ERROR_SUCCESS if operation was successful,
    ##   otherwise to an error code (can be `nil`)
    ## userData
    ##   Optional user supplied data that will be passed unmodified to the
    ##   callback function (can be `nil`)
    ##
    ## The callback function will be called when the command is completed.


  TobiigazeAsyncGeometryMountingCallback* = proc (
    geometryMounting: ptr TobiigazeGeometryMounting;
    errorCode: TobiigazeErrorCode; userData: pointer)
    ## This type is used for the callback function that is registered with
    ## `tobiigazeGetGeometryMountingAsync <#tobiigazeGetGeometryMountingAsync>`_.
    ##
    ## geometryMounting
    ##   The retrieved geometry mounting
    ## errorCode
    ##   Will be set to TOBIIGAZE_ERROR_SUCCESS if operation was successful,
    ##   otherwise to an error code (can be `nil`)
    ## userData
    ##   Optional user supplied data that will be passed unmodified to the
    ##   callback function (can be `nil`)
    ##
    ## The callback function will be called when the command is completed.


  TobiigazeAsyncCalibrationCallback* = proc (
    calibration: ptr TobiigazeCalibration; errorCode: TobiigazeErrorCode; 
    userData: pointer)
    ## This type is used for the callback function that is registered with
    ## `tobiigazeGetCalibrationAsync <#tobiigazeGetCalibrationAsync>`_.
    ##
    ## calibration
    ##   The retrieved Calibration
    ## errorCode
    ##   Will be set to TOBIIGAZE_ERROR_SUCCESS if operation was successful,
    ##   otherwise to an error code (can be `nil`)
    ## userData
    ##   Optional user supplied data that will be passed unmodified to the
    ##   callback function (can be `nil`)
    ##
    ## The callback function will be called when the command is completed.


  TobiigazeKeyProviderCallback* = proc (realmId: cint; key: ptr TobiigazeKey;
    userData: pointer)
    ## This type is used for the callback function that is registered with
    ## `tobiigazeRegisterKeyProvider <#tobiigazeRegisterKeyProvider>`_.
    ##
    ## realmId
    ##   The realm of the eye tracker to provide the key for
    ## key
    ##   The key to use for unlocking the eye tracker
    ## userData
    ##   Optional user supplied data that will be passed unmodified to the
    ##   callback function (can be `nil`)
    ##
    ## The callback function will be called when an eye tracker is to be
    ## unlocked.


  TobiigazeGetTimeCallback* = proc (timestamp: ptr culonglong; userData: pointer)
    ## This callback is used for timestamping gaze data when time sync is enabled.
    ##
    ## timestamp
    ##   The timestamp that will be used for time synchronization. Should be
    ##   returned in microseconds.
    ## userData
    ##   Optional user supplied data that will be passed unmodified to the
    ##   callback function (can be `nil`)


  TobiigazeAsyncCustomCommandCallback* = proc (
    command: ptr TobiigazeCustomCommand; errorCode: TobiigazeErrorCode; 
    userData: pointer)
    ## This type is used for the callback function that is registered with
    ## `tobiigazeSendCustomCommandAsync <#tobiigazeSendCustomCommandAsync>`_.
    ##
    ## command
    ##   The response command from the eye tracker
    ## errorCode
    ##   Will be set to TOBIIGAZE_ERROR_SUCCESS if operation was successful,
    ##   otherwise to an error code (can be `nil`)
    ## userData
    ##   Optional user supplied data that will be passed unmodified to the
    ##   callback function (can be `nil`)
    ##
    ## The callback function will be called when an eye tracker is to be unlocked.


  TobiigazeAsyncFrameratesCallback* = proc (frameRates: ptr TobiigazeFramerates;
    errorCode: TobiigazeErrorCode; userData: pointer)


  TobiigazeAsyncFramerateCallback* = proc (frameRate: ptr cfloat;
    errorCode: TobiigazeErrorCode; userData: pointer)


  TobiigazeAsyncIlluminationsCallback* = proc (
    modes: ptr tobiigazeIlluminationModes; errorCode: TobiigazeErrorCode;
    userData: pointer)
  

  TobiigazeAsyncIlluminationCallback* = proc (
    mode: ptr tobiigazeIlluminationMode; errorCode: TobiigazeErrorCode;
    userData: pointer)


  TobiigazeAsyncDiagonsticsReportCallback* = proc (blob: ptr TobiigazeBlob;
    errorCode: TobiigazeErrorCode; userData: pointer)
  

  TobiigazeAsyncLow_blinkModeCallback* = proc (low_blink: ptr cuint;
      errorCode: TobiigazeErrorCode; userData: pointer)
  

  TobiigazeAsyncUnitNameCallback* = proc (
      unitName: ptr TobiigazeUnitName; errorCode: TobiigazeErrorCode;
      userData: pointer)


  TobiigazeAsyncExtensionsCallback* = proc (
    extensions: ptr TobiigazeExtensions; errorCode: TobiigazeErrorCode;
    userData: pointer)


  TobiigazeAsyncConfigKeyValueCallback* = proc (
    configKeyValue: ptr TobiigazeConfigKeyValue; errorCode: TobiigazeErrorCode;
    userData: pointer)


  TobiigazeAsync_timesyncReceive_packetCallback* = proc (
      packet: ptr TobiigazeTimesyncInfo; userData: pointer)


  TobiigazeAsyncTimesyncSendPacketCallback* = proc (userData: pointer)


  TobiigazeAsyncXconfigWritableCallback* = proc (
    xconfigWritable: ptr cuint; errorCode: TobiigazeErrorCode; userData: pointer)
