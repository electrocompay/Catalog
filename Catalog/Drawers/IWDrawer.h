//
//  IWDrawer.h
//  Catalog
//
//  Created by Abel Miranda on 2/11/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWForniture.h"

@interface IWDrawer : NSObject

-(void) drawForniture: (IWForniture*) forniture;
-(void) addLayer: (NSString*) imageName;
-(void) clear;

@property UIView* view;
@property BOOL frontView;
@property NSInteger offsetY;

@end
