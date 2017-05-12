//
//  AppDelegate.h
//  NewRest
//
//  Created by 李嘉军 on 2017/5/11.
//  Copyright © 2017年 lli. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainWindowController.h"
#import "NowWindowController.h"



@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong, nonatomic) MainWindowController *mainWindow;

@property (strong, nonatomic) NowWindowController *nowWindow;

@end

