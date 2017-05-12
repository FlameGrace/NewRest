//
//  AppDelegate.m
//  NewRest
//
//  Created by 李嘉军 on 2017/5/11.
//  Copyright © 2017年 lli. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    self.mainWindow = [MainStoryBoard instantiateControllerWithIdentifier:@"MainWindow"];
    [[self.mainWindow window]center];
    [[self.mainWindow window]orderFront:nil];
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
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
