# *io-gaze* - Nim bindings for the Tobii Gaze eye tracking SDK.
#
# This file is part of the `Nim I/O <http://nimio.us>`_ package collection.
# See the file LICENSE included in this distribution for licensing details.
# GitHub pull requests are encouraged. (c) 2015 Headcrash Industries LLC.

type 
  TobiigazeLogLevel* {.pure, size: sizeof(cint).} = enum
    ## Enumerates the different log levels.
    off = 0,
    debug = 1, 
    info = 2,
    warning = 3, 
    error = 4


const
  tobiigazeDeviceInfoMaxSerialNumberLength = 128,
  tobiigazeDeviceInfoMaxModelLength = 64,
  tobiigazeDeviceInfoMaxGenerationLength = 64,
  tobiigazeDeviceInfoMaxFirmwareLength = 128,
  tobiigazeCalibrationDataCapacity = 4 * 1024 * 1024,
  tobiigazeKeySize = 32,
  tobiigazeMaxCalibrationPointDataItems = 512,
  tobiiUsbDeviceInfoMaxSize = 128,
  tobiiUsbDeviceAddressMaxSize = 138,
  tobiiUsbMaxDevices = 9,
  tobiigazeFrameratesMaxSize = 32,
  tobiigazeIlluminationModeStringMaxSize = 64,
  tobiigazeIlluminationModesMaxSize = 16,
  tobiigazeUnitNameMaxSize = 64,
  tobiigazeExtensionNameMaxSize = 16,
  tobiigazeExtensionsMaxSize = 16,
  tobiigazeMaxWakeOnGazeRegions = 4,
  tobiigazeAuthorizeChallengeMaxLen = 512,
  tobiigazeMaxGazeDataExtensions = 32,
  tobiigazeMaxGazeDataExtensionLength = 256,
  tobiigazeMaxConfigKeyLength = 128


type 
  TobiigazeTrackingStatus* {.pure, size: sizeof(cint).} = enum
    ## Enumerates the possible gaze tracking statuses.
    noEyesTracked = 0, 
    bothEyesTracked = 1, 
    onlyLeftEyeTracked = 2, 
    oneEyeTrackedProbablyLeft = 3, 
    oneEyeTrackedUnknownWhich = 4, 
    oneEyeTrackedProbablyRight = 5, 
    onlyRightEyeTracked = 6


  TobiigazeCalibrationPointStatus* {.pure, size: sizeof(cint).} = enum
    ## Enumerates the possible calibration point statuses.
    failedOrInvalid = - 1, 
    validButNotUsedInCalibration = 0, 
    validAndUsedInCalibration = 1


  TobiigazeOption* {.size: sizeof(cint).} = enum
    ## Enumeratess settable options.
    timeout = 0 ## Timeout for synchronous operations. Value is of type `cuint`


