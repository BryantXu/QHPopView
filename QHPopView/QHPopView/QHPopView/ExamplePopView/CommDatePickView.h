//
//  CommDatePickView.h
//  lovewith
//
//  Created by imqiuhang on 15/5/6.
//  Copyright (c) 2015年 lovewith.me. All rights reserved.
//

#import "RootPopView.h"

@protocol CommDatePickViewDelegate <NSObject>

- (void)didPickDataWithDate:(NSDate *)date andTag:(int)tag;

@end

@interface CommDatePickView : RootPopView

@property (nonatomic,weak)id<CommDatePickViewDelegate>delagate;

@property (nonatomic,strong)UIDatePicker *dataPickView;

- (void)setAsDateAndTime;



@end
