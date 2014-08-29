//
//  MainViewContView.m
//  XBW
//
//  Created by yzl on 14-8-20.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "MainViewContView.h"
#import "YZLTabbar.h"
#import "OrderFoodController.h"
#import "BaseNVController.h"
#import "YZLADView.h"
#import "RegisterViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "ForgetPsdController.h"

@interface MainViewContView ()

@property(nonatomic,weak,readonly)UIButton *lastSelBar;

- (void)setupAdView;

- (void)doSwitchControllers:(UIButton *)button;


@end

@implementation MainViewContView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
            }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    
    //自定义tab bar
     _yzlTabBar = [[YZLTabbar alloc] init];
    [self.view addSubview:_yzlTabBar];
    
    //给自定义tab bar每个button添加处理方法
    for (UIButton *button in _yzlTabBar.buttons)
    {
        [button addTarget:self action:@selector(doSwitchControllers:) forControlEvents:UIControlEventTouchUpInside];
    }
    _lastSelBar = _yzlTabBar.buttons[0];
    
    OrderFoodController *odFoodVC = [[OrderFoodController alloc] init];
    UINavigationController *baseNV_odF = [[BaseNVController alloc] initWithRootViewController:odFoodVC];
    
    RegisterViewController *regVC = [[RegisterViewController alloc] init];
    UINavigationController *baseNV = [[BaseNVController alloc] initWithRootViewController:regVC];
    
    ForgetPsdController *forgetVC = [[ForgetPsdController alloc] init];
    UINavigationController *baseNV_forget = [[BaseNVController alloc] initWithRootViewController:forgetVC];
    
    self.viewControllers = @[baseNV,baseNV_odF,baseNV_forget];
    self.selectedIndex = 1;

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 广告视图

- (void)setupAdView
{
    YZLADView *adView = [[YZLADView alloc] initWithNumOfCells:0];
    [self.view addSubview:adView];
    
    for (UIImageView *ad in adView.cells)
    {
        
    }
}

#pragma mark - 切换视图

- (void)doSwitchControllers:(UIButton *)button
{
    _lastSelBar.selected = NO;
    button.selected = YES;
    self.selectedIndex = button.tag - 1;
    
    _lastSelBar = button;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
