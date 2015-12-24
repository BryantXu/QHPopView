//
//  ViewController.m
//  QHPopView
//
//  Created by imqiuhang on 15/8/13.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "ViewController.h"
#import "GuidpageDownView.h"
#import "YMSOpenNotifyDownView.h"
#import "CommDatePickView.h"
#import "CommPickView.h"
#import "QHHead.h"
#import "AreaPickView.h"

#import "MenuPopViewController.h"


/*!
 *  @author imqiuhang, 15-12-24
 *
 *  @brief 使用的时候只需要把QHPopView里面的RootPopView这个文件夹拖到自己项目就好了 使用的时候UIView继承一下父类就好了 详情请看 ExamplePopView里面的各种列子 当然 例子也是直接可以用的
 
 
 另外，还有一种通过Present弹出Viewcontroller的方法是通过自己实现弹出协议来实现的，具体请看另一种是使用present那个文件夹里面的例子
 */

@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
CardDownAnimationViewDelegate,
CommDatePickViewDelegate,
CommPickViewDelegate,
AreaPickViewDelegate
>

@end

@implementation ViewController

{
    NSArray *data;
    
    GuidpageDownView *guidpageDownView;
    YMSOpenNotifyDownView *openNotifyDownView;
    CommDatePickView *commDatePickView;
    CommPickView *commPickView;
    AreaPickView *areaPickView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"PopView";
    [self initModel];
    [self initView];
}


#pragma mark events

- (void)showDefaultCard {
    if (!openNotifyDownView) {
        openNotifyDownView = [[YMSOpenNotifyDownView alloc] init];
        openNotifyDownView.delegate = self;
    }
    
    [openNotifyDownView show];
}

- (void)showScrollCard {
    if (!guidpageDownView) {
        guidpageDownView = [[GuidpageDownView alloc] init];
        guidpageDownView.delegate = self;
    }
    
    [guidpageDownView show];
}

- (void)showPickView {
    if (!commPickView) {
        commPickView = [[CommPickView alloc] init];
        commPickView.delagate = self;
    }
    
    commPickView.dataForPickView = @[@"aaaa",@"bbbb",@"cccc",@"dddd"];
    [commPickView showWithTag:1];
}

- (void)showDate {
    if (!commDatePickView) {
        commDatePickView = [[CommDatePickView alloc] init];
        commDatePickView.delagate = self;
        //可以通过里面的日期选择器自定义日期选择的规则
        commDatePickView.dataPickView.minimumDate = [NSDate dateWithTimeIntervalSince1970:0];
    }
    [commDatePickView showWithTag:1];
}

- (void)showAddress {
    if (!areaPickView) {
        areaPickView = [[AreaPickView alloc] init];
        areaPickView.delagate = self;
    }
    [areaPickView showWithTag:1];
}

- (void)showPresent {
    [self.navigationController pushViewController:[MenuPopViewController new] animated:YES];
}

#pragma mark - 弹出视图消失或者选择了相应delegate
//卡片视图消失时候的代理
-  (void)cardDownAnimationViewDidHide:(CardDownAnimationView *)cardDownView {
    if (cardDownView==guidpageDownView) {
        [guidpageDownView removeFromSuperview];
        guidpageDownView = nil;
    }else if (cardDownView==openNotifyDownView) {
        [openNotifyDownView removeFromSuperview];
        openNotifyDownView = nil;
    }
}

- (void)didPickDataWithDate:(NSDate *)date andTag:(int)tag {
    MSLog(@"date is:%@",date);
}

- (void)didPickObjectWithIndex:(int)index andTag:(int)tag {
    MSLog(@"点击的位置是 :%i",index);
}

- (void)areaPickViewdidPickProvince:(NSString *)province andCity:(NSString *)city andArea:(NSString *)area {
    //选择了相应的省市区
}



#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = data[indexPath.row][@"title"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL sel = NSSelectorFromString(data[indexPath.row][@"SEL"]);
    [self performSelector:sel];
#pragma clang diagnostic pop
    
    
}

#pragma mark -init

- (void)initView {

    
    UITableView *dataTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    dataTableView.delegate       = self;
    dataTableView.dataSource     = self;
    [self.view addSubview:dataTableView];
    
}

- (void)initModel {
  data = @[
    @{
      @"title" : @"滑动式卡片",
      @"SEL" : @"showScrollCard"
    },
    @{
      @"title" : @"卡片式掉落",
      @"SEL" : @"showDefaultCard"
    },

    @{
      @"title" : @"弹出选择器",
      @"SEL" : @"showPickView"
    },
    @{
      @"title" : @"弹出日期",
      @"SEL" : @"showDate"
    },

    @{
      @"title" : @"弹出地址选择器",
      @"SEL" : @"showAddress"
    },
    
    @{
        @"title" : @"另一种弹出ViewController的类型",
        @"SEL" : @"showPresent"
        },
  ];
}

@end
