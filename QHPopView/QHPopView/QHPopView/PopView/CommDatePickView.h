//
//  CommDatePickView.h
//  lovewith
//
//  Created by imqiuhang on 15/5/6.
//  Copyright (c) 2015年 lovewith.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommDatePickViewDelegate <NSObject>

- (void)didPickDataWithDate:(NSDate *)date andTag:(int)tag;

@end

@interface CommDatePickView : UIView

@property (nonatomic,weak)id<CommDatePickViewDelegate>delagate;

@property (nonatomic,strong)UIDatePicker *dataPickView;

- (void)setAsDateAndTime;

//比如有2个按钮可以出发显示 回调的时候可以区分是选择了哪个tag选择的日期
- (void)showWithTag:(int )tag;
- (void)hide:(BOOL)animation;


@end
