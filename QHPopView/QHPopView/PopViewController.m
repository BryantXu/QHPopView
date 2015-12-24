//
//  PopViewController.m
//  commonAnimation
//
//  Created by imqiuhang on 15/1/14.
//  Copyright (c) 2015年 your Co. Ltd. All rights reserved.
//

#import "PopViewController.h"
#import "QHHead.h"
@interface PopViewController ()
{
    NSArray*btnArr;
}
@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    btnArr=@[@"aaa",@"bbb",@"ccc",@"ddd",@"取消"];
    [self initBtn];
    [self performSelector:@selector(shakeBtn) withObject:nil afterDelay:1.0f];
    
}
- (void)initBtn {
    int tag=0;

    for (NSString*title in btnArr) {
        UIButton*curBtn=[[UIButton alloc] initWithFrame:CGRectMake(10, 10+tag*40, screenWidth-20, 30)];
        curBtn.tag=tag++;
        curBtn.layer.cornerRadius=5;
        curBtn.backgroundColor=[UIColor blackColor];
        [curBtn setTitle:title forState:UIControlStateNormal];

        
        /**
         *  !!!!!!!!!!!注意 必须设置子视图的自动布局方式  不然超出的地方将看不到!!!!!!!!!!!!
         */
        curBtn.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        
        //或者curBtn.autoresizingMask=(UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin);

       [self.view addSubview:curBtn];
        
        
        if ([title isEqualToString:[btnArr lastObject]]) {
            [curBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

-(void) shakeBtn {
    for(UIButton*btn in self.view.subviews) {
        [btn.layer pop_addAnimation:[CoreAnimationScale LayerScaleToScaleWithFromeScale:0.8f andToScale:1.0f] forKey:@"sadasds"];
    }
}
- (void) dismiss {
    [self dismissViewControllerAnimated:YES completion:^{
        //结束
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
