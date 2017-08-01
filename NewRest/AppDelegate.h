//
//  AppDelegate.h
//  NewRest
//
//  Created by Flame Grace on 2017/5/11.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NowWindowController.h"
#import "TimeStatusBar.h"
#import "RestTimer.h"


@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong ,nonatomic) TimeStatusBar *statusBar;


@property (strong, nonatomic) RestTimer *restTimer;

@property (strong, nonatomic) NowWindowController *nowWindow;

@end

