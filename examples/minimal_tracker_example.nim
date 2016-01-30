# *gaze* - Nim bindings for the Tobii Gaze eye tracking SDK.
#
# This file is part of the `Nim I/O <http://nimio.us>`_ package collection.
# See the file LICENSE included in this distribution for licensing details.
# GitHub pull requests are encouraged. (c) 2015 Headcrash Industries LLC.

import gaze, gazedatatypes, gazeerrorcodes


# This is a simple example that demonstrates the synchronous TobiiGazeCore
# calls. It prints gaze data for 20 seconds.

const urlSize = 256


proc onGazeData(gazeData: ptr TobiigazeGazeData,
 gazeDataExtensions: ptr TobiigazeGazeDataExtensions; userData: pointer) =
 # Print gaze information, or "-" if gaze position could not be determined.
 echo "foo"


proc printDeviceInfo(eyeTracker: ptr TobiigazeEyeTracker) =
  # Query and print device information.
  var errorCode: TobiigazeErrorCode
  var info: TobiigazeDeviceInfo
  echo "foo"
