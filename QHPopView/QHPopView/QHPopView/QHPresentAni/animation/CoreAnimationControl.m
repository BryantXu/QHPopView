//
//  CoreAnimationControl.m
//  commonAnimation
//
//  Created by imqiuhang on 15/1/14.
//  Copyright (c) 2015年 your Co. Ltd. All rights reserved.
//

#import "CoreAnimationControl.h"

@implementation CoreAnimationScale

+(POPSpringAnimation*)LayerScaleAnimationDefault {
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    anim.springBounciness = defaultLayerScaleSpringBounciness;
    anim.springSpeed = defaultLayerScalePpringSpeed;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    return anim;
}

+(POPSpringAnimation*)LayerScaleToDefaultWithFromeScale:(float)fromscale {
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    anim.springBounciness = defaultLayerScaleSpringBounciness;
    anim.springSpeed = defaultLayerScalePpringSpeed;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(fromscale, fromscale)];
    return anim;
}

+(POPSpringAnimation*)LayerScaleToScaleWithFromeScale:(float)fscale andToScale:(float)tscale {
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    anim.springBounciness = defaultLayerScaleSpringBounciness;
    anim.springSpeed = defaultLayerScalePpringSpeed;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(fscale, fscale)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(tscale, tscale)];
    return anim;
}

@end


@implementation CoreAnimationOpacity

+(POPBasicAnimation*)OpacityDefaultToZero {
    POPBasicAnimation *opacityAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    opacityAnim.duration = defaultOpacityDuration;
    opacityAnim.toValue = @0.0;
    return opacityAnim;
}

+(POPBasicAnimation*)OpacityDefaultToFull {
    POPBasicAnimation *opacityAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    opacityAnim.duration = defaultOpacityDuration;
    opacityAnim.toValue = @1.0;
    return opacityAnim;
}


+(POPBasicAnimation*)OpacityFromOpacity:(float)fopacity toOpacity:(float)topacity {
    POPBasicAnimation *opacityAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    opacityAnim.duration = defaultOpacityDuration;
    opacityAnim.fromValue=@(fopacity);
    opacityAnim.toValue = @(topacity);
    return opacityAnim;
}




@end


@implementation CoreAnimationCenter

+(POPSpringAnimation*)CenterDefaultToCenter:(CGPoint)tcenter andBounciness:(float)Bounciness andSpeed:(float)speed {
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    positionAnimation.toValue = [NSValue valueWithCGPoint:tcenter];
    positionAnimation.springBounciness = Bounciness;
    positionAnimation.springSpeed = speed;
    return positionAnimation;
}


+(POPSpringAnimation*)CenterDefaultFromeCenter:(CGPoint)fcenter andBounciness:(float)Bounciness andSpeed:(float)speed {
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:fcenter];
    positionAnimation.springBounciness = Bounciness;
    positionAnimation.springSpeed = speed;
    return positionAnimation;
}


+(POPSpringAnimation*)CenterFromeCenter:(CGPoint)fcenter toCenter:(CGPoint)tcenter andBounciness:(float)Bounciness andSpeed:(float)speed {
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    positionAnimation.fromValue=[NSValue valueWithCGPoint:fcenter];
    positionAnimation.toValue = [NSValue valueWithCGPoint:tcenter];
    positionAnimation.springBounciness = Bounciness;
    positionAnimation.springSpeed = speed;
    return positionAnimation;
}

@end