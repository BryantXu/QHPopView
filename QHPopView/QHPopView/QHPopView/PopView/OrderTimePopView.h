//
//  orderTimePopView.h
//  qingmedia_ios
//
//  Created by imqiuhang on 15/7/15.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "UIView+QHUIViewCtg.h"
#import "CoreAnimationControl.h"
@interface OrderTimePopView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

{
 @private  __weak UIView *fatherAniView;
}


- (void)showWithAnimationdView:(UIView *)aniView;
- (void)disMiss;



@end
