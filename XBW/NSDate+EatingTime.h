//
//  NSDate+EatingTime.h
//  XBW
//
//  Created by yzl on 14-8-27.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum EatingTime
{
    kNone=1,
    kBreakfast,
    kLunch,
    kDinner,
    kNight_snack
}EatingTime;

@interface NSDate (EatingTime)

- (EatingTime)nowEatingTime;

@end
