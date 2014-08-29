//
//  RegisterViewController.m
//  XBW
//
//  Created by yzl on 14-8-21.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "RegisterViewController.h"
#import "AddInfoCell.h"
#import "FRDLivelyButton.h"
#import "User.h"
#import "POP.h"
#import "AFNetworking.h"

#define AddNewPhoneBtn 101

#define kStreet @"Street"
#define kDetail @"Detail"

@interface RegisterViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableArray *_phones;    //textfield can reach max 3
    NSMutableArray *_addrs;     //nsdictionary contains two textfield,the two also can reach max 3
    NSMutableArray *_phoneBtns; //button relative to phone textfield
    NSMutableArray *_addrBtns;  //button relative to addr textfield
    User           *_user;
}
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *addrView;

@property (weak, nonatomic) IBOutlet UITextField *phone_textField;
@property (weak, nonatomic) IBOutlet UITextField *street_textField;
@property (weak, nonatomic) IBOutlet UITextField *detail_textField;
@property (weak, nonatomic) IBOutlet UITextField *userAccount_tf;
@property (weak, nonatomic) IBOutlet UITextField *password_tf;
@property (weak, nonatomic) IBOutlet UITextField *username_tf;

@property (weak, nonatomic) IBOutlet UIButton *register_btn;
- (IBAction)doRegister:(UIButton *)sender;


- (void)doAddNewPhone:(FRDLivelyButton *)button;

@end

@implementation RegisterViewController

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
    // Do any additional setup after loading the view from its nib.
    
    //[self setupTableView];
    _phones    = [NSMutableArray arrayWithCapacity:3];
    _addrs     = [NSMutableArray arrayWithCapacity:3];
    _phoneBtns = [NSMutableArray arrayWithCapacity:3];
    _addrBtns  = [NSMutableArray arrayWithCapacity:3];
    _user      = [[User alloc] init];
    
    [self setupLayout];
    [self setupScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupLayout
{
    CGSize winS = Main_Screen_Frame.size;
    CGRect srcF = _scrollView.frame;
    
    if (winS.height == kIphone4Height)
    {
        _navigationView.frame = CGRectMake(0, 0, winS.width, 84);
        srcF.origin.y = 84;

    }
    else
    {
        _navigationView.frame = CGRectMake(0, 0, winS.width, 0);
        srcF.origin.y = 0;
    }

    NSLog(@"%@",NSStringFromCGRect(_navigationView.frame));
    
    
    _scrollView.frame = srcF;
    NSLog(@"%@",NSStringFromCGRect(_scrollView.frame));
}

- (void)setupTableView
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AddInfo" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    AddInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[AddInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            cell.cusTitle.text = @"手机号码";
            cell.textFiled.placeholder = @"请输入手机号码";
        }
        else if (indexPath.row == 1)
        {
            cell.cusTitle.text = @"输入密码";
            cell.textFiled.placeholder = @"至少6位字符数字或符号";
        }
        else if (indexPath.row == 2)
        {
            cell.cusTitle.text = @"确认密码";
            cell.textFiled.placeholder = @"请再次输入密码";
        }
    }
    else if (indexPath.section == 1)
    {
        
    }
    
    return nil;
}


#pragma mark - 设置scrollView

- (void)setupScrollView
{
    CGRect phoneVF = _phoneView.frame;
    CGFloat cellH  = 54;
    
    FRDLivelyButton *button = [[FRDLivelyButton alloc] initWithFrame:CGRectMake(phoneVF.size.width - 15 - 20, cellH + (cellH - 20)/2, 20, 20)];
    [button setStyle:kFRDLivelyButtonStyleCirclePlus animated:NO];
    button.tag = AddNewPhoneBtn;
    [button addTarget:self action:@selector(doAddNewPhone:) forControlEvents:UIControlEventTouchUpInside];
    [_phoneView addSubview:button];
    [_phoneBtns addObject:button];
    [_phones addObject:_phone_textField];

    FRDLivelyButton *addrBtn = [[FRDLivelyButton alloc] initWithFrame:CGRectMake(_addrView.frame.size.width - 15 - 20, cellH - 12, 20, 20)];
    [addrBtn addTarget:self action:@selector(doAddAddress:) forControlEvents:UIControlEventTouchUpInside];
    [addrBtn setStyle:kFRDLivelyButtonStyleCirclePlus animated:NO];
    [_addrView addSubview:addrBtn];
    [_addrBtns addObject:addrBtn];
    NSDictionary *addrDic = @{kStreet: _street_textField,kDetail:_detail_textField};
    [_addrs addObject:addrDic];
    
    CGRect scrF = _scrollView.frame;
    scrF.size.height += 40;
    _scrollView.contentSize = scrF.size;
    _scrollView.alwaysBounceVertical = YES;
    
    _userAccount_tf.delegate   = self;
    _password_tf.delegate      = self;
    _username_tf.delegate      = self;
    _phone_textField.delegate  = self;
    _street_textField.delegate = self;
    _detail_textField.delegate = self;

    NSLog(@"%@",NSStringFromCGRect(_scrollView.frame));

}

