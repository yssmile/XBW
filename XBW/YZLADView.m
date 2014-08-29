//
//  YZLADView.m
//  XBW
//
//  Created by yzl on 14-8-22.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "YZLADView.h"

@implementation YZLADView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithNumOfCells:(NSInteger)num
{
    if (num <= 0) {
        return nil;
    }
    CGRect winF = Main_Screen_Frame;
    self = [super initWithFrame:winF];
    if (self)
    {
        self.contentSize = CGSizeMake(winF.size.width * num, winF.size.height);
        
        _cells = [NSMutableArray arrayWithCapacity:num];
        for (int i = 0; i < num; i++)
        {
            UIImageView *ad = [[UIImageView alloc] initWithFrame:winF];
            [self addSubview:ad];
            [_cells addObject:ad];
        }
        
        _exit = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat eX = self.contentSize.width - 100;
        CGFloat eY = self.contentSize.height - 80;
        _exit.frame = CGRectMake(eX, eY, 70, 30);
        [self addSubview:_exit];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
