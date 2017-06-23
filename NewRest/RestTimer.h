//
//  RestTimer.h
//  NewRest
//
//  Created by Flame Grace on 2017/5/12.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RestTimer;

@protocol RestTimerDelegate <NSObject>

- (void)restTimer:(RestTimer *)timer handleTime:(NSTimeInterval)handleTime;

- (void)restTimerArriveRestTime:(RestTimer *)timer;

@end


@interface RestTimer : NSObject

@property (weak, nonatomic) id<RestTimerDelegate> delegate;

@property (assign, nonatomic) NSTimeInterval restTime;

@property (readonly, nonatomic) NSTimeInterval handleTime;

- (instancetype)initWithRestTime:(NSTimeInterval)restTime delegate:(id<RestTimerDelegate>)delegate;

- (void)startTimer;

- (void)stopTimer;

- (void)pauseTimer;

- (void)continueTimer;

@end
