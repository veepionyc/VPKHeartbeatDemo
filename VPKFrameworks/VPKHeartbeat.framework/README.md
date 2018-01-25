# VPKHeartbeat

A thin wrapper around Adobe Video Heartbeat - video analytics
For details of Adobe analytics refer to:
[Adobe iOS SDK 4.0.x for marketing solutions](https://marketing.adobe.com/resources/help/en_US/mobile/ios/analytics_main.html)
[Adobe Video Heartbeat 2.x Developer Guide for iOS](https://marketing.adobe.com/resources/help/en_US/sc/appmeasurement/hbvideo/ios_2.0/)

Required dependencies:
```AdobeVideoHeartbeatSDK 2.0.1 ```
```AdobeMobileSDK 4.8.4```
```VPKit SDK 2.6.0```

VPKHeartbeat acts as a bridge between the VPKit video player and Adobe/Overture video analytics.  It listens for event notifications from the VPKit player and forwards them to the Adobe Mobile SDK.

VPKHeartbeat  provides a `VPKHeartbeatProvider` object with four class methods.

```
+ (void)initializeHeartbeat:(nonnull ADBMediaHeartbeatConfig*)heartbeatConfig;
```
VPKHeartbeatProvider must be initialized with a hearbeatConfig object before any tracking can take place. This is application-level data and only needs to be set once. For `heartbeatConfig`  refer to the Adobe documention.

```
+ (void)createSession:(nonnull VPKPreview*)preview mediaObject:(nonnull ADBMediaObject*)mediaObject;
```

Creates the current session and starts listening for NSNotifications. This should be recreated per media object when tracking is required. For `ADBMediaHeartbeatConfig`  refer to the Adobe documention.


```
+ (void)removeSession;
```
Removes the current session and stops listening for NSNotifications. Not required if subequently creating a new session.

```
+ (void)setDebugLogging:(BOOL)logging;
```

Console logging. Default is `NO`.







