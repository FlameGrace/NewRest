//
//  ViewController.m
//  NoteRest
//
//  Created by 李嘉军 on 2017/5/11.
//  Copyright © 2017年 lli. All rights reserved.
//

#import "MainViewController.h"

#define RestTime (10)


@interface MainViewController()

@property (assign, nonatomic) BOOL isShowNowWindow;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger timeFlag;


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
}


- (void)startTimer
{
    [self stopTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)handleTimer
{
    if(self.isShowNowWindow)
    {
        return;
    }
    if(self.timeFlag%RestTime == 0&&self.timeFlag!=0)
    {
        [ApplicationDelegate.mainWindow showNowWindow];
        self.isShowNowWindow = YES;
    }
    int m = (int)(self.timeFlag/60);
    int s = (int)(self.timeFlag%60);
    self.timeLabel.stringValue = [NSString stringWithFormat:@"%d : %02d",m,s];
    self.timeFlag ++;
    
    
    
    
}


- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
    self.timeFlag = 0;
}



@end