type 
  TobiigazeDeviceInfo* = object
    ## This struct holds Device Info that is fetched from the Eye Tracker.
    ##
    ## The char arrays holds null terminated strings.
    serialNumber*: array[tobiigazeDeviceInfoMaxSerialNumberLength, char] ## The
      ## serial number of the eye tracker
    model*: array[tobiigazeDeviceInfoMaxModelLength, char] ## The eye tracker
      ## model, e.g. "REXDEV_Laptop"
    generation*: array[tobiigazeDeviceInfoMaxGenerationLength, char] ## The eye
      ## tracker generation, e.g. G5
    firmwareVersion*: array[tobiigazeDeviceInfoMaxFirmwareLength, char] ## The
      ## eye tracker serial number


  TobiigazeCalibration* = object
    ## This struct holds eye tracker Calibration Data that is fetched from or sent to the Eye Tracker.
    ##
    ## The data array holds null terminated strings.
    data*: array[tobiigazeCalibrationDataCapacity, char] ## The calibration data
    actualSize*: cuint ## The length of the calibration data


  TobiigazePoint2d* = object
    ## This struct holds a two dimensional point.
    x*: cdouble ## X coordinate
    y*: cdouble ## Y coordinate


  TobiigazePoint2df* = object
    ## This struct holds a two dimensional point.
    x*: cfloat ## X coordinate
    y*: cfloat ## Y coordinate


  TobiigazePoint3d* = object
    ## This struct holds a three dimensional point.
    x*: cdouble ## X coordinate
    y*: cdouble ## Y coordinate
    z*: cdouble ## Z coordinate


  TobiigazeRect* = object
    ## This struct holds a rectangle.
    left*: cint ## Specifies the x-coordinate of the upper-left corner of a
      ## rectangle
    top*: cint ## Specifies the y-coordinate of the upper-left corner of a
      ## rectangle
    right*: cint32 ## Specifies the x-coordinate of the lower-right corner of a
      ## rectangle
    bottom*: cint32 ## Specifies the y-coordinate of the lower-right corner of a
      ## rectangle


  TobiigazeGazeDataEye* = object
    ## This struct holds gaze data for one eye.
    eyePositionFromEyeTrackerMm*: TobiigazePoint3d
    eyePositionInTrackBoxNormalized*: TobiigazePoint3d
    gazePointFromEyeTrackerMm*: TobiigazePoint3d
    gazePointOnDisplayNormalized*: TobiigazePoint2d


  TobiigazeGazeData* = object
    ## This struct holds gaze data reveiced from the eye tracker
    timestamp*: culonglong ## Timestamp for the gaze data
    trackingStatus*: tobiigazeTrackingStatus ## The combined tracking status for
      ## both eyes
    left*: tobiigazeGazeDataEye ## Gaze data for the left eye
    right*: tobiigazeGazeDataEye ## Gaze data for the right eye


  TobiigazeGazeDataExtension* = object
    ## This struct holds a gaze data extension.
    columnId*: cuint ## The id of the extension which uniquely identifies it
    data*: array[tobiigazeMaxGazeDataExtensionLength, char] ## The extension
      ## data. Use the helper functions in tobiigazeExt.h to convert this data
      ## to types
    actualSize*: cuint ## The size of the data


  TobiigazeGazeDataExtensions* = object
    ## This struct holds a gaze data extension
    extensions*: array[tobiigazeMaxGazeDataExtensions,
      tobiigazeGazeDataExtension] ## An array of extensions
    actualSize*: cuint ## The number of extensions


  TobiigazeTrackBox* = object
    ## This struct holds a track box: a frustum specified by eight points in
    ## space.
    ##
    ## Front means closer to the eye tracker.
    ## Left and right are as seen by the user.
    frontUpperRightPoint*: TobiigazePoint3d ## Front upper right point
    frontUpperLeftPoint*: TobiigazePoint3d ## Front upper left point
    frontLowerLeftPoint*: TobiigazePoint3d ## Front lower left point
    frontLowerRightPoint*: TobiigazePoint3d ## Front lower right point
    backUpperRightPoint*: TobiigazePoint3d ## Back upper right point
    backUpperLeftPoint*: TobiigazePoint3d ## Back upper left point
    backLowerLeftPoint*: TobiigazePoint3d ## Back lower left point
    backLowerRightPoint*: TobiigazePoint3d ## Back lower right point


  TobiigazeDisplayArea* = object
    ## This struct holds a display area.
    topLeft*: TobiigazePoint3d ## Upper left point
    topRight*: TobiigazePoint3d ## Upper right point
    bottomLeft*: TobiigazePoint3d ## Lower left point


  TobiigazeKey* = object
    ## This struct holds a key for unlocking an eye tracker.
    data*: array[tobiigazeKeySize, char] ## The key


  TobiigazeCalibrationPointData* = object
    ## Contains data about a calibration point sample.
    truePosition*: TobiigazePoint2df ## The point in normalized coordinates on
      ## the display area where the calibration stimulus was displayed
    leftMapPosition*: TobiigazePoint2df ## The left eye gaze point in normalized
      ## coordinates on the display area after calibration
    leftStatus*: tobiigazeCalibrationPointStatus ## Status code containing
      ## information about the validity and usage of the left eye data
    rightMapPosition*: TobiigazePoint2df ## The right eye gaze point in
      ## normalized coordinates on the display area after calibration
    rightStatus*: tobiigazeCalibrationPointStatus ## Status code containing
      ## information about the validity and usage of the right eye data


  UsbDeviceInfo* = object
    ## This structs hold discovery information for USB trackers.
    serialNumber*: array[tobiiUsbDeviceInfoMaxSize, char]
    productName*: array[tobiiUsbDeviceInfoMaxSize, char]
    platformType*: array[tobiiUsbDeviceInfoMaxSize, char]
    firmwareVersion*: array[tobiiUsbDeviceInfoMaxSize, char]


  TobiigazeFramerates* = object
    ## This structs hold information about available frame rates.
    framerates*: array[tobiiGazeFramerateMaxSize, cfloat]
    actualSize*: cuint


  TobiigazeIlluminationMode* = object
    ## Contains an illumination mode identifier.
    data*: array[tobiigazeIlluminationModeStringMaxSize, char]


  TobiigazeIlluminationModes* = object
    ## This struct contains a list of all supported illumination modes.
    data*: array[tobiigazeIlluminationModeStringMaxSize, 
      array[tobiigazeIlluminationModesMaxSize, char]]
    actualSize*: cuint


  TobiigazeCustomCommand* = object
    ## This structs contains data for sending and receiving custom commands.
    data*: ptr char ## Must be allocated by the client
    capacity*: cuint
    actualSize*: cuint


  TobiigazeUnitName* = object
    ## This structs holds the given name of a unit.
    data*: array[tobiigazeUnitNameMaxSize, char]


  TobiigazeBlob* = object
    ## This struct holds a diagonstics image.
    data*: array[tobiigazeCalibrationDataCapacity, char]
    actualSize*: cuint


  TobiigazeExtension* = object
    ## This struct holds information about an extension.
    protocolVersion*: cuint
    extensionId*: cuint
    realm*: cint
    name*: array[tobiigazeExtensionNameMaxSize, char]


  TobiigazeExtensions* = object
    ## This struct holds a list of extensions.
    extensions*: array[tobiigazeExtensionsMaxSize, TobiigazeExtension]
    actualSize*: cuint


  TobiigazeWakeOnGazeRegion* = object 
    upperLeft*: TobiigazePoint2d
    lowerRight*: TobiigazePoint2d


  TobiigazeWakeOnGazeConfiguration* = object 
    dwellTime*: cuint # milliseconds
    region*: array[tobiigazeMaxWakeOnGazeRegions, TobiigazeWakeOnGazeRegion]
    actualSize*: cuint


  TobiigazeGeometryMounting* = object
    guides*: cuint
    width*: cfloat
    angle*: cfloat
    externalOffset*: TobiigazePoint3d
    internalOffset*: TobiigazePoint3d


  TobiigazeAuthorizeChallenge* = object 
    realmId*: cint
    algorithm*: cint
    challenge*: array[tobiigazeAuthorizeChallengeMaxLen, char]
    actualSize*: cuint


  TobiigazePayPerUseInfo* = object
    isPpuUnit*: cuint
    realmId*: cint
    realmIsAuthorized*: cuint


  TobiigazeTimesyncInfo* = object
    ## This struct holds timesync information.
    packetNumber*: cuint
    remoteTimestamp*: culonglong


  TobiigazeConfigKey_value* = object
    ## This struct holds configuration information.
    key*: array[TOBIIGAZEMAX_CONFIG_KEY_LENGTH, char]
    value*: array[TOBIIGAZEMAX_CONFIG_KEY_LENGTH, char]
