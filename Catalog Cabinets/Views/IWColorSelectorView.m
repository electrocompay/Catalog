//
//  IWColorSelectorView.m
//  Catalog
//
//  Created by Abel Miranda on 5/12/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWColorSelectorView.h"

@interface IWColorSelectorView ()

@end

@implementation IWColorSelectorView
{
    IBOutlet UIButton *button;
    IBOutlet UIImageView *imageView;
    
}

-(id)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)initialize
{
    UIView* view = [[[NSBundle mainBundle] loadNibNamed:@"IWColorSelectorView" owner:self options:nil] objectAtIndex:0];
    [self addSubview:view];
    self.frame = view.frame;
    self.enabled = YES;
}

-(void)setColor:(IWColor *)color
{
    _color = color;
    [imageView setImage:[UIImage imageNamed:color.file]];
    if (_color) {
        [button setTitle:_color.name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    }
    [self updateButton];
}

-(void)updateButton
{
    if (button.selected) {
        for (UIView *view in self.superview.subviews) {
            if (view != self && [view isKindOfClass:[IWColorSelectorView class]]) {
                IWColorSelectorView *selector = (IWColorSelectorView*) view;
                [selector unSelect];
            }
        }
        [button setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1]];
    } else {
        [button setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]];
    }
    [button setHidden:!_enabled];
    [imageView setHidden:!_enabled];
}

-(IBAction)button_click:(id)sender
{
    button.selected = YES;
    [self updateButton];
}

-(void)unSelect
{
    button.selected = NO;
    [self updateButton];
}

-(void)setSelected:(BOOL)selected
{
    button.selected = selected;
}

-(BOOL)selected
{
    return button.selected;
}

-(void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    [self updateButton];
}



@end
