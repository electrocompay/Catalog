//
//  IWTable.m
//  Catalog
//
//  Created by Abel Miranda on 4/6/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWTable.h"
#import "NSArray+color.h"

@implementation IWTable

-(id)init
{
    if (self = [super init]) {
        _color =  [[IWColors tableColors] colorByCode:@"29"];
        _legsColor = [[IWColors tableLegColors] colorByCode:@"27"];
        _tableType = kDinningTable;
    }
    
    return self;
}

-(void)setModel:(IWModel *)model
{
    if (model != _model) {
        _model = model;
        
        if (_model && _model.sizes && _model.sizes.count > 0){
            _size = [_model.sizes objectAtIndex:0];
        } else {
            _size = Nil;
        }
        
        if (model.colors) {
            _color = [[IWColors tableColors] colorByCode:[model.colors objectAtIndex:0]];
        } else {
            _color = [[IWColors tableColors] objectAtIndex:0];
        }

        if (model.legColors) {
            _legsColor = [[IWColors tableLegColors] colorByCode:[model.legColors objectAtIndex:0]];
        } else {
            _legsColor = [[IWColors tableLegColors] objectAtIndex:0];
        }
    }
    
}

@end
