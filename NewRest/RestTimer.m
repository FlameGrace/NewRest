//
//  RestTimer.m
//  NewRest
//
//  Created by 李嘉军 on 2017/5/12.
//  Copyright © 2017年 lli. All rights reserved.
//

#import "RestTimer.h"

@interface RestTimer()

@property (assign, nonatomic) BOOL isPausing;
@property (assign, nonatomic) int phase;
@property (strong, nonatomic) NSTimer *timer;
@property (readwrite,assign,nonatomic) NSTimeInterval handleTime;
@property (assign, nonatomic) NSTimeInterval startTime;
@property (assign, nonatomic) NSTimeInterval pauseTime;

@end

@implementation RestTimer


- (instancetype)initWithRestTime:(NSTimeInterval)restTime delegate:(id<RestTimerDelegate>)delegate
{
    if(self = [super init])
    {
        self.delegate = delegate;
        self.restTime = restTime;
    }
    return self;
}

- (void)setRestTime:(NSTimeInterval)restTime
{
    _restTime = restTime;
    [self startTimer];
}


- (void)continueTimer
{
    if(!self.timer||!self.timer.isValid)
    {
        [self startTimer];
        return;
    }
    self.isPausing = NO;
    self.startTime += [[NSDate date]timeIntervalSince1970] - self.pauseTime;
    self.pauseTime = 0;
}

- (void)pauseTimer
{
    self.isPausing = YES;
    self.pauseTime = [[NSDate date]timeIntervalSince1970];
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
    if(self.isPausing)
    {
        return;
    }
    self.handleTime = [[NSDate date]timeIntervalSince1970] - self.startTime;
    if(self.delegate && [self.delegate respondsToSelector:@selector(restTimer:handleTime:)])
    {
        [self.delegate restTimer:self handleTime:self.handleTime];
    }
    
    int timeFlag = (int)self.handleTime;
    int restTime = (int)self.restTime;
    if(timeFlag!= 0&&timeFlag%restTime == 0&&timeFlag/restTime!=self.phase)
    {
        self.phase = timeFlag/self.restTime;
        [self pauseTimer];
        if(self.delegate&&[self.delegate respondsToSelector:@selector(restTimerArriveRestTime:)])
        {
            [self.delegate restTimerArriveRestTime:self];
        }
    }
}


- (void)stopTimer
{
    self.isPausing = NO;
    [self.timer invalidate];
    self.timer = nil;
    self.pauseTime = 0;
    self.startTime = 0;
    self.phase = -1;
}





@end
