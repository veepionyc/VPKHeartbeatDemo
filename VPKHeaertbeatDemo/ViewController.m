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
    VPKImage* vpkImage = [[VPKImage alloc] initWithImage:image url:contentURL];
    vpkImage.mediaIdentifier = @"ITjsb22-EwQ";
    self.viewerPreview.image = vpkImage;
    
    self.mediaObject =
    [ADBMediaHeartbeat createMediaObjectWithName:@"tomcruise"
                                         mediaId:@"ITjsb22-EwQ"
                                          length:15
                                      streamType:ADBMediaHeartbeatStreamTypeLINEAR];
}



#pragma mark - example pass-through delegate methods.

- (void)vpkPreview:(VPKPreview *)preview passedThroughTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    NSLog(@"tapped %@",tapGestureRecognizer);
}

- (void)vpkPreview:(VPKPreview *)preview handledTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    /*
     We could have created the session in `configureViewer:` - which would work in this simple case. However we need to be sure that the analytics data mediaId is associated with the correct media currently playing. In a UITableView or UICollectionView scenario with multiple and reusable VPKPreviews this delegate method is more robust, as it is called only when the VPKVideoPlayer is about to be invoked.
     */
    [VPKHeartbeatProvider createSession:preview mediaObject:self.mediaObject];
}





@end
