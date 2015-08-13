//
//  MenuPopViewController.m
//  QHPopView
//
//  Created by imqiuhang on 15/8/13.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "MenuPopViewController.h"
#import "CoreAnimationPresent.h"
#import "PopViewController.h"

@interface MenuPopViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate>

@end

@implementation MenuPopViewController
{
    NSArray *data;
    NSDictionary *aniInfo;
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
    
    [self present];

}


#pragma mark -events {

- (void) topPop {
    self->aniInfo=@{@"toViewSize":[NSValue valueWithCGSize:CGSizeMake(200, 300)],
                    @"fromType":@(fromType_FromTop),
                    @"showType":@(showType_pop),
                    };
}

- (void) leftPop{
    self->aniInfo=@{@"toViewSize":[NSValue valueWithCGSize:CGSizeMake(200, 300)],
                    @"fromType":@(fromType_FromLeft),
                    @"showType":@(showType_pop),
                    };
    
}

- (void) topMenu {
    self->aniInfo=@{@"toViewSize":[NSValue valueWithCGSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 300)],
                    @"fromType":@(fromType_FromTop),
                    @"showType":@(showType_menu),
                    };
}

- (void) bottomMenu {
    self->aniInfo=@{@"toViewSize":[NSValue valueWithCGSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 300)],
                    @"fromType":@(fromType_FromBottom),
                    @"showType":@(showType_menu),
                    };
}

- (void)present {
    PopViewController*popViewController= [PopViewController new];
    /**
     *  以下两句必须写 设置代理和将弹出的方式设置为自己的方式
     */
    popViewController.transitioningDelegate=self;
    popViewController.modalPresentationStyle = UIModalPresentationCustom;
    [self.navigationController presentViewController:popViewController animated:YES completion:^{
    }];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    //根据自己的需要设置部分属性, 不设置的属性都将被置为默认值
    PresentingAnimator*presentingAnimator=[[PresentingAnimator alloc] init];
    presentingAnimator.toViewSize=[aniInfo[@"toViewSize"] CGSizeValue];
    presentingAnimator.fromType=[aniInfo[@"fromType"] intValue];
    presentingAnimator.showType=[aniInfo[@"showType"] intValue];
    presentingAnimator.dimmingViewColor=[UIColor blackColor];
    presentingAnimator.dimmingViewApha=0.5f;
    
    [presentingAnimator setFinishBlock:^(NSString*className, BOOL finished) {
        if ([className isEqualToString:NSStringFromClass([PopViewController class])]&&finished) {
            //在这里做动画结束想要做的事情
        }
        
    }];
    
    return presentingAnimator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    DismissingAnimator* dismissingAnimator=[[DismissingAnimator alloc] init];
    dismissingAnimator.fromType=[aniInfo[@"fromType"] intValue];
    [dismissingAnimator setFinishBlock:^(NSString*className, BOOL finished) {
    }];
    return dismissingAnimator;
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
             @{@"title":@"从上往下pop",@"SEL":@"topPop"},
             @{@"title":@"从左往右pop",@"SEL":@"leftPop"},
             @{@"title":@"从上往下菜单",@"SEL":@"topMenu"},
             @{@"title":@"从下往上菜单",@"SEL":@"bottomMenu"},
             ];
}


@end
