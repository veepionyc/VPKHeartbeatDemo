//
//  ViewController_Autolayout.m
//  VPKHeartbeatDemo
//
//  Created by jonathan on 25/01/2018.
//  Copyright © 2018 VEEPIO LLC. All rights reserved.
//

#import "ViewController_Autolayout.h"
#import <VPKit/VPKit.h>
@implementation ViewController (Autolayout)


#pragma mark - (layout boilerplate for the demo app, not relevant to the SDK)

- (void)configureConstraints {
    if (@available (iOS 9, *)) {
        [self configureConstraints_new];
    } else {
        [self configureConstraints_ios8];
    }
}

- (NSDictionary*)constraintsDict {
    return @{
             @"_titleLabel":self.titleLabel
             ,@"_viewerPreview":self.viewerPreview
             ,@"_consumeLabel":self.consumeLabel
             ,@"_versionLabel":self.versionLabel
                 };
}
- (void)configureConstraints_new {
   
    for (UIView* view in self.constraintsDict.allValues) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    };
    
    for (UIView* view in @[self.titleLabel,self.consumeLabel,self.versionLabel]) {
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
    
    [guide1.bottomAnchor constraintEqualToAnchor:self.titleLabel.topAnchor].active = YES;
    [self.titleLabel.bottomAnchor constraintEqualToAnchor:guide2.topAnchor].active = YES;
    [guide2.bottomAnchor constraintEqualToAnchor:self.viewerPreview.topAnchor].active = YES;
    [self.viewerPreview.bottomAnchor constraintEqualToAnchor:self.consumeLabel.topAnchor].active = YES;
    [self.consumeLabel.bottomAnchor constraintEqualToAnchor:guide3.topAnchor].active = YES;
    [guide3.bottomAnchor constraintEqualToAnchor:guide4.topAnchor].active = YES;
    [guide4.bottomAnchor constraintEqualToAnchor:self.versionLabel.topAnchor].active = YES;
    
    if (@available (iOS 11, *)) {
        [self.versionLabel.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    } else {
        [self.versionLabel.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
        
    }
    
    [self.viewerPreview.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.28].active = YES;
    [self.viewerPreview.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active =YES;
    
    
    
}


- (void)updateViewConstraints {
    [super updateViewConstraints];
    for (NSLayoutConstraint* constraint in self.constraints) {
        [self.view removeConstraint:constraint];
    }
    for (UIImageView* view in @[self.viewerPreview]) {
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



- (void)configureConstraints_ios8 {
    NSLog(@"%s",__func__);
    
    
    for (UIView* view in self.constraintsDict.allValues) {
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
      @"H:|-(vMargin)-[_versionLabel]-(vMargin)-|",
      
      @"V:|-(tMargin)-[_titleLabel]-(18)-[_viewerPreview]-(4)-[_consumeLabel]",
      @"V:[_versionLabel]-(8)-|"
      ];
    
    
    for (NSString* format in formats) {
        [self.view addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:format
                                                 options:0
                                                 metrics:@{@"vMargin":@(vMargin),@"tMargin":@(tMargin)}
                                                   views:self.constraintsDict]];
    }
  //  CGSize size = self.viewerPreview.image.size;
  //  if (size.width > 0)
  //  [self alignHeightToView:self.viewerPreview ratio: size.height/size.width];
    
    
}


@end