#pragma mark - 电话cell

- (UIView*)phoneCell
{
    CGFloat cellH = 54;
    CGRect phoneF = _phoneView.frame;
    CGFloat cY = (_phoneBtns.count-1) * (cellH+1) + phoneF.origin.y + phoneF.size.height+1;
    
    UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(phoneF.origin.x + phoneF.size.width/2, cY + cellH/2, 1, 1)];
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(phoneF.origin.x, cY, phoneF.size.width, cellH)];
    anim.springSpeed = 5;
    anim.springBounciness = 5;
    [cell pop_addAnimation:anim forKey:@"size"];
    
    UILabel *phoneL = [[UILabel alloc] initWithFrame:CGRectMake(15,20, 73, 21)];
    phoneL.text = @"联系电话:";
    phoneL.textAlignment = NSTextAlignmentRight;
    [cell addSubview:phoneL];
    
    UITextField *phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(94, 12, 151, 30)];
    [cell addSubview:phoneTF];
    [_phones addObject:phoneTF];
    
    FRDLivelyButton *button = [[FRDLivelyButton alloc] initWithFrame:CGRectMake(phoneF.size.width - 15 - 20,(cellH - 20)/2, 20, 20)];
    [button setStyle:kFRDLivelyButtonStyleCircleClose animated:NO];
    [_phoneBtns addObject:button];
    [button addTarget:self action:@selector(doDeletePhone:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell addSubview:button];
    cell.backgroundColor = [UIColor whiteColor];
    cell.clipsToBounds = YES;
    
    [_scrollView insertSubview:cell belowSubview:_phoneView];
    return cell;
}

#pragma mark - 地址cell

- (UIView*)addrCell
{
    CGFloat cellH = 108;
    CGRect addrF = _addrView.frame;
    CGFloat cY = (_addrBtns.count-1) * (cellH+1) + addrF.origin.y + addrF.size.height+1;
    
    UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(addrF.origin.x + addrF.size.width/2, cY + cellH/2, 1, 1)];
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(addrF.origin.x, cY, addrF.size.width, cellH)];
    anim.springSpeed = 5;
    anim.springBounciness = 5;
    [cell pop_addAnimation:anim forKey:@"size"];
    
    UILabel *street = [[UILabel alloc] initWithFrame:CGRectMake(15,20, 73, 21)];
    street.text = @"街道地址:";
    street.textAlignment = NSTextAlignmentRight;
    [cell addSubview:street];
    
    UITextField *streetTF = [[UITextField alloc] initWithFrame:CGRectMake(94, 12, 151, 30)];
    [cell addSubview:streetTF];
    
    UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(15,20+cellH/2, 73, 21)];
    detail.text = @"门牌或详细地址:";
    detail.textAlignment = NSTextAlignmentRight;
    [cell addSubview:detail];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 54, addrF.size.width - 57, 1)];
    line.backgroundColor = RGBCOLOR(236, 237, 237);
    [cell addSubview:line];
    
    UITextField *detailTF = [[UITextField alloc] initWithFrame:CGRectMake(94, 12, 151, 30)];
    [cell addSubview:detailTF];
    
    NSDictionary *addrDic = @{kStreet: streetTF,kDetail:detailTF};
    [_addrs addObject:addrDic];
    
    FRDLivelyButton *button = [[FRDLivelyButton alloc] initWithFrame:CGRectMake(addrF.size.width - 15 - 20,(cellH - 20)/2, 20, 20)];
    [button setStyle:kFRDLivelyButtonStyleCircleClose animated:NO];
    [_addrBtns addObject:button];
    [button addTarget:self action:@selector(doDeleteAddress:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell addSubview:button];
    cell.backgroundColor = [UIColor whiteColor];
    cell.clipsToBounds = YES;
    
    [_scrollView insertSubview:cell belowSubview:_addrView];
    return cell;

}

#pragma mark - 按钮动作
#pragma mark - 添加电话

//添加电话


