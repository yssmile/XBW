//
//  OrderRecord.h
//  XBW
//
//  Created by yzl on 14-8-28.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "BaseObject.h"

@interface OrderRecord : BaseObject

@property(nonatomic)NSString *orderNumber;
@property(nonatomic,strong)NSMutableArray *timelines;
@property(nonatomic,strong)NSMutableArray *orderedFood;

@end
