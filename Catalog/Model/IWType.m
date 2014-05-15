//
//  IWType.m
//  Catalog
//
//  Created by Abel Miranda on 2/11/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWType.h"
#import "IWOption.h"

NSArray *options;

@implementation IWType

+(NSArray *)getTypeOptionsFor:(NSString*)codeCube
{
    if ([codeCube isEqualToString:@"40"] || [codeCube isEqualToString:@"55"] || codeCube == nil) {
        return [NSArray arrayWithObjects:
                [IWOption optionWithCode:@"H" description:@"Cupboard" andCategory:@""],
                [IWOption optionWithCode:@"B" description:@"Cabinet" andCategory:@""],
                [IWOption optionWithCode:@"K" description:@"Column Cabinet" andCategory:@""],
                nil];
    } else if ([codeCube isEqualToString:@"83"])
    {
        return [NSArray arrayWithObjects:
                [IWOption optionWithCode:@"C" description:@"Cosy" andCategory:@""],
                [IWOption optionWithCode:@"J" description:@"Joli" andCategory:@""],
                nil];
    } else if ([codeCube isEqualToString:@"C193"])
    {
        return [NSArray arrayWithObjects:
                [IWOption optionWithCode:@"C" description:@"Cosy" andCategory:@""],
                [IWOption optionWithCode:@"J" description:@"Joli" andCategory:@""],
                nil];
        
    }
    return Nil;
    
}

@end
