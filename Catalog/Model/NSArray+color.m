//
//  NSArray+color.m
//  Catalog
//
//  Created by Abel Miranda on 5/29/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "NSArray+color.h"

@implementation NSArray (color)

-(IWColor *)colorByCode:(NSString *)code
{
    for (IWColor *color in self) {
        if ([color.code isEqualToString:code]) {
            return color;
        }
    }
    return nil;
}

@end
