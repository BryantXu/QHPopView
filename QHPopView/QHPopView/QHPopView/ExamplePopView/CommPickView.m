//
//  CommPickView.m
//  lovewith
//
//  Created by imqiuhang on 15/5/19.
//  Copyright (c) 2015年 lovewith.me. All rights reserved.
//

#import "CommPickView.h"

@implementation CommPickView
{
    UIButton *doneBtn;
    
}

- (void)setDataForPickView:(NSArray *)dataForPickView {
    if (dataForPickView.count>0) {
        _dataForPickView = dataForPickView;
        [self.pickView reloadAllComponents];
    }
}

- (void)prepareForContentSubView {
    doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    doneBtn.right=self.width-10;
    doneBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:YMSBrandColor forState:UIControlStateNormal];
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
}

- (void)done {
    if ([self.delagate respondsToSelector:@selector(didPickObjectWithIndex:andTag:)]) {
        [self.delagate didPickObjectWithIndex:(int)[self.pickView selectedRowInComponent:0] andTag:self.showTag];
    }
    [self hide:YES];
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
