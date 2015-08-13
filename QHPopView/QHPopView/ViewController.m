//
//  ViewController.m
//  QHPopView
//
//  Created by imqiuhang on 15/8/13.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "ViewController.h"
#import "OrderTimePopView.h"
#import "CommDatePickView.h"
#import "CommPickView.h"
#import "PopViewController.h"
#import "CoreAnimationPresent.h"
#import "MenuPopViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

{
    NSArray *data;
    OrderTimePopView *orderTimePopView;
    CommDatePickView *datePickView;
    CommPickView *pickView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"QHNavSliderMenuView";
    [self initModel];
    [self initView];
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
#pragma mark events

- (void)showAsTBPush {
    if (!orderTimePopView) {
        orderTimePopView = [[OrderTimePopView alloc] init];
    }
    [orderTimePopView showWithAnimationdView:self.view];

}

- (void)showDate {
    if (!datePickView) {
        datePickView = [[CommDatePickView alloc] init];
        //如果需要选择日期 设置datePickView.delagate =self; pickView也一样
    }
    [datePickView showWithTag:0];
}

- (void)showPickView {
    if (!pickView) {
        pickView = [[CommPickView alloc] initWithDataArr:@[@"男",@"女"]];
    }
    [pickView showWithTag:0];
}

- (void)push {
    [self.navigationController pushViewController:[MenuPopViewController new] animated:YES];
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
          @"title" : @"仿淘宝压入式变形弹出",
          @"SEL" : @"showAsTBPush"
        },
        @{
          @"title" : @"弹出日期",
          @"SEL" : @"showDate"
        },
        @{
          @"title" : @"弹出选择器",
          @"SEL" : @"showPickView"
        },
        @{
          @"title" : @"各个方向的菜单",
          @"SEL" : @"push"
        },
  ];
}

@end
