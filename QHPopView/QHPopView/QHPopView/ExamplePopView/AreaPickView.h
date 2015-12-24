//
//  AreaPickView.h
//  yimashuo
//
//  Created by imqiuhang on 15/9/19.
//  Copyright © 2015年 imqiuhang. All rights reserved.
//

#import "RootPopView.h"

@class AreaPickView;

@protocol AreaPickViewDelegate <NSObject>

- (void)areaPickViewdidPickProvince:(NSString *)province andCity:(NSString *)city andArea:(NSString *)area;

@end



@interface AreaPickView : RootPopView



@property (nonatomic,weak)id<AreaPickViewDelegate>delagate;

@property (nonatomic,strong)UIPickerView *pickView;

@end

@interface AreaPickInfo : NSObject

@property (nonatomic,strong)NSString *province;
@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong)NSString *area;

@end
