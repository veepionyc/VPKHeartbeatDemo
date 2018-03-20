//
//  VPKMediaObject.h
//  VPKHeartbeat
//
//  Created by jonathan on 20/03/2018.
//  Copyright © 2018 jonathan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VPKMediaObject : NSObject
@property (nonnull, nonatomic, copy, readonly) NSString* name;
@property (nonnull, nonatomic, copy, readonly) NSString* mediaId;
@property (nonnull, nonatomic, copy, readonly) NSString* streamType;


+ (nullable instancetype)createMediaObjectWithName:(nonnull NSString *)name
                                              mediaId:(nonnull NSString *)mediaId
                                           streamType:(nonnull NSString *)streamType;

@end
