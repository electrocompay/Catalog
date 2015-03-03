//
//  IWPasswordViewViewController.m
//  Catalog
//
//  Created by Abel Miranda on 1/24/15.
//  Copyright (c) 2015 Indian Webs. All rights reserved.
//

#import "IWPasswordView.h"
#import "IWPriceManager.h"

@interface IWPasswordView ()

@end

@implementation IWPasswordView{
    
    IBOutlet UITextField *textView;
    IBOutlet UIButton *buttonValidate;
    IBOutlet UIButton *buttonRequest;
    IBOutlet UIView *leftTriangle;
    IBOutlet UIView *rightTriangle;    
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
    UIView* view = [[[NSBundle mainBundle] loadNibNamed:@"IWPasswordView" owner:self options:nil] objectAtIndex:0];
    [self addSubview:view];
    self.frame = view.frame;
    [textView.layer setCornerRadius:16.0f];
    [buttonRequest.layer setCornerRadius:16.0f];
    [buttonValidate.layer setCornerRadius:16.0f];
    [textView setText:@""];
}

-(void)showLeftTriangle{
    [leftTriangle setHidden:NO];
    [rightTriangle setHidden:YES];
}

-(void)showRightTriangle{
    [leftTriangle setHidden:YES];
    [rightTriangle setHidden:NO];
}

-(BOOL)isLeftVisible{
    return !leftTriangle.hidden;
}

-(IBAction)authenticateClick:(id)sender
{
    
    if ([[IWPriceManager getInstance] authenticate:[textView text]]) {
        if (_delegate) {
            [_delegate passwordView:self authenticateResult:YES];
        }
    }
}

@end
