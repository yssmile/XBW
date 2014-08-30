//
//  LimitTimeCell.m
//  XBW
//
//  Created by yzl on 14-8-30.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "LimitTimeCell.h"
#import "UITableViewCell+SeparateLine.h"

@implementation LimitTimeCell

- (void)awakeFromNib
{
    // Initialization code
    
    [self addSeparateLineByColor:kCellLineColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
