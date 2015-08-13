//
//  CommPickView.h
//  lovewith
//
//  Created by imqiuhang on 15/5/19.
//  Copyright (c) 2015年 lovewith.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommPickViewDelegate <NSObject>

- (void)didPickObjectWithIndex:(int)index andTag:(int)tag;

@end

@interface CommPickView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,weak)id<CommPickViewDelegate>delagate;

@property (nonatomic,strong)UIPickerView *pickView;

//请使用initWithDataArr:初始化 不必直接赋值
@property (nonatomic,strong)NSArray *dataForPickView;

//比如有2个按钮可以出发显示 回调的时候可以区分是选择了哪个tag选择的日期
- (void)showWithTag:(int )tag;
- (void)hide:(BOOL)animation;
- (id)initWithDataArr:(NSArray *)data;

@end
