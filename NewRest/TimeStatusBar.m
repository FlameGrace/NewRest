//
//  TimeStatusItem.m
//  NewRest
//
//  Created by Flame Grace on 2017/5/12.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "TimeStatusBar.h"


@interface TimeObject : NSObject

@property (assign,nonatomic) NSTimeInterval restTime;
@property (strong,nonatomic) NSString *title;

+ (instancetype)objectWithRestTime:(NSTimeInterval)restTime title:(NSString *)title;

@end

@implementation TimeObject

+ (instancetype)objectWithRestTime:(NSTimeInterval)restTime title:(NSString *)title
{
    TimeObject *object = [[TimeObject alloc]init];
    object.restTime = restTime;
    object.title = title;
    return object;
}

@end


@interface TimeStatusBar()

@property (strong,nonatomic) NSMutableArray *edits;
@property (strong,nonatomic) NSMenu *editSubMenu;

@end



@implementation TimeStatusBar

- (instancetype)init
{
    if(self = [super init])
    {
        self.item = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
        self.item.title = @"0:00";
        self.item.target = self;
        NSMenu *cMenu = [[NSMenu alloc] init];
        self.item.menu = cMenu;
        [self insertPause];
        [self insertEdit];
        [self insertQuit];
        
    }
    return self;
}




-(void)quit:(id)sender
{
    [NSApp terminate:self];
}

-(void)pause:(id)sender
{
    [ApplicationDelegate.restTimer pauseTimer];
    [self.item.menu removeAllItems];
    [self insertContinue];
    [self insertEdit];
    [self insertQuit];
}

-(void)continueT:(id)sender
{
    [ApplicationDelegate.restTimer continueTimer];
    [self.item.menu removeAllItems];
    [self insertPause];
    [self insertEdit];
    [self insertQuit];
}

-(void)edit:(id)sender
{
    
}




-(void)editRestTime:(id)sender
{
    NSMenuItem *item = (NSMenuItem*)sender;
    NSInteger index = [self.editSubMenu indexOfItem:item];
    TimeObject *object = self.edits[index];
    ApplicationDelegate.restTimer.restTime = object.restTime;
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",object.restTime] forKey:@"restTime"];
    
    [self.item.menu removeAllItems];
    [self insertPause];
    [self insertEdit];
    [self insertQuit];

}



- (void)insertPause
{
    NSMenuItem *item = [[NSMenuItem alloc]init];
    item.title = NSLocalizedString(@"Pause", nil);
    [item setTarget:self];
    [item setAction:@selector(pause:)];
    [self.item.menu addItem:item];
    
}

- (void)insertEdit
{
    NSMenu *subMenu = [[NSMenu alloc] init];
    
    NSString *restTimeString = [[NSUserDefaults standardUserDefaults]objectForKey:@"restTime"];
    NSTimeInterval restTime = restTimeString.doubleValue;
    
    for (TimeObject *object in self.edits)
    {
        NSMenuItem *subItem = [[NSMenuItem alloc]init];
        subItem.title = object.title;
        [subItem setTarget:self];
        [subItem setAction:@selector(editRestTime:)];
        if(object.restTime == restTime)
        {
            subItem.state = 1;
        }
        [subMenu addItem:subItem];
    }
    
    NSMenuItem *item = [[NSMenuItem alloc]init];
    item.title = NSLocalizedString(@"Edit", nil);
    self.editSubMenu = subMenu;
    [item setSubmenu:subMenu];
    [item setTarget:self];
    [item setAction:@selector(edit:)];
    [self.item.menu addItem:item];
    
}

- (void)insertQuit
{
    NSMenuItem *item = [[NSMenuItem alloc]init];
    item.title = NSLocalizedString(@"Quit", nil);
    [item setTarget:self];
    [item setAction:@selector(quit:)];
    [self.item.menu addItem:item];
}

- (void)insertContinue
{
    NSMenuItem *pause = [[NSMenuItem alloc]init];
    pause.title = NSLocalizedString(@"Continue", nil);
    [pause setTarget:self];
    [pause setAction:@selector(continueT:)];
    [self.item.menu addItem:pause];
}

- (NSMutableArray *)edits
{
    if(!_edits)
    {
        _edits = [[NSMutableArray alloc]init];
        TimeObject *ten = [TimeObject objectWithRestTime:10*60 title:NSLocalizedString(@"10 minutes", nil)];
        [_edits addObject:ten];
        TimeObject *five = [TimeObject objectWithRestTime:15*60 title:NSLocalizedString(@"15 minutes", nil)];
        [_edits addObject:five];
        TimeObject *three = [TimeObject objectWithRestTime:30*60 title:NSLocalizedString(@"30 minutes", nil)];
        [_edits addObject:three];
        TimeObject *d = [TimeObject objectWithRestTime:45*60 title:NSLocalizedString(@"45 minutes", nil)];
        [_edits addObject:d];
        TimeObject *one = [TimeObject objectWithRestTime:60*60 title:NSLocalizedString(@"1 hour", nil)];
        [_edits addObject:one];
        TimeObject *two = [TimeObject objectWithRestTime:2*60*60 title:NSLocalizedString(@"2 hours", nil)];
        [_edits addObject:two];
        TimeObject *four = [TimeObject objectWithRestTime:4*60*60 title:NSLocalizedString(@"4 hours", nil)];
        [_edits addObject:four];
    }
    return _edits;
}


@end
