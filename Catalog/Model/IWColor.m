//
//  IWColor.m
//  Catalog
//
//  Created by Abel Miranda on 4/7/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWColor.h"

@implementation IWColor

+(IWColor *)colorWithName:(NSString *)name andCode:(NSString *)code andFile:(NSString *)file
{
    IWColor* newColor = [[IWColor alloc] init];
    [newColor setName:name];
    [newColor setCode:code];
    [newColor setFile:file];
    return newColor;
}

-(IWColor *)withCategory:(NSString *)category
{
    self.category = category;
    return self;
}

@end
