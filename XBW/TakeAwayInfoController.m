//
//  TakeAwayInfoController.m
//  XBW
//
//  Created by yzl on 14-8-28.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "TakeAwayInfoController.h"

@interface TakeAwayInfoController ()

@property (weak, nonatomic) IBOutlet UITextField *tel_tf;
@property (weak, nonatomic) IBOutlet UITextField *street_tf;
@property (weak, nonatomic) IBOutlet UITextField *detail_tf;
@end

@implementation TakeAwayInfoController

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
    [self setupTextField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTextField
{
    _tel_tf.layer.borderColor = kTFBorderColor.CGColor;
    _tel_tf.layer.borderWidth = 1.5;
    
    _street_tf.layer.borderWidth = 1.5;
    _street_tf.layer.borderColor = kTFBorderColor.CGColor;
    
    _detail_tf.layer.borderColor = kTFBorderColor.CGColor;
    _detail_tf.layer.borderWidth = 1.5;
}

@end
