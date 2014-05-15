//
//  IWOption.m
//  Catalog
//
//  Created by Abel Miranda on 2/11/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWOption.h"

@implementation IWOption


+(id)optionWithCode:(NSString *)code description:(NSString *)description andCategory:(NSString *)category
{
    IWOption *option = [[IWOption alloc] init];
    [option setCode:code];
    [option setDescription:description];
    [option setCategory:category];
    return option;
}

@end
