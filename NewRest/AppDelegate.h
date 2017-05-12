//
//  AppDelegate.h
//  NewRest
//
//  Created by 李嘉军 on 2017/5/11.
//  Copyright © 2017年 lli. All rights reserved.
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

