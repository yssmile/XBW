//
//  OrderController.m
//  XBW
//
//  Created by yzl on 14-8-22.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "OrderController.h"
#import "TimelineCell.h"
#import "LimitTimeCell.h"
#import "OrderedFoodCell.h"
#import "AFHTTPRequestOperation.h"

@interface OrderController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_reocords;
}
@end

@implementation OrderController

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
    self.title = @"我的订单";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 请求数据

- (void)findMyOrderRecords
{
    NSDictionary *params = @{@"": @""};
    AFHTTPRequestOperation *operation = [self operationWithParams:params path:MyOrderRecordsPath];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        NSLog(@"%@ error:%@",MyOrderRecordsPath,error);
        
    }];
}

#pragma mark - 设置tableview
- (void)setupTableView
{
    [super setupTableView];
    CGRect winF = Main_View_Frame;
    CGRect tbF = winF;
    tbF.size.height = tbF.size.height - kBottomBarHeight;
    
    self.tableView.frame = tbF;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //cell
    [self.tableView registerNib:[UINib nibWithNibName:@"TimeLineCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"time"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LimiteTimeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"limite"];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderFoodCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"order"];
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier_time = @"time";
    static NSString *identifier_limite = @"limite";
    static NSString *identifier_order = @"order";
    
    BaseTableViewCell *cell;
    switch (indexPath.row) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:identifier_time forIndexPath:indexPath];
            break;
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:identifier_limite forIndexPath:indexPath];
            break;
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:identifier_order forIndexPath:indexPath];
            break;
        default:
            break;
    }
    
    if (!cell)
    {
        switch (indexPath.row)
        {
            case 0:
                cell = [[TimelineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_time];
                break;
            case 1:
                cell = [[LimitTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_time];
                break;
            case 2:
                cell = [[OrderedFoodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_time];
            default:
                break;
        }
    }
    
    [cell setRecord:_reocords[indexPath.row]];
    
    
    return nil;
}

#pragma mark - Table view delegate

@end
