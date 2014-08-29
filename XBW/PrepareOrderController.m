//
//  PrepareOrderController.m
//  XBW
//
//  Created by yzl on 14-8-28.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "PrepareOrderController.h"
#import "YZLPickerView.h"
#import "UIViewAdditions.h"
#import "UIView+LoadData.h"
#import "FRDLivelyButton.h"
#import "TakeAwayInfoController.h"

@interface PrepareOrderController ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
    UIScrollView   *_scrollView;
    NSMutableArray *_addrs;
}

@end

@implementation PrepareOrderController

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
    // Do any additional setup after loading the view.
    [self addKeyboardNotification];
    [self setupTableView];
    [self setupScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 布局

#pragma mark - tableview
- (void)setupTableView
{
    [super setupTableView];
    CGSize winS = Main_Screen_Frame.size;
    self.tableView.frame = CGRectMake(0, 0, winS.width, winS.height);
    
    //header
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, winS.width, 30)];
    UILabel *myOrders = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 30)];
    myOrders.text = @"我的订单";
    myOrders.font = [UIFont systemFontOfSize:22];
    myOrders.textColor = kAppColor;
    [header addSubview:myOrders];
    
    self.tableView.tableHeaderView = header;
    
}

#pragma mark - scrollview
- (void)setupScrollView
{
    CGSize winS = Main_Screen_Frame.size;
    
    CGFloat scrH = 300;
    CGFloat scrY = 0;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scrY, winS.width, scrH)];
    self.tableView.tableFooterView = _scrollView;
    
    UILabel *presentInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 30)];
    presentInfo.text = @"送餐信息";
    presentInfo.font = [UIFont systemFontOfSize:20];
    presentInfo.textColor = kAppColor;
    [_scrollView addSubview:presentInfo];
    
    [self setupTakeAwayInfo];
    [self setupCustomer];
}

#pragma mark - 送餐信息
#pragma mark - 送餐地址
- (void)setupTakeAwayInfo
{
    UILabel *takeAwayAddr = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 150, 20)];
    takeAwayAddr.text = @"送餐地址";
    takeAwayAddr.font = [UIFont systemFontOfSize:16];
    takeAwayAddr.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [_scrollView addSubview:takeAwayAddr];
    
    UIPickerView *addrPicker = [[YZLPickerView alloc] initWithFrame:CGRectMake(10, takeAwayAddr.height+10, self.view.width-10*2, 120)];
    addrPicker.delegate = self;
    addrPicker.dataSource = self;
    addrPicker.success = ^(NSDictionary *result)
    {
      
    };
    [_scrollView addSubview:addrPicker];
    
    FRDLivelyButton *addAddrs_btn = [[FRDLivelyButton alloc] initWithFrame:CGRectMake(_scrollView.width - 40, 30, 20, 20)];
    [addAddrs_btn setStyle:kFRDLivelyButtonStyleCirclePlus animated:NO];
    [addAddrs_btn addTarget:self action:@selector(goTakeAwayDetail) forControlEvents:UIControlEventTouchUpInside];
    [addAddrs_btn setOptions:@{kFRDLivelyButtonColor: kAppColor}];
    [_scrollView addSubview:addAddrs_btn];
}

#pragma mark - 送餐人，电话

- (void)setupCustomer
{
    UILabel *customerName = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 80, 20)];
    customerName.text = @"顾客姓名";
    customerName.font = kAppLabelFont;
    [_scrollView addSubview:customerName];
    
    UITextField *cName_tf = [[UITextField alloc] initWithFrame:CGRectMake(105, customerName.top-5, self.view.width - 160, 30)];
    cName_tf.layer.borderColor = RGBCOLOR(246, 218, 215).CGColor;
    cName_tf.layer.borderWidth = 1.5;
    cName_tf.returnKeyType = UIReturnKeyNext;
    [_scrollView addSubview:cName_tf];
    cName_tf.delegate =self;
    
    UILabel *customerTel = [[UILabel alloc] initWithFrame:CGRectMake(20, 240, 80, 20)];
    customerTel.text = @"联系电话";
    customerTel.font = kAppLabelFont;
    [_scrollView addSubview:customerTel];
    
    UITextField *cTel_tf = [[UITextField alloc] initWithFrame:CGRectMake(105, customerTel.top-5, self.view.width - 160, 30)];
    cTel_tf.layer.borderColor = RGBCOLOR(246, 218, 215).CGColor;
    cTel_tf.layer.borderWidth = 1.5;
    cTel_tf.returnKeyType = UIReturnKeyDone;
    [_scrollView addSubview:cTel_tf];
    cTel_tf.delegate =self;
    
    FRDLivelyButton *addTel_btn = [[FRDLivelyButton alloc] initWithFrame:CGRectMake(_scrollView.width - 40, cName_tf.bottom -4, 20, 20)];
    [addTel_btn setStyle:kFRDLivelyButtonStyleCirclePlus animated:NO];
    [addTel_btn addTarget:self action:@selector(goTakeAwayDetail) forControlEvents:UIControlEventTouchUpInside];
    [addTel_btn setOptions:@{kFRDLivelyButtonColor: kAppColor}];
    [_scrollView addSubview:addTel_btn];
    
}

#pragma mark - picker view
#pragma mark - datasource
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

#pragma mark - delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    if (_addrs.count)
    {
        return _addrs[row];
    }
    else
    {
        return @"加载中....";
    }
}

#pragma mark - Button action
#pragma mark - 地址详情

- (void)goTakeAwayDetail
{
    TakeAwayInfoController *takeAwayInfoVC = [[TakeAwayInfoController alloc] init];
    [self.navigationController pushViewController:takeAwayInfoVC animated:YES];
}

#pragma mark - textfield代理

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

#pragma mark - 键盘通知

- (void)addKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification *)notification
{
    NSValue *value = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize kbSize = value.CGRectValue.size;
    NSTimeInterval animationDuration;
    NSValue *animationDurationValue = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [animationDurationValue getValue:&animationDuration];
    [UIView animateWithDuration:animationDuration animations:^{
       
        self.view.transform = CGAffineTransformTranslate(self.view.transform, 0, -kbSize.height+kBottomBarHeight);
        
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    NSValue *value = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize kbSize = value.CGRectValue.size;
    NSTimeInterval animationDuration;
    NSValue *animationDurationValue = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [animationDurationValue getValue:&animationDuration];
    [UIView animateWithDuration:animationDuration animations:^{
        
        self.view.transform = CGAffineTransformTranslate(self.view.transform, 0, kbSize.height-kBottomBarHeight);
        
    }];
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
