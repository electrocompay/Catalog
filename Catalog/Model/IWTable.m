//
//  IWTable.m
//  Catalog
//
//  Created by Abel Miranda on 4/6/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWTable.h"

@implementation IWTable

-(id)init
{
    if (self = [super init]) {
        _color = [IWColor colorWithName:nil andCode:@"29" andFile:nil];
        _legsColor = [IWColor colorWithName:nil andCode:@"27" andFile:nil];
        _cofee = NO;
    }
    
    return self;
}

-(void)setModel:(IWModel *)model
{
    _model = model;
    if (_model && _model.sizes && _model.sizes.count > 0){
        _size = [_model.sizes objectAtIndex:0];
    }
}

@end
