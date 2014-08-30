//
//  OrderedFoodCell.h
//  XBW
//
//  Created by yzl on 14-8-30.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface OrderedFoodCell : BaseTableViewCell
{
    NSMutableArray *_foodViews;
}

@property(nonatomic,strong)NSArray* orderedFood;

- (void)setRecord:(OrderRecord *)record;

@end
