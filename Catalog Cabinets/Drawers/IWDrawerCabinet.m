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


-(void)drawCabinet:(IWCabinet*)cabinet InPosition:(NSInteger)position andSufix:(BOOL)sufix
{
    if (!cabinet) {
        return;
    }
    
    NSString *modelCode = cabinet.model.code;
    if ([modelCode isEqualToString:@"J83"]) {
        modelCode = @"C83";
    }
    NSString *strSufix = @"";
    if (sufix)
    {
       strSufix = @"a";
    }
    NSString *mask = @"%@-%@%@-%@-%@%@-%d%@";
    NSString *modelMask = @"";
    if ([cabinet.size.code isEqualToString:@"1,0"]) {
        modelMask = @"1D";
    } else if ([cabinet.size.code isEqualToString:@"2,0"]){
        modelMask = @"2D";
    } else if ([cabinet.size.code isEqualToString:@"2,1"]){
        modelMask = @"LDD";
    } else if ([cabinet.size.code isEqualToString:@"0,3"]){
        modelMask = @"3L";
    }
    if ((position == 4 && !sufix) || (position == 3 && [modelMask isEqualToString:@"1D"])) {
        modelMask = [modelMask stringByAppendingString:@"a"];
    }
    NSString* filename;

    filename = [NSString stringWithFormat:mask, modelCode, modelMask, strSufix, cabinet.top.code, @"F", @"", position, strSufix];
    filename = [filename stringByReplacingOccurrencesOfString:@"F-" withString:@""];
    [self addLayer:filename];

    if ([cabinet.size.code isEqualToString:@"1,0"] || [cabinet.size.code isEqualToString:@"2,0"]) {
        for (int i = 0; i < cabinet.colors.count; i++) {
            IWColor *color = [cabinet.colors objectAtIndex:i];
            NSString *index = cabinet.colors.count > 1 ? [NSString stringWithFormat:@"%d", i + 1] : @"";
            if (![cabinet.size.code isEqualToString:@"2,1"]) {
                filename = [NSString stringWithFormat:mask, modelCode, modelMask, strSufix, color.code, @"F", index, position, strSufix];
                [self addLayer:filename];
            }
        }
    }
    
    
    if ([cabinet.size.code isEqualToString:@"2,1"]) {
        filename = [NSString stringWithFormat:mask, modelCode, modelMask, strSufix, ((IWColor*) [cabinet.drawers objectAtIndex:0]).code, @"F", @"1", position, strSufix];
        [self addLayer:filename];
        filename = [NSString stringWithFormat:mask, modelCode, modelMask, strSufix, ((IWColor*) [cabinet.colors objectAtIndex:0]).code,  @"F", @"2", position, strSufix];
        [self addLayer:filename];
        filename = [NSString stringWithFormat:mask, modelCode, modelMask, strSufix, ((IWColor*) [cabinet.colors objectAtIndex:1]).code,  @"F", @"3", position, strSufix];
        [self addLayer:filename];
    }
    
    if ([cabinet.size.code isEqualToString:@"0,3"]) {
        for (int i = 0; i < cabinet.drawers.count; i++) {
            IWColor *color = [cabinet.drawers objectAtIndex:i];
            NSString *index = [NSString stringWithFormat:@"%d", i + 1];
            filename = [NSString stringWithFormat:mask,  modelCode,  modelMask, strSufix, color.code, @"F", index , position, strSufix];
            [self addLayer:filename];
        }
    }
    
    
    filename = [NSString stringWithFormat:mask, modelCode, modelMask, strSufix, cabinet.top.code, @"T", @"", position, strSufix];
    [self addLayer:filename];

    
    filename = [NSString stringWithFormat:mask, modelCode, modelMask, strSufix, cabinet.side.code, @"S", @"", position, strSufix];
    [self addLayer:filename];

  /*  filename = [NSString stringWithFormat:@"%@-%dD%@-%@-T-%d%@", modelCode, cabinet.colors.count, strSufix, cabinet.top.code, position, strSufix];
    [self addLayer:filename];
    filename = [NSString stringWithFormat:@"%@-%dD%@-%@-S-%d%@", modelCode, cabinet.colors.count, strSufix, cabinet.side.code, position, strSufix];
    [self addLayer:filename];*/
  /*  filename = [NSString stringWithFormat:@"%@-%dL%@-%@-T-%d%@", modelCode, cabinet.drawers.count, strSufix, cabinet.top.code, position, strSufix];
    [self addLayer:filename];
    filename = [NSString stringWithFormat:@"%@-%dL%@-%@-S-%d%@", modelCode, cabinet.drawers.count, strSufix, cabinet.side.code, position, strSufix];
    [self addLayer:filename];*/
    
    if (cabinet.useStripe) {
        filename = [NSString stringWithFormat:@"%@-%dD%@-%@-F-%d%@", cabinet.model.code, cabinet.colors.count, strSufix, cabinet.stripe.code, position, strSufix];
        [self addLayer:filename];
        filename = [NSString stringWithFormat:@"%@-%dL%@-%@-F-%d%@", cabinet.model.code, cabinet.drawers.count, strSufix, cabinet.stripe.code, position, strSufix];
        [self addLayer:filename];
    }
}

-(void)drawForniture:(IWForniture *)forniture
{
    [super drawForniture:forniture];
    IWCabinet *cabinet = (IWCabinet*) forniture;
    NSString *filename;
    
    if (cabinet.useModules) {
        BOOL sufix = NO;
        sufix = cabinet.module2.colors.count == 1;
        [self drawCabinet:cabinet.module4 InPosition:4 andSufix:sufix];
        [self drawCabinet:cabinet.module3 InPosition:3 andSufix:sufix];
        [self drawCabinet:cabinet.module2 InPosition:2 andSufix:NO];
        [self drawCabinet:cabinet InPosition:1 andSufix:NO];
        
    } else {
        
        if (cabinet.showLegs) {
            filename = [NSString stringWithFormat:@"%@-%@%@-00-%@", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.legsColor.code];
            [self addLayer:filename];
        }
        
        for (int i = 0; i<cabinet.colors.count; i++) {
            IWColor *color = [cabinet.colors objectAtIndex:i];
            filename = [NSString stringWithFormat:@"%@-%@%@-%@-00-F%d", cabinet.model.code, cabinet.type.code, cabinet.size.code, color.code, i + 1];
            [self addLayer:filename];
        }
        
        filename = [NSString stringWithFormat:@"%@-%@%@-%@-00-T", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.top.code];
        [self addLayer:filename];
        
        filename = [NSString stringWithFormat:@"%@-%@%@-%@-00-S", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.side.code];
        [self addLayer:filename];
        
        
        
        /* WHITHOUT LEGS*/
        
        filename = [NSString stringWithFormat:@"%@-%@%@-%@", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.legsColor.code];
        [self addLayer:filename];

        if ([cabinet.model.code isEqualToString:@"C193"]) {
            filename = [NSString stringWithFormat:@"%@-%dD-29-T%@-1", cabinet.model.code, cabinet.colors.count, cabinet.interiorColor.code];
        }
        
        for (int i = 0; i<cabinet.colors.count; i++) {
            IWColor *color = [cabinet.colors objectAtIndex:i];
            /*if (i == 0) {
                filename = [NSString stringWithFormat:@"%@-%@%@-%@-F", cabinet.model.code, cabinet.type.code, cabinet.size.code, color.code];
            } else {*/
                filename = [NSString stringWithFormat:@"%@-%@%@-%@-F%d", cabinet.model.code, cabinet.type.code, cabinet.size.code, color.code, i +1];
           // }
            
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
