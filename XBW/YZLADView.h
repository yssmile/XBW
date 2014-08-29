//
//  YZLADView.h
//  XBW
//
//  Created by yzl on 14-8-22.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZLADView : UIScrollView

- (id)initWithNumOfCells:(NSInteger)num;

@property(nonatomic,strong) NSMutableArray *cells;
@property(nonatomic,strong) UIButton *exit;

@end
