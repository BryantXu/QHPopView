//
//  orderTimePopView.m
//  qingmedia_ios
//
//  Created by imqiuhang on 15/7/15.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "OrderTimePopView.h"
#import "CommAnimationEffect.h"
#import "CoreAnimationControl.h"

#define contentViewHeight       350.f
#define OrderTimePopViewTag     828734778
#define dateBtnGap              20.f
#define weekdaybtnYellowTag     23840234
#define OrderTimePopViewAniTime 0.35f

@implementation OrderTimePopView
{
    UIView *shadowView,*contentView;
    UIPickerView *pickView;
    NSArray *dataForPickView;
    NSMutableArray *weekdayBtns;
    
    int curSelectDateIndex;
    
}
- (instancetype)init {
    if (self=[super init]) {
        self.frame = CGRectMake(0, 0, QHScreenWidth, QHScreenHeight);
        self.tag = OrderTimePopViewTag;
        [self initModel];
        [self initView];
        
    }
    return self;
}


- (void)choodeWeekDay:(UIButton *)sender {
    curSelectDateIndex = (int)sender.tag;
    for(UIButton *btn in weekdayBtns) {
        if (btn!=sender&&btn.tag==weekdaybtnYellowTag) {
            btn.tag = 0;
            POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
            anim.springBounciness = 0;
            anim.springSpeed      = 5;
            anim.fromValue        = [UIColor yellowColor];
            anim.toValue=[UIColor clearColor];
            [btn pop_addAnimation:anim forKey:@"cleancolor"];
        }
    }
    sender.tag = weekdaybtnYellowTag;
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
    anim.springBounciness = 0;
    anim.springSpeed      = 5;
    anim.fromValue        = [UIColor whiteColor];
    anim.toValue=[UIColor yellowColor];
    [sender pop_addAnimation:anim forKey:@"bachcolor"];
    
}


- (void)done {
    [self disMiss];
}

- (void)cancel {
    [self disMiss];
}

- (void)initModel {
    NSMutableArray *muArr = [[NSMutableArray alloc] initWithCapacity:20];
    for(int i=9;i<=21;i++) {
        [muArr addObject:@(i)];
    }
    dataForPickView = [muArr copy];
    
    curSelectDateIndex = 0;

}

- (void)showWithAnimationdView:(UIView *)aniView {
    [[QHKEY_WINDOW viewWithTag:OrderTimePopViewTag] removeFromSuperview];
    [QHKEY_WINDOW addSubview:self];
    
    [aniView.layer addAnimation:[CommAnimationEffect animationGroup:YES andDuration:OrderTimePopViewAniTime] forKey:@"aniStart"];
    fatherAniView    = aniView;

    contentView.top  = self.height;
    shadowView.alpha = 0.f;
    [UIView animateWithDuration:OrderTimePopViewAniTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        contentView.bottom = self.height;
        shadowView.alpha   = 0.6f;
    } completion:nil];
    
}

- (void)disMiss {
    if (fatherAniView) {
        [fatherAniView.layer addAnimation:[CommAnimationEffect animationGroup:NO andDuration:OrderTimePopViewAniTime] forKey:@"aniEnd"];
    }
    [UIView animateWithDuration:OrderTimePopViewAniTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        contentView.top  = self.height;
        shadowView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark Picker Delegate Methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50.f;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view  {
    UIView *dateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, QHScreenWidth ,40)];
    
    UILabel *dateLable      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    dateLable.text =[NSString stringWithFormat:@"%@:00",dataForPickView[row]];
    dateLable.textColor = [UIColor blackColor];
    dateLable.font =defaultFont(16);
    dateLable.centerX       = dateView.width/2.f;
    dateLable.centerY       = dateView.height/2.f;
    dateLable.textAlignment = NSTextAlignmentCenter;
    [dateView addSubview:dateLable];
    
    if (row%3==0&&row>0) {
        UILabel *haveOrderLable           = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        haveOrderLable.right              = dateView.width-15;
        haveOrderLable.centerY            = dateView.height/2.f;
        haveOrderLable.text = @"已被预约";
        haveOrderLable.textColor = [UIColor blackColor];
        haveOrderLable.font =defaultFont(18);
        haveOrderLable.textAlignment      = NSTextAlignmentCenter;
        haveOrderLable.layer.cornerRadius = 5.f;
        haveOrderLable.clipsToBounds      = YES;
        haveOrderLable.backgroundColor    = [UIColor yellowColor];
        [dateView addSubview:haveOrderLable];
    }
    
 
    return dateView;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [dataForPickView count];
}


