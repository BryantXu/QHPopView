//
//  YMSOpenNotifyDownView.m
//  yimashuo
//
//  Created by imqiuhang on 15/12/18.
//  Copyright © 2015年 imqiuhang. All rights reserved.
//

#import "YMSOpenNotifyDownView.h"

@implementation YMSOpenNotifyDownView

- (void)prepareForContentSubView {
    contentView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_push_card_notify.png"]];
    imageView.top = 50;
    imageView.centerX = contentView.width/2.f;
    
    [contentView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, imageView.bottom+30, contentView.width - 40, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 2;
    [label setText:@"想第一时间得到达人回复消息,\n请不要关闭推送哦!" andFont:defaultFont(16) andTextColor:YMSTitleColor];
    
    [contentView addSubview:label];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, contentView.width - 40, 50)];
    btn.bottom = contentView.height - 30;
    [btn setTitle:@"我知道了" andFont:defaultFont(16) andTitleColor:[UIColor whiteColor] andBgColor:YMSBrandColor andRadius:5];
    [contentView addSubview:btn];
    [btn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
}

@end
