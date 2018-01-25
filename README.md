# VPKHeartbeatDemo
Demo app using VPKit and VPKHeartbeat frameworks to send Adobe Video Heartbeat analyticis

##Requirements
`VPKit.framework 2.6.0`   
`VPKHeartbeat.framework 0.1.2`   

(included in this distribution)  

`AdobeVideoHeartbeatSDK 2.0.1`  
`AdobeMobileSDK 4.8.4`  

(install using the included Cocoapods Podfile)


## VPKHeartbeat

A thin wrapper around Adobe Video Heartbeat - video analytics  
For details of Adobe analytics refer to:  
[Adobe iOS SDK 4.0.x for marketing solutions](https://marketing.adobe.com/resources/help/en_US/mobile/ios/analytics_main.html)  
[Adobe Video Heartbeat 2.x Developer Guide for iOS](https://marketing.adobe.com/resources/help/en_US/sc/appmeasurement/hbvideo/ios_2.0/)

For details of VPKit SDK refer to:  
[veep.io](https://veep.io/)  
[veepionyc.github.io](https://veepionyc.github.io/)

For details of Video Player callbacks handled by this SDK refer to:  
[VPKPublicEventConstants](https://github.com/veepionyc/VPKitDemo/blob/2.6.0/VPKit.framework/Headers/VPKPublicEventConstants.h)  

Required dependencies:  
```AdobeVideoHeartbeatSDK 2.0.1 ```  
```AdobeMobileSDK 4.8.4```  
```VPKit 2.6.0```  

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
#


###Integrating VPKHeartbeat with a host app
Check out the demo app included here.

`initializeHeartbeat:` is sent once in the App Delegate.


`createSession:mediaObject:` should only be sent when a `VeepViewer` with video content will appear. A good place to do this is in the `VPKPreview` `passThroughDelegate` method:


	- (void)vpkPreview:(VPKPreview *)preview 
	        handledTap:(UITapGestureRecognizer *)tapGestureRecognizer 
	  {
	    ADBMediaObject* mediaObject = self.mediaObject;
	    [VPKHeartbeatProvider createSession:preview mediaObject:mediaObject];
     }
     
In a `UITableView` or `UICollectionView` context, with multiple VPKPreviews available to the user, it is essential that the correct mediaObject is associated with the corresponding VPKPreview: this delegate is the ideal place to do that. In the sample app the delegate is the corresponding Cell.


