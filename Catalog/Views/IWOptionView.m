//
//  IWOptionView.m
//  Catalog
//
//  Created by Abel Miranda on 4/8/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWOptionView.h"

@interface IWOptionView ()

@end

@implementation IWOptionView
{
    IBOutlet UIImageView* imageView;
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
    _selected = NO;
    [self updateViewState];
    UIView* view = [[[NSBundle mainBundle] loadNibNamed:@"IWOptionView" owner:self options:nil] objectAtIndex:0];
    [self addSubview:view];
    self.frame = view.frame;
    [self updateViewState];
}

-(void)setSelected:(BOOL)selected
{
    _selected = selected;
    [self updateViewState];
}

-(void)updateViewState
{
    if (_selected) {
        [_label setBackgroundColor:[UIColor colorWithRed:0.48 green:0.48 blue:0.48 alpha:1]];
        [_label setTextColor:[UIColor whiteColor]];
    } else {
        [_label setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]];
        [_label setTextColor:[UIColor blackColor]];
    }
}

-(void)clearSelection
{
    self.selected = NO;
}

-(void)setImage:(NSString *)image
{
    _image = image;
    UIImage* img = [UIImage imageNamed:image];
    [imageView setImage:img];
}

@end
