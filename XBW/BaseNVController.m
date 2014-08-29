//
//  BaseNVController.m
//  XBW
//
//  Created by yzl on 14-8-20.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "BaseNVController.h"
#import "UIImage+FlatUI.h"

@interface BaseNVController ()

@end

@implementation BaseNVController

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        if ([self.navigationBar respondsToSelector:@selector(setTintColor:)]) {
            [self.navigationBar setTintColor:[UIColor whiteColor]];
        }
        // Custom initialization
//        if (Sys_Version < 7.0)
//        {
            [self configureFlatNavigationBarWithColor:kAppColor];
//        }
//        else
//        {
//            [self setTintColor:[UIColor whiteColor]];
//            if ([self respondsToSelector:@selector(setBarTintColor:)]) {
//                [self setBarTintColor:kAppColor];
//            }
//            
//        }
        NSMutableDictionary *textDic = [NSMutableDictionary dictionaryWithCapacity:4];
        [textDic setObject:[UIFont boldSystemFontOfSize:20] forKey:UITextAttributeFont];
        [textDic setObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
        [textDic setObject:RGBCOLOR(224, 224, 221) forKey:UITextAttributeTextShadowColor];
        [textDic setObject:[NSValue valueWithCGSize:CGSizeMake(0, 0)] forKey:UITextAttributeTextShadowOffset];
        [self.navigationBar setTitleTextAttributes:textDic];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBCOLOR(254, 244, 223);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureFlatNavigationBarWithColor:(UIColor*)color
{
    UIImage * img = [UIImage imageWithColor:color cornerRadius:0];
    if (Sys_Version < 7.0) {
        
    } else {
        
    }
    [self.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    
    
//    NSMutableDictionary *titleTextAttrs = [[self titleTextAttributes] mutableCopy];
//    if (!titleTextAttrs)
//    {
//        titleTextAttrs = [[NSMutableDictionary alloc] init];
//    }
//    
//    [titleTextAttrs setValue:[UIColor clearColor] forKey:UITextAttributeTextShadowColor];
//    [titleTextAttrs setValue:[NSValue valueWithUIOffset:UIOffsetMake(0, 0)] forKey:UITextAttributeTextShadowOffset];
//    [self.navigationBar setTitleTextAttributes:titleTextAttrs];
//    if ([self.navigationBar respondsToSelector:@selector(setShadowImage:)]) {
//        [self.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor] cornerRadius:0]];
//    }
}

@end
