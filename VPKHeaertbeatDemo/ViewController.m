//
//  ViewController.m
//  VPKitDemo
//
//  Copyright © 2018 VEEPIO LLC. All rights reserved.
//

#import "ViewController.h"
#import <VPKit/VPKit.h>
#import <VPKHeartbeat/VPKHeartbeat.h>
#import "VPKAnalyticsModel.h"
#import <AdobeVideoHeartbeatSDK/ADBMediaHeartbeat.h>
#import "ViewController_Autolayout.h"
@interface ViewController ()<VPKPreviewPassThroughDelegate>


@property (nonatomic, strong) VPKVeepViewer* vpViewer;

@property (nonatomic, strong) ADBMediaObject* mediaObject;

@end

@implementation ViewController




#pragma mark - viewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.versionLabel.text = [VPKit sdkVersion];
    [self configureViewer];
    [self configureConstraints];
    self.viewerPreview.passThroughDelegate = self;
    self.constraints = [[NSMutableArray alloc] init];

}



#pragma mark - configuration

- (void)configureViewer{
    
    UIImage* image = [UIImage imageNamed:@"tomcruise"];
    NSURL* contentURL = [NSURL URLWithString:@"youtube://ITjsb22-EwQ"];
    image = [[VPKImage alloc] initWithImage:image url:contentURL];
    self.viewerPreview.image = image;
    
    self.mediaObject =
    [ADBMediaHeartbeat createMediaObjectWithName:@"tomcruise"
                                         mediaId:@"youtube://ITjsb22-EwQ"
                                          length:1200
                                      streamType:@"FILE"];
}

/*


- (void)configureViewer2WithTestVideo {
    
    UIImage* image = [UIImage imageNamed:@"tomcruise"];
    NSURL* contentURL = [NSURL URLWithString:@"https://phieagles.akamaized.net//PHI/videos/dct/video_audio/2017/12-December/171204_Westbrook_Review-500k.mp4"];
    
    image = [[VPKImage alloc] initWithImage:image url:contentURL];
    self.viewerPreview2.image = image;
    self.mediaObject1 =
    [ADBMediaHeartbeat createMediaObjectWithName:@"tomcruise"
                                         mediaId:@"youtube://ITjsb22-EwQ"
                                          length:1200
                                      streamType:@"FILE"];
    
    
}

- (void)configureViewer2 {
    UIImage* image = [UIImage imageNamed:@"stik_thin"];
    image = [[VPKImage alloc] initWithImage:image veepId:@"1787"];
    self.viewerPreview2.image = image;
}
*/
#pragma mark - example pass-through delegate. Relays UITapGestureRecongizer response in the event a Veep is not available.

- (void)vpkPreview:(VPKPreview *)preview passedThroughTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    NSLog(@"tapped %@",tapGestureRecognizer);
}

- (void)vpkPreview:(VPKPreview *)preview handledTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    ADBMediaObject* mediaObject = nil;
 
    [VPKHeartbeatProvider createSession:preview mediaObject:mediaObject];


}





@end
