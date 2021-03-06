//
//  IWChair.h
//  Catalog
//
//  Created by Abel Miranda on 4/6/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWForniture.h"
#import "IWColor.h"
#import "IWModel.h"

@interface IWChair : IWForniture

@property (nonatomic, strong) IWModel* model;
@property (nonatomic, strong) IWColor* color;
@property (nonatomic, strong) IWColor* legsColor;

@end
