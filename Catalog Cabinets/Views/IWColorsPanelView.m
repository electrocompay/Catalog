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
    IBOutlet IWColorSelectorView *picDrawer1;
    IBOutlet IWColorSelectorView *picDrawer2;
    IBOutlet IWColorSelectorView *picDrawer3;
    IBOutlet IWColorSelectorView *door1;
    IBOutlet IWColorSelectorView *door2;
    IBOutlet IWColorSelectorView *door3;
    IBOutlet IWColorSelectorView *door4;
    IBOutlet IWColorSelectorView *door5;
    IBOutlet IWColorSelectorView *door6;
    IBOutlet IWColorSelectorView *door7;
    IBOutlet IWColorSelectorView *door8;
    IBOutlet IWColorSelectorView *door9;
    IBOutlet IWColorSelectorView *stripe;
}


-(id)initWithNibName:(NSString*)nibName
{
    self = [super init];
    if (self) {
        container = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:0];
        [self addSubview:container];
        self.frame = container.frame;
        
        picDrawer1.delegate = self;
        picDrawer2.delegate = self;
        picDrawer3.delegate = self;
        door1.delegate = self;
        door2.delegate = self;
        door3.delegate = self;
        door4.delegate = self;
        door5.delegate = self;
        door6.delegate = self;
        door7.delegate = self;
        door8.delegate = self;
        door9.delegate = self;
        stripe.delegate = self;
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

+(IWColorsPanelView *)colorsPanelModuleDoors
{
    IWColorsPanelView* panelView = [[IWColorsPanelView alloc] initWithNibName:@"IWColorsPanelModuleView"];
    return panelView;
}

-(void)setColorToSelection:(IWColor*)color
{
    
    if (!_cabinet.useModules) {
        
        if (_cabinet.colors.count > 0 && (door1.selected || _cabinet.oneColorMode)) {
            [_cabinet.colors replaceObjectAtIndex:0 withObject:color];
            door1.color = color;
        }
        if (_cabinet.colors.count > 1 && (door2.selected || _cabinet.oneColorMode)) {
            [_cabinet.colors replaceObjectAtIndex:1 withObject:color];
            door2.color = color;
        }
        
        if (_cabinet.colors.count > 2 && (door3.selected || _cabinet.oneColorMode)) {
            [_cabinet.colors replaceObjectAtIndex:2 withObject:color];
            door3.color = color;
        }
        if (_cabinet.colors.count > 3 && (door4.selected || _cabinet.oneColorMode)) {
            [_cabinet.colors replaceObjectAtIndex:3 withObject:color];
            door4.color = color;
        }
        if (_cabinet.colors.count > 4 && (door5.selected || _cabinet.oneColorMode)) {
            [_cabinet.colors replaceObjectAtIndex:4 withObject:color];
            door5.color = color;
        }
        if (_cabinet.colors.count > 5 && (door6.selected || _cabinet.oneColorMode)) {
            [_cabinet.colors replaceObjectAtIndex:5 withObject:color];
            door6.color = color;
        }
        if (_cabinet.colors.count > 6 && (door7.selected || _cabinet.oneColorMode)) {
            [_cabinet.colors replaceObjectAtIndex:6 withObject:color];
            door7.color = color;
        }
        if (_cabinet.colors.count > 7 && (door8.selected || _cabinet.oneColorMode)) {
            [_cabinet.colors replaceObjectAtIndex:7 withObject:color];
            door8.color = color;
        }
        if (_cabinet.colors.count > 8 && (door9.selected || _cabinet.oneColorMode)) {
            [_cabinet.colors replaceObjectAtIndex:8 withObject:color];
            door9.color = color;
        }
    } else {
        NSInteger selectedTag = 0;
        for (UIView *sview in container.subviews) {
            if ([sview isKindOfClass:[IWColorSelectorView class]]) {
                IWColorSelectorView *selector = (IWColorSelectorView*) sview;
                if (selector.selected) {
                    selectedTag = selector.tag;
                    break;
                }
            }
        }
        if (selectedTag < 2) {
            if (_cabinet.colors.count > 0 && (door1.selected || _cabinet.oneColorMode)) {
                [_cabinet.colors replaceObjectAtIndex:0 withObject:color];
                door1.color = color;
            }
            if (_cabinet.colors.count > 1 && (door2.selected || _cabinet.oneColorMode)) {
                [_cabinet.colors replaceObjectAtIndex:1 withObject:color];
                door2.color = color;
            }
        } else if (selectedTag < 5) {
        if (_cabinet.drawers.count > 0 && (picDrawer1.selected || _cabinet.oneColorMode)) {
            [_cabinet.drawers replaceObjectAtIndex:0 withObject:color];
            picDrawer1.color = color;
        }
        if (_cabinet.drawers.count > 1 && (picDrawer2.selected || _cabinet.oneColorMode)) {
            [_cabinet.drawers replaceObjectAtIndex:1 withObject:color];
            picDrawer2.color = color;
        }
        if (_cabinet.drawers.count > 2 && (picDrawer3.selected || _cabinet.oneColorMode)) {
            [_cabinet.drawers replaceObjectAtIndex:2 withObject:color];
            picDrawer3.color = color;
        } } else {
        if (stripe.selected) {
            _cabinet.stripe = color;
            stripe.color = color;
        }}
    }
    
    if (_delegate) {
        [_delegate didChange:self];
    }
}

-(void)setCabinet:(IWCabinet *)cabinet
{
    _cabinet = cabinet;
    [self updateLayout];
}

-(void)updateLayout
{
    if (_cabinet.colors.count > 0) {
        door1.enabled = YES;
        door1.color = [_cabinet.colors objectAtIndex:0];
    } else {
        door1.enabled = NO;
    }
    
    if (_cabinet.colors.count > 1 && ![_cabinet oneColorMode]) {
        door2.enabled = YES;
        door2.color = [_cabinet.colors objectAtIndex:1];
    } else {
        door2.enabled = NO;
    }
    if (_cabinet.colors.count > 2 && ![_cabinet oneColorMode]) {
        door3.enabled = YES;
        door3.color = [_cabinet.colors objectAtIndex:2];
    } else {
        door3.enabled = NO;
    }
    if (_cabinet.colors.count > 3 && ![_cabinet oneColorMode]) {
        door4.enabled = YES;
        door4.color = [_cabinet.colors objectAtIndex:3];
    } else {
        door4.enabled = NO;
    }
    if (_cabinet.colors.count > 4 && ![_cabinet oneColorMode]) {
        door5.enabled = YES;
        door5.color = [_cabinet.colors objectAtIndex:4];
    } else {
        door5.enabled = NO;
    }
    if (_cabinet.colors.count > 5 && ![_cabinet oneColorMode]) {
        door6.enabled = YES;
        door6.color = [_cabinet.colors objectAtIndex:5];
    } else {
        door6.enabled = NO;
    }
    if (_cabinet.colors.count > 6 && ![_cabinet oneColorMode]) {
        door7.enabled = YES;
        door7.color = [_cabinet.colors objectAtIndex:6];
    } else {
        door7.enabled = NO;
    }
    if (_cabinet.colors.count > 7 && ![_cabinet oneColorMode]) {
        door8.enabled = YES;
        door8.color = [_cabinet.colors objectAtIndex:7];
    } else {
        door8.enabled = NO;
    }
    if (_cabinet.colors.count > 8 && ![_cabinet oneColorMode]) {
        door9.enabled = YES;
        door9.color = [_cabinet.colors objectAtIndex:8];
    } else {
        door9.enabled = NO;
    }
    
    if ([_cabinet useModules]) {
        if (_cabinet.drawers.count > 0) {
            picDrawer1.enabled = YES;
            picDrawer1.color = [_cabinet.drawers objectAtIndex:0];
        } else {
            picDrawer1.enabled = NO;
        }
        if (_cabinet.drawers.count > 1 && !_cabinet.oneColorMode) {
            picDrawer2.enabled = YES;
            picDrawer2.color = [_cabinet.drawers objectAtIndex:1];
        } else {
            picDrawer2.enabled = NO;
        }
        if (_cabinet.drawers.count > 2 && !_cabinet.oneColorMode) {
            picDrawer3.enabled = YES;
            picDrawer3.color = [_cabinet.drawers objectAtIndex:2];
        } else {
            picDrawer3.enabled = NO;
        }
        if (_cabinet.colors.count > 0) {
            door1.enabled = YES;
            door1.color = [_cabinet.colors objectAtIndex:0];
        } else {
            door1.enabled = NO;
        }
        if (_cabinet.colors.count > 1 && !_cabinet.oneColorMode) {
            door2.enabled = YES;
            door2.color = [_cabinet.colors objectAtIndex:1];
        } else {
            door2.enabled = NO;
        }
        
        stripe.enabled = _cabinet.useStripe;
    }
}

-(void)setOneSelectionMode:(BOOL)oneSelectionMode
{
    _oneSelectionMode = oneSelectionMode;
    [_cabinet setOneColorMode:_oneSelectionMode];
    [self updateLayout];
}

-(void)colorSelectorView:(IWColorSelectorView *)colorSelectorView didSelection:(UIView *)view
{
    if (_delegate) {
        [_delegate didChange:self didSelectButton:view.tag];
    }
}

@end
