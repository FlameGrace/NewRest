//
//  RightMenu.m
//  NewRest
//
//  Created by Flame Grace on 2017/5/19.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "RightMenu.h"

@implementation RightMenu

- (instancetype)initWithFrame:(NSRect)frameRect
{
    if(self = [super initWithFrame:frameRect])
    {
        [self saveButton];
        [self skipeButton];
        [self confirmButton];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}




- (NSButton *)confirmButton
{
    if(!_confirmButton)
    {
        _confirmButton = [[NSButton alloc]initWithFrame:CGRectMake(0, 60, 100, 30)];
        [self addSubview:_confirmButton];
        _confirmButton.title = @"休息过了";
    }
    return _confirmButton;
}


- (NSButton *)skipeButton
{
    if(!_skipeButton)
    {
        _skipeButton = [[NSButton alloc]initWithFrame:CGRectMake(0, 30, 100, 30)];
        [self addSubview:_skipeButton];
        _skipeButton.title = @"不想休息";
    }
    return _skipeButton;
}


- (NSButton *)saveButton
{
    if(!_saveButton)
    {
        _saveButton = [[NSButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        [self addSubview:_saveButton];
        _saveButton.title = @"保存美图";
    }
    return _saveButton;
}









@end
