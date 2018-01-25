
#import "VideoAnalyticsProvider.h"
#import <AdobeVideoHeartbeatSDK/ADBMediaHeartbeat.h>


NSString *const PLAYER_NAME = @"iOS basic media player";
NSString *const VIDEO_ID	= @"bipbop";
NSString *const VIDEO_NAME	= @"Bip bop video";

NSString *const HEARTBEAT_TRACKING_SERVER	= @"obumobile1.hb.omtrdc.net";
NSString *const HEARTBEAT_CHANNEL			= @"test-channel";
NSString *const HEARTBEAT_OVP_NAME			= @"test-ovp";
NSString *const HEARTBEAT_APP_VERSION		= @"VHL2 Sample Player v1.0";

double const VIDEO_LENGTH = 1800;

@interface VideoAnalyticsProvider()
@end
@implementation VideoAnalyticsProvider

#pragma mark Initializer & dealloc


+ (ADBMediaHeartbeatConfig*)heartbeatConfig {
    ADBMediaHeartbeatConfig* config = [[ADBMediaHeartbeatConfig alloc] init];
    
    config.trackingServer = HEARTBEAT_TRACKING_SERVER;
    config.channel = HEARTBEAT_CHANNEL;
    config.appVersion = HEARTBEAT_APP_VERSION;
    config.ovp = HEARTBEAT_OVP_NAME;
    config.playerName = PLAYER_NAME;
    config.ssl = NO;
    config.debugLogging = NO;
    return config;
}



#pragma mark - sample objects

+ (ADBMediaObject*)mediaObject {
    ADBMediaObject* mediaObject =
    [ADBMediaHeartbeat createMediaObjectWithName:VIDEO_NAME
                                         mediaId:VIDEO_ID
                                          length:1200
                                      streamType:ADBMediaHeartbeatStreamTypeLINEAR];
    
    [mediaObject setValue:self.standardVideoMetadata forKey:ADBMediaObjectKeyStandardVideoMetadata];
    
    return mediaObject;
    
}

+ (NSDictionary*) standardVideoMetadata {
    // Sample implementation for using standard metadata keys
    return @{
             ADBVideoMetadataKeySHOW:@"Sample show"
             ,ADBVideoMetadataKeySEASON:@"Sample Season"
             };
    
}






@end
