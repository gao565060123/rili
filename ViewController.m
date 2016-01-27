//
//  ViewController.m
//  CoreCalendar
//
//  Created by 冯成林 on 15/9/16.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "ViewController.h"

#import "CoreCalendarView.h"

#import "ServiceModel.h"

#import "GCButton.h"






@interface ViewController ()<CoreCalendarDelegate>

@property (nonatomic,strong) CoreCalendarView *calendarView;

@property (nonatomic, assign) BOOL isCalendarView;

@property (nonatomic, strong) UIView *blurView;  // 蒙板

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.isCalendarView = NO;
    
    [self addButtonView];
    
    
    
    

    
    
    
}
- (void)addButtonView
{
    GCButton *btn = [GCButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50) title:@"日历开关按钮" titleColor:[UIColor whiteColor] backgroundImage:nil andBlock:^{
        
        if (!self.isCalendarView) {
            [self.view addSubview:self.blurView];
            [self.view addSubview:self.calendarView];
        }else{
            [self.calendarView removeFromSuperview];
            [self.blurView removeFromSuperview];
        }
        self.isCalendarView = !self.isCalendarView;
        
    }];
    btn.backgroundColor =  [UIColor colorWithRed:31 / 255.0 green:172 / 255.0 blue:248 / 255.0 alpha:1];
    [self.view addSubview:btn];
}
// 31  172  248





- (UIView *)blurView
{
    if (!_blurView) {
        _blurView = [[UIView alloc] initWithFrame:self.view.bounds];
        _blurView.backgroundColor  = [UIColor grayColor];
        _blurView.alpha = 0.2;
        _blurView.userInteractionEnabled = NO;
    }
    return _blurView;
}



/**
 *  懒加载
 */
- (CoreCalendarView *)calendarView
{
    if (!_calendarView) {
        // 1 初始化
        CoreCalendarView *calendarView = [CoreCalendarView calendarViewWithCalendarType:CoreCalendarTypeVertical];  // 垂直方向滑动   (水平方向滑动)
        
        // 2 设置属性
        self.calendarView=calendarView;
        calendarView.delegate = self;
        /*
        
//        ServiceModel *m1 = [[ServiceModel alloc] init];
//        // 时间戳
//        m1.timestamp = @"1444694400";
//        // 点击回调block开关   yes---不回调block
//        m1.offEdit = YES;
//        //  所有日期文字显示   都为黑色
//        calendarView.isDarkEarlierDays = NO;
//        
//        self.calendarView.timestampsIn = @[m1];
        */
         // 日历视图frame
        calendarView.frame = CGRectMake(0, 120, self.view.frame.size.width * 0.6, 200 );
//        [self.view addSubview:calendarView];
        NSDate *date = [NSDate date];
        
        // 点击日期按钮  回调block
        calendarView.ClickDayBlock =  ^BOOL(NSDate *d){
        BOOL res = date.timeIntervalSince1970 - 3600 * 24 <= d.timeIntervalSince1970;
            return res;
        };
        // 背景色
        calendarView.backgroundColor = [UIColor whiteColor];
//        calendarView.backgroundColor = [UIColor colorWithRed:193 / 255.0 green:193 / 255.0 blue:193 / 255.0 alpha:1];
    }
    return _calendarView;
}




#pragma mark     CoreCalendarDelegate  代理方法
/**
 *  显示前几个月的个数
 */
-(NSNumber *)coreCalendarLeftMonths{
    return @-1;   // 显示之前一个月
}

/**
 *  显示之后几个月的个数
 */
-(NSNumber *)coreCalendarRightMonths{
    return @1;    // 显示之后一个月
}



@end
