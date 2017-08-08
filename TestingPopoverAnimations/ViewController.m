//
//  ViewController.m
//  TestingPopoverAnimations
//
//  Created by Todd Thomas on 2017-08-08.
//  Copyright © 2017 Tapbots, LLC. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"

@interface ViewController() <NSWindowDelegate>
@property (nonatomic, weak) IBOutlet NSPopUpButton *popUpButton;
@property (nonatomic, strong) TableViewController *tableViewController;
@property (nonatomic, strong) NSWindow *tableWindow;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _popUpButton.bordered = NO;
}

- (IBAction)showPopUp:(NSButton *)button
{
    NSPopover *popover = [[NSPopover alloc] init];
    popover.behavior = NSPopoverBehaviorSemitransient;
    
    if (_tableViewController == nil) {
        _tableViewController = [[TableViewController alloc] init];
    }
    
    popover.contentViewController = _tableViewController;
    //popover.delegate = self;
    //_geoSearchController.enclosingPopover = popover;
    //_geoSearchPopover = popover;
    
    [popover showRelativeToRect:button.bounds ofView:button preferredEdge:NSRectEdgeMaxY];

}

- (IBAction)showWindow:(NSButton *)button
{
    if (_tableWindow != nil) {
        [_tableWindow makeKeyAndOrderFront:nil];
        return;
    }
    
    NSWindow *window = [[NSWindow alloc] initWithContentRect:NSMakeRect(100.0, 100.0, 100.0, 100.0) styleMask:(NSWindowStyleMaskTitled | NSWindowStyleMaskClosable) backing:NSBackingStoreBuffered defer:NO];
    
    TableViewController *tableViewController = [[TableViewController alloc] init];
    window.contentViewController = tableViewController;
    
    [window makeKeyAndOrderFront:nil];
    //window.delegate = self;
    window.releasedWhenClosed = NO;
    _tableWindow = window;
}

//- (void)windowWillClose:(NSNotification *)notification
//{
//    if (_tableWindow == notification.object) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            _tableWindow.delegate = nil;
//            _tableWindow = nil;
//        });
//    }
//}

@end
