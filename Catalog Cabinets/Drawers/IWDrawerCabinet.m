//
//  IWDrawerCabinet.m
//  Catalog
//
//  Created by Abel Miranda on 2/11/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWDrawerCabinet.h"
#import "IWCabinet.h"

@implementation IWDrawerCabinet


-(void)drawCabinet:(IWCabinet*)cabinet InPosition:(NSInteger)position andSufix:(NSString*)sufix
{
    NSString *mask = @"%@-%@%@-%@-F%@-%d%@";
    NSString *modelMask;
    if ([cabinet.size.code isEqualToString:@"1,0"]) {
        modelMask = @"1D";
    } else if ([cabinet.size.code isEqualToString:@"2,0"]){
        modelMask = @"2D";
    } else if ([cabinet.size.code isEqualToString:@"2,1"]){
        modelMask = @"LDD";
    } else if ([cabinet.size.code isEqualToString:@"3,0"]){
        modelMask = @"3L";
    }
    NSString* filename;
    for (int i = 0; i < cabinet.colors.count; i++) {
        IWColor *color = [cabinet.colors objectAtIndex:i];
        NSString *index = cabinet.colors.count > 1 ? [NSString stringWithFormat:@"%d", i + 1] : @"";
        if (![cabinet.size.code isEqualToString:@"2,1"]) {
            filename = [NSString stringWithFormat:mask, cabinet.model.code, modelMask, sufix, color.code, index, position, sufix];
            [self addLayer:filename];
        }
        if ([cabinet.size.code isEqualToString:@"2,1"]) {
            filename = [NSString stringWithFormat:@"%@-LDD%@-%@-F%d-%d%@", cabinet.model.code, sufix, color.code, i + 2, position, sufix];
            [self addLayer:filename];
        }
    }
    
    
    for (int i = cabinet.drawers.count - 1; i > -1; i--) {
        IWColor *color = [cabinet.drawers objectAtIndex:i];
        filename = [NSString stringWithFormat:@"%@-%dL%@-%@-F%d-%d%@", cabinet.model.code, cabinet.drawers.count, sufix, color.code, i + 1, position, sufix];
        [self addLayer:filename];
        if ([cabinet.size.code isEqualToString:@"2,1"]) {
            filename = [NSString stringWithFormat:@"%@-LDD%@-%@-F%d-%d%@", cabinet.model.code, sufix, color.code,  i + 1, position, sufix];
            [self addLayer:filename];
        }
    }
    
    filename = [NSString stringWithFormat:@"%@-%dD%@-%@-T-%d%@", cabinet.model.code, cabinet.colors.count, sufix, cabinet.top.code, position, sufix];
    [self addLayer:filename];
    filename = [NSString stringWithFormat:@"%@-%dD%@-%@-S-%d%@", cabinet.model.code, cabinet.colors.count, sufix, cabinet.side.code, position, sufix];
    [self addLayer:filename];
    filename = [NSString stringWithFormat:@"%@-%dL%@-%@-T-%d%@", cabinet.model.code, cabinet.drawers.count, sufix, cabinet.top.code, position, sufix];
    [self addLayer:filename];
    filename = [NSString stringWithFormat:@"%@-%dL%@-%@-S-%d%@", cabinet.model.code, cabinet.drawers.count, sufix, cabinet.side.code, position, sufix];
    [self addLayer:filename];
    
}

-(void)drawForniture:(IWForniture *)forniture
{
    [super drawForniture:forniture];
    IWCabinet *cabinet = (IWCabinet*) forniture;
    NSString *filename;
    
    if (cabinet.useModules) {
        NSString *sufix = @"";
        [self drawCabinet:cabinet InPosition:1 andSufix:@""];
        [self drawCabinet:cabinet.module2 InPosition:2 andSufix:sufix];
        if (cabinet.module2.colors.count == 1) {
            sufix = @"a";
        }
        [self drawCabinet:cabinet.module3 InPosition:3 andSufix:sufix];
        if (cabinet.module3.colors.count == 1) {
            sufix = @"a";
        }
        [self drawCabinet:cabinet.module4 InPosition:4 andSufix:sufix];
        
    } else {
        
        filename = [NSString stringWithFormat:@"%@-%@%@-00-%@", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.legsColor.code];
        [self addLayer:filename];
        
        for (int i = 0; i<cabinet.colors.count; i++) {
            IWColor *color = [cabinet.colors objectAtIndex:i];
            if (i == 0 ) {
                filename = [NSString stringWithFormat:@"%@-%@%@-%@-00-F", cabinet.model.code, cabinet.type.code, cabinet.size.code, color.code];
            } else {
                filename = [NSString stringWithFormat:@"%@-%@%@-%@-00-F%d", cabinet.model.code, cabinet.type.code, cabinet.size.code, color.code, i];
            }
            [self addLayer:filename];
        }
        
        filename = [NSString stringWithFormat:@"%@-%@%@-%@-00-T", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.top.code];
        [self addLayer:filename];
        
        filename = [NSString stringWithFormat:@"%@-%@%@-%@-00-S", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.side.code];
        [self addLayer:filename];
        
        
        
        /* WHITHOUT LEGS*/
        
        filename = [NSString stringWithFormat:@"%@-%@%@-%@", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.legsColor.code];
        [self addLayer:filename];
        
        
        for (int i = 0; i<cabinet.colors.count; i++) {
            IWColor *color = [cabinet.colors objectAtIndex:i];
            if (i == 0) {
                filename = [NSString stringWithFormat:@"%@-%@%@-%@-F", cabinet.model.code, cabinet.type.code, cabinet.size.code, color.code];
            } else {
                filename = [NSString stringWithFormat:@"%@-%@%@-%@-F%d", cabinet.model.code, cabinet.type.code, cabinet.size.code, color.code, i];
            }
            
            if ([cabinet.model.code isEqualToString:@"C193"]) {
                filename = [NSString stringWithFormat:@"%@-%dD-%@-T", cabinet.model.code, cabinet.colors.count, cabinet.top.code];
                [self addLayer:filename];
                if (cabinet.colors.count == 1) {
                    filename = [NSString stringWithFormat:@"%@-%dD-%@-F", cabinet.model.code, cabinet.colors.count, color.code];
                } else {
                    filename = [NSString stringWithFormat:@"%@-%dD-%@-F%d", cabinet.model.code, cabinet.colors.count, color.code, i + 1];
                }
                [self addLayer:filename];
                filename = [NSString stringWithFormat:@"%@-%dD-%@-S", cabinet.model.code, cabinet.colors.count, cabinet.side.code];
                [self addLayer:filename];
                filename = [NSString stringWithFormat:@"%@-%dD-29-T%@-V", cabinet.model.code, cabinet.colors.count, cabinet.interiorColor.code];
                [self addLayer:filename];
            }
            [self addLayer:filename];
        }
        
        filename = [NSString stringWithFormat:@"%@-%@%@-%@-T", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.top.code];
        [self addLayer:filename];
        
        filename = [NSString stringWithFormat:@"%@-%@%@-%@-S", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.side.code];
        [self addLayer:filename];
    }
    
}

@end
