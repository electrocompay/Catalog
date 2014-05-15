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


-(void)drawForniture:(IWForniture *)forniture
{
    [super drawForniture:forniture];
    IWCabinet *cabinet = (IWCabinet*) forniture;
    NSString *filename;
    
    
    filename = [NSString stringWithFormat:@"%@-%@%@-00-%@", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.legsColor.code];
    [self addLayer:filename];
    if (cabinet.colors.count == 0) {
        filename = [NSString stringWithFormat:@"%@-%@%@-%@-00-F", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.color.code];
        [self addLayer:filename];
    } else {
        
        for (int i = 0; i<cabinet.colors.count; i++) {
            IWColor *color = [cabinet.colors objectAtIndex:i];
            if (i == 0 ) {
                filename = [NSString stringWithFormat:@"%@-%@%@-%@-00-F", cabinet.model.code, cabinet.type.code, cabinet.size.code, color.code];
            } else {
                filename = [NSString stringWithFormat:@"%@-%@%@-%@-00-F%d", cabinet.model.code, cabinet.type.code, cabinet.size.code, color.code, i];
            }
            [self addLayer:filename];
        }
    }
    
    filename = [NSString stringWithFormat:@"%@-%@%@-%@-00-T", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.top.code];
    [self addLayer:filename];
    
    filename = [NSString stringWithFormat:@"%@-%@%@-%@-00-S", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.side.code];
    [self addLayer:filename];
    
    
    
    /* WHITHOUT LEGS*/
    
    filename = [NSString stringWithFormat:@"%@-%@%@-%@", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.legsColor.code];
    [self addLayer:filename];

    if (cabinet.colors.count == 0) {
        filename = [NSString stringWithFormat:@"%@-%@%@-%@-F", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.color.code];
        [self addLayer:filename];
    } else {
    
        for (int i = 0; i<cabinet.colors.count; i++) {
            IWColor *color = [cabinet.colors objectAtIndex:i];
            if (i == 0) {
                filename = [NSString stringWithFormat:@"%@-%@%@-%@-F", cabinet.model.code, cabinet.type.code, cabinet.size.code, color.code];
            } else {
            filename = [NSString stringWithFormat:@"%@-%@%@-%@-F%d", cabinet.model.code, cabinet.type.code, cabinet.size.code, color.code, i];
            }
            [self addLayer:filename];
        }
    }
    
    
    filename = [NSString stringWithFormat:@"%@-%@%@-%@-T", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.top.code];
    [self addLayer:filename];
    
    filename = [NSString stringWithFormat:@"%@-%@%@-%@-S", cabinet.model.code, cabinet.type.code, cabinet.size.code, cabinet.side.code];
    [self addLayer:filename];
    
    
}

@end
