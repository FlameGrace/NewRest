//
//  NowViewController.m
//  NewRest
//
//  Created by 李嘉军 on 2017/5/11.
//  Copyright © 2017年 lli. All rights reserved.
//

#import "NowViewController.h"


//local path fot save the picture
#define RandomImageLocalPath ([NSString stringWithFormat:@"%@/Documents/ad.data",NSHomeDirectory()])
//request url
#define RandomImageHttpRequestUrl (@"https://unsplash.it/1920/1080/?random")


@interface NowViewController ()

@property (weak) IBOutlet NSImageView *imageView;
@property (assign, nonatomic) BOOL isRequestRandomImage;

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
}

- (IBAction)confirm:(id)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:ConfirmNotificationName object:nil];
    [self showMainWindow];
}

- (IBAction)skip:(id)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:SkipNotificationName object:nil];
    [self showMainWindow];
}

- (void)showMainWindow
{
    [[ApplicationDelegate.mainWindow window]center];
    [[ApplicationDelegate.mainWindow window]orderFront:nil];
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
        }
        self.isRequestRandomImage = NO;
        NSLog(@"下载完成");
        
    });
    
}















@end
