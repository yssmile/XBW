//
//  BaseTableViewController.h
//  XBW
//
//  Created by yzl on 14-8-22.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController

@property(nonatomic,strong)UITableView *tableView;

- (void)setupTableView;

@end
