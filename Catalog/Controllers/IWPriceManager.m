//
//  IWPriceManager.m
//  Catalog
//
//  Created by Abel Miranda on 2/26/15.
//  Copyright (c) 2015 Indian Webs. All rights reserved.
//

#import "IWPriceManager.h"

NSString *const AUTHENTICATED_FIELD = @"authenticated";
NSString *const PRICE_LIST_PREFIX = @"belux";
NSString *const TABLE_PRICE_FORMAT = @"%@-%@-%@-%@";

IWPriceManager *pricemanager;
NSDictionary *tablePriceList;

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
    
    NSString *priceKey = [[NSString stringWithFormat:TABLE_PRICE_FORMAT, table.model.name, table.legsColor.name, [table.size.name stringByReplacingOccurrencesOfString:@" " withString:@""], table.color.name] uppercaseString];
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
    if (YES) {
        NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
        [userDefaults setValue:[NSNumber numberWithBool:YES] forKey:AUTHENTICATED_FIELD];
        return YES;
    }
    return NO;
}

-(NSDictionary*)loadPriceList:(NSString*)name
{

    NSString *filename = [NSString stringWithFormat:@"%@_%@_%@", PRICE_LIST_PREFIX, name, @"prices"];
    
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


@end
