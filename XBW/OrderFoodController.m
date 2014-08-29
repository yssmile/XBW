//
//  OrderFoodController.m
//  XBW
//
//  Created by yzl on 14-8-21.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "OrderFoodController.h"
#import "NSDate+EatingTime.h"
#import "PrepareOrderController.h"

@interface OrderFoodController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *_lastSelBtn;            //上一次一级菜单选中的按钮
}
@property (weak, nonatomic) IBOutlet UIScrollView *leftSelectView;
@property (weak, nonatomic) IBOutlet UITableView *foodTableView;

- (void)doFirstMenuAction:(UIButton *)button;

@end

@implementation OrderFoodController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"我的订单";
        //[self loginLogic];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupLeftView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.appearCount<2)
    {
        [self loginLogic];
    }
}


- (void)setupNavigationItem
{
    UIButton *user_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [user_btn setImage:[UIImage imageNamed:@"common_user"] forState:UIControlStateNormal];
    user_btn.frame = CGRectMake(0, 0, 45, 20);
    user_btn.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *user = [[UIBarButtonItem alloc] initWithCustomView:user_btn];
    self.navigationItem.leftBarButtonItem = user;
    
    UIButton *place_order = [UIButton buttonWithType:UIButtonTypeCustom];
    [place_order setImage:[UIImage imageNamed:@"order_food_order"] forState:UIControlStateNormal];
    place_order.frame = CGRectMake(0, 0, 45, 20);
    [place_order addTarget:self action:@selector(goPrepareOrder:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *order = [[UIBarButtonItem alloc] initWithCustomView:place_order];
    self.navigationItem.rightBarButtonItem = order;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置左边选择种类view

- (void)setupLeftView
{
    _leftSelectView.showsVerticalScrollIndicator = NO;
    CGFloat winH = Main_Screen_Height;
    CGRect leftSF = _leftSelectView.frame;
    leftSF.size.height = 439;
    _leftSelectView.contentSize = CGSizeMake(leftSF.size.width, 409);
    
    if (winH == kIphone4Height)
    {
        leftSF.size.height = 439 - kIphone5Height + kIphone4Height;
    }
    _leftSelectView.frame = leftSF;
    
    [self setupFirstLevelMenu];
    
    NSLog(@"%@",NSStringFromCGPoint(_leftSelectView.contentOffset));
    NSLog(@"%@",NSStringFromCGRect(_leftSelectView.frame));
    NSLog(@"%@",NSStringFromCGSize(_leftSelectView.contentSize));
}

#pragma mark - 设置一级菜单

- (void)setupFirstLevelMenu
{
    NSDate *date = [NSDate date];
    EatingTime eating = [date nowEatingTime];
    for (int i = 1; i < 7; i++)
    {
        UIButton *button = (UIButton*)[_leftSelectView viewWithTag:i];
        [button addTarget:self action:@selector(doFirstMenuAction:) forControlEvents:UIControlEventTouchUpInside];
        if (eating == i)
        {
            button.selected = YES;
        }
    }
}
/**** 一级菜单的按钮逻辑 ****/

- (void)doFirstMenuAction:(UIButton *)button
{
    _lastSelBtn.selected = NO;
    button.selected = YES;
    _lastSelBtn = button;
}

#pragma mark - 设置各种吃的的视图

- (void)setupFoodCollection
{
    _foodTableView.dataSource = self;
    _foodTableView.delegate = self;
}

#pragma mark - 导航动作
#pragma mark - 订餐

- (void)goPrepareOrder:(UIButton*)button
{
    PrepareOrderController *prepareVC = [[PrepareOrderController alloc] init];
    [self.navigationController pushViewController:prepareVC animated:YES];
}

#pragma mark - foodTable data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - foodTable delegate

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
