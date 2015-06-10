//
//  IWDrawerTable.m
//  Catalog
//
//  Created by Abel Miranda on 4/10/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWDrawerTable.h"
#import "IWTable.h"

@implementation IWDrawerTable

-(void)drawForniture:(IWForniture *)forniture
{
    [super drawForniture:forniture];
    IWTable *table = (IWTable*) forniture;
    NSString *replaceString = @"";
    if (self.frontView) {
        replaceString = @"-B.png";
    } else {
        replaceString = @"-A.png";
    }
    NSString *filename = [table.model.file stringByReplacingOccurrencesOfString:@".jpg" withString:replaceString];
    [self addLayer:filename];
    NSString *tableCode = [table.model.code stringByAppendingString:replaceString];
    filename = [tableCode stringByReplacingOccurrencesOfString:@"LL" withString:table.legsColor.code];
    filename = [filename stringByReplacingOccurrencesOfString:@"CC" withString:@"00"];
    [self addLayer:filename];
    filename = [tableCode stringByReplacingOccurrencesOfString:@"CC" withString:table.color.code];
    filename = [filename stringByReplacingOccurrencesOfString:@"LL" withString:@"00"];
    [self addLayer:filename];
}

@end
