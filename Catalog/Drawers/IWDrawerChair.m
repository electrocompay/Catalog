//
//  IWDrawerChair.m
//  Catalog
//
//  Created by Abel Miranda on 4/14/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWDrawerChair.h"
#import "IWChair.h"

@implementation IWDrawerChair


-(void)drawForniture:(IWForniture *)forniture
{
    [super drawForniture:forniture];
    IWChair *chair = (IWChair*) forniture;
    NSString *replaceString = @"";
    if (self.frontView) {
        replaceString = @"-B.png";
    } else {
        replaceString = @"-A.png";
    }
    NSString *filename;
    if ([chair.model.file hasSuffix:@".jpg"]){
        filename = [chair.model.file stringByReplacingOccurrencesOfString:@".jpg" withString:replaceString];
    } else {
        filename = [chair.model.file stringByReplacingOccurrencesOfString:@".png" withString:replaceString];
    }
    [self addLayer:filename];
    NSString *chairCode = [chair.model.code stringByAppendingString:replaceString];
    filename = [chairCode stringByReplacingOccurrencesOfString:@"CC" withString:chair.color.code];
    filename = [filename stringByReplacingOccurrencesOfString:@"LL" withString:@"00"];
    [self addLayer:filename];
    filename = [chairCode stringByReplacingOccurrencesOfString:@"LL" withString:chair.legsColor.code];
    filename = [filename stringByReplacingOccurrencesOfString:@"CC" withString:@"00"];
    [self addLayer:filename];
    
    if ([chair.model.name isEqualToString:@"Picasso-P"]) {
        replaceString = [NSString stringWithFormat:@"-%2@.png", chair.leatherLinerColor.code];
        filename = [filename stringByReplacingOccurrencesOfString:@".png" withString:replaceString];
        [self addLayer:filename];
    }
}

@end
