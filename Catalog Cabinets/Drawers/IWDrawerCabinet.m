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
{
    NSInteger _activeModule;
    BOOL _doAnimate;
}

-(id)init
{
    self = [super init];
    if (self) {
        _activeModule = -1;
        _doAnimate = NO;
    }
    return self;
}


-(void)drawCabinet:(IWCabinet*)cabinet InPosition:(NSInteger)position andSufix:(BOOL)sufix
{
    if (!cabinet) {
        return;
    }
    
    _doAnimate =  position == _activeModule;
    
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

    filename = [NSString stringWithFormat:mask, modelCode, modelMask, strSufix, @"29", @"F", @"", position, strSufix];
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

    if (cabinet.useStripe) {
        filename = [NSString stringWithFormat:mask, modelCode, modelMask, strSufix, cabinet.stripe.code, @"F", @"", position, strSufix];
        filename = [filename stringByReplacingOccurrencesOfString:@"C83" withString:@"J83"];
        [self addLayer:filename];
        filename = [NSString stringWithFormat:@"%@-%ldD%@-%@-F-%ld%@", cabinet.model.code, (long)cabinet.colors.count, strSufix, cabinet.stripe.code, position, strSufix];
        [self addLayer:filename];
        filename = [NSString stringWithFormat:@"%@-%ldL%@-%@-F-%ld%@", cabinet.model.code, (long)cabinet.drawers.count, strSufix, cabinet.stripe.code, position, strSufix];
        [self addLayer:filename];
    }
    
    if (_doAnimate) {
        filename = [NSString stringWithFormat:mask, modelCode, modelMask, strSufix, cabinet.top.code, @"TR", @"", position, strSufix];
        NSString *filename2 = [NSString stringWithFormat:@"%@-%@%@-%ld%@", modelCode, modelMask, strSufix, (long)position, strSufix];
        [self addLayer:filename2];
        UIView *trView = [self addLayer:filename];
        [UIView animateWithDuration:0.3 animations:^(void) {
            trView.alpha = 0.9;
            trView.alpha = 0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.8 animations:^(void) {
                trView.alpha = 0.9;
                trView.alpha = 0;
            }];
        }];
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
        _activeModule = -1;
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
            filename = [NSString stringWithFormat:@"%@-%luD-29-T%@", cabinet.model.code, (unsigned long)cabinet.colors.count, @"34"];
            [self addLayer:filename];
        }
        
        for (int i = 0; i<cabinet.colors.count; i++) {
            IWColor *color = [cabinet.colors objectAtIndex:i];
                filename = [NSString stringWithFormat:@"%@-%@%@-%@-F%d", cabinet.model.code, cabinet.type.code, cabinet.size.code, color.code, i +1];
            
            if ([cabinet.model.code isEqualToString:@"C193"]) {
                filename = [NSString stringWithFormat:@"%@-%luD-%@-T", cabinet.model.code, (unsigned long)cabinet.colors.count, cabinet.top.code];
                [self addLayer:filename];
                if (cabinet.colors.count == 1) {
                    filename = [NSString stringWithFormat:@"%@-%luD-%@-F", cabinet.model.code, cabinet.colors.count, color.code];
                } else {
                    filename = [NSString stringWithFormat:@"%@-%luD-%@-F%d", cabinet.model.code, cabinet.colors.count, color.code, i + 1];
                }
                [self addLayer:filename];
                filename = [NSString stringWithFormat:@"%@-%luD-%@-S", cabinet.model.code, cabinet.colors.count, cabinet.side.code];
                [self addLayer:filename];
                [self addLayer:filename];
            }
            [self addLayer:filename];
        }

        if ([cabinet.model.code isEqualToString:@"C193"]) {
            for (int i = 0; i<cabinet.interiorColors.count; i++) {
                IWColor *color = [cabinet.interiorColors objectAtIndex:i];
                if (cabinet.interiorColors.count == 1) {
                    filename = [NSString stringWithFormat:@"%@-%luD-29-%@-V", cabinet.model.code, cabinet.interiorColors.count, color.code];
                } else {
                    filename = [NSString stringWithFormat:@"%@-%luD-29-%@-V%d", cabinet.model.code, cabinet.interiorColors.count, color.code, i + 1];
                }
                [self addLayer:filename];
            }
        }
        
        filename = [NSString stringWithFormat:@"%@-%@%@-%@-T", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.top.code];
        [self addLayer:filename];
        
        filename = [NSString stringWithFormat:@"%@-%@%@-%@-S", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.side.code];
        [self addLayer:filename];
    }
}

-(void)activateModule:(NSInteger)module
{
    _activeModule = module;
    _doAnimate = module > -1;
}

-(UIImageView *)addLayer:(NSString *)imageName
{
    UIImageView *layer = [super addLayer:imageName];
    [layer setContentMode:UIViewContentModeScaleAspectFit];
    return layer;
}

@end
