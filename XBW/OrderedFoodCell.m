//
//  OrderedFoodCell.m
//  XBW
//
//  Created by yzl on 14-8-30.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "OrderedFoodCell.h"
#import "UITableViewCell+SeparateLine.h"
#import "UIViewAdditions.h"
#import "UIImageView+WebCache.h"
#import "OrderedFood.h"

#define kFoodLineHeight 54
#define kMarginW 10
#define kMarginH 5

@implementation OrderedFoodCell

- (void)awakeFromNib
{
    // Initialization code
    _foodViews = [NSMutableArray array];
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
    [self setOrderedFood:record.orderedFood];
}

- (void)setOrderedFood:(NSArray *)orderedFood
{
    //传入额大于当前的
    if (orderedFood.count >= _orderedFood.count)
    {
        int i = 0;
        //替换当前view的数据
        for (UIView *view in _foodViews)
        {
            [self setViewDatas:orderedFood[i] forView:view];
            i++;
        }
        
        //增加view
        for (i = _orderedFood.count; i < orderedFood.count; i++)
        {
            UIView *view = [self addFoodView:orderedFood[i]];
            [self.contentView addSubview:view];
            [_foodViews addObject:view];
        }
    }
    else  //小于当前数据
    {
        int i = 0;
        for (UIView *view in _foodViews)
        {
            [self setViewDatas:orderedFood[i] forView:view];
            i++;
        }
        
        for (i = _foodViews.count; i < orderedFood.count; i++)
        {
            [_foodViews[i] removeFromSuperview];
            [_foodViews removeLastObject];
        }
        
    }
}


- (UIView*)addFoodView:(OrderedFood*)food
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, kFoodLineHeight)];
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(kMarginW, kMarginH, 100, 44)];
    icon.tag = 1;
    [icon sd_setImageWithURL:[NSURL URLWithString:food.icon_path] placeholderImage:[UIImage imageNamed:@""]];
    [view addSubview:icon];
    
    UILabel *foodName = [[UILabel alloc] initWithFrame:CGRectMake(icon.right + kMarginW, (kFoodLineHeight-20)/2, 100, 20)];
    foodName.textAlignment = NSTextAlignmentCenter;
    foodName.text = food.name;
    foodName.textColor = kAppColor;
    [view addSubview:foodName];
    
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(foodName.right+kMarginW, foodName.top, 60, 20)];
    price.tag = 2;
    price.text = [NSString stringWithFormat:@"¥ %f/份",food.price];
    price.textAlignment = NSTextAlignmentCenter;
    price.textColor = kAppColor;
    [view addSubview:foodName];
    
    UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(self.width - kMarginW - 60, price.top, 60, 20)];
    count.tag = 3;
    count.textAlignment = NSTextAlignmentCenter;
    count.text = [NSString stringWithFormat:@"%d份",food.orderedCount];
    count.textColor = kAppColor;
    [view addSubview:count];
    
    return view;
}

- (void)setViewDatas:(OrderedFood*)food forView:(UIView*)view
{
    UIImageView *icon = (UIImageView*)[view viewWithTag:1];
    [icon sd_setImageWithURL:[NSURL URLWithString:food.icon_path] placeholderImage:[UIImage imageNamed:@""]];
    
    UILabel *foodName = (UILabel*)[view viewWithTag:2];
    foodName.text = food.name;
    
    UILabel *price = (UILabel*)[view viewWithTag:3];
    price.text = [NSString stringWithFormat:@"¥ %f/份",food.price];
    
    UILabel *count = (UILabel*)[view viewWithTag:4];
    count.text = count.text = [NSString stringWithFormat:@"%d份",food.orderedCount];
}

- (void)layoutSubviews
{
    int i = 0;
    for (UIView *view in _foodViews)
    {
        view.frame = CGRectMake(0, kFoodLineHeight * i, self.width, kFoodLineHeight);
        i++;
    }
}

@end
