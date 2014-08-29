//
//  FoodInfo.h
//  XBW
//
//  Created by yzl on 14-8-28.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "BaseObject.h"

@interface FoodInfo : BaseObject

@property(nonatomic,copy)NSString *icon_path;
@property(nonatomic,copy)NSString *name;
@property(nonatomic)float price;
@property(nonatomic)NSInteger allCount;
@property(nonatomic)NSInteger orderCount;

@end
