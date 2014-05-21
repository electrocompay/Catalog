//
//  IWCabinet.h
//  Catalog
//
//  Created by Abel Miranda on 2/11/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWForniture.h"
#import "IWColor.h"
#import "IWModel.h"

@interface IWCabinet : IWForniture

@property (nonatomic, strong) IWModel* model;
@property (nonatomic, strong) IWColor* color;
@property (nonatomic, strong) NSMutableArray* colors;
@property (nonatomic, strong) IWColor* legsColor;
@property (nonatomic, strong) IWColor* type;
@property (nonatomic, strong) IWColor* size;
@property (nonatomic, strong) IWColor* side;
@property (nonatomic, strong) IWColor* top;
@property (nonatomic, strong) IWCabinet* module2;
@property (nonatomic, strong) IWCabinet* module3;
@property (nonatomic, strong) IWCabinet* module4;
@property (nonatomic, readonly) BOOL useDoors;
@property (nonatomic, readonly) BOOL hasLegs;
@property (nonatomic, readonly) BOOL useModules;
@property (nonatomic, strong) NSMutableArray* drawers;
@property (nonatomic, strong) IWColor* stripe;
@property (nonatomic) BOOL oneColorMode;
@property (nonatomic, strong) IWCabinet* parentCabinet;
@property (nonatomic, strong) IWColor* interiorColor;
@property (nonatomic, readonly) BOOL useStripe;
@property (nonatomic) BOOL showLegs;

@end
