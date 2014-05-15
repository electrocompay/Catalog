//
//  IWColor.h
//  Catalog
//
//  Created by Abel Miranda on 4/7/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWColor : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* code;
@property (nonatomic, strong) NSString* file;
@property (nonatomic, strong) NSString* category;

+(IWColor*) colorWithName:(NSString*) name andCode:(NSString*) code andFile:(NSString*) file;
-(IWColor*) withCategory:(NSString*)category;

@end
