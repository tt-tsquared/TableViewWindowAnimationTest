//
//  TableViewController.m
//  TestingPopoverAnimations
//
//  Created by Todd Thomas on 2017-08-08.
//  Copyright © 2017 Tapbots, LLC. All rights reserved.
//

#import "TableViewController.h"

@interface TableCellView : NSTableCellView
@end

@interface ButtonTableCellView : NSTableCellView
@property (nonatomic, readonly) NSButton *button;
@end

@interface TableViewController() <NSTableViewDataSource, NSTableViewDelegate>
@property (nonatomic, readonly) NSTableView *tableView;
@end

@implementation TableViewController

- (void)loadView
{
    /*
    NSScrollView *scrollView = [[NSScrollView alloc] init];
    scrollView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    scrollView.hasVerticalScroller = YES;
    scrollView.hasHorizontalScroller = NO;
    [scrollView.heightAnchor constraintGreaterThanOrEqualToConstant:100.0].active = YES;
    [scrollView.heightAnchor constraintLessThanOrEqualToConstant:200.0].active = YES;
    [scrollView.widthAnchor constraintEqualToConstant:150.0].active = YES;
    
    self.view = scrollView;
    */
    
    NSTableView *tableView = [[NSTableView alloc] init];
    tableView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    //tableView.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.headerView = nil;
    //[tableView.heightAnchor constraintGreaterThanOrEqualToConstant:100.0].active = YES;
    //[tableView.heightAnchor constraintLessThanOrEqualToConstant:200.0].active = YES;
    [tableView.widthAnchor constraintEqualToConstant:150.0].active = YES;
    self.view = tableView;
    
    NSTableColumn *tableColumn = [[NSTableColumn alloc] initWithIdentifier:@"Column"];
    tableColumn.editable = YES;
    tableColumn.resizingMask = NSTableColumnAutoresizingMask;
    [tableView addTableColumn:tableColumn];
    [tableView setAllowsColumnReordering:NO];
    [tableView setAllowsColumnSelection:NO];
    [tableView setAllowsEmptySelection:YES];
    [tableView setAllowsMultipleSelection:NO];
    [tableView setAllowsTypeSelect:NO];
    [tableView setRowSizeStyle:NSTableViewRowSizeStyleCustom];
    [tableView setGridStyleMask:NSTableViewGridNone];
    [tableView setIntercellSpacing:NSMakeSize(0.0, 0.0)];
    //[scrollView setDocumentView:tableView];
    //[tableView.leadingAnchor constraintEqualToAnchor:tableView.superview.leadingAnchor].active = YES;
    //[tableView.trailingAnchor constraintEqualToAnchor:tableView.superview.trailingAnchor].active = YES;
    //[tableView.topAnchor constraintEqualToAnchor:tableView.superview.topAnchor].active = YES;
    [tableView setContentCompressionResistancePriority:NSLayoutPriorityDefaultHigh forOrientation:NSLayoutConstraintOrientationVertical];
    [tableView setContentHuggingPriority:NSLayoutPriorityDefaultHigh forOrientation:NSLayoutConstraintOrientationVertical];
    
    //NSLayoutConstraint *tableViewHeightConstraint = [scrollView.contentView.heightAnchor constraintEqualToAnchor:tableView.heightAnchor];
    //tableViewHeightConstraint.priority = NSLayoutPriorityDefaultHigh;
    //tableViewHeightConstraint.active = YES;

    tableView.dataSource = self;
    tableView.delegate = self;
    //[tableView hideRowsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(5, 5)] withAnimation:NSTableViewAnimationEffectNone];
    _tableView = tableView;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return 11;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    if (row == 10) {
        ButtonTableCellView *buttonCell = (ButtonTableCellView *)[tableView makeViewWithIdentifier:@"ButtonCell" owner:self];
        if (buttonCell == nil) {
            buttonCell = [[ButtonTableCellView alloc] init];
            buttonCell.identifier = @"ButtonCell";
            buttonCell.button.title = @"Show/Hide";
            buttonCell.button.target = self;
            buttonCell.button.action = @selector(_showHideRows:);
        }
        
        return buttonCell;
    }
    
    TableCellView *cell = (TableCellView *)[tableView makeViewWithIdentifier:@"TableCell" owner:self];
    if (cell == nil) {
        cell = [[TableCellView alloc] init];
        cell.identifier = @"TableCell";
    }

    cell.textField.stringValue = [NSString stringWithFormat:@"row %ld", (long)row];
    return cell;
}

- (void)_showHideRows:(NSButton *)button
{
    if (_tableView.hiddenRowIndexes.count == 0) {
        [_tableView hideRowsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(5, 5)] withAnimation:NSTableViewAnimationEffectFade];
    }
    else {
        [_tableView unhideRowsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(5, 5)] withAnimation:NSTableViewAnimationEffectFade];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"tableview intrinsicSize: %@", NSStringFromSize(_tableView.intrinsicContentSize));
    });
}

@end

@implementation TableCellView

- (instancetype)initWithFrame:(NSRect)frameRect
{
    if ((self = [super initWithFrame:frameRect]) != nil) {
        NSTextField *label = [NSTextField labelWithString:@""];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.backgroundColor = [NSColor whiteColor];
        [self addSubview:label];
        [label.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10.0].active = YES;
        [label.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
        self.textField = label;
    }
    
    return self;
}

@end

@implementation ButtonTableCellView

- (instancetype)initWithFrame:(NSRect)frameRect
{
    if ((self = [super initWithFrame:frameRect]) != nil) {
        NSButton *button = [[NSButton alloc] init];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setButtonType:NSButtonTypeMomentaryChange];
        [self addSubview:button];
        [button.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10.0].active = YES;
        [button.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
        _button = button;
    }
    
    return self;
}

@end
