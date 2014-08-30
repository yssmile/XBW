//
//  BaseTableViewCell.h
//  XBW
//
//  Created by yzl on 14-8-30.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderRecord.h"
@interface BaseTableViewCell : UITableViewCell

@property(nonatomic,strong)OrderRecord *record;

- (void)setRecord:(OrderRecord *)record;

@end