- (void)doAddNewPhone:(FRDLivelyButton*)button
{
    CGSize scrCS = _scrollView.contentSize;
    scrCS.height += 55;
    _scrollView.contentSize = scrCS;
    
    [self phoneCell];
    [UIView animateWithDuration:.3 animations:^{
        
        for (UIButton *btn in _addrBtns)
        {
            UIView *view = [btn superview];
            view.transform = CGAffineTransformTranslate(view.transform, 0, 55);
        }
        _register_btn.transform = CGAffineTransformTranslate(_register_btn.transform, 0, 55);
    }];
    
}

#pragma mark - 删除电话

- (void)doDeletePhone:(FRDLivelyButton *)button
{
    UIView *cell = [button superview];
    __weak UIView *weakCell = cell;
    
    int index = [_phoneBtns indexOfObject:button];
    [_phoneBtns removeObjectAtIndex:index];
    [_phones removeObjectAtIndex:index];

    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(cell.center.x , cell.center.y, 0, 0)];
    [cell pop_addAnimation:anim forKey:@"zero"];
    anim.completionBlock = ^(POPAnimation *animate,BOOL finished)
    {
        if (finished)
        {
            [weakCell removeFromSuperview];

        }
    };
    
    [UIView animateWithDuration:.3 animations:^{
        
        for (UIButton *btn in _addrBtns)
        {
            UIView *view = [btn superview];
            view.transform = CGAffineTransformTranslate(view.transform, 0, -55);
        }
        _register_btn.transform = CGAffineTransformTranslate(_register_btn.transform, 0, 55);

    }];
    CGSize scrCS = _scrollView.contentSize;
    scrCS.height -= 55;
    _scrollView.contentSize = scrCS;
}

#pragma mark - 增加地址详情

- (void)doAddAddress:(FRDLivelyButton*)button
{
    [self addrCell];
    CGSize scrCS = _scrollView.contentSize;
    scrCS.height += 109;
    _scrollView.contentSize = scrCS;
    [_scrollView scrollRectToVisible:CGRectMake(0, scrCS.height- 100,scrCS.width , scrCS.height) animated:YES];

}

#pragma mark - 删除地址详情

- (void)doDeleteAddress:(FRDLivelyButton*)button
{
    UIView *cell = [button superview];
    __weak UIView *weakCell = cell;
    
    int index = [_addrBtns indexOfObject:button];
    [_addrBtns removeObjectAtIndex:index];
    [_addrs removeObjectAtIndex:index];
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(cell.center.x , cell.center.y, 0, 0)];
    [cell pop_addAnimation:anim forKey:@"zero"];
    anim.completionBlock = ^(POPAnimation *animate,BOOL finished)
    {
        if (finished)
        {
            [weakCell removeFromSuperview];
        }
    };
    
    CGSize scrCS = _scrollView.contentSize;
    scrCS.height -= 109;
    _scrollView.contentSize = scrCS;
}

#pragma mark - 注册
- (IBAction)doRegister:(UIButton *)sender {
    
    
    NSDictionary *params = @{@"": _user.username};
    AFHTTPRequestOperation *operation = [self operationWithParams:params path:RegisterPath];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [operation start];
}


/*
#pragma mark - 还原button样式
//remain to user
- (void)restoreButton:(FRDLivelyButton *)button
{
    [button setStyle:kFRDLivelyButtonStyleCirclePlus animated:YES];
}

#pragma mark - 改变button样式
//
- (void)doChangeFRBtnStyle:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        return;
    }
    FRDLivelyButton *button = (FRDLivelyButton *)gesture.view;
    if (button.buttonStyle == kFRDLivelyButtonStyleCirclePlus)
    {
        [button setStyle:kFRDLivelyButtonStyleCircleClose animated:YES];
    }
    else
    {
        [button setStyle:kFRDLivelyButtonStyleCirclePlus animated:YES];
    }
    [button performSelector:@selector(showUnHighlight) withObject:nil];
}
 */

#pragma mark - textField delegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:_userAccount_tf])
    {
        if(textField.text.length != 11)
        {
            [self showAlterWithInfo:@"亲，电话长度不正确哦"];
        }
        else
        {
            _user.userAccount = textField.text;
        }
    }
    else if ([textField isEqual:_password_tf])
    {
        if (textField.text.length < 6)
        {
            [self showAlterWithInfo:@"亲，密码至少6个字符哦"];
        }
        else
        {
            _user.password = textField.text;
        }
    }
    else if ([textField isEqual:_username_tf])
    {
        _user.username = _username_tf.text;
    }
    else if ([_phones containsObject:textField])
    {
        
    }
    else if ([_addrs containsObject:textField])
    {
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

@end
