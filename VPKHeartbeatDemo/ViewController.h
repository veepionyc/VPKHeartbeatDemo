//
//  ViewController.h
//  VPKitDemo
//
//  Copyright © 2018 VEEPIO LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VPKPreview;
@class VPKMediaObject;

@interface ViewController : UIViewController
@property (nonatomic, strong) IBOutlet VPKPreview* viewerPreview;
@property (nonatomic, strong) IBOutlet UILabel* consumeLabel;
@property (nonatomic, strong) IBOutlet UILabel* titleLabel;
@property (nonatomic, strong) IBOutlet UILabel* versionLabel;
@property (nonatomic, strong) NSMutableArray* constraints;
@property (nonatomic, strong, readonly) VPKMediaObject* mediaObject;

@end

