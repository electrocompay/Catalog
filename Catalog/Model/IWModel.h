//
//  IWModel.h
//  Catalog
//
//  Created by Abel Miranda on 4/23/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWColor.h"

@interface IWModel : IWColor

@property (nonatomic, strong) NSArray* colors;
@property (nonatomic, strong) NSArray* legColors;

+(IWModel*) modelWithName:(NSString*) name andCode:(NSString*) code andFile:(NSString*) file andColors:(NSString*) colors andLegColors:(NSString*) legColors;

@end
