//
//  HCObjectSwitch.m
//  HCObjectSwitch
//
//  Created by Klaus-Peter Dudas on 06/11/2013.
//  Copyright (c) 2013 Hypercrypt Solutions Ltd. All rights reserved.
//

#import "HCObjectSwitch.h"

static id const HCObjectSwitchDefaultCase = @"_HCObjectSwitchDefaultCase";

@implementation HCObjectSwitch
{
    id _currentObject;
}

- (instancetype)initWithObject:(id)object
{
    self = [super init];
    
    if (self && (object != [NSNull null]))
    {
        _currentObject = object;
    }
    
    return self;
}

- (void)_fallthroughToCase:(id)fallthroughCase
{
    HCObjectSwitchBlock block = _actions[fallthroughCase];
    
    if (block)
    {
        block(self, _currentObject);
    }
}

- (void)_fallthroughToDefault
{
    HCObjectSwitchBlock block = _actions[HCObjectSwitchDefaultCase];
    
    if (block)
    {
        block(self, _currentObject);
    }
}

@synthesize _actions = _actions;
- (void)_setActions:(NSDictionary *)actions
{
    _actions = actions;
    
    HCObjectSwitchBlock block = actions[_currentObject] ?: actions[HCObjectSwitchDefaultCase];
    
    if (block)
    {
        block(self, _currentObject);
    }
}

@end
