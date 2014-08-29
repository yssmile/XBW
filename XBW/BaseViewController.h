//
//  BaseViewController.h
//  XBW
//
//  Created by yzl on 14-8-21.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AFHTTPRequestOperation;
@interface BaseViewController : UIViewController

@property(nonatomic,assign)NSInteger appearCount;
@property(nonatomic,readonly,getter = isTabBarHidden)BOOL tabBarHidden;
@property(nonatomic,weak)UIView *firstResponseView;

/*
 设置导航条的item
 */
- (void)setupNavigationItem;

/*
 显示提醒消息
 */
- (void)showAlterWithInfo:(NSString*)info;

/*
 获取操作网路AFHttpRequestOperation 对象
 */
- (AFHTTPRequestOperation*)operationWithParams:(NSDictionary *)params path:(NSString*)path;

/*
 登陆逻辑
 */
- (BOOL)loginLogic;

/*
 设置自定义tabbar隐藏，显示
 */
- (void)setTabBarHidden:(BOOL)hidden animate:(BOOL)animate;

@end
