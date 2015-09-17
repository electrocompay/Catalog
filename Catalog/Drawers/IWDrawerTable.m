//
//  IWDrawerTable.m
//  Catalog
//
//  Created by Abel Miranda on 4/10/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWDrawerTable.h"
#import "IWTable.h"

@implementation IWDrawerTable

-(void)drawForniture:(IWForniture *)forniture
{
    [super drawForniture:forniture];
    IWTable *table = (IWTable*) forniture;
    NSString *replaceString = @"";
    if (self.frontView) {
        replaceString = @"-B.png";
    } else {
        replaceString = @"-A.png";
    }
    
    NSString *filename = [table.model.file stringByReplacingOccurrencesOfString:@".jpg" withString:replaceString];
    if (table.tableType == kCoffeeTable) {
        filename = [self addCafeText:filename];
    }
    else if (table.tableType == kWallTable) {
        filename = [self addWallText:filename];
    }
    
    [self addLayer:filename];

    NSString *tableCode = [table.model.code stringByAppendingString:replaceString];
    filename = [tableCode stringByReplacingOccurrencesOfString:@"LL" withString:table.legsColor.code];
    if (table.tableType == kCoffeeTable) {
        filename = [self addCafeText:filename];
    }
    else if (table.tableType == kWallTable) {
        filename = [self addWallText:filename];
    }

    filename = [filename stringByReplacingOccurrencesOfString:@"CC" withString:@"00"];
    [self addLayer:filename];

    filename = [tableCode stringByReplacingOccurrencesOfString:@"CC" withString:table.color.code];
    if (table.tableType == kCoffeeTable) {
        filename = [self addCafeText:filename];
    }
    else if (table.tableType == kWallTable) {
        filename = [self addWallText:filename];
    }

    filename = [filename stringByReplacingOccurrencesOfString:@"LL" withString:@"00"];
    [self addLayer:filename];
    
    if (NSNotFound != [tableCode rangeOfString:@"Largo-Wood"].location) {
        filename = [tableCode stringByReplacingOccurrencesOfString:@"CC" withString:table.color.code];
        filename = [filename stringByReplacingOccurrencesOfString:@"LL" withString:table.legsColor.code];
        [self addLayer:filename];
        
        filename = [tableCode stringByReplacingOccurrencesOfString:@"CC" withString:@"00"];
        filename = [filename stringByReplacingOccurrencesOfString:@"LL" withString:table.legsColor.code];
        [self addLayer:filename];
    }

    if ((NSNotFound != [tableCode rangeOfString:@"Chrominox XL"].location) ||
        (NSNotFound != [tableCode rangeOfString:@"Wings XL"].location)){
        replaceString = @"";
        if (self.frontView) {
            replaceString = @"B";
        } else {
            replaceString = @"A";
        }

        // Base Table
        filename = @"Chrominox XL-29-22-D-29.png";
        filename = [filename stringByReplacingOccurrencesOfString:@"D" withString:replaceString];
        [self addLayer:filename];
        
        NSMutableString *codeCompleteName = [[table.model.code stringByReplacingOccurrencesOfString:@"D" withString:replaceString] mutableCopy];
        
        [codeCompleteName appendString:@".png"];
        
        filename = [codeCompleteName stringByReplacingOccurrencesOfString:@"CC" withString:table.color.code];
        filename = [filename stringByReplacingOccurrencesOfString:@"LL" withString:@"00"];
        filename = [filename stringByReplacingOccurrencesOfString:@"EE" withString:@"00"];
        [self addLayer:filename];

        filename = [codeCompleteName stringByReplacingOccurrencesOfString:@"EE" withString:table.color.code];
        filename = [filename stringByReplacingOccurrencesOfString:@"LL" withString:@"00"];
        filename = [filename stringByReplacingOccurrencesOfString:@"CC" withString:@"00"];
        [self addLayer:filename];

        filename = [codeCompleteName stringByReplacingOccurrencesOfString:@"LL" withString:table.legsColor.code];
        filename = [filename stringByReplacingOccurrencesOfString:@"EE" withString:@"00"];
        filename = [filename stringByReplacingOccurrencesOfString:@"CC" withString:@"00"];
        [self addLayer:filename];
    }
}

-(NSString*)addCafeText:(NSString*)text{
    NSString *convertedText = text;
    NSString *replacedString = @"-";
    NSString *replacingString = @" cafe-";
    
    // Tripod is a coffee table called raco
    if (NSNotFound != [text rangeOfString:@"Tripod"].location) {
        replacingString = @" raco-";
    }
    else if (NSNotFound != [text rangeOfString:@"Easy-4"].location) {
        replacingString = @"-4 cafe-";
        replacedString = @"-4-";
    }
    else if (NSNotFound != [text rangeOfString:@"Largo-Wood"].location) {
        replacingString = @"-Wood cafe-";
        replacedString = @"-Wood-";
    }
    
    NSRange rOriginal = [convertedText rangeOfString: replacedString];
    if (NSNotFound != rOriginal.location) {
        convertedText = [convertedText
                    stringByReplacingCharactersInRange: rOriginal
                    withString:                         replacingString];
    }
    
    return convertedText;
}

-(NSString*)addWallText:(NSString*)text{
    NSString *convertedText = text;
    NSRange rOriginal = [convertedText rangeOfString: @"-"];
    if (NSNotFound != rOriginal.location) {
        convertedText = [convertedText
                         stringByReplacingCharactersInRange: rOriginal
                         withString:                         @" consola-"];
    }
    
    return convertedText;
}

@end
