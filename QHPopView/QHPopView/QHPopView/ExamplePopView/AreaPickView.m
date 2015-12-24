//
//  AreaPickView.m
//  yimashuo
//
//  Created by imqiuhang on 15/9/19.
//  Copyright © 2015年 imqiuhang. All rights reserved.
//

#import "AreaPickView.h"

@interface AreaPickView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation AreaPickView
{
    UIButton     *doneBtn;
    
    NSArray *provinces, *cities, *areas;
    
    AreaPickInfo *areaPickInfo;
}

- (void)prepareForContentSubView {
    
    [self initModel];
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
    [contentView addSubview:self.pickView];
    
    
}

- (void)initModel {
    provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
    cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
    areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
    
    areaPickInfo = [AreaPickInfo new];
    
    areaPickInfo.province = [[provinces objectAtIndex:0] objectForKey:@"state"];
    areaPickInfo.city = [[cities objectAtIndex:0] objectForKey:@"city"];
    
    areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
    if (areas.count > 0) {
        areaPickInfo.area = [areas objectAtIndex:0];
    } else{
       areaPickInfo.area = @"";
    }
}

- (void)done {
    NSString *provice = areaPickInfo.province;
    NSString *city = areaPickInfo.city;
    
    NSString *area = areaPickInfo.area;
    if (![area isNotEmptyCtg]) {
        area = city;
        city = provice;
    }
    
    if ([self.delagate respondsToSelector:@selector(areaPickViewdidPickProvince:andCity:andArea:)]) {
        [self.delagate areaPickViewdidPickProvince:provice andCity:city andArea:area];
    }
    [self hide:YES];
}

#pragma mark- Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return [provinces count];
        case 1:
            return [cities count];
        case 2:
            return [areas count];
        default:
            return 0;
    }
}


#pragma mark- Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    switch (component) {
        case 0:
            return [[provinces objectAtIndex:row] objectForKey:@"state"];
            break;
        case 1:
            return [[cities objectAtIndex:row] objectForKey:@"city"];
            break;
        case 2:
            if ([areas count] > 0) {
                return [areas objectAtIndex:row];
                break;
            }
        default:
            return  @"";
            break;
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            cities = [[provinces objectAtIndex:row] objectForKey:@"cities"];
            [self.pickView selectRow:0 inComponent:1 animated:YES];
            [self.pickView reloadComponent:1];
            
            areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
            [self.pickView reloadComponent:2];
            [self.pickView selectRow:0 inComponent:2 animated:YES];

            areaPickInfo.province = [[provinces objectAtIndex:row] objectForKey:@"state"];
            areaPickInfo.city = [[cities objectAtIndex:0] objectForKey:@"city"];
            if ([areas count] > 0) {
                areaPickInfo.area = [areas objectAtIndex:0];
            } else{
                areaPickInfo.area = @"";
            }
            break;
        case 1:
            areas = [[cities objectAtIndex:row] objectForKey:@"areas"];
            [self.pickView reloadComponent:2];
            [self.pickView selectRow:0 inComponent:2 animated:YES];
            
            
            areaPickInfo.city = [[cities objectAtIndex:row] objectForKey:@"city"];
            if ([areas count] > 0) {
                areaPickInfo.area = [areas objectAtIndex:0];
            } else{
                areaPickInfo.area = @"";
            }
            break;
        case 2:
            if ([areas count] > 0) {
                areaPickInfo.area = [areas objectAtIndex:row];
            } else{
                areaPickInfo.area = @"";
            }
            break;
        default:
            break;
    }
    
}



@end


@implementation AreaPickInfo



@end

