//
//  IWColorsPanelView.m
//  Catalog
//
//  Created by Abel Miranda on 5/13/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWColorsPanelView.h"
#import "IWColorSelectorView.h"

@interface IWColorsPanelView ()

@end

@implementation IWColorsPanelView
{
    UIView *container;
}


-(id)initWithNibName:(NSString*)nibName
{
    self = [super init];
    if (self) {
        container = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:0];
        [self addSubview:container];
        self.frame = container.frame;
    }
    return self;
}

+(IWColorsPanelView *)colorsPanelFourDoors
{
    IWColorsPanelView* panelView = [[IWColorsPanelView alloc] initWithNibName:@"IWColorsPanelFourDoorsView"];
    return panelView;
}

+(IWColorsPanelView *)colorsPanelNineDoors
{
    IWColorsPanelView* panelView = [[IWColorsPanelView alloc] initWithNibName:@"IWColorsPanelNineDoorsView"];
    return panelView;
}

-(void)setColorToSelection:(IWColor *)color
{
    if (_oneSelectionMode) {
        _cabinet.color = color;
        
    } else {
        for (UIView *view in container.subviews) {
            if ([view isKindOfClass:[IWColorSelectorView class]]) {
                IWColorSelectorView *selector = (IWColorSelectorView*) view;
                if (selector.selected) {
                    selector.color = color;
                    [_cabinet.colors replaceObjectAtIndex:selector.tag withObject:color];
                }
            }
        }
    }
    if (_delegate) {
        [_delegate didChange:self];
    }
}

-(void)setCabinet:(IWCabinet *)cabinet
{
    _cabinet = cabinet;
    self.oneSelectionMode = _cabinet.colors.count == 0;
    [self updateLayout];
}

-(void)updateLayout
{
    BOOL selectionDone = FALSE;
    for (UIView *view in container.subviews) {
        if ([view isKindOfClass:[IWColorSelectorView class]]) {
            IWColorSelectorView *selector = (IWColorSelectorView*) view;
            if (selector.tag < _cabinet.colors.count) {
                selector.color = [_cabinet.colors objectAtIndex:selector.tag];
                [selector setEnabled:YES];
                if (!selectionDone) {
                    [selector setSelected:YES];
                    selectionDone = YES;
                }
            } else {
                [selector setEnabled:NO];
            }
            if (selector.tag == 0 && _oneSelectionMode) {
                [selector setEnabled:YES];
                selector.color = _cabinet.color;
            }
        }
    }
}

-(void)setOneSelectionMode:(BOOL)oneSelectionMode
{
    BOOL updateState = YES; //_oneSelectionMode != oneSelectionMode;
    _oneSelectionMode = oneSelectionMode;
    if (updateState) {
        if (_oneSelectionMode) {
            for (UIView *view in container.subviews) {
                if ([view isKindOfClass:[IWColorSelectorView class]]) {
                    IWColorSelectorView *selector = (IWColorSelectorView*) view;
                    if (selector.tag > 0) {
                        [selector setEnabled:NO];
                    } else {
                        [selector setEnabled:YES];
                    }
                }
            }
            [_cabinet setOneColorMode:YES];
        } else{
            [_cabinet setOneColorMode:NO];
            [self updateLayout];
        }
    }
}

@end
