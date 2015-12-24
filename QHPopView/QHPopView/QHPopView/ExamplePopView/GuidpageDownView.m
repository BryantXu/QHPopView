//
//  GuidpageDownView.m
//  yimashuo
//
//  Created by imqiuhang on 15/9/23.
//  Copyright © 2015年 imqiuhang. All rights reserved.
//

#import "GuidpageDownView.h"
#import "YLImageView.h"

#define pageCount 4

@interface GuidpageDownView ()<UIScrollViewDelegate>

@end

@implementation GuidpageDownView
{
    UIScrollView *contentScrollView;
    UIPageControl *pageControl;
}
- (void)prepareForContentSubView {
    contentView.backgroundColor = [UIColor whiteColor];
    
    contentScrollView = [[UIScrollView alloc] initWithFrame:contentView.bounds];
    [contentView addSubview:contentScrollView];
    
    contentScrollView.contentSize = CGSizeMake(contentView.width*pageCount, contentScrollView.contentSize.height);
    contentScrollView.pagingEnabled = YES;
    contentScrollView.bounces = NO;
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.delegate = self;
    
    for(int i =0;i<pageCount;i++) {
        UIView *indexView  = [[UIView alloc] initWithFrame:contentScrollView.bounds];
        indexView.left = i*contentScrollView.width;
        [contentScrollView addSubview:indexView];
            YLImageView *gifImageView = [[YLImageView alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
            gifImageView.centerX = indexView.width/2.f;
            gifImageView.centerY = 180;
            gifImageView.image = [YLGIFImage imageNamed:[NSString stringWithFormat:@"pageGif_%i.gif",i+1]];
            [indexView addSubview:gifImageView];
            
            UIImageView *fontImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"pageFont_%i",i+1]]];
            fontImageView.centerX = indexView.width/2.f;
            fontImageView.centerY = 60.f;
            [indexView addSubview:fontImageView];
  
    }
    
    
    UIButton *iKnowBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, contentView.width - 100 , 40)];
    iKnowBtn.centerX = contentView.width/2.f;
    iKnowBtn.bottom = contentView.height - 40;
    [iKnowBtn setTitle:@"本宫知道了" andFont:defaultFont(16) andTitleColor:[UIColor whiteColor] andBgColor:YMSBrandColor andRadius:5];
    [iKnowBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:iKnowBtn];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    pageControl.centerX       = contentView.width/2.f;
    pageControl.bottom        = iKnowBtn.top - 20;
    pageControl.numberOfPages = pageCount;
    pageControl.currentPage   = 0;
    [pageControl setCurrentPageIndicatorTintColor:YMSBrandColor];
    [pageControl setPageIndicatorTintColor:[QHUtil colorWithHexString:@"e8e8e8"]];
    
    [contentView addSubview:pageControl];
    
}

- (void)didiScrollToIndex:(int)index {
    if (pageControl.currentPage ==index) {
        return;
    }
    pageControl.currentPage = index;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self didiScrollToIndex:(int)((scrollView.contentOffset.x+scrollView.width/2.f)/scrollView.width)];
    
}


- (void)dealloc {
    MSLog(@"GuidpageDownView dealloc");
}
@end
