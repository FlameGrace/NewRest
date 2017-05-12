//
//  ViewController.m
//  NoteRest
//
//  Created by 李嘉军 on 2017/5/11.
//  Copyright © 2017年 lli. All rights reserved.
//

#import "MainViewController.h"

#define RestTime (15*60)


@interface MainViewController()

@property (assign, nonatomic) BOOL isShowNowWindow;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSTimeInterval startTime;
@property (assign, nonatomic) NSTimeInterval pauseTime;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(confirm) name:ConfirmNotificationName object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(skip) name:SkipNotificationName object:nil];
    self.timeLabel.textColor = [NSColor redColor];
    self.timeLabel.alignment = NSTextAlignmentCenter;
    self.timeLabel.font = [NSFont systemFontOfSize:50];
    [self startTimer];
    
}


- (void)viewWillAppear
{
    [super viewWillAppear];
    [self.view setWantsLayer:YES];
    self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
}

- (void)confirm
{
    self.isShowNowWindow = NO;
    [self startTimer];
}

- (void)skip
{
    self.isShowNowWindow = NO;
    self.startTime += [[NSDate date]timeIntervalSince1970] - self.pauseTime;
    self.pauseTime = 0;
}


- (void)startTimer
{
    [self stopTimer];
    self.startTime = [[NSDate date]timeIntervalSince1970];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1/5 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    
    [self.timer fire];
}

- (void)handleTimer
{
    if(self.isShowNowWindow)
    {
        return;
    }
    NSTimeInterval reduce = [[NSDate date]timeIntervalSince1970] - self.startTime;
    if(reduce >= RestTime)
    {
        self.pauseTime = [[NSDate date]timeIntervalSince1970];
        [ApplicationDelegate.mainWindow showNowWindow];
        self.isShowNowWindow = YES;
    }
    int timeFlag = (int)reduce;
    int m = (int)(timeFlag/60);
    int s = (int)(timeFlag%60);
    self.timeLabel.stringValue = [NSString stringWithFormat:@"%d : %02d",m,s];
    
}


- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
    self.pauseTime = 0;
    self.startTime = 0;
}



@end
