//
//  HCObjectSwitchTests.m
//  HCObjectSwitchTests
//
//  Created by Klaus-Peter Dudas on 06/11/2013.
//  Copyright (c) 2013 Hypercrypt Solutions Ltd. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "HCObjectSwitch.h"

@interface HCObjectSwitchTests : XCTestCase

@end

@implementation HCObjectSwitchTests

- (void)testEmpty
{
    // All we can check here is that this doesn't crash
    
    Switch (@"anything") {};
}

- (void)testSimpleCase
{
    __block id hitObject;
    static id const TestCase = @"TestCase";
    
    Switch (TestCase)
    {
        
        Case(@"Other1")
        {
            XCTFail(@"Should not reach this case");
        },
        
        Case(TestCase)
        {
            hitObject = _object_;
        },
    };
    
    XCTAssertEqualObjects(TestCase, hitObject, @"The expected test case was not hit");
}

- (void)testWithFallthrough
{
    __block id hitObject;
    __block id fallthroughHitObject;
    static id const TestCase = @"TestCase";
    
    Switch (TestCase)
    {
        Case (@"Other1")
        {
            XCTFail(@"Should not reach this case");
            
            FallthroughTo(TestCase);
        },
        
        Case (TestCase)
        {
            hitObject = _object_;
            
            FallthroughToDefault();
        },

        Default
        {
            fallthroughHitObject = _object_;
        },
    };
    
    XCTAssertEqualObjects(TestCase, hitObject, @"The expected test case was not hit");
    XCTAssertEqualObjects(TestCase, fallthroughHitObject, @"The expected test case was not hit");
}

- (void)testNestedSwitch
{
    __block id hitObject;
    static id const TestCase = @"TestCase";
    
    Switch (@"XXX")
    {
        Case (@"Other1")
        {
            XCTFail(@"Should not reach this case");
            
            FallthroughTo(TestCase);
        },
        
        Case (@"XXX")
        {
            Switch (TestCase)
            {
                Case (TestCase)
                {
                    hitObject = _object_;
                },
                
                Case(@"YYY")
                {
                    XCTFail(@"Should not reach this case");
                },
                
                Default
                {
                    XCTFail(@"Should not reach this case");
                },
            };
        },
        
        Default
        {
            XCTFail(@"Should not reach this case");
        },
    };
    
    XCTAssertEqualObjects(TestCase, hitObject, @"The expected test case was not hit");
}

@end
