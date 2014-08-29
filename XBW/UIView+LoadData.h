//
//  UIView+LoadData.h
//  XBW
//
//  Created by yzl on 14-8-28.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ SuccessBlock)(NSDictionary*);
typedef void (^ FailerBlock) (void);

@interface UIView (LoadData)

@property(nonatomic,strong)UIActivityIndicatorView *indicator;

@property(nonatomic,copy)SuccessBlock success;
@property(nonatomic,copy)FailerBlock  failer;

- (void)loadDataWithParams:(NSDictionary*)params path:(NSString*)path;

@end
