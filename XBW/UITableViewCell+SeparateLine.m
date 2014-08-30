//
//  UITableViewCell+SeparateLine.m
//  XBW
//
//  Created by yzl on 14-8-30.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "UITableViewCell+SeparateLine.h"

@implementation UITableViewCell (SeparateLine)

- (void)addSeparateLineByColor:(UIColor *)color
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 1, self.frame.size.width, 1.5)];
    view.backgroundColor = color;
    [self.contentView addSubview:view];
}

@end
