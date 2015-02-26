//
//  IWModel.m
//  Catalog
//
//  Created by Abel Miranda on 4/23/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWModel.h"

@implementation IWModel

+(IWModel *)modelWithName:(NSString *)name andCode:(NSString *)code andFile:(NSString *)file andColors:(NSString *)colors andLegColors:(NSString *)legColors
{
    IWModel* model = [[IWModel alloc] init];
    model.name = name;
    model.code = code;
    model.file = file;
    if (colors) {
        model.colors = [colors componentsSeparatedByString:@","];
    }
    if (legColors) {
        model.legColors = [legColors componentsSeparatedByString:@","];
    }
    
    return model;
}

-(IWModel *)withSizes:(NSString *)sizes
{
    NSArray* dataSizes = [sizes componentsSeparatedByString:@","];

    NSMutableArray* mutableArray = [[NSMutableArray alloc] init];
    
    for (NSString* dataSize in dataSizes) {
        [mutableArray addObject:[IWColor colorWithName:dataSize andCode:dataSize andFile:Nil]];
    }
    _sizes = mutableArray;
    return self;
}

@end
