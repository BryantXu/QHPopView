//
//  CoreAnimationShare.h
//  commonAnimation
//
//  Created by imqiuhang on 15/1/14.
//  Copyright (c) 2015年 your Co. Ltd. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "POP.h"



#define dimViewTag                          423234
#define defaultDuraTime                     0.5f

#pragma mark -
#pragma mark -PresentingAnimator

#define defaultSize CGSizeMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2)

typedef enum {
    fromType_FromTop=0,//=0,默认的弹出方式
    fromType_FromBottom,
    fromType_FromLeft,
    fromType_FromRight
}fromType;

typedef enum {
    showType_pop=0,//=0,默认的方式,是弹出到正中间 还有可以设置为菜单
    showType_menu
}showType;
/**
 *  弹出视图
 */


@interface PresentingAnimator : NSObject <UIViewControllerAnimatedTransitioning>
{
  @protected
    //如需继承该接口协议时标记
   __block BOOL fatherFinished;

}
@property (nonatomic,assign) NSTimeInterval durationTime;
@property (nonatomic,assign) fromType      fromType;
@property (nonatomic,assign) showType       showType;
@property (nonatomic,assign) CGSize         toViewSize;
@property (nonatomic,strong) UIColor        *dimmingViewColor;
@property (nonatomic,assign) float          dimmingViewApha;
@property (nonatomic,assign) BOOL           canFromViewTouch;

@property (nonatomic,assign) void(^finishBlock)(NSString*className, BOOL finished);

/**
 *  按照自己的喜好设置,你也可以不要调用这个方法而在alloc init以后直接一个个设置想要设置的属性,不需要全部设置
 *
 *  @param aToViewSize      弹出视图的Size,默认是半个屏幕的大小
 *  @param aType            弹出的方式,目前只有各个方向的弹出,更多类型慢慢来,默认是从上往下
 *  @param showType         弹出的类型,默认是弹到正中间的那种,也可以设置为菜单类型
 *  @param aDurationTime    弹出需要的时间,默认0.5秒
 *  @param aDimColor        背景层的颜色,默认是黑色的
 *  @param aDimApha         背景层的透明度 默认是0.5透明
 *  @param canFromViewTouch 弹出窗口后父窗口是否参与交互,如果为yes,则不会加入背景层,默认是NO不参与交互的
 *  @param finishBlock      动画结束时调用的代码块,不是整个切换过程结束
 */


@end

/**
 *  dismiss的动画~~~消失的话 把type设置成何弹出一样就行了~没有太多设置了~太麻烦了
 */
@interface DismissingAnimator : NSObject <UIViewControllerAnimatedTransitioning>
{
@protected
    //如需继承该接口使用
   __block BOOL fatherFinished;
}
@property (nonatomic,assign) fromType fromType;
@property (nonatomic,assign) void(^finishBlock)(NSString*className,BOOL finished);

@end

