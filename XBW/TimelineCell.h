//
//  TimelineCell.h
//  XBW
//
//  Created by yzl on 14-8-29.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface TimelineCell : BaseTableViewCell
{
    NSMutableArray *_timeLs;
    NSMutableArray *_localtionLs;
}

@property(nonatomic,strong)NSArray *timelines;

@end
