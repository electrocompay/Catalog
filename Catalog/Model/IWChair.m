//
//  IWChair.m
//  Catalog
//
//  Created by Abel Miranda on 4/6/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWChair.h"

@implementation IWChair

- (instancetype)init
{
    self = [super init];
    if (self) {
        _color = [IWColor colorWithName:nil andCode:@"01" andFile:nil];
        _legsColor = [IWColor colorWithName:nil andCode:@"27" andFile:nil];
        _leatherLinerColor = [IWColor colorWithName:nil andCode:@"01" andFile:nil];
    }
    return self;
}

@end
