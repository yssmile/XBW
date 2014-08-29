//
//  YZLTabbar.m
//  XBW
//
//  Created by yzl on 14-8-20.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//
#define kButtonNum 5

#import "YZLTabbar.h"

@implementation YZLTabbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init
{
    CGRect winRect = Main_Screen_Frame;
    CGRect tabBarFrame = CGRectMake(0, winRect.size.height - kBottomBarHeight, winRect.size.width, kBottomBarHeight);
    
    CGFloat btnW = winRect.size.width/kButtonNum;
    self.backgroundColor = [UIColor redColor];
    
    
    self = [super initWithFrame:tabBarFrame];
    if (self) {
        UIButton *order_food = [UIButton buttonWithType:UIButtonTypeCustom];
        [order_food setImage:[UIImage imageNamed:@"order_food_tabbar_btn_nor"] forState:UIControlStateNormal];
        order_food.selected = YES;
        [order_food setImage:[UIImage imageNamed:@"oder_food_tabbar_btn_sel"] forState:UIControlStateSelected];
        order_food.frame = CGRectMake(0, 0, btnW, kBottomBarHeight);
        order_food.tag = 1;
        [self addSubview:order_food];
        
        UIButton *order = [UIButton buttonWithType:UIButtonTypeCustom];
        [order setImage:[UIImage imageNamed:@"order_tabbar_btn_nor"] forState:UIControlStateNormal];
        [order setImage:[UIImage imageNamed:@"order_tabbar_btn_sel"] forState:UIControlStateSelected];
        order.frame = CGRectMake(btnW, 0, btnW, kBottomBarHeight);
        order.tag = 2;
        [self addSubview:order];
        
        UIButton *appointment = [UIButton buttonWithType:UIButtonTypeCustom];
        [appointment setImage:[UIImage imageNamed:@"appoint_tabbar_btn_nor"] forState:UIControlStateNormal];
        [appointment setImage:[UIImage imageNamed:@"appoint_tabbar_btn_sel"] forState:UIControlStateSelected];
        appointment.frame = CGRectMake(btnW * 2, 0, btnW, kBottomBarHeight);
        appointment.tag = 3;
        [self addSubview:appointment];
        
        UIButton *expressage = [UIButton buttonWithType:UIButtonTypeCustom];
        [expressage setImage:[UIImage imageNamed:@"expressage_tabbar_btn_nor"] forState:UIControlStateNormal];
        [expressage setImage:[UIImage imageNamed:@"expressage_tabbar_btn_sel"] forState:UIControlStateSelected];
        expressage.frame = CGRectMake(btnW * 3, 0, btnW, kBottomBarHeight);
        expressage.tag = 3;
        [self addSubview:expressage];
        
        UIButton *game = [UIButton buttonWithType:UIButtonTypeCustom];
        [game setImage:[UIImage imageNamed:@"game_tabbar_btn_nor"] forState:UIControlStateNormal];
        [game setImage:[UIImage imageNamed:@"game_tabbar_btn_sel"] forState:UIControlStateSelected];
        game.frame = CGRectMake(btnW * 4, 0, btnW, kBottomBarHeight);
        game.tag = 3;
        [self addSubview:game];
        
        _buttons = @[order_food,order,appointment,expressage,game];
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
