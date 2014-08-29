//
//  NSDate+EatingTime.m
//  XBW
//
//  Created by yzl on 14-8-27.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "NSDate+EatingTime.h"
#import "NSDateAdditions.h"

@implementation NSDate (EatingTime)

- (NSDate*)converDateFromString:(NSString*)string
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *date = [fmt stringFromDate:self];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *nowString = [date stringByAppendingFormat:@" %@",string];
    return [fmt dateFromString:nowString];
}

- (EatingTime)nowEatingTime
{
    NSDate *min       = [self converDateFromString:@"6:00"];
    NSDate *morning   = [self converDateFromString:@"11:00"];
    NSDate *noon      = [self converDateFromString:@"15:00"];
    NSDate *afternoon = [self converDateFromString:@"19:00"];
    NSDate *night     = [self converDateFromString:@"22:00"];
    //NSDate *max       = [self converDateFromString:@"10:30"];
    
    
    if ([self compare:morning] == NSOrderedAscending && [self compare:min] == NSOrderedDescending) {
        return kBreakfast;
    }
    else if ([self compare:morning] == NSOrderedDescending && [self compare:noon] == NSOrderedAscending)
    {
        return kLunch;
    }
    else if ([self compare:noon] == NSOrderedDescending && [self compare:afternoon] == NSOrderedAscending)
    {
        return kDinner;
    }
    else if ([self compare:afternoon] == NSOrderedAscending && [self compare:night] == NSOrderedAscending)
    {
        return kNight_snack;
    }
    else
    {
        return kNone;
    }
}

@end
