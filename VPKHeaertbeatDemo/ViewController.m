//
//  ViewController.m
//  VPKitDemo
//
//  Created by jonathan on 01/03/2016.
//  Copyright © 2016 jonathan. All rights reserved.
//

#import "ViewController.h"
#import <VPKit/VPKit.h>
#import <VPKHeartbeat/VPKHeartbeat.h>
#import "VPKAnalyticsModel.h"
#import <AdobeVideoHeartbeatSDK/ADBMediaHeartbeat.h>

@interface ViewController ()<VPKPreviewPassThroughDelegate>


@property (nonatomic, strong) VPKVeepViewer* vpViewer;

@property (nonatomic, strong) IBOutlet VPKPreview* viewerPreview;
@property (nonatomic, strong) ADBMediaObject* mediaObject;
@property (nonatomic, strong) IBOutlet UILabel* consumeLabel;
@property (nonatomic, strong) IBOutlet UILabel* createLabel;
@property (nonatomic, strong) IBOutlet UILabel* titleLabel;
@property (nonatomic, strong) IBOutlet UILabel* versionLabel;
@property (nonatomic, strong) NSMutableArray* constraints;
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

#pragma mark - (layout boilerplate for the demo app, not relevant to the SDK)

- (void)configureConstraints {
    if (@available (iOS 9, *)) {
        [self configureConstraints_new];
    } else {
        [self configureConstraints_old];
    }
}

- (void)configureConstraints_new {
    NSDictionary* dict = NSDictionaryOfVariableBindings(_titleLabel,_viewerPreview,_consumeLabel,_versionLabel);
    for (UIView* view in dict.allValues) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    };
    
    for (UIView* view in @[_titleLabel,_consumeLabel,_versionLabel]) {
        if (@available(iOS 11, *)) {
            [view.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor constant:20].active = YES;
            [view.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor constant:-20].active = YES;
        } else {
            [view.leftAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leftAnchor constant:20].active = YES;
            [view.rightAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.rightAnchor constant:-20].active = YES;
        }
        [view.heightAnchor constraintEqualToConstant:30].active = YES;
    }
    
    UILayoutGuide* guide1 = [[UILayoutGuide alloc] init];
    UILayoutGuide* guide2 = [[UILayoutGuide alloc]  init];
    UILayoutGuide* guide3 = [[UILayoutGuide alloc]  init];
    UILayoutGuide* guide4 = [[UILayoutGuide alloc]  init];

    for (UILayoutGuide* guide in @[guide1,guide2,guide3,guide4]) {
        [self.view addLayoutGuide:guide];
        if (![guide isEqual:guide1])
        [guide1.heightAnchor constraintEqualToAnchor:guide.heightAnchor].active = YES;
    }

    if (@available (iOS 11, *)) {
        [guide1.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    } else {
        [guide1.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;

    }
    
    [guide1.bottomAnchor constraintEqualToAnchor:_titleLabel.topAnchor].active = YES;
    [_titleLabel.bottomAnchor constraintEqualToAnchor:guide2.topAnchor].active = YES;
    [guide2.bottomAnchor constraintEqualToAnchor:_viewerPreview.topAnchor].active = YES;
    [_viewerPreview.bottomAnchor constraintEqualToAnchor:_consumeLabel.topAnchor].active = YES;
    [_consumeLabel.bottomAnchor constraintEqualToAnchor:guide3.topAnchor].active = YES;
    [guide3.bottomAnchor constraintEqualToAnchor:guide4.topAnchor].active = YES;
    [guide4.bottomAnchor constraintEqualToAnchor:_versionLabel.topAnchor].active = YES;
    
    if (@available (iOS 11, *)) {
        [_versionLabel.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    } else {
        [_versionLabel.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;

    }
    
    [_viewerPreview.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.28].active = YES;
    [_viewerPreview.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active =YES;

    
    
}


- (void)updateViewConstraints {
    [super updateViewConstraints];
    for (NSLayoutConstraint* constraint in self.constraints) {
        [self.view removeConstraint:constraint];
    }
    for (UIImageView* view in @[_viewerPreview]) {
        CGSize size = view.image.size;
        if (size.height > 0) {
            [self.constraints addObject:[self alignWidthToHeight:view ratio:size.width/size.height]];
        }
        
    }
    [self.view addConstraints:self.constraints];

}

- (void)alignHeightToWidth:(UIView*)view ratio:(CGFloat)ratio{
    [view.superview addConstraint:
     [NSLayoutConstraint constraintWithItem:view
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:view
                                  attribute:NSLayoutAttributeWidth
                                 multiplier:ratio
                                   constant:0]];
}

- (NSLayoutConstraint*)alignWidthToHeight:(UIView*)view ratio:(CGFloat)ratio{
    return
     [NSLayoutConstraint constraintWithItem:view
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:view
                                  attribute:NSLayoutAttributeHeight
                                 multiplier:ratio
                                   constant:0];
}

- (void)alignHeightToView:(UIView*)view ratio:(CGFloat)ratio{
    [view.superview addConstraint:
     [NSLayoutConstraint constraintWithItem:view
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeHeight
                                 multiplier:0.4
                                   constant:0]];
}
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self updateViewConstraints];
    
}



- (void)configureConstraints_old {
    NSLog(@"%s",__func__);
    
    NSDictionary* dict = NSDictionaryOfVariableBindings(_titleLabel,_viewerPreview,_consumeLabel,_versionLabel);
    for (UIView* view in dict.allValues) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    };
    CGFloat ratio = self.view.bounds.size.height>0?self.view.bounds.size.width/self.view.bounds.size.height:1.0;
    CGFloat vMargin = 80*ratio;
    CGFloat tMargin = self.view.bounds.size.height/20.0;
    NSArray* formats =
    @[
      @"H:|-(vMargin)-[_titleLabel]-(vMargin)-|",
      @"H:|-(vMargin)-[_viewerPreview]-(vMargin)-|",
      @"H:|-(vMargin)-[_consumeLabel]-(vMargin)-|",
      @"H:|-(vMargin)-[_createLabel]-(vMargin)-|",
      @"H:|-(vMargin)-[_versionLabel]-(vMargin)-|",
      
      @"V:|-(tMargin)-[_titleLabel]-(18)-[_viewerPreview]-(4)-[_consumeLabel]",
      @"V:[_versionLabel]-(8)-|"
      ];
    
    
    for (NSString* format in formats) {
        [self.view addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:format
                                                 options:0
                                                 metrics:@{@"vMargin":@(vMargin),@"tMargin":@(tMargin)}
                                                   views:dict]];
    }
    CGSize size = self.viewerPreview.image.size;
    if (size.width > 0)
    [self alignHeightToView:self.viewerPreview ratio: size.height/size.width];

    
}



@end
