//
//  CommPickView.h
//  lovewith
//
//  Created by imqiuhang on 15/5/19.
//  Copyright (c) 2015年 lovewith.me. All rights reserved.
//

#import "RootPopView.h"

@protocol CommPickViewDelegate <NSObject>

- (void)didPickObjectWithIndex:(int)index andTag:(int)tag;

@end

@interface CommPickView : RootPopView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,weak)id<CommPickViewDelegate>delagate;

@property (nonatomic,strong)UIPickerView *pickView;

@property (nonatomic,strong)NSArray *dataForPickView;

@end