- (void)initView {
    shadowView = [[UIView alloc] initWithFrame:self.bounds];
    shadowView.backgroundColor = QHRGBA(0, 0, 0, 0.8);
    shadowView.alpha           = 0.f;
    UITapGestureRecognizer *closeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMiss)];
    [shadowView addGestureRecognizer:closeTap];
    [self addSubview:shadowView];
    //--------------------------------------contentView-------------------------------------
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, QHScreenWidth, contentViewHeight)];
    contentView.top                 = self.height;
    contentView.backgroundColor     = [UIColor whiteColor];
    contentView.layer.shadowColor   = [UIColor darkGrayColor].CGColor;
    contentView.layer.shadowOpacity = 0.8f;
    contentView.layer.shadowRadius  = 10.f;
    contentView.layer.shadowPath    = [[UIBezierPath bezierPathWithRect:self.bounds] CGPath];
    //-----------------------------------------^---------------------------------------------
    [self initDateBtn];
    //-----------------------------------------确定按钮---------------------------------------
    UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 100, 40)];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    doneBtn.right = contentView.width  -10;
    doneBtn.titleLabel.font=defaultFont(16);
    [doneBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:doneBtn];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 100, 40)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    cancelBtn.left            = 10;
    cancelBtn.titleLabel.font = defaultFont(16);
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancelBtn];
    
    
    [self addSubview:contentView];
    
    
    UIView *lineViewTopForBtn = [[UIView alloc] initWithFrame:CGRectMake(0, doneBtn.top, QHScreenWidth, 0.5f)];
    lineViewTopForBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];;
    [contentView addSubview:lineViewTopForBtn];
    
    UIView *lineViewbottomForBtn = [[UIView alloc] initWithFrame:CGRectMake(0, doneBtn.bottom, QHScreenWidth, 0.5f)];
    lineViewbottomForBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [contentView addSubview:lineViewbottomForBtn];
    //-----------------------------------------^---------------------------------------------
    
    //-----------------------------------------pickView---------------------------------
    
    pickView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, cancelBtn.bottom, self.width, 250)];
    [pickView.layer setFrame:CGRectMake(0,cancelBtn.bottom, self.width, 250)];
    pickView.showsSelectionIndicator = YES;
    pickView.dataSource              = self;
    pickView.delegate                = self;
    [pickView selectRow:dataForPickView.count/2 inComponent:0 animated:YES];
    
    [contentView addSubview:pickView];
    //-----------------------------------------^---------------------------------------------
    
    
}

- (void)initDateBtn {
    
    weekdayBtns  =[[NSMutableArray alloc] initWithCapacity:10];
    for(int i=0;i<7;i++) {
        float btnWidth =(QHScreenWidth-2*dateBtnGap)/7.f;
        UIView * dateBtnBackGroud = [[UIButton alloc] initWithFrame:CGRectMake(dateBtnGap+i*btnWidth, -5, btnWidth, 50)];
        
        [contentView addSubview:dateBtnBackGroud];
        
        UIButton *dateChooseBtn = [[UIButton alloc] initWithFrame:dateBtnBackGroud.bounds];
        dateChooseBtn.tag = i;
        [dateChooseBtn addTarget:self action:@selector(choodeWeekDay:) forControlEvents:UIControlEventTouchUpInside];
        [dateBtnBackGroud addSubview:dateChooseBtn];
        [weekdayBtns addObject:dateChooseBtn];
        if (i==0) {
            dateChooseBtn.backgroundColor  = [UIColor yellowColor];
            dateChooseBtn.tag = weekdaybtnYellowTag;
        }
        
        UILabel *dateDay = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, dateBtnBackGroud.width, 30)];
        dateDay.text          = [NSString stringWithFormat:@"%i",i+1];
        dateDay.font          = defaultFont(16);
        dateDay.textAlignment = NSTextAlignmentCenter;
        
        [dateBtnBackGroud addSubview:dateDay];
        
        NSArray *weeks = @[@"周一",@"周一",@"周一",@"周一",@"周一",@"周一",@"周一"];
        
        UILabel *dateweekDay = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, dateBtnBackGroud.width, 30)];
        dateweekDay.text          = weeks[i];
        dateweekDay.font          = defaultFont(12);
        dateweekDay.textAlignment = NSTextAlignmentCenter;
        
        [dateBtnBackGroud addSubview:dateweekDay];
        
    }
}



@end
