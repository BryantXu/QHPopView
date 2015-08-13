//
//  CommPickView.m
//  lovewith
//
//  Created by imqiuhang on 15/5/19.
//  Copyright (c) 2015年 lovewith.me. All rights reserved.
//

#import "CommPickView.h"
#import "UIView+QHUIViewCtg.h"
#define CommPickViewTag  76347678

@implementation CommPickView
{
    int showTag;
    UIView       *backgroundView;
    UIView       *contentView;
    UIButton     *doneBtn;
    
}


- (id)initWithDataArr:(NSArray *)data {
    if (self=[super init]) {
        self.dataForPickView = data;
        [self initView];
    }
    return self;
}

- (void)initView {
    self.tag=CommPickViewTag;
    self.frame=QHKEY_WINDOW.bounds;
    
    backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0.f;
    [self addSubview:backgroundView];
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 250)];
    [self addSubview:contentView];
    contentView.top=self.height;
    contentView.backgroundColor=[UIColor whiteColor];
    
    doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    doneBtn.right=self.width-10;
    doneBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    doneBtn.titleLabel.font = defaultFont(18);
    [contentView addSubview:doneBtn];
    [doneBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, doneBtn.bottom, self.width, 200)];
    self.pickView.showsSelectionIndicator=YES;
    self.pickView.dataSource=self;
    self.pickView.delegate=self;
    if (self.dataForPickView.count>=1) {
        [self.pickView selectRow:0 inComponent:0 animated:YES];
    }
    [contentView addSubview:self.pickView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
    [backgroundView addGestureRecognizer:tap];
    
    
}

- (void)done {
    if ([self.delagate respondsToSelector:@selector(didPickObjectWithIndex:andTag:)]) {
        [self.delagate didPickObjectWithIndex:(int)[self.pickView selectedRowInComponent:0] andTag:showTag];
    }
    [self hide:YES];
}

- (void)tapEvent {
    [self hide:YES];
}

- (void)showWithTag:(int)tag {
    
    showTag= tag;
    if ([QHKEY_WINDOW viewWithTag:CommPickViewTag]) {
        [[QHKEY_WINDOW viewWithTag:CommPickViewTag] removeFromSuperview];
    }
    [QHKEY_WINDOW addSubview:self];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        contentView.bottom=self.height;
        backgroundView.alpha=0.4f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide:(BOOL)animation {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        contentView.top=self.height;
        backgroundView.alpha=0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.dataForPickView count];
}

#pragma mark Picker Delegate Methods


-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return self.dataForPickView[row];
}

@end
