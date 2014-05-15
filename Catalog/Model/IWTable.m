//
//  IWTable.m
//  Catalog
//
//  Created by Abel Miranda on 4/6/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWTable.h"

@implementation IWTable

-(id)init
{
    if (self = [super init]) {
        _color = [IWColor colorWithName:nil andCode:@"29" andFile:nil];
        _legsColor = [IWColor colorWithName:nil andCode:@"27" andFile:nil];
    }
    
    return self;
}

@end
