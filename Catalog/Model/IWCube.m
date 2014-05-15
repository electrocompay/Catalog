//
//  IWCube.m
//  Catalog
//
//  Created by Abel Miranda on 2/11/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWCube.h"
#import "IWOption.h"

NSArray *options;

@implementation IWCube


+(NSArray *)getOptions
{
    if (!options) {
        options = [NSArray arrayWithObjects:
                   [IWOption optionWithCode:@"40" description:@"Cube 40" andCategory:@""],
                   [IWOption optionWithCode:@"55" description:@"Cube 55" andCategory:@""],
                   [IWOption optionWithCode:@"83" description:@"Cube 83" andCategory:@""],
                   [IWOption optionWithCode:@"C193" description:@"Cube 193" andCategory:@""],
                   nil];
    }
    
    return options;
}

@end
