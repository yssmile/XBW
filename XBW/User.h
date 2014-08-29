//
//  User.h
//  XBW
//
//  Created by yzl on 14-8-22.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "BaseObject.h"

@interface User : BaseObject

@property(nonatomic,copy)NSString *userAccount;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *username;
@property(nonatomic,strong)NSMutableArray *phoneNums;
@property(nonatomic,strong)NSMutableArray *sendAddrs;

@end
