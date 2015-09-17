//
//  IWPriceManager.h
//  Catalog
//
//  Created by Abel Miranda on 2/26/15.
//  Copyright (c) 2015 Indian Webs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWTable.h"
#import "IWChair.h"
#import "IWCabinet.h"

@interface IWPriceManager : NSObject

@property (nonatomic) BOOL authenticated;

-(BOOL)authenticate:(NSString*)authenticationCode;
-(double)getTablePrice:(IWTable*)table;
-(double)getChairPrice:(IWChair*)chair;
-(double)getCabinetPrice:(IWCabinet*)cabinet forModule:(NSInteger)module;
-(double)getCabinetPrice:(IWCabinet*)cabinet;

+(IWPriceManager*)getInstance;

@end
