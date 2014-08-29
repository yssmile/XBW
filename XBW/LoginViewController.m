//
//  LoginViewController.m
//  XBW
//
//  Created by yzl on 14-8-21.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "RegisterViewController.h"
#import "ForgetPsdController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *back;
- (IBAction)doBack:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *username_tf;
@property (weak, nonatomic) IBOutlet UITextField *password_tf;
- (IBAction)doLogin:(UIButton *)sender;
- (IBAction)goForgetPsd:(UIButton *)sender;

- (IBAction)goRegister:(UIButton *)sender;
@end

@implementation LoginViewController

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
    [self setupTF];
    
}

- (void)setupTF
{
    _username_tf.layer.borderColor = [UIColor colorWithWhite:.85 alpha:1].CGColor;
    _username_tf.layer.borderWidth = 1.5;
    _username_tf.layer.masksToBounds = YES;
    _username_tf.layer.cornerRadius = 6;
    _username_tf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 10)];
    _username_tf.leftViewMode = UITextFieldViewModeAlways;
    _username_tf.tintColor = [UIColor grayColor];
    
    _password_tf.layer.borderColor =  [UIColor colorWithWhite:.85 alpha:1].CGColor;
    _password_tf.layer.borderWidth = 1.5;
    _password_tf.layer.masksToBounds = YES;
    _password_tf.layer.cornerRadius = 6;
    _password_tf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 10)];
    _password_tf.leftViewMode = UITextFieldViewModeAlways;
    _password_tf.tintColor = [UIColor grayColor];
    
    _password_tf.delegate= self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 返回

- (IBAction)doBack:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 登陆
- (IBAction)doLogin:(UIButton *)sender
{
    if ([_username_tf.text isEqualToString:@""]||[_password_tf.text isEqualToString:@""])
    {
        [self showAlterWithInfo:@"亲，用户名或密码不能为空哦"];
    }
    else
    {
        MBProgressHUD *waiting = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        waiting.animationType = MBProgressHUDAnimationZoomIn;
        waiting.mode = MBProgressHUDModeIndeterminate;
        waiting.labelText = @"登录中";
        
        AFHTTPRequestOperation *operation = [self operationWithParams:@{@"": _username_tf.text,@"":_password_tf.text} path:LoginPath];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
        }];
    }
}


#pragma mark - 忘记密码
- (IBAction)goForgetPsd:(UIButton *)sender {
    ForgetPsdController *forgetVC = [[ForgetPsdController alloc] init];
    forgetVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:forgetVC animated:YES completion:nil];
}

#pragma mark - 注册

- (IBAction)goRegister:(UIButton *)sender
{
    RegisterViewController *regVC = [[RegisterViewController alloc] init];
    regVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:regVC animated:YES completion:nil];
}

#pragma mark - textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self doLogin:nil];
    [textField endEditing:YES];
    return YES;
}
@end
