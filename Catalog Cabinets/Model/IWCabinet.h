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

-(void)setOneColorMode:(BOOL)oneColor;


@end
