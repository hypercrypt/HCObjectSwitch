//
//  HCObjectSwitch.h
//  HCObjectSwitch
//
//  Created by Klaus-Peter Dudas on 06/11/2013.
//  Copyright (c) 2013 Hypercrypt Solutions Ltd. All rights reserved.
//

#pragma once

#define Switch(object)          [[HCObjectSwitch alloc] initWithObject:object]._actions = @
#define Case(case)              case ?: [NSNull null] : ^(HCObjectSwitch *_objectSwitch_, id _object_)
#define Default                 @"_HCObjectSwitchDefaultCase" : ^(HCObjectSwitch *_objectSwitch_, id _object_)
#define FallthroughTo(case)     [_objectSwitch_ _fallthroughToCase:case]
#define FallthroughToDefault()  [_objectSwitch_ _fallthroughToDefault]

#import <Foundation/Foundation.h>

@class HCObjectSwitch;

typedef void(^HCObjectSwitchBlock)(HCObjectSwitch *objectSwitch, id object);

@interface HCObjectSwitch : NSObject

- (instancetype)initWithObject:(id<NSCopying>)object;

- (NSDictionary *)_actions __attribute__((unavailable));
@property (nonatomic, setter=_setActions:) NSDictionary *_actions;

- (void)_fallthroughToCase:(id)fallthroughCase;
- (void)_fallthroughToDefault;

@end
