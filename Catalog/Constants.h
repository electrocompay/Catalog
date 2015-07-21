//
//  Constants.h
//  Catalog
//
//  Created by Alejandro Molina Quiroga on 7/14/15.
//  Copyright (c) 2015 Indian Webs. All rights reserved.
//

#ifndef Catalog_Constants_h
#define Catalog_Constants_h


typedef enum {
    kFirstPriceList,
    kSecondPriceList
} priceListEnum;

typedef enum {
    kDinningTable,
    kWallTable,
    kCoffeeTable
} tableTypeEnum;

//static const int kAutoRefreshInterval = 40;
static NSString *kList1Pass = @"qwerty";
static NSString *kList2Pass = @"asdfgh";

static NSString *kDinningTableText = @"Dinning table";
static NSString *kWallTableText = @"Wall table";
static NSString *kCoffeeTableText = @"Coffee table";

#endif
