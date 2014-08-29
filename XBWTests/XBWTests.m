//
//  XBWTests.m
//  XBWTests
//
//  Created by yzl on 14-8-20.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"

@interface XBWTests : XCTestCase
{
    UIApplication *_application;
    AppDelegate   *_appDelete;
    MainViewContView *_mainVC;
}

@end

@implementation XBWTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _application = [UIApplication sharedApplication];
    _appDelete = _application.delegate;
    _mainVC = _appDelete.mainVC;
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    NSLog(@"%@",_mainVC);
}

@end
