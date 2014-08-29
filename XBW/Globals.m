//
//  Globals.m
//  xmpptest
//
//  Created by yzl on 14-8-19.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "Globals.h"
#import "Config.h"

UIColor *globalColor;

UIColor *get_globalColor()
{
    NSString *colorPath = [DocumentsDir stringByAppendingString:@"/theme.arch"];
    UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithFile:colorPath];
    return color;
}


void set_globalColor()
{
    if (globalColor)
    {
        NSString *colorPath = [DocumentsDir stringByAppendingString:@"/theme.arch"];
        if ([NSKeyedArchiver archiveRootObject:globalColor toFile:colorPath])
        {
            NSLog(@"保存全局color success");
        }
        else
        {
            NSLog(@"保存全局color failure");
        }
    }
}