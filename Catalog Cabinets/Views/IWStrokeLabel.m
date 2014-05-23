//
//  IWStrokeLabel.m
//  Catalog
//
//  Created by Abel Miranda on 5/22/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWStrokeLabel.h"

@interface IWStrokeLabel ()

@end

@implementation IWStrokeLabel
{
    IBOutlet UIView *stroke;
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
    UIView* view = [[[NSBundle mainBundle] loadNibNamed:@"IWStrokeLabel" owner:self options:nil] objectAtIndex:0];
    [self addSubview:view];
    self.frame = view.frame;
}

-(void)setEnabled:(BOOL)enabled
{
    [stroke setHidden:!enabled];
}

@end
