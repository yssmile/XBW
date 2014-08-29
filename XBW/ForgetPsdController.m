//
//  ForgetPsdController.m
//  XBW
//
//  Created by yzl on 14-8-22.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "ForgetPsdController.h"
#import "POP.h"

@interface ForgetPsdController ()
- (IBAction)doGetCode:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *userAccount_tf;
@property (weak, nonatomic) IBOutlet UITextField *verify_tf;

@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@end

@implementation ForgetPsdController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma - mark 获取验证码
- (IBAction)doGetCode:(UIButton *)sender
{
    __weak UIButton *weakBtn = sender;
    
    POPSpringAnimation *zoomOut = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    zoomOut.toValue = [NSValue valueWithCGPoint:CGPointMake(1.1, 1.1)];
    [sender pop_addAnimation:zoomOut forKey:@"zoomout"];
    zoomOut.completionBlock = ^(POPAnimation *anim,BOOL finished)
    {
        if (finished) {
            POPSpringAnimation *zoomIn = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
            zoomIn.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
            [weakBtn pop_addAnimation:zoomIn forKey:@"zoomin"];
        }
    };
}
@end
