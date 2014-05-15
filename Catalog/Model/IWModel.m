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

@end
