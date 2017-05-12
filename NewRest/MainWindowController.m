//
//  MainWindowController.m
//  NewRest
//
//  Created by 李嘉军 on 2017/5/11.
//  Copyright © 2017年 lli. All rights reserved.
//

#import "MainWindowController.h"
#import "NowWindowController.h"

@interface MainWindowController () <NSWindowDelegate>


@end

@implementation MainWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    self.window.delegate = self;
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (BOOL)windowShouldClose:(id)sender
{
    [self.window miniaturize:nil];
    return NO;
}


- (void)showNowWindow
{
    [[ApplicationDelegate.nowWindow window]orderFront:nil];
    [[ApplicationDelegate.nowWindow window]center];
    [self.window orderOut:nil];
    
}

@end
