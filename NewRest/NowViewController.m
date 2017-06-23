//
//  NowViewController.m
//  NewRest
//
//  Created by Flame Grace on 2017/5/11.
//  Copyright © 2017年 flamegrace@hotmail.com. All rights reserved.
//

#import "NowViewController.h"
#import "ShellTool.h"
#import "RightMenu.h"


//local path fot save the picture
#define RandomImageLocalPath ([NSString stringWithFormat:@"%@/Documents/ad.data",NSHomeDirectory()])
//request url
#define RandomImageHttpRequestUrl (@"https://unsplash.it/1920/1080/?random")


@interface NowViewController ()

@property (weak) IBOutlet NSImageView *imageView;
@property (assign, nonatomic) BOOL isRequestRandomImage;
@property (strong, nonatomic) RightMenu *rightMenu;

@end

@implementation NowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear
{
    [super viewWillAppear];
    [self.view setWantsLayer:YES];
    self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
    self.imageView.image = [self randomImage];
    [self updateRandomImage];
    self.rightMenu = [[RightMenu alloc]initWithFrame:CGRectZero];
    [self.rightMenu.confirmButton setTarget:self];
    [self.rightMenu.confirmButton setAction:@selector(confirm:)];
    [self.rightMenu.skipeButton setTarget:self];
    [self.rightMenu.skipeButton setAction:@selector(skip:)];
    [self.rightMenu.saveButton setTarget:self];
    [self.rightMenu.saveButton setAction:@selector(save:)];
    self.rightMenu.hidden = YES;
    self.rightMenu.layer.shadowColor = [NSColor blackColor].CGColor;
    self.rightMenu.layer.shadowRadius = 5;
    [self.view addSubview:self.rightMenu];
}


- (void)mouseDown:(NSEvent *)event
{
    [self mouseDownForEvent:event];
}

-(void)rightMouseDown:(NSEvent *)theEvent
{
    [self mouseDownForEvent:theEvent];
}

- (void)mouseDownForEvent:(NSEvent *)event
{
    BOOL hidden = NO;
    CGPoint location = event.locationInWindow;
    if(self.rightMenu.frame.origin.x == location.x && self.rightMenu.frame.origin.y == location.y)
    {
        hidden = !self.rightMenu.hidden;
    }
    else
    {
        hidden = NO;
    }
    CGRect frame = CGRectMake(location.x, location.y, 100, 90);
    self.rightMenu.frame = frame;
    self.rightMenu.hidden = hidden;
}

- (void)confirm:(id)sender {
    
    self.rightMenu.hidden = YES;
    [ApplicationDelegate.restTimer startTimer];
    [self showMainWindow];
    
}

- (void)skip:(id)sender {
    
    self.rightMenu.hidden = YES;
    [ApplicationDelegate.restTimer continueTimer];
    [self showMainWindow];
}

- (void)save:(id)sender {
    
    self.rightMenu.hidden = YES;
    NSData *imageData = [self.imageView.image TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    [imageRep setSize:[[self.imageView image] size]];
    // png
    NSData * imageData1 = [imageRep representationUsingType:NSPNGFileType properties:nil];
    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
    
    NSSavePanel*panel = [NSSavePanel savePanel];
    panel.directoryURL = [NSURL URLWithString:@"~/Desktop"];
    [panel setNameFieldStringValue:[NSString stringWithFormat:@"%.0f",time]];
    [panel setMessage:NSLocalizedString(@"Choose", nil)];
    [panel setAllowsOtherFileTypes:NO];
    [panel setAllowedFileTypes:@[@"png"]];
    [panel setExtensionHidden:YES];
    [panel setCanCreateDirectories:YES];
    [panel beginSheetModalForWindow:ApplicationDelegate.nowWindow.window completionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton)
        {
            NSString *path = [[panel URL] path];
            [imageData1 writeToFile:path atomically:YES];
        }
    }];
    
}

- (void)showMainWindow
{
    [[ApplicationDelegate.nowWindow window]orderOut:nil];
}


- (NSImage *)randomImage
{
    NSImage *image = [[NSImage alloc]initWithContentsOfFile:RandomImageLocalPath];
    return image;
}

- (void)updateRandomImage
{
    
    if(self.isRequestRandomImage)
    {
        NSLog(@"不能下载");
        return;
    }
    self.isRequestRandomImage = YES;
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        __strong typeof(weakSelf) self = weakSelf;
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:RandomImageHttpRequestUrl]];
        if(data&&data.length>0)
        {
            [data writeToFile:RandomImageLocalPath atomically:YES];
            //[self updateDesktopBackgroundImage];
        }
        self.isRequestRandomImage = NO;
        NSLog(@"下载完成");
        
    });
    
}


//如果设置桌面背景图片路径为"cd ~/Desktop;cd ../桌面.jpeg;",则会自动更换桌面
- (void)updateDesktopBackgroundImage
{
    NSString *cmd = @"cd ~/Desktop;";
    cmd = [cmd stringByAppendingString:@"cd ../;"];
    cmd = [cmd stringByAppendingString:[NSString stringWithFormat:@"cp %@ 桌面.jpeg;",RandomImageLocalPath]];
    cmd = [cmd stringByAppendingString:@"killall Dock;"];
    [ShellTool executeCmd:cmd];
}


@end
