//
//  User.m
//  XBW
//
//  Created by yzl on 14-8-22.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "User.h"

@implementation User

- (id)init
{
    self = [super init];
    if (self) {
        _phoneNums = [NSMutableArray arrayWithCapacity:3];
        _sendAddrs = [NSMutableArray arrayWithCapacity:3];
    }
    return self;
}

@end
