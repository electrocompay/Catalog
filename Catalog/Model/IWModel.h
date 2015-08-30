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
@property (nonatomic, strong) NSArray* sizes;
@property (nonatomic, strong) NSArray* wallSizes;
@property (nonatomic, strong) NSArray* smallSizes;
@property (nonatomic, strong) NSArray* optionColors;
@property (nonatomic, strong) NSString* priceFormat;
@property (nonatomic) BOOL isWithoutChairs;
@property (nonatomic, strong) NSString* bucketMask;

+(IWModel*) modelWithName:(NSString*) name andCode:(NSString*) code andFile:(NSString*) file andColors:(NSString*) colors andLegColors:(NSString*) legColors;
+(IWModel *)modelWithName:(NSString *)name andCode:(NSString *)code andFile:(NSString *)file andColors:(NSString *)colors andLegColors:(NSString *)legColors andOptionColors:(NSString *)optionColors;
-(IWModel*) withSizes:(NSString*)sizes;
-(IWModel *)withWallSizes:(NSString *)sizes;
-(IWModel*) withSmallSizes:(NSString*)sizes;
-(IWModel*) withPriceFormat:(NSString*)priceFormat;
-(IWModel*) withoutChairs:(BOOL)withoutChairs;
-(IWModel*) withBucketMask:(NSString*)bucketMask;

@end
