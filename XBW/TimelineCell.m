//
//  TimelineCell.m
//  XBW
//
//  Created by yzl on 14-8-29.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "TimelineCell.h"
#import "TimeLocation.h"
#import "UIViewAdditions.h"
#import "UITableViewCell+SeparateLine.h"

#define kMargin 10

@implementation TimelineCell

- (void)awakeFromNib
{
    // Initialization code
    _timeLs = [NSMutableArray array];
    _localtionLs = [NSMutableArray array];
    [self addSeparateLineByColor:kCellLineColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRecord:(OrderRecord *)record
{
    [super setRecord:record];
    [self setTimelines:record.timelines];
}

- (void)setTimelines:(NSMutableArray *)timelines
{
    _timelines = timelines;
    for (TimeLocation *timeLocation in timelines)
    {
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        timeLabel.text = timeLocation.time;
        [self.contentView addSubview:timeLabel];
        
        UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        locationLabel.text = timeLocation.location;
        [self.contentView addSubview:locationLabel];
    }
    
    //如果传入的时间线大于当前时间线
    if (timelines.count >= _timelines.count)
    {
        int i;
        
        //遍历上一次设置的时间线，重新填充本次数据
        for (i = 0; i < _timelines.count; i++)
        {
            TimeLocation *tl = timelines[i];
            UILabel *timeLable = _timeLs[i];
            timeLable.text = tl.time;
            
            UILabel *locationLabel = _localtionLs[i];
            locationLabel.text = tl.location;
        }
        
        //增加时间线
        for (i = _timelines.count ; i < timelines.count; i++)
        {
            TimeLocation *tl = timelines[i];
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            timeLabel.text = tl.time;
            [_timeLs addObject:timeLabel];
            [self.contentView addSubview:timeLabel];
            
            UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            locationLabel.text = tl.location;
            [_localtionLs addObject:locationLabel];
            [self.contentView addSubview:locationLabel];
        }
    }
    else   //如果传入的小于当前
    {
        int i;
        
        //遍历重置数据
        for (i = 0; i < _timelines.count; i++)
        {
            TimeLocation *tl = timelines[i];
            UILabel *timeLable = _timeLs[i];
            timeLable.text = tl.time;
            
            UILabel *locationLabel = _localtionLs[i];
            locationLabel.text = tl.location;
        }
        
        //删除不必要的timeline label
        while (i < timelines.count)
        {
            [_timeLs[i] removeFromSuperview];
            [_timeLs removeLastObject];
            [_localtionLs removeLastObject];
            [_localtionLs[i] removeFromSuperview];
            i++;
        }
    }
    _timelines = timelines;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int index = 0;
    for (UILabel *timeL in _timeLs)
    {
        timeL.frame = CGRectMake(kMargin, (kMargin + 20) * (index+1), 130, 20);
        index++;
    }
    
    index = 0;
    for (UILabel *locationL in _localtionLs)
    {
        locationL.frame = CGRectMake(kMargin, (20+ kMargin)*(index+1) , self.width - kMargin - 170, 20);
        index++;
    }
    
    CGRect frame = self.frame;
    frame.size.height = (kMargin + 20) * (_localtionLs.count + _timeLs.count) + kMargin;
}

@end
