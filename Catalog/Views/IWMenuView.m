//
//  IWMenuView.m
//  Catalog
//
//  Created by Abel Miranda on 4/29/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWMenuView.h"

@interface IWMenuView ()

@end

@implementation IWMenuView
{
    IBOutlet UIView* triangle;
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
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    UIView* view = [[[NSBundle mainBundle] loadNibNamed:@"IWMenuView" owner:self options:nil] objectAtIndex:0];
    [self addSubview:view];
    self.frame = view.frame;
}

-(void)setItems:(NSArray *)items
{
    _items = items;
    NSInteger position = 0;
    NSInteger buttonWidth = 150;
    NSInteger buttonHeight = 56;
    
    for (NSString* item in _items)
    {
        UIButton* button = [[UIButton alloc] init];
        [button setTitle:item forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(0, position * (buttonHeight + 1) + 25, buttonWidth, buttonHeight);
        
        UIView *colorView = [[UIView alloc] initWithFrame:button.bounds];
        [colorView setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]];
        
        UIGraphicsBeginImageContext(colorView.bounds.size);
        [colorView.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [button setBackgroundImage:colorImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(option_Clicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:position];
        [self addSubview:button];
        position++;
    }
}

-(void)option_Clicked:(UIView*)sender
{
    if (_delegate) {
        [self setHidden:YES];
        [_delegate menuView:self didClick:sender.tag];
    }
}



@end
