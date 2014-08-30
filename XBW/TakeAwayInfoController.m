//
//  TakeAwayInfoController.m
//  XBW
//
//  Created by yzl on 14-8-28.
//  Copyright (c) 2014年 com.ccwl. All rights reserved.
//

#import "TakeAwayInfoController.h"
#import "FRDLivelyButton.h"
#import "UIViewAdditions.h"
#import "POP.h"

#define kStreet @"Street"
#define kDetail @"Detail"

@interface TakeAwayInfoController ()
{
    NSMutableArray *_phoneBtns;     //电话旁边的那个按钮 uibutton
    NSMutableArray *_phones;        //电话uitf
    NSMutableArray *_addrBtns;     //地址旁边的那个按钮
    NSMutableArray *_addrs;         //地址dic
}



@property (weak, nonatomic) IBOutlet UITextField *username_tf;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *tel_tf;
@property (weak, nonatomic) IBOutlet UITextField *street_tf;
@property (weak, nonatomic) IBOutlet UITextField *detail_tf;
@property (weak, nonatomic) IBOutlet UIView *addrView;

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
    
    _phoneBtns = [NSMutableArray arrayWithCapacity:3];
    _phones    = [NSMutableArray arrayWithCapacity:3];
    _addrBtns  = [NSMutableArray arrayWithCapacity:3];
    _addrs     = [NSMutableArray arrayWithCapacity:3];
    
    [self setupTextField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - textfield setup

- (void)setupTextField
{
    _username_tf.layer.borderColor = kTFBorderColor.CGColor;
    _username_tf.layer.borderWidth = 1.5;
    
    _tel_tf.layer.borderColor = kTFBorderColor.CGColor;
    _tel_tf.layer.borderWidth = 1.5;
    [_phones addObject:_tel_tf];
    
    //增加电话button
    FRDLivelyButton *addPhone_btn = [[FRDLivelyButton alloc] initWithFrame:CGRectMake(_tel_tf.right + 12, _tel_tf.centerY - 10, 20, 20)];
    [addPhone_btn setStyle:kFRDLivelyButtonStyleCirclePlus animated:NO];
    [addPhone_btn setOptions:@{kFRDLivelyButtonColor: kAppColor}];
    [addPhone_btn addTarget:self action:@selector(doAddPhoneCell) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:addPhone_btn];
    [_phoneBtns addObject:addPhone_btn];
    
    _street_tf.layer.borderWidth = 1.5;
    _street_tf.layer.borderColor = kTFBorderColor.CGColor;
    
    _detail_tf.layer.borderColor = kTFBorderColor.CGColor;
    _detail_tf.layer.borderWidth = 1.5;
    
    NSDictionary *addrDic = @{kStreet: _street_tf,kDetail:_detail_tf};
    [_addrs addObject:addrDic];
    
    //增加地址button
    FRDLivelyButton *addAddr_btn = [[FRDLivelyButton alloc] initWithFrame:CGRectMake(_detail_tf.right + 12, _street_tf.centerY+43/2.0-10, 20, 20)];
    [addAddr_btn setStyle:kFRDLivelyButtonStyleCirclePlus animated:NO];
    [addAddr_btn setOptions:@{kFRDLivelyButtonColor: kAppColor}];
    [addAddr_btn addTarget:self action:@selector(doAddAddrCell) forControlEvents:UIControlEventTouchUpInside];
    [_addrView addSubview:addAddr_btn];
    [_addrBtns addObject:addAddr_btn];

}

#pragma mark - 电话地址
#pragma mark - 电话cell

- (UIView*)phoneCell
{
    CGFloat cellH = 43;
    CGFloat cY = (_phoneBtns.count-1) * (cellH) + _tel_tf.bottom;
    
    UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(_scrollView.centerX,cY - 20,1,1)];
    cell.clipsToBounds = YES;
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(13,cY,_scrollView.width,cellH)];
    anim.springSpeed = 5;
    anim.springBounciness = 5;
    [cell pop_addAnimation:anim forKey:@"size"];
    
    UILabel *phoneL = [[UILabel alloc] initWithFrame:CGRectMake(0,16, 75, 21)];
    phoneL.text = @"联系电话";
    phoneL.font = kAppLabelFont;
    phoneL.textAlignment = NSTextAlignmentRight;
    [cell addSubview:phoneL];
    
    UITextField *phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(phoneL.right+14, 12, 171, 30)];
    phoneTF.layer.borderColor = kTFBorderColor.CGColor;
    phoneTF.layer.borderWidth = 1.5;
    [cell addSubview:phoneTF];
    [_phones addObject:phoneTF];
    
    FRDLivelyButton *button = [[FRDLivelyButton alloc] initWithFrame:CGRectMake(phoneTF.right+12,phoneTF.centerY-10, 20, 20)];
    [button setStyle:kFRDLivelyButtonStyleCircleClose animated:NO];
    [button setOptions:@{kFRDLivelyButtonColor: kAppColor}];

    [_phoneBtns addObject:button];
    [button addTarget:self action:@selector(doDeletePhone:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell addSubview:button];
    cell.clipsToBounds = YES;
    
    [_scrollView addSubview:cell];
    return cell;
}

