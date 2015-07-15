//
//  IWPriceManager.m
//  Catalog
//
//  Created by Abel Miranda on 2/26/15..
//  Copyright (c) 2015 Indian Webs. All rights reserved.
//

#import "Constants.h"
#import "IWPriceManager.h"

NSString *const AUTHENTICATED_FIELD = @"authenticated";
NSString *const PRICE_LIST_PREFIX = @"belux";
NSString *const DEFAULT_TABLE_PRICE_FORMAT = @"%@-%@-%@-%@";
NSString *const CHAIR_PRICE_FORMAT = @"%@-%@";

IWPriceManager *pricemanager;
NSDictionary *tablePriceList;
NSDictionary *chairPriceList;

priceListEnum priceList;

@implementation IWPriceManager


-(BOOL)authenticated
{
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
    NSNumber *authenticated = [userDefaults valueForKey:AUTHENTICATED_FIELD];
    if (authenticated) {
        return [authenticated boolValue];
    }
    return NO;
}

-(double)getTablePrice:(IWTable *)table
{
    if (!tablePriceList) {
        tablePriceList = [self loadPriceList:@"table"];
    }
    
    NSString* priceFormat = table.model.priceFormat ? table.model.priceFormat : DEFAULT_TABLE_PRICE_FORMAT;
    ;
    NSString *priceKey;
    if ([[priceFormat componentsSeparatedByString:@"@"] count] == 5) {
        priceKey = [[NSString stringWithFormat:priceFormat, table.model.name, table.legsColor.name, [table.size.name stringByReplacingOccurrencesOfString:@" " withString:@""], table.color.name] uppercaseString];
    } else {
        priceKey = [[NSString stringWithFormat:priceFormat, table.model.name, [table.size.name stringByReplacingOccurrencesOfString:@" " withString:@""], table.color.name] uppercaseString];
    }
    
    if (priceKey) {
        NSDictionary *price = [tablePriceList objectForKey:priceKey];
        NSNumber *value = [price objectForKey:@"UnitPrice"];
        if (value) {
            return [value doubleValue];
        }
    }

    return 0;
}

-(double)getChairPrice:(IWChair *)chair
{
    if (!chairPriceList) {
        chairPriceList = [self loadPriceList:@"chair"];
    }
    
    NSString* priceFormat = chair.model.priceFormat ? chair.model.priceFormat : CHAIR_PRICE_FORMAT;

    NSString *priceKey;
    
    if ([[priceFormat componentsSeparatedByString:@"@"] count] == 3)
      priceKey = [[NSString stringWithFormat:priceFormat, chair.model.name, chair.color.name] uppercaseString];
    else
      priceKey = [[NSString stringWithFormat:priceFormat, chair.model.name, chair.legsColor.name, chair.color.name] uppercaseString];
    
    if (priceKey) {
        NSDictionary *price = [chairPriceList objectForKey:priceKey];
        NSNumber *value = [price objectForKey:@"UnitPrice"];
        if (value) {
            return [value doubleValue];
        }
    }

    return 0;
}

+(IWPriceManager *)getInstance
{
    if (!pricemanager){
        pricemanager = [[IWPriceManager alloc] init];
    }
    
    return pricemanager;
}

-(BOOL)authenticate:(NSString *)authenticationCode
{
    if ([authenticationCode isEqualToString:kList1Pass]) {
        [self savePasswordValidation];
        priceList = kFirstPriceList;
        return YES;
    }
    else if ([authenticationCode isEqualToString:kList2Pass]) {
        [self savePasswordValidation];
        priceList = kSecondPriceList;
        return YES;
    }
    
    return NO;
}
    
-(void)savePasswordValidation {
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
    [userDefaults setValue:[NSNumber numberWithBool:YES] forKey:AUTHENTICATED_FIELD];
}

-(NSDictionary*)loadPriceList:(NSString*)name
{

    NSString *priceListString;
    
    priceListString = @"prices";
    if (priceList == kSecondPriceList) {
        priceListString = @"prices_2";
    }
    
    NSString *filename = [NSString stringWithFormat:@"%@_%@_%@", PRICE_LIST_PREFIX, name, priceListString];
    NSString *fullName =[[NSBundle mainBundle] pathForResource:filename ofType:@"json"];

    NSData *data = [NSData dataWithContentsOfFile:fullName];
    
    NSArray *arrayData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    if (arrayData) {
        NSDictionary *result = [[NSMutableDictionary alloc] init];
        
        for (NSDictionary *element in arrayData) {
            [result setValue:element forKey:[[element valueForKey:@"ItemName"] uppercaseString]];
            
        }
    
        return result;
    }
    
    return Nil;
}

-(double)getCabinetPrice:(IWCabinet *)cabinet
{
    //TODO prices
    return 0;
}


@end
