//
//  IWOption.h
//  Catalog
//
//  Created by Abel Miranda on 2/11/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWOption : NSObject

@property NSString* code;
@property NSString* description;
@property NSString* category;

+(id) optionWithCode:(NSString*) code description:(NSString*) description andCategory:(NSString*) category;

@end
