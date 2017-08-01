//
//  AppDelegate.m
//  NewRest
//
//  Created by Flame Grace on 2017/5/11.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "AppDelegate.h"
#import "ShellTool.h"



@interface AppDelegate () <RestTimerDelegate>

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    if(![[NSUserDefaults standardUserDefaults]objectForKey:@"restTime"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"15*60" forKey:@"restTime"];
    }
    [self statusBar];
    [self restTimer];
}


- (void)restTimer:(RestTimer *)timer handleTime:(NSTimeInterval)handleTime
{
    int timeFlag = (int)handleTime;
    int m = (int)(timeFlag/60);
    int s = (int)(timeFlag%60);
    self.statusBar.item.title = [NSString stringWithFormat:@"%d:%02d",m,s];
}

- (void)restTimerArriveRestTime:(RestTimer *)timer
{
    [[self.nowWindow window]orderFront:nil];
    [[self.nowWindow window]center];
}


- (TimeStatusBar *)statusBar
{
    if(!_statusBar)
    {
        _statusBar = [[TimeStatusBar alloc]init];
    
    }
    return _statusBar;
}


- (RestTimer *)restTimer
{
    if(!_restTimer)
    {
        NSString *restTimeString = [[NSUserDefaults standardUserDefaults]objectForKey:@"restTime"];
        _restTimer = [[RestTimer alloc]initWithRestTime:restTimeString.doubleValue delegate:self];
    }
    return _restTimer;
}

- (NowWindowController *)nowWindow
{
    if(!_nowWindow)
    {
        _nowWindow = [MainStoryBoard instantiateControllerWithIdentifier:@"NowWindow"];
    }
    return _nowWindow;
}



@end
