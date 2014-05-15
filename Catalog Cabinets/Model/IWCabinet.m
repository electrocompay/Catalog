//
//  IWCabinet.m
//  Catalog
//
//  Created by Abel Miranda on 2/11/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWCabinet.h"
#import "IWColors.h"

@implementation IWCabinet

-(id)init
{
    if (self = [super init]) {
        _color = [[IWColors cabinetColors] objectAtIndex:0];
        _legsColor = [IWColor colorWithName:nil andCode:@"27" andFile:nil];
        _top = [[IWColors cabinetColors] objectAtIndex:0];
        _side = [[IWColors cabinetColors] objectAtIndex:0];
        _legsColor = [IWColor colorWithName:nil andCode:@"22" andFile:nil];
        _colors = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)setOneColorMode:(BOOL)oneColor
{
    [_colors removeAllObjects];
    if (!oneColor) {
        NSInteger size = [[_size.name substringToIndex:1] intValue];
        for (int i = 0; i < size; i++) {
            [_colors addObject: _color];
        }
    }
}

@end
