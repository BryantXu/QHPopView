//
//  CommAnimationEffect.m
//  qingmedia_ios
//
//  Created by imqiuhang on 15/7/14.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "CommAnimationEffect.h"

@implementation CommAnimationEffect

+ (CAAnimationGroup*)animationGroup:(BOOL)isBegain andDuration:(CFTimeInterval)duration {

    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0 / -900;
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    t1 = CATransform3DRotate(t1, 15.0f * M_PI / 180.0f, 1, 0, 0);
    
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = t1.m34;
    double scale = 0.8;
    
    t2 = CATransform3DTranslate(
                                t2, 0, [[UIScreen mainScreen] bounds].size.height * -0.08, 0);
    t2 = CATransform3DScale(t2, scale, scale, 1);
    
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:t1];
    animation.duration = duration;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [animation
     setTimingFunction:[CAMediaTimingFunction
                        functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    CABasicAnimation *animation2 =
    [CABasicAnimation animationWithKeyPath:@"transform"];
    //    animation2.toValue = [NSValue
    //    valueWithCATransform3D:(isBegain?t2:CATransform3DIdentity)];
    //    animation2.beginTime = animation.duration;
    animation2.toValue = [NSValue valueWithCATransform3D:(CATransform3DIdentity)];
    animation2.duration = animation.duration;
    animation2.fillMode = kCAFillModeForwards;
    animation2.removedOnCompletion = NO;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [group setDuration:animation.duration * 2];
    [group setAnimations:isBegain ? @[ animation ] : @[ animation2 ]];
    return group;
    
    
}


@end
