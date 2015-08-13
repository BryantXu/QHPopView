//
//  CoreAnimationControl.h
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
//没赋值时候使用的默认阻力,速度,透明度变化时间,弹出视图的宽和高
#define  defaultLayerScaleSpringBounciness  20
#define  defaultLayerScalePpringSpeed       20
#define  defaultOpacityDuration             0.5f

@interface CoreAnimationScale : NSObject

/**
 *  默认的抖动 可以做一些小按钮的抖动之类的
 *
 *  @return 返回从(0,0)大小变到控件本来的大小的一个动画
 */
+(POPSpringAnimation*)LayerScaleAnimationDefault;

/**
 *  从指定大小变到控件本来大小的动画
 *
 *  @param fromscale 从多少大开始变到原本大小
 *
 *  @return 返回从指定大小变到控件本来大小的动画
 */
+(POPSpringAnimation*)LayerScaleToDefaultWithFromeScale:(float)fromscale;

/**
 *  从指定多少大变化到指定大小的动画
 *
 *  @param fscale 从多少大开始变化
 *  @param tscale 变成多少大
 *
 *  @return 从指定多少大变化到指定大小的动画
 */
+(POPSpringAnimation*)LayerScaleToScaleWithFromeScale:(float)fscale andToScale:(float)tscale;

@end


@interface CoreAnimationOpacity : NSObject

/**
 *  从原本透明度渐变到0
 *
 *  @return 从原本透明度渐变到0的动画
 */
+(POPBasicAnimation*)OpacityDefaultToZero;

/**
 *  从原本透明度渐变到1
 *
 *  @return 从原本透明度渐变到1的动画
 */
+(POPBasicAnimation*)OpacityDefaultToFull;

/**
 *  从指定透明度渐变到指定透明度
 *
 *  @param fopacity 从多少透明度开始变化
 *  @param topacity 变化到多少透明度
 *
 *  @return 从指定透明度渐变到指定透明度的动画
 */

+(POPBasicAnimation*)OpacityFromOpacity:(float)fopacity toOpacity:(float)topacity;

@end


@interface CoreAnimationCenter : NSObject

/**
 *  从控件自身的中心点中心点变化到指定中心点
 *
 *  @param tcenter    变化到哪个中心点  如果X或者Y不想变 那么设置为原来的值
 *  @param Bounciness 阻力,越大刹车效果越明显,抖动次数变少 参考弹簧的阻尼！
 *  @param speed      速度 参考弹簧的速度 ~自己image一下。。
 *
 *  @return 从指定中心点变化到指定中心点的动画
 */
+(POPSpringAnimation*)CenterDefaultToCenter:(CGPoint)tcenter andBounciness:(float)Bounciness andSpeed:(float)speed;

/**
 *  从指定中心点变化到指定控件自身的中心点
 *
 *  @param fcenter    同上
 *  @param Bounciness 同上
 *  @param speed      同上
 *
 *  @return 同上
 */
+(POPSpringAnimation*)CenterDefaultFromeCenter:(CGPoint)fcenter andBounciness:(float)Bounciness andSpeed:(float)speed;

/**
 *  从制动中心点变化到指定中心店
 *
 *  @param fcenter    同上
 *  @param tcenter    同上
 *  @param Bounciness 同上
 *  @param speed      同上
 *
 *  @return 同上
 */
+(POPSpringAnimation*)CenterFromeCenter:(CGPoint)fcenter toCenter:(CGPoint)tcenter andBounciness:(float)Bounciness andSpeed:(float)speed;

@end