//
//  BaseViewController.m
//  XBW
//
//  Created by yzl on 14-8-21.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"
#import "LoginViewController.h"
#import "MainViewContView.h"
#import "YZLTabbar.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize tabBarHidden = _tabBarHidden;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
            [self setEdgesForExtendedLayout:UIRectEdgeNone];
            _appearCount = 0;
            _tabBarHidden = NO;
        }
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _appearCount++;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBCOLOR(255, 246, 232);
    [self setupNavigationItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlterWithInfo:(NSString *)info
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:info delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alter show];
}

- (AFHTTPRequestOperation*)operationWithParams:(NSDictionary *)params path:(NSString *)path
{
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request = [serializer requestWithMethod:@"POST" URLString:[XBWBaseURL stringByAppendingFormat:@"%@",path] parameters:params error:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    return operation;
}

- (void)setupNavigationItem
{}

- (BOOL)loginLogic
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //id username = [defaults objectForKey:kUsername];
    BOOL logined = [[defaults objectForKey:kLogined] boolValue];
    if (!logined)
    {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
        return NO;
    }
    return YES;
}

- (void)setTabBarHidden:(BOOL)hidden animate:(BOOL)animate
{
     MainViewContView *viewController = (MainViewContView*)self.tabBarController;
    YZLTabbar *yzlTabBar = viewController.yzlTabBar;
    _tabBarHidden = hidden;
    if (animate)
    {
        [UIView animateWithDuration:.4 animations:^{

            yzlTabBar.transform = CGAffineTransformTranslate(yzlTabBar.transform, 0, hidden? kBottomBarHeight:-kBottomBarHeight);
        }];
    }
    else
    {
        CGRect rect = yzlTabBar.frame;
        rect.origin.y += hidden?kBottomBarHeight:-kBottomBarHeight;
        yzlTabBar.frame = rect;
    }
}

- (BOOL)isTabBarHidden
{
    return _tabBarHidden;
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
