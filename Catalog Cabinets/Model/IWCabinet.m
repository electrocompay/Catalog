//
//  IWCabinet.m
//  Catalog
//
//  Created by Abel Miranda on 2/11/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWCabinet.h"
#import "IWColors.h"

@implementation IWCabinet
{
    BOOL _subModule;
}

-(id)init
{
    if (self = [super init]) {
        _model = [[IWColors cabinetModels] objectAtIndex:0];
        _color = [[IWColors cabinetColors] objectAtIndex:0];
        _legsColor = [IWColor colorWithName:nil andCode:@"27" andFile:nil];
        _top = [[IWColors cabinetColors] objectAtIndex:0];
        _side = [[IWColors cabinetColors] objectAtIndex:0];
        _legsColor = [IWColor colorWithName:nil andCode:@"22" andFile:nil];
        _colors = [[NSMutableArray alloc] init];
        _drawers = [[NSMutableArray alloc] init];
        _subModule = NO;
        _oneColorMode = YES;
        _showLegs = YES;
    }
    
    return self;
}

-(id)initAsSubModule:(IWCabinet*)cabinet
{
    self = [self init];
    if (self) {
        _subModule = YES;
        _model = cabinet.model;
        _parentCabinet = cabinet;
    }
    return self;
}

-(void)setOneColorMode:(BOOL)oneColorMode
{
    if (!oneColorMode != oneColorMode){
        _oneColorMode = oneColorMode;
    }
}

-(BOOL)useDoors
{
    return [_model.code isEqualToString:@"40"] || [_model.code isEqualToString:@"55"] || [_model.code isEqualToString:@"55"] || [_model.code isEqualToString:@"C193"];
}

-(BOOL)hasLegs
{
    return ([_model.code isEqualToString:@"40"] || [_model.code isEqualToString:@"55"]) && [_type.code isEqualToString:@"H"];
}

-(BOOL)useModules
{
    return [_model.code isEqualToString:@"C83"] || [_model.code isEqualToString:@"J83"];
}

-(void)setModel:(IWModel *)model
{
    if (_model != model) {
        _model = model;
        if ([self useModules] && !_subModule) {
            _module2 = [[IWCabinet alloc] initAsSubModule:self];
            _module3 = [[IWCabinet alloc] initAsSubModule:self];
            _module4 = [[IWCabinet alloc] initAsSubModule:self];
        } else {
            _module2 = nil;
            _module3 = nil;
            _module4 = nil;
        }
    }
}

-(void)setSize:(IWColor *)size
{
    if (_size != size) {
        _size = size;
        if (self.useModules) {
            NSArray *params = [_size.code componentsSeparatedByString:@","];
            NSInteger ndoors = [params[0] intValue];
            [_colors removeAllObjects];
            for (int i = 0; i < ndoors; i++) {
                [_colors addObject: _color];
            }
            NSInteger ndrawers = [params[1] intValue];
            [_drawers removeAllObjects];
            for (int i = 0; i < ndrawers; i++) {
                [_drawers addObject: _color];
            }
        } else {
            [_colors removeAllObjects];
                 NSInteger size = [[_size.name substringToIndex:1] intValue];
                 for (int i = 0; i < size; i++) {
                     [_colors addObject: _color];
                 }
        }
    }
}

-(IWColor *)top{
    if (_parentCabinet) {
        return _parentCabinet.top;
    }
    return _top;
}

-(BOOL)useStripe
{
    return [_model.code isEqualToString:@"J83"];
}

@end
