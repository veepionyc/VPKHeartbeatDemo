//
//  VideoHeartbeatProvider.h
//  VPKHeartbeat
//
//  Created by jonathan on 15/01/2018.
//  Copyright © 2018 VEEPIO LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADBMediaHeartbeatConfig;
@class ADBMediaObject;


@protocol VPKHeartbeatMediaProvider <NSObject>

/**
 Length of video in seconds.
 */
- (Float64)duration;

/**
 Current playback time of video in seconds.
 */
- (Float64)currentPlaybackTime;

/**
 QoS dictionary of video.
 */
- (nullable NSDictionary*)qualityOfServiceDict;

/**
 Optional media identifier supplied when initialising a VPKPreview object.
 */
- (nullable NSString*)mediaIdentifier;

/**
 Session identifier fallback if media identifier is unset.
 */
- (nonnull NSString*)sessionIdentifier;
@end



@interface VPKHeartbeatProvider : NSObject

/**
 VPKHeartbeatProvider must be initialized with a hearbeatConfig object before any tracking can take place.
 This is application-level data and only needs to be set once.
 
 */

+ (void)initializeHeartbeat:(nonnull ADBMediaHeartbeatConfig*)heartbeatConfig;

/**
 Creates the current session and starts listening for NSNotifications.
 This should be recreated per media object when tracking is required.
 */
+ (void)createSession:(nonnull id<VPKHeartbeatMediaProvider>)mediaProvider mediaObject:(nonnull ADBMediaObject*)mediaObject;

/**
 Removes the current session and stops listening for NSNotifications.
 Not required if subequently creating a new session.
 */

+ (void)removeSession;

/**
 If set to YES, heartbeat events are logged to the console. Default is NO.
 
 */

+ (void)setDebugLogging:(BOOL)logging;
@end
