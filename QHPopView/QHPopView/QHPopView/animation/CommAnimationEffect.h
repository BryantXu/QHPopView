//
//  CommAnimationEffect.h
//  qingmedia_ios
//
//  Created by imqiuhang on 15/7/14.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommAnimationEffect : NSObject

+ (CAAnimationGroup*)animationGroup:(BOOL)isBegain andDuration:(CFTimeInterval)duration;

@end
