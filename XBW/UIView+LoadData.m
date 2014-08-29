//
//  UIView+LoadData.m
//  XBW
//
//  Created by yzl on 14-8-28.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "UIView+LoadData.h"
#import "AFNetworking.h"

@implementation UIView (LoadData)

@dynamic failer;
@dynamic success;
@dynamic indicator;

- (void)loadDataWithParams:(NSDictionary *)params path:(NSString *)path
{
    self.backgroundColor = [UIColor clearColor];
    self.alpha = .4;
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.indicator startAnimating];
    self.failer = nil;
    self.success = nil;
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request = [serializer requestWithMethod:@"POST" URLString:[XBWBaseURL stringByAppendingFormat:@"%@",path] parameters:params error:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.indicator.hidden = YES;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        self.success(dic);
        self.alpha = 1;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.indicator.hidden = YES;
        self.failer();
        NSLog(@"UIView loadData: %@",error);
    }];
    
    [operation start];
}

- (void)setSuccess:(SuccessBlock)success
{
    success = success;
}

- (void)setFailer:(FailerBlock)failer
{
    failer = failer;
}

- (void)setIndicator:(UIActivityIndicatorView *)indicator
{
    self.indicator = indicator;
}

@end
