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
NSString *const CABINET_PRICE_FORMAT = @"cabinet-%@-%@-%u doors-%@-Matilux-white";
NSString *const CABINET_PRICE_FORMAT_C193 = @"cabinet-Cube-193 Cosy-wood melamine-%@-Matilux-white-vitrine-%uB-%ux193x40-met verlichting";
NSString *const CABINET_PRICE_FORMAT_83 = @"cabinet-Cube-83-Matilux-white-dressoir-%uB-%ux83x50-%@";
//NSString *const CABINET_PRICE_FORMAT = @"cabinet-Cube-40-wall cabinet-%d doors-80x40x40-Matilux-white";

IWPriceManager *pricemanager;
NSDictionary *tablePriceList;
NSDictionary *chairPriceList;
NSDictionary *cabinetPriceList;

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
    NSString *priceKey;
    
    NSString *cleanSizeName = [self getCleanSizeName:table.size.name];
    
    if ([[priceFormat componentsSeparatedByString:@"@"] count] == 5) {
        priceKey = [[NSString stringWithFormat:priceFormat, table.model.name, table.legsColor.name, cleanSizeName, table.color.name] uppercaseString];
    } else {
        priceKey = [[NSString stringWithFormat:priceFormat, table.model.name, cleanSizeName, table.color.name] uppercaseString];
    }
    
    if (priceKey) {
        NSDictionary *price = [tablePriceList objectForKey:priceKey];
        NSNumber *value = [price objectForKey:@"UnitPrice"];
        if (value) {
            return [value doubleValue];
        } else {
            [self alertPriceNotFound:priceKey];
        }
    }

    return 0;
}

-(NSString *)getCleanSizeName:(NSString*)sizeName
{
    return [[[[sizeName stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"Ø" withString:@""] stringByReplacingOccurrencesOfString:@"cm" withString:@""] stringByReplacingOccurrencesOfString:@"/" withString:@" "];
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
        } else {
            [self alertPriceNotFound:priceKey];
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

-(double)getCabinetPrice:(IWCabinet *)cabinet forModule:(NSInteger)module
{
    if (!cabinetPriceList) {
        cabinetPriceList = [self loadPriceList:@"cabinet"];
    }
    
    
    NSString* priceKey;
    
    if ([cabinet.model.code isEqualToString:@"C193"]) {
        priceKey = [self priceKeyForCosy193:cabinet];
    } else if ([cabinet.model.code isEqualToString:@"40"] || [cabinet.model.code isEqualToString:@"55"]) {
        priceKey = [self priceKeyForCube:cabinet];
    } else if ([cabinet.model.code isEqualToString:@"C83"] || [cabinet.model.code isEqualToString:@"J83"]){
        priceKey = [self priceKeyFor83:cabinet forModule:module];
    }
    
    if (priceKey) {
        NSDictionary *price = [cabinetPriceList objectForKey:priceKey];
        NSNumber *value = [price objectForKey:@"UnitPrice"];
        if (value) {
            return [value doubleValue];
        } else {
            [self alertPriceNotFound:priceKey];
        }
    }
    
    return 0;
}

-(NSString*)priceKeyFor83:(IWCabinet*)cabinet forModule:(NSInteger)module
{
    IWCabinet* lcabinet = cabinet;
    switch (module) {
        case 1:
            lcabinet = cabinet.module2;
            break;
        case 2:
            lcabinet = cabinet.module3;
            break;
        case 3:
            lcabinet = cabinet.module4;
            break;
            
        default:
            break;
    }
    
    int doors = 2;
    if ([lcabinet.size.code isEqualToString:@"1,0"]) {
        doors = 1;
    }
    
    NSString* param1;
    if ([lcabinet.size.code isEqualToString:@"1,0"]) {
        param1 = @"D";
    } else if ([lcabinet.size.code isEqualToString:@"2,0"]) {
        param1 = @"2D";
    } else if ([lcabinet.size.code isEqualToString:@"2,1"]) {
        param1 = @"LDD";
    } else if ([lcabinet.size.code isEqualToString:@"0,3"]) {
        param1 = @"3L";
    }
    
    NSString* priceKey = [[NSString stringWithFormat:CABINET_PRICE_FORMAT_83, doors, doors * 55, param1] uppercaseString];
    
    return priceKey;
}


-(NSString*)priceKeyForCube:(IWCabinet*)cabinet
{
    NSString* priceFormat = CABINET_PRICE_FORMAT;
    
    NSString* modelName;
    
    if ([cabinet.model.code isEqualToString:@"40"]){
        modelName = @"Cube-40";
    } else if ([cabinet.model.code isEqualToString:@"55"]){
        modelName = @"Cube-55";
    }
    
    NSString* typeName;
    
    if ([cabinet.type.code isEqualToString:@"B"]){
        typeName = @"bar cabinet";
    } else if ([cabinet.type.code isEqualToString:@"H"]){
        typeName = @"wall cabinet";
    } else if ([cabinet.type.code isEqualToString:@"K"]){
        typeName = @"column cabinet";
    }
    
    NSString* sizeName;
    
    sizeName = cabinet.size.name;
    NSRange startRange = [sizeName rangeOfString:@"("];
    if (startRange.location != NSNotFound) {
        sizeName = [[sizeName substringFromIndex:startRange.location + 1] stringByReplacingOccurrencesOfString:@")" withString:@""];
        
    }
    
    NSString* priceKey = [[NSString stringWithFormat:priceFormat, modelName, typeName, cabinet.colors.count, sizeName] uppercaseString];
    
    return priceKey;
}

-(NSString*)priceKeyForCosy193:(IWCabinet*)cabinet
{
    NSString* priceKey = [[NSString stringWithFormat:CABINET_PRICE_FORMAT_C193, cabinet.interiorColor.name, (int) cabinet.colors.count, (int)cabinet.colors.count*55] uppercaseString];
    
   
    return priceKey;
}

-(double)getCabinetPrice:(IWCabinet *)cabinet
{
    double totalPrice;
    
    if ([cabinet.model.code isEqualToString:@"C83"] || [cabinet.model.code isEqualToString:@"J83"]) {
        totalPrice = [self getCabinetPrice:cabinet forModule:0];
        
        totalPrice += cabinet.module2.size.code ? [self getCabinetPrice:cabinet forModule:1] : 0;
        totalPrice += cabinet.module3.size.code ? [self getCabinetPrice:cabinet forModule:2] : 0;
        totalPrice += cabinet.module4.size.code ? [self getCabinetPrice:cabinet forModule:3] : 0;
        
    } else {
        totalPrice = [self getCabinetPrice:cabinet forModule:0];
    }
    
    return totalPrice;
}

-(void)alertPriceNotFound:(NSString*)priceKey{
    
    if (!priceKey) return;
    if ([priceKey containsString:@"NULL"]) return;
    
    [[[UIAlertView alloc] initWithTitle:@"Prices" message:[NSString stringWithFormat:@"No prices found with id %@", priceKey] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
}

@end
