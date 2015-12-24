//
//  CoreAnimationShare.m
//  commonAnimation
//
//  Created by imqiuhang on 15/1/14.
//  Copyright (c) 2015年 your Co. Ltd. All rights reserved.
//

#import "CoreAnimationPresent.h"


@implementation PresentingAnimator

inline CGSize getDefaultSize(){
    return CGSizeZero;
}
- (instancetype)init {
    if (self=[super init]) {
        [self setAsDefault];
    }
    return self;
}
- (void)setAsDefault {
    [self setAsCustomWithSize:defaultSize andType:fromType_FromTop ansShowType:showType_pop andDuraTime:defaultDuraTime andDimViewColor:[UIColor blackColor] andDimApha:defaultDuraTime andcanFromViewTouch:NO];
}
- (void)setAsCustomWithSize:(CGSize)aToViewSize andType:(fromType)aFromType ansShowType:(showType)aShowType andDuraTime:(NSTimeInterval)aDurationTime andDimViewColor:(UIColor *)aDimColor andDimApha:(float)aDimApha andcanFromViewTouch:(BOOL)canFromViewTouch {
    self.toViewSize       = aToViewSize;
    self.fromType         = aFromType;
    self.showType         = aShowType;
    self.durationTime     = aDurationTime;
    self.dimmingViewColor = aDimColor;
    self.dimmingViewApha  = aDimApha;
    self.canFromViewTouch = canFromViewTouch;
    
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return self.durationTime!=NSTimeIntervalSince1970?self.durationTime:defaultDuraTime;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    
    fromView.userInteractionEnabled = self.canFromViewTouch;
    
    UIView *dimmingView = [[UIView alloc] initWithFrame:fromView.bounds];
    dimmingView.backgroundColor = self.dimmingViewColor;
    dimmingView.layer.opacity = 0.0f;
    dimmingView.tag=dimViewTag;
    
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    toView.frame = CGRectMake(0,
                              0,
                              self.toViewSize.width,
                              self.toViewSize.height
                              );
    
    NSString* kPOPLayerType;
    CGPoint toViewCenter;
    switch (self.fromType) {
        case fromType_FromTop:{
            kPOPLayerType=kPOPLayerPositionY;
            toViewCenter=CGPointMake(transitionContext.containerView.center.x, -transitionContext.containerView.center.y);
            break;
        }case fromType_FromBottom:{
            kPOPLayerType=kPOPLayerPositionY;
            toViewCenter=CGPointMake(transitionContext.containerView.center.x, 2*transitionContext.containerView.center.y);
            break;
        }case fromType_FromLeft:{
            kPOPLayerType=kPOPLayerPositionX;
            toViewCenter=CGPointMake(-transitionContext.containerView.center.x, transitionContext.containerView.center.y);
            break;
        }case fromType_FromRight:{
            kPOPLayerType=kPOPLayerPositionX;
            toViewCenter=CGPointMake(2*transitionContext.containerView.center.x, transitionContext.containerView.center.y);
            break;
        }
           
            
        default:
            break;
    }
    toView.center = toViewCenter;
    
    [transitionContext.containerView addSubview:dimmingView];
    [transitionContext.containerView addSubview:toView];
    
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerType];
    float toValue;
    
    if (self.showType==showType_pop) {
        toValue=[kPOPLayerType isEqualToString:kPOPLayerPositionX]?transitionContext.containerView.center.x:transitionContext.containerView.center.y;
    } else {
             toValue=[kPOPLayerType isEqualToString:kPOPLayerPositionX]?self.toViewSize.width/2:self.toViewSize.height/2;
        if (self.fromType==fromType_FromRight||self.fromType==fromType_FromBottom) {
            toValue=[kPOPLayerType isEqualToString:kPOPLayerPositionX]?fromView.frame.size.width-toValue:fromView.frame.size.height-toValue;
        }
    }
    
    
    positionAnimation.toValue = @(toValue);
    positionAnimation.springBounciness = 10;
    [positionAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [transitionContext completeTransition:YES];
        if (self.finishBlock) {
            self.finishBlock(NSStringFromClass([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey]class]),finished);
            fatherFinished=finished;
        }
    }];
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.springBounciness = 20;
    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.4)];
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(self.dimmingViewApha);
    
    [toView.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    if (self.showType==showType_pop) {
        [toView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }
    
    [dimmingView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
}




@end


@implementation DismissingAnimator
-(instancetype)init {
    if (self=[super init]) {
        self.fromType=fromType_FromTop;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return defaultDuraTime;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    toVC.view.userInteractionEnabled = YES;
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    __block UIView *dimmingView;
    [transitionContext.containerView.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if (view.tag==dimViewTag) {
            dimmingView = view;
            *stop = YES;
        }
    }];
    NSString* kPOPLayerType=self.fromType==fromType_FromTop||self.fromType==fromType_FromBottom?kPOPLayerPositionY:kPOPLayerPositionX;
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.0);
    
    POPBasicAnimation *offscreenAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerType];
    float toValue=[kPOPLayerType isEqualToString:kPOPLayerPositionX]?-fromVC.view.layer.position.x:-fromVC.view.layer.position.y;
    offscreenAnimation.toValue = @(toValue);
    [offscreenAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [transitionContext completeTransition:YES];
        if (self.finishBlock) {
            self.finishBlock(NSStringFromClass([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey]class]),finished);
            fatherFinished=finished;
        }
    }];
    [fromVC.view.layer pop_addAnimation:offscreenAnimation forKey:@"offscreenAnimation"];
    [dimmingView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
}

@end
