//
//  NSArray+color.h
//  Catalog
//
//  Created by Abel Miranda on 5/29/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWColors.h"
#import "IWColor.h"

@interface NSArray (color)

-(IWColor*)colorByCode:(NSString*)code;
-(NSArray*)withoutColor:(NSString*)code;

@end