#pragma mark - 地址cell

- (UIView*)addrCell
{
    CGFloat cellH = 86;
    //CGRect addrF = _addrView.frame;
    CGFloat cY = (_addrBtns.count-1) * (cellH) + _addrView.bottom;
    
    UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(_addrView.centerX, cY + cellH/2, 1, 1)];
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(10, cY, _addrView.width, cellH)];
    anim.springSpeed = 5;
    anim.springBounciness = 5;
    [cell pop_addAnimation:anim forKey:@"size"];
    
    UILabel *street = [[UILabel alloc] initWithFrame:CGRectMake(0,20, 75, 21)];
    street.text = @"街道地址";
    street.textAlignment = NSTextAlignmentRight;
    [cell addSubview:street];
    
    UITextField *streetTF = [[UITextField alloc] initWithFrame:CGRectMake(street.right + 17, 12, 171, 30)];
    streetTF.layer.borderWidth = 1.5;
    streetTF.layer.borderColor = kTFBorderColor.CGColor;
    [cell addSubview:streetTF];
    
    UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(0,20+cellH/2, 73, 21)];
    detail.text = @"门牌或详细地址";
    detail.textAlignment = NSTextAlignmentRight;
    [cell addSubview:detail];
    
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 54, addrF.size.width - 57, 1)];
//    line.backgroundColor = RGBCOLOR(236, 237, 237);
//    [cell addSubview:line];
    
    UITextField *detailTF = [[UITextField alloc] initWithFrame:CGRectMake(detail.right + 15, 12+cellH/2, 170, 30)];
    detailTF.layer.borderWidth = 1.5;
    detailTF.layer.borderColor = kTFBorderColor.CGColor;
    [cell addSubview:detailTF];
    
    NSDictionary *addrDic = @{kStreet: streetTF,kDetail:detailTF};
    [_addrs addObject:addrDic];
    
    FRDLivelyButton *button = [[FRDLivelyButton alloc] initWithFrame:CGRectMake(streetTF.right+15,(cellH - 20)/2, 20, 20)];
    [button setStyle:kFRDLivelyButtonStyleCircleClose animated:NO];
    [_addrBtns addObject:button];
    [button addTarget:self action:@selector(doDeleteAddress:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell addSubview:button];
    cell.clipsToBounds = YES;
    
    [_scrollView addSubview:cell];
    return cell;
}

#pragma mark - 按钮动作
#pragma mark - 增加电话cell

- (void)doAddPhoneCell
{
    [self phoneCell];
    [UIView animateWithDuration:.4 animations:^{
       
        _addrView.transform = CGAffineTransformTranslate(_addrView.transform, 0, 43);
        
    }];
    
    CGSize scrCS = _scrollView.contentSize;
    scrCS.height += 43;
    _scrollView.contentSize = scrCS;

}

#pragma mark - 增加地址cell

- (void)doAddAddrCell
{
    [self addrCell];
    CGSize scrCS = _scrollView.contentSize;
    scrCS.height += 86;
    _scrollView.contentSize = scrCS;
}

#pragma mark - 删除电话cell

- (void)doDeletePhone:(FRDLivelyButton*)button
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
        
        _addrView.transform = CGAffineTransformTranslate(_addrView.transform, 0, -43);
        
    }];
    CGSize scrCS = _scrollView.contentSize;
    scrCS.height -= 43;
    _scrollView.contentSize = scrCS;
}

#pragma mark - 删除地址cell

- (void)doDeleteAddress:(FRDLivelyButton *)button
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
    scrCS.height -= 86;
    _scrollView.contentSize = scrCS;
}

@end
