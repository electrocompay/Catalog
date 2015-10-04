//
//  IWColors.m
//  Catalog
//
//  Created by Abel Miranda on 4/7/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWColors.h"
#import "IWColor.h"
#import "IWModel.h"

NSArray* _allColors;
NSArray* _tableModels;
NSArray* _tableColors;
NSArray* _tableLegColors;
NSArray* _chairModels;
NSArray* _chairColors;
NSArray* _chairLegColors;
NSArray* _leatherLinerColors;

NSArray* _cabinetModels;
NSArray* _cabinet40Types;
NSArray* _cabinet40HSizes;
NSArray* _cabinet40BSizes;
NSArray* _cabinet40KSizes;


NSArray* _cabinet55Types;
NSArray* _cabinet55HSizes;
NSArray* _cabinet55BSizes;
NSArray* _cabinet55KSizes;

NSArray* _cabinetsColors;
NSArray* _cabinetsInteriorColors;
NSArray* _cabinets83Modules;
NSArray* _cabinetC193Sizes;
NSArray* _cabinetStripeColors;
NSArray* _cabinetSideColors;
NSArray* _cabinetTopColors;
NSArray* _cabinetLegColors;
NSArray* _cabinetDrawerColors;

@implementation IWColors


+(NSArray *)allColors
{
    if (!_allColors) {
        _allColors = [[NSArray alloc] initWithObjects:
                      [IWColor colorWithName:@"Antracite 25" andCode:@"25" andFile:@""],
                      [IWColor colorWithName:@"Antracite 26" andCode:@"26" andFile:@""],
                      [IWColor colorWithName:@"Antracite 605" andCode:@"605" andFile:@""],
                      [IWColor colorWithName:@"Antracite" andCode:@"605" andFile:@""],
                      [IWColor colorWithName:@"Antracite 25" andCode:@"25" andFile:@""],
                      [IWColor colorWithName:@"Antracite 26" andCode:@"26" andFile:@""],
                      [IWColor colorWithName:@"Antracite 605" andCode:@"605" andFile:@""],
                      [IWColor colorWithName:@"Antracite" andCode:@"605" andFile:@""],
                      [IWColor colorWithName:@"Antracite 25" andCode:@"25" andFile:@""],
                      [IWColor colorWithName:@"Antracite 26" andCode:@"26" andFile:@""],
                      [IWColor colorWithName:@"Antracite 605" andCode:@"605" andFile:@""],
                      [IWColor colorWithName:@"Antracite" andCode:@"605" andFile:@""],
                      
                      nil];
    }
    
    return _allColors;
}

+(NSArray *)tableModels
{
    if (!_tableModels) {
        _tableModels = [[NSArray alloc] initWithObjects:
//                        [[IWModel modelWithName:@"Blucinox" andCode:@"Blucinox-CC-27" andFile:@"Blucinox-29-27.jpg" andColors:@"29,30,31,32,33,34,35,36,37,38,41" andLegColors:@"27"] withCategory:@"model"] ,
//                        [[IWModel modelWithName:@"Bluco" andCode:@"Bluco-CC-LL" andFile:@"Bluco-29-22.jpg" andColors:nil andLegColors:@"22,23,24,25,26"] withCategory:@"model"],
                        [[[[[IWModel modelWithName:@"Chateau" andCode:@"Chateau-CC-LL" andFile:@"Chateau-29-22.jpg" andColors:@"29,30,31,32,33,34,35,36,37,38,41,70" andLegColors:@"22,23,24,25,26"] withSizes:@"300 x 128 x 75,300 x 100 x 75,250 x 128 x 75,250 x 100 x 75,220 x 128 x 75,220 x 100 x 75,200 x 128 x 75,200 x 100 x 75,180 x 128 x 75,180 x 90 x 75" andSizeToShow:@"300 x 128 x 75"] withWallSizes:@"200 x 40 x 75" andWallSizeToShow:@"200 x 40 x 75"] withSmallSizes:@"150 x 100 x 38,130 x 70 x 38,100 x 100 x 38,55 x 55 x 55" andSmallSizeToShow:@"130 x 70 x 38"] withCategory:@"model"],

                        [[[[[IWModel modelWithName:@"Chrominox" andCode:@"Chrominox-CC-27" andFile:@"Chrominox-29-27.jpg" andColors:@"29,30,31,32,33,34,35,36,37,38,41,70" andLegColors:@"27"] withSizes:@"300 x 100 x 75,250 x 100 x 75,220 x 100 x 75,200 x 100 x 75,180 x 90 x 75,150 x 150 x 75,140 x 90 x 75,130 x 130 x 75,100 x 100 x 75" andSizeToShow:@"250 x 100 x 75"] withWallSizes:@"130 x 35 x 75" andWallSizeToShow:@"130 x 35 x 75"] withSmallSizes:@"100 x 100 x 38,100 x 100 x 29,130 x 70 x 38,130 x 70 x 29" andSmallSizeToShow:@"130 x 70 x 38"] withCategory:@"model"],
                        
                        [[[IWModel modelWithName:@"Chrominox XL" andCode:@"Chrominox XL-CC-LL-D-EE" andFile:@"Chrominox-XL-29-27.jpg" andColors:@"29,30,31,32,33,34,35,36,37,70,71,72" andLegColors:@"27"] withSizes:@"300/400 x 100 x 75,220/320 x 100 x 75,160/260 x 100 x 75" andSizeToShow:@"300/400 x 100 x 75"] withCategory:@"model"],
                        
                        [[[[IWModel modelWithName:@"Cube" andCode:@"Cube-CC" andFile:@"Cube-29-22.jpg" andColors:@"29,30,31,32,33,34,35,36,37,41,70" andLegColors:@"22"] withSmallSizes:@"100 x 100 x 39,85 x 85 x 39" andSmallSizeToShow:@"100 x 100 x 39"] withPriceFormat:@"%@-%@-%@"] withCategory:@"model"],

                        [[[[IWModel modelWithName:@"Easy-4" andCode:@"Easy-4-CC-LL" andFile:@"Easy-4-29-22.jpg" andColors:@"29,30,31,32,33,34,35,36,37,41,70" andLegColors:@"22,23,24,25,26,27"] withSmallSizes:@"150 x 100 x 29,100 x 100 x 29,130 x 70 x 29" andSmallSizeToShow:@"130 x 70 x 29"] withPriceFormat:@"%@-%@-%@"] withCategory:@"model"],

                        [[[[[IWModel modelWithName:@"Elyps" andCode:@"Elyps-CC-LL" andFile:@"Elyps-29-22.jpg" andColors:@"29,30,31,32,33,34,35,36,37,38,41,70" andLegColors:@"22,23,24,25,26,27"] withSizes:@"360 x 128 x 75,300 x 128 x 75,250 x 128 x 75,210 x 128 x 75" andSizeToShow:@"300 x 128 x 75"] withSmallSizes:@"160 x 70 x 29,120 x 60 x 29" andSmallSizeToShow:@"120 x 60 x 29"] withPriceFormat:@"%@-%@-%@"] withCategory:@"model"],
                        
                        [[[[IWModel modelWithName:@"Facet" andCode:@"Facet-CC-LL" andFile:@"Facet-29-22.jpg" andColors:@"29,30,31,32,33,41,34,35,36,37,38,41,70" andLegColors:@"22,23,24,25,26,27"] withSizes:@"150 x 150 x 75,130 x 130 x 75" andSizeToShow:@"150 x 150 x 75"]  withSmallSizes:@"100 x 100 x 29,130 x 70 x 29,55 x 55 x 55" andSmallSizeToShow:@"130 x 70 x 29"] withCategory:@"model"],
                        
                        [[[[[IWModel modelWithName:@"Largo" andCode:@"Largo-CC-LL" andFile:@"Largo-29-22.jpg" andColors:@"29,30,31,32,33,34,35,36,37,38,41,70" andLegColors:@"22,23,24,25,26,27"] withSizes:@"300 x 100 x 75,250 x 100 x 75,220 x 100 x 75,200 x 100 x 75,150 x 150 x 75,130 x 130 x 75,180 x 90 x 75,140 x 90 x 75,100 x 100 x 75" andSizeToShow:@"250 x 100 x 75"] withWallSizes:@"130 x 35 x 75" andWallSizeToShow:@"130 x 35 x 75"] withSmallSizes:@"100 x 100 x 29,130 x 70 x 29,55 x 55 x 55" andSmallSizeToShow:@"130 x 70 x 29"] withCategory:@"model"],
                        
                        [[[[IWModel modelWithName:@"Largo Wood" andCode:@"Largo-Wood-CC-LL" andFile:@"Largo-Wood-29-22.jpg" andColors:@"29,30,31,32,33,34,35,36,37,38,41,70" andLegColors:@"28"] withSizes:@"300 x 100 x 75,250 x 100 x 75,220 x 100 x 75,200 x 100 x 75,130 x 130 x 75,150 x 150 x 75,180 x 90 x 75,140 x 90 x 75,100 x 100 x 75" andSizeToShow:@"250 x 100 x 75"] withSmallSizes:@"100 x 100 x 38,130 x 70 x 38,55 x 55 x 55" andSmallSizeToShow:@"130 x 70 x 38"] withCategory:@"model"],
                        
                        [[[IWModel modelWithName:@"Largo XL" andCode:@"Largo-XL-CC-LL" andFile:@"Largo-XL-29-22.jpg" andColors:@"29,30,31,32,33,36,37,41" andLegColors:@"22,23,24,25,26"] withSizes:@"200/300 x 100 x 75" andSizeToShow:@"200/300 x 100 x 75"] withCategory:@"model"],
                        
                        [[[IWModel modelWithName:@"Luna" andCode:@"Luna-CC-LL" andFile:@"Luna-29-22.jpg" andColors:@"29,30,31,32,33,34,35,36,37,38,41,70" andLegColors:@"22,23,24,25,26,27"] withSizes:@"Ø 180 x 75,Ø 160 x 75,Ø 140 x 75,Ø 120 x 75" andSizeToShow:@"Ø 180 x 75"] withCategory:@"model"],

                        [[[[[IWModel modelWithName:@"Propeller" andCode:@"Propeller-CC-LL" andFile:@"Propeller-29-22.jpg" andColors:@"29,30,31,32,33,34,35,36,37,38,41,70" andLegColors:@"22,23,24,25,26"] withSizes:@"300 x 128 x 75,300 x 100 x 75,250 x 128 x 75,250 x 100 x 75,220 x 128 x 75,220 x 100 x 75,200 x 128 x 75,200 x 100 x 75,180 x 128 x 75,180 x 90 x 75" andSizeToShow:@"300 x 128 x 75"] withWallSizes:@"200 x 40 x 75" andWallSizeToShow:@"200 x 40 x 75"] withSmallSizes:@"150 x 100 x 38,130 x 70 x 38,100 x 100 x 38,55 x 55 x 55" andSmallSizeToShow:@"130 x 70 x 38"] withCategory:@"model"],
                        
                        [[[IWModel modelWithName:@"Tripod" andCode:@"Tripod-CC-LL" andFile:@"Tripod-29-22.jpg" andColors:@"29,30,31,32,33,34,35,36,37,38,41,70" andLegColors:@"22,23,24,25,26,27"] withSmallSizes:@"Ø 45 x 40" andSmallSizeToShow:@"Ø 45 x 40"] withCategory:@"model"],

                        //[[[[[IWModel modelWithName:@"Wings" andCode:@"Wings-CC-LL" andFile:@"Wings-29-22.jpg" andColors:@"29,30,31,32,33,34,35,36,37,38" andLegColors:@"22,23,24,25,26"] withSizes:@"300 x 100 x 75,250 x 100 x 75,220 x 100 x 75,200 x 100 x 75,180 x 90 x 75,150 x 150 x 75,140 x 90 x 75,130 x 130 x 75,100 x 100 x 75"] withWallSizes:@"130 x 35 x 75"] withSmallSizes:@"100 x 100 x 38,100 x 100 x 29,130 x 70 x 38,130 x 70 x 29,55 x 55 x 55"] withCategory:@"model"],

                        [[[[[IWModel modelWithName:@"Wings Indoor" andCode:@"Wings-CC-LL" andFile:@"Wings-29-22.jpg" andColors:@"29,30,31,32,33,34,35,36,37,38,41,70" andLegColors:@"22,23,24,25,26"] withSizes:@"300 x 100 x 75,250 x 100 x 75,220 x 100 x 75,200 x 100 x 75,180 x 90 x 75,150 x 150 x 75,140 x 90 x 75,130 x 130 x 75,100 x 100 x 75" andSizeToShow:@"220 x 100 x 75"] withWallSizes:@"130 x 35 x 75" andWallSizeToShow:@"130 x 35 x 75"] withSmallSizes:@"100 x 100 x 38,100 x 100 x 29,130 x 70 x 38,130 x 70 x 29,55 x 55 x 55" andSmallSizeToShow:@"130 x 70 x 29"] withCategory:@"model"],
                        
                        [[[[IWModel modelWithName:@"Wings Outdoor" andCode:@"Wings-CC-LL" andFile:@"Wings-29-22.jpg" andColors:@"29,30,31,32,33,34,35,36,37,38,41,70" andLegColors:@"22,23,24,25,26"] withSizes:@"300 x 100 x 75,250 x 100 x 75,220 x 100 x 75,200 x 100 x 75,180 x 90 x 75,150 x 150 x 75,140 x 90 x 75,130 x 130 x 75,100 x 100 x 75" andSizeToShow:@"220 x 100 x 75"] withSmallSizes:@"100 x 100 x 38,100 x 100 x 29,130 x 70 x 38,130 x 70 x 29,55 x 55 x 55" andSmallSizeToShow:@"130 x 70 x 29"] withCategory:@"model"],
                        
                        //[[[IWModel modelWithName:@"Wings XL" andCode:@"Wings-XL-CC-LL" andFile:@"Wings-XL-29-22.jpg" andColors:@"29,30,31,32,33,34,35,36,37,38" andLegColors:@"22,23,24,25,26"] withSizes:@"260 x 100 x 75"] withCategory:@"model"],

                        [[[IWModel modelWithName:@"Wings XL" andCode:@"Chrominox XL-CC-LL-D-EE" andFile:@"Chrominox-XL-29-27.jpg" andColors:@"29,30,31,32,33,34,35,36,37,70,71,72" andLegColors:@"22,23,24,25,26"] withSizes:@"300/400 x 100 x 75,220/320 x 100 x 75,160/260 x 100 x 75" andSizeToShow:@"300/400 x 100 x 75"] withCategory:@"model"],
                        
                        nil];
    }
    
    return _tableModels;
}

+(NSArray *)tableColors
{
    if (!_tableColors) {
        _tableColors = [[NSArray alloc] initWithObjects:
                        [[IWColor colorWithName:@"Ultra white" andCode:@"29" andFile:@"Ultra white.jpg"] withCategory:@"Xeramica"],
                        [[IWColor colorWithName:@"Sahara" andCode:@"30" andFile:@"Sahara.jpg"] withCategory:@"Xeramica"],
                        [[IWColor colorWithName:@"Blue Stone" andCode:@"31" andFile:@"Blue Stone.jpg"] withCategory:@"Xeramica"],
                        [[IWColor colorWithName:@"Wood grey" andCode:@"32" andFile:@"Wood Grey.jpg"] withCategory:@"Xeramica"],
                        [[IWColor colorWithName:@"Uni grey" andCode:@"33" andFile:@"Uni Grey.jpg"] withCategory:@"Xeramica"],
                        [[IWColor colorWithName:@"Old Oak" andCode:@"34" andFile:@"Old Oak.jpg"] withCategory:@"Xeramica"],
                        [[IWColor colorWithName:@"Smoke Oak" andCode:@"35" andFile:@"Smoke Oak.jpg"] withCategory:@"Xeramica"],
                        [[IWColor colorWithName:@"Calacatta" andCode:@"41" andFile:@"Caltatta.jpg"] withCategory:@"Xeramica"],
                        [[IWColor colorWithName:@"Beton" andCode:@"70" andFile:@"Beton 70.jpg"] withCategory:@"Xeramica"],
                        [[IWColor colorWithName:@"White" andCode:@"36" andFile:@"White.jpg"] withCategory:@"Glass"],
                        [[IWColor colorWithName:@"Taupe" andCode:@"37" andFile:@"Taupe.jpg"] withCategory:@"Glass"],
                        //[[IWColor colorWithName:@"Carrara" andCode:@"38" andFile:@"Matrilux Carara.jpg"] withCategory:@"Glass"],
                        [[IWColor colorWithName:@"Ice" andCode:@"43" andFile:@"Ice 43.jpg"] withCategory:@"Glass"],
                        [[IWColor colorWithName:@"Greige" andCode:@"44" andFile:@"Greige 44.jpg"] withCategory:@"Glass"],
                        [[IWColor colorWithName:@"Taupe" andCode:@"45" andFile:@"Taupe 45.jpg"] withCategory:@"Glass"],
                        [[IWColor colorWithName:@"Black" andCode:@"46" andFile:@"Black 46.jpg"] withCategory:@"Glass"],
                        [[IWColor colorWithName:@"Walnut" andCode:@"47" andFile:@"Walnut 47.jpg"] withCategory:@"Glass"],
                        [[IWColor colorWithName:@"Chocolate" andCode:@"48" andFile:@"Chocolate 48.jpg"] withCategory:@"Glass"],
                        [[IWColor colorWithName:@"Tan" andCode:@"49" andFile:@"Tan 49.jpg"] withCategory:@"Glass"],
                        [[IWColor colorWithName:@"Mushroom" andCode:@"50" andFile:@"Mushroom 50.jpg"] withCategory:@"Glass"],
                        [[IWColor colorWithName:@"Dark Brown" andCode:@"71" andFile:@"Dark brown 71.jpg"] withCategory:@"Glass"],
                        [[IWColor colorWithName:@"Antracite" andCode:@"72" andFile:@"Antracite 25.jpg"] withCategory:@"Glass"],
                        nil];
    }
    
    return _tableColors;
}

+(NSArray *)tableLegColors
{
    if (!_tableLegColors) {
        _tableLegColors = [[NSArray alloc] initWithObjects:
                           [[IWColor colorWithName:@"White" andCode:@"22" andFile:@"White.jpg"] withCategory:@"frame color"],
                           [[IWColor colorWithName:@"Taupe" andCode:@"23" andFile:@"Taupe.jpg"] withCategory:@"frame color"],
                           [[IWColor colorWithName:@"Brown" andCode:@"24" andFile:@"Brown.jpg"] withCategory:@"frame color"],
                           [[IWColor colorWithName:@"Antracite" andCode:@"25" andFile:@"Antracite 25.jpg"] withCategory:@"frame color"],
                           [[IWColor colorWithName:@"Black" andCode:@"26" andFile:@"Black 90.jpg"] withCategory:@"frame color"],
                           [[IWColor colorWithName:@"Stainless Steel" andCode:@"27" andFile:@"Chrome-Inox.jpg"] withCategory:@"frame color"],
                           [[IWColor colorWithName:@"Wood" andCode:@"28" andFile:@"Wood.jpg"] withCategory:@"frame color"],
                           nil];
    }
    
    return _tableLegColors;
}

+(NSArray *)chairModels
{
    if (!_chairModels) {
        _chairModels = [[NSArray alloc] initWithObjects:
                        [[IWModel modelWithName:@"Angelina-S" andCode:@"Angelina-S-CC-27" andFile:@"Angelina-S-01-27.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Angelina-A" andCode:@"Angelina-A-CC-27" andFile:@"Angelina-A-01-27.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Angelina-W" andCode:@"Angelina-W-CC-27" andFile:@"Angelina-W-01-27.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Angelina-AW" andCode:@"Angelina-AW-CC-27" andFile:@"Angelina-AW-01-27.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50,56,57,58,59,60,61,62,63" andLegColors:@"27"] withCategory:@"model"],

                        [[IWModel modelWithName:@"Angelina Bar-S" andCode:@"Angelina-B-CC-28" andFile:@"Angelina-B-01-28.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Angelina Bar-A" andCode:@"Angelina Bar-A-CC-28" andFile:@"Angelina Bar-A-01-28.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Angelina Bar-W" andCode:@"Angelina Bar-W-CC-28" andFile:@"Angelina Bar-W-01-28.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Angelina Bar-AW" andCode:@"Angelina Bar-AW-CC-28" andFile:@"Angelina Bar-AW-01-28.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50,56,57,58,59,60,61,62.63" andLegColors:@"27"] withCategory:@"model"],

                        [[IWModel modelWithName:@"Angelina low-AL" andCode:@"Angelina low-AL-CC-28" andFile:@"Angelina low-AL-01-28.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27"] withCategory:@"model"],

                        [[IWModel modelWithName:@"Da Vinci" andCode:@"Da vinci-A-CC-LL" andFile:@"Da vinci-A-14-22.jpg" andColors:@"14,15,16,17,18,42" andLegColors:@"22,23,24,25,26"] withCategory:@"model"],
                        
                        [[IWModel modelWithName:@"Ensor-S" andCode:@"Ensor-S-CC-LL" andFile:@"Ensor-S-14-27.jpg" andColors:@"14,16,17,18,42" andLegColors:@"99,22,23,24,25,26"] withCategory:@"model"],

                        [[IWModel modelWithName:@"Gaugin-S" andCode:@"Gaugin-S-CC-30" andFile:@"Gaugin-S-01-30.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"30"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Gaugin-A" andCode:@"Gaugin-A-CC-30" andFile:@"Gaugin-A-01-30.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"30"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Gaugin-SW" andCode:@"Gaugin-SW-CC-30" andFile:@"Gaugin-SW-01-30.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"30"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Gaugin-AW" andCode:@"Gaugin-AW-CC-30" andFile:@"Gaugin-AW-01-30.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"30"] withCategory:@"model"],

                        [[[IWModel modelWithName:@"Largo-A" andCode:@"Largo-U-CC-LL" andFile:@"Largo-U-01-22.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,14,16,17,18,43,44,45,46,47,48,49,50" andLegColors:@"22,23,24,25,26,27"] withPriceFormat:@"%@-%@-%@"] withCategory:@"model"],

                        [[IWModel modelWithName:@"Margueritte-S" andCode:@"Margueritte-S-CC-CC" andFile:@"Margueritte-S-22-22.jpg" andColors:@"22,23,25,26,74,75" andLegColors:@"22,23,24,25,26,74,75"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Margueritte-A" andCode:@"Margueritte-A-CC-CC" andFile:@"Margueritte-A-22-22.jpg" andColors:@"22,23,25,26,74,75" andLegColors:@"22"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Margueritte-S-S" andCode:@"Margueritte-S-S-CC-LL" andFile:@"Margueritte-S-S-22-22.jpg" andColors:@"22,23,24,25,26,74,75" andLegColors:@"22,23,24,25,26,74,75" andOptionColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Margueritte-A-S" andCode:@"Margueritte-A-S-CC-LL" andFile:@"Margueritte-A-S-22-22.jpg" andColors:@"22,23,24,25,26,74,75" andLegColors:@"22,23,24,25,26,74,75" andOptionColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50"] withCategory:@"model"],

                        [[IWModel modelWithName:@"Moon-A" andCode:@"Moon-U-01-LL" andFile:@"Moon-U-01-22.jpg" andColors:@"01" andLegColors:@"22,27"] withCategory:@"model"],

                        [[IWModel modelWithName:@"Monet-S" andCode:@"Monet-S-CC-27" andFile:@"Monet-S-01-27.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Monet-A" andCode:@"Monet-A-CC-27" andFile:@"Monet-A-01-27.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27"] withCategory:@"model"],

                        [[IWModel modelWithName:@"Monet-W" andCode:@"Monet-W-CC-27" andFile:@"Monet-W-01-27.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27"] withCategory:@"model"],

                        [[IWModel modelWithName:@"Monet-AW" andCode:@"Monet-AW-CC-27" andFile:@"Monet-AW-01-27.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Monet Bar-S" andCode:@"Monet-B-CC-28" andFile:@"Monet-B-01-28.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Monet Bar-H" andCode:@"Monet-BH-CC-28" andFile:@"Monet-BH-01-28.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27"] withCategory:@"model"],

                        [[IWModel modelWithName:@"Monet Bar-W" andCode:@"Monet-Bar-W-CC-28" andFile:@"Monet-W-01-28.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27"] withCategory:@"model"],
                        
                        [[IWModel modelWithName:@"Monet low-ML" andCode:@"Monet low-ML-CC-28" andFile:@"Monet low-ML-01-28.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27"] withCategory:@"model"],
                        
                        [[IWModel modelWithName:@"Picasso-P" andCode:@"Picasso-P-CC-CC" andFile:@"Picasso-P-01-01-A-02.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27" andOptionColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50"] withCategory:@"model"],

                        [[IWModel modelWithName:@"Rafael Wood-S" andCode:@"Rafael-S-CC-28" andFile:@"Rafael-S-14-28.jpg" andColors:@"14,15,16,18,42" andLegColors:@"28"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Rafael-A" andCode:@"Rafael-A-CC-LL" andFile:@"Rafael-A-14-22.jpg" andColors:@"14,15,16,18,42" andLegColors:@"22,23,24,25,26"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Rafael Bar-S" andCode:@"Rafael Bar-B-CC-LL" andFile:@"Rafael Bar-B-14-22.jpg" andColors:@"14,15,16" andLegColors:@"22,23,26"] withCategory:@"model"],

                        [[IWModel modelWithName:@"Renoir-S" andCode:@"Renoir-S-CC-27" andFile:@"Renoir-S-01-27.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Renoir-A" andCode:@"Renoir-A-CC-27" andFile:@"Renoir-A-01-27.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Renoir-W" andCode:@"Renoir-W-CC-27" andFile:@"Renoir-W-01-27.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Renoir-AW" andCode:@"Renoir-AW-CC-27" andFile:@"Renoir-AW-01-27.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13,43,44,45,46,47,48,49,50" andLegColors:@"27"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Renoir Bar-S" andCode:@"Renoir Bar-B-CC-28" andFile:@"Renoir Bar-B-01-28.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13" andLegColors:@"27"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Renoir Bar-AW" andCode:@"Renoir Bar-AW-CC-28" andFile:@"Renoir Bar-AW-01-28.jpg" andColors:@"01,02,03,04,05,06,07,08,09,10,11,12,13" andLegColors:@"27"] withCategory:@"model"],

                        [[IWModel modelWithName:@"RollBloc" andCode:@"Rolbloc-CC-LL" andFile:@"Rolbloc-19-22.jpg" andColors:@"19,20,21" andLegColors:@"22,23,25,26,27"] withCategory:@"model"],

                        [[IWModel modelWithName:@"RollBloc Low" andCode:@"Rolbloc Low-CC-LL" andFile:@"Rolbloc Low-19-22.jpg" andColors:@"19,20,21" andLegColors:@"22,23,25,26,27"] withCategory:@"model"],
                        
                        [[IWModel modelWithName:@"Van Gogh-S" andCode:@"Van Gogh-S-CC-28" andFile:@"Van Gogh-S-01-28.jpg" andColors:@"07,10" andLegColors:@"28"] withCategory:@"model"],
                        [[IWModel modelWithName:@"Van Gogh-A" andCode:@"Van Gogh-A-CC-28" andFile:@"Van Gogh-A-01-28.jpg" andColors:@"07,10" andLegColors:@"28"] withCategory:@"model"],
                        
                        [[IWModel modelWithName:@"Zchair" andCode:@"Zchair-CC-27" andFile:@"Zchair-19-27.jpg" andColors:@"19,20,21" andLegColors:@"27"] withCategory:@"model"],
                        
                        nil];
    }
    
    return _chairModels;
}

+(NSArray *)chairColors
{
    if (!_chairColors) {
        _chairColors = [[NSArray alloc] initWithObjects:
                        [[IWColor colorWithName:@"White 10" andCode:@"01" andFile:@"White 10.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Beige 110" andCode:@"02" andFile:@"Beige 110.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Lipstick 80" andCode:@"03" andFile:@"Lipstick 80.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Wine Red 18" andCode:@"04" andFile:@"Wine Red 18.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Mocca 29" andCode:@"05" andFile:@"Mocca 29.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Taupe 27" andCode:@"06" andFile:@"Taupe 27.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Nutella 58" andCode:@"07" andFile:@"Nutella.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Grey 21" andCode:@"08" andFile:@"Grey 21.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Antracite 25" andCode:@"09" andFile:@"Antracite 25.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Black 08" andCode:@"10" andFile:@"Black 08.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Aubergine 77" andCode:@"11" andFile:@"Aubergine 77.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Choco 57" andCode:@"12" andFile:@"Choco 57.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Smoke 17" andCode:@"13" andFile:@"Smoke 17.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"White 01" andCode:@"14" andFile:@"White 01.jpg"] withCategory:@"Skai color"],
                        //[[IWColor colorWithName:@"Mocca 29" andCode:@"15" andFile:@"Mocca 29.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Taupe 062" andCode:@"15" andFile:@"Taupe 062.jpg"] withCategory:@"Skai color"],
                        [[IWColor colorWithName:@"Black 901" andCode:@"16" andFile:@"Black 90.jpg"] withCategory:@"Skai color"],
                        [[IWColor colorWithName:@"L. grey 617" andCode:@"17" andFile:@"Light Grey 617.jpg"] withCategory:@"Skai color"],
                        [[IWColor colorWithName:@"Antracite 605" andCode:@"18" andFile:@"Antracite 605.jpg"] withCategory:@"Skai color"],
                        [[IWColor colorWithName:@"White" andCode:@"19" andFile:@"White.jpg"] withCategory:@"Textylene"],
                        [[IWColor colorWithName:@"Taupe" andCode:@"20" andFile:@"Taupe.jpg"] withCategory:@"Textylene"],
                        [[IWColor colorWithName:@"Grey" andCode:@"21" andFile:@"Grey 21.jpg"] withCategory:@"Textylene"],
                        [[IWColor colorWithName:@"White" andCode:@"22" andFile:@"White.jpg"] withCategory:@"Lacquered"],
                        [[IWColor colorWithName:@"Taupe" andCode:@"23" andFile:@"Taupe.jpg"] withCategory:@"Lacquered"],
                        [[IWColor colorWithName:@"Brown" andCode:@"24" andFile:@"Brown.jpg"] withCategory:@"Lacquered"],
                        [[IWColor colorWithName:@"Antracite" andCode:@"25" andFile:@"Antracite 25.jpg"] withCategory:@"Lacquered"],
                        [[IWColor colorWithName:@"Black" andCode:@"26" andFile:@"Black 90.jpg"] withCategory:@"Lacquered"],
                        [[IWColor colorWithName:@"Chrome Inox" andCode:@"27" andFile:@"Chrome-inox.jpg"] withCategory:@"Lacquered"],
                        [[IWColor colorWithName:@"Wood" andCode:@"28" andFile:@"Wood.jpg"] withCategory:@"Lacquered"],
                        [[IWColor colorWithName:@"Brown" andCode:@"42" andFile:@"Brown.jpg"] withCategory:@"Skai color"],
                        [[IWColor colorWithName:@"Ice 002" andCode:@"43" andFile:@"Ice 002.jpg"] withCategory:@"Torres color"],
                        [[IWColor colorWithName:@"Greige 001" andCode:@"44" andFile:@"Greige 001.jpg"] withCategory:@"Torres color"],
                        [[IWColor colorWithName:@"Taupe 004" andCode:@"45" andFile:@"Taupe 004.jpg"] withCategory:@"Torres color"],
                        [[IWColor colorWithName:@"Black 006" andCode:@"46" andFile:@"Black 006.jpg"] withCategory:@"Torres color"],
                        [[IWColor colorWithName:@"Wallnut 011" andCode:@"47" andFile:@"Wallnut 011.jpg"] withCategory:@"Torres color"],
                        [[IWColor colorWithName:@"Chocolate 010" andCode:@"48" andFile:@"Chocolate 010.jpg"] withCategory:@"Torres color"],
                        [[IWColor colorWithName:@"Tan 001" andCode:@"49" andFile:@"Tan 001.jpg"] withCategory:@"Torres color"],
                        [[IWColor colorWithName:@"Mushroom 003" andCode:@"50" andFile:@"Mushroom 003.jpg"] withCategory:@"Torres color"],
                        [[IWColor colorWithName:@"Red" andCode:@"74" andFile:@"Red 74.jpg"] withCategory:@"Lacquered"],
                        [[IWColor colorWithName:@"Yellow" andCode:@"75" andFile:@"Yellow 75.jpg"] withCategory:@"Lacquered"],
                        nil];
    }
    
    return _chairColors;
}

+(NSArray *)chairLegColors
{
    if (!_chairLegColors) {
        _chairLegColors = [[NSArray alloc] initWithObjects:
                           [[IWColor colorWithName:@"White 10" andCode:@"01" andFile:@"White 10.jpg"] withCategory:@"Legs Leather"],
                           [[IWColor colorWithName:@"Beige 110" andCode:@"02" andFile:@"Beige 110.jpg"] withCategory:@"Legs Leather"],
                           [[IWColor colorWithName:@"Lipstick 80" andCode:@"03" andFile:@"Lipstick 80.jpg"] withCategory:@"Legs Leather"],
                           [[IWColor colorWithName:@"Wine Red 18" andCode:@"04" andFile:@"Wine Red 18.jpg"] withCategory:@"Legs Leather"],
                           [[IWColor colorWithName:@"Taupe 27" andCode:@"05" andFile:@"Taupe 27.jpg"] withCategory:@"Legs Leather"],
                           [[IWColor colorWithName:@"Mocca 29" andCode:@"06" andFile:@"Mocca 29.jpg"] withCategory:@"Legs Leather"],
                           [[IWColor colorWithName:@"Nutella 58" andCode:@"07" andFile:@"Nutella.jpg"] withCategory:@"Legs Leather"],
                           [[IWColor colorWithName:@"Grey 21" andCode:@"08" andFile:@"Grey 21.jpg"] withCategory:@"Legs Leather"],
                           [[IWColor colorWithName:@"Antracite 25" andCode:@"09" andFile:@"Antracite 25.jpg"] withCategory:@"Legs Leather"],
                           [[IWColor colorWithName:@"Black 08" andCode:@"10" andFile:@"Black 08.jpg"] withCategory:@"Legs Leather"],
                           [[IWColor colorWithName:@"Aubergine 77" andCode:@"11" andFile:@"Aubergine 77.jpg"] withCategory:@"Legs Leather"],
                           [[IWColor colorWithName:@"Choco 57" andCode:@"12" andFile:@"Choco 57.jpg"] withCategory:@"Legs Leather"],
                           [[IWColor colorWithName:@"Smoke 17" andCode:@"13" andFile:@"Smoke 17.jpg"] withCategory:@"Legs Leather"],
                           [[IWColor colorWithName:@"White" andCode:@"22" andFile:@"White.jpg"] withCategory:@"Legs lacquered"],
                           [[IWColor colorWithName:@"Taupe" andCode:@"23" andFile:@"Taupe.jpg"] withCategory:@"Legs lacquered"],
                           [[IWColor colorWithName:@"Brown" andCode:@"24" andFile:@"Brown.jpg"] withCategory:@"Legs lacquered"],
                           [[IWColor colorWithName:@"Antracite" andCode:@"25" andFile:@"Antracite 25.jpg"] withCategory:@"Legs lacquered"],
                           [[IWColor colorWithName:@"Black" andCode:@"26" andFile:@"Black 90.jpg"] withCategory:@"Legs lacquered"],
                           [[IWColor colorWithName:@"Stainless Steel" andCode:@"27" andFile:@"Chrome-Inox.jpg"] withCategory:@"Legs lacquered"],
                           [[IWColor colorWithName:@"Chrome" andCode:@"99" andFile:@"Chrome-Inox.jpg"] withCategory:@"Legs lacquered"],
                           [[IWColor colorWithName:@"Wood" andCode:@"28" andFile:@"Wood.jpg"] withCategory:@"Legs lacquered"],
                           [[IWColor colorWithName:@"Ice 002" andCode:@"43" andFile:@"Ice 002.jpg"] withCategory:@"Legs torres"],
                           [[IWColor colorWithName:@"Greige 001" andCode:@"44" andFile:@"Greige 001.jpg"] withCategory:@"Legs torres"],
                           [[IWColor colorWithName:@"Taupe 004" andCode:@"45" andFile:@"Taupe 004.jpg"] withCategory:@"Legs torres"],
                           [[IWColor colorWithName:@"Black 006" andCode:@"46" andFile:@"Black 006.jpg"] withCategory:@"Legs torres"],
                           [[IWColor colorWithName:@"Wallnut 011" andCode:@"47" andFile:@"Wallnut 011.jpg"] withCategory:@"Legs torres"],
                           [[IWColor colorWithName:@"Chocolate 010" andCode:@"48" andFile:@"Chocolate 010.jpg"] withCategory:@"Legs torres"],
                           [[IWColor colorWithName:@"Tan 001" andCode:@"49" andFile:@"Tan 001.jpg"] withCategory:@"Legs torres"],
                           [[IWColor colorWithName:@"Mushroom 003" andCode:@"50" andFile:@"Mushroom 003.jpg"] withCategory:@"Legs torres"],
                           nil];
    }
    
    return _chairLegColors;
}

+(NSArray *)leatherLinerColors
{
    if (!_leatherLinerColors) {
        _leatherLinerColors = [[NSArray alloc] initWithObjects:
                        [[IWColor colorWithName:@"White 10" andCode:@"01" andFile:@"White 10.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Beige 110" andCode:@"02" andFile:@"Beige 110.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Lipstick 80" andCode:@"03" andFile:@"Lipstick 80.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Wine Red 18" andCode:@"04" andFile:@"Wine Red 18.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Mocca 29" andCode:@"05" andFile:@"Mocca 29.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Taupe 27" andCode:@"06" andFile:@"Taupe 27.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Nutella 58" andCode:@"07" andFile:@"Nutella.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Grey 21" andCode:@"08" andFile:@"Grey 21.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Antracite 25" andCode:@"09" andFile:@"Antracite 25.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Black 08" andCode:@"10" andFile:@"Black 08.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Aubergine 77" andCode:@"11" andFile:@"Aubergine 77.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Choco 57" andCode:@"12" andFile:@"Choco 57.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Smoke 17" andCode:@"13" andFile:@"Smoke 17.jpg"] withCategory:@"Leather color"],
                        [[IWColor colorWithName:@"Ice 002" andCode:@"43" andFile:@"Ice 002.jpg"] withCategory:@"Torres color"],
                        [[IWColor colorWithName:@"Greige 001" andCode:@"44" andFile:@"Greige 001.jpg"] withCategory:@"Torres color"],
                        [[IWColor colorWithName:@"Taupe 004" andCode:@"45" andFile:@"Taupe 004.jpg"] withCategory:@"Torres color"],
                        [[IWColor colorWithName:@"Black 006" andCode:@"46" andFile:@"Black 006.jpg"] withCategory:@"Torres color"],
                        [[IWColor colorWithName:@"Wallnut 011" andCode:@"47" andFile:@"Wallnut 011.jpg"] withCategory:@"Torres color"],
                        [[IWColor colorWithName:@"Chocolate 010" andCode:@"48" andFile:@"Chocolate 010.jpg"] withCategory:@"Torres color"],
                        [[IWColor colorWithName:@"Tan 001" andCode:@"49" andFile:@"Tan 001.jpg"] withCategory:@"Torres color"],
                        [[IWColor colorWithName:@"Mushroom 003" andCode:@"50" andFile:@"Mushroom 003.jpg"] withCategory:@"Torres color"],
                        nil];
    }
    
    return _leatherLinerColors;
}

+(NSArray *)cabinetModels
{
    
    if (!_cabinetModels) {
        _cabinetModels = [[NSArray alloc] initWithObjects:
                          [IWModel modelWithName:@"Cube 40" andCode:@"40" andFile:@"40-H01-29-22" andColors:nil andLegColors:nil],
                          [IWModel modelWithName:@"Cube 55" andCode:@"55" andFile:@"55-H01-29-22"
                                       andColors:nil andLegColors:nil],
                          [IWModel modelWithName:@"Cube 83" andCode:@"C83" andFile:nil andColors:nil andLegColors:@"27"],
                          [IWModel modelWithName:@"Cosy 193" andCode:@"C193" andFile:nil andColors:nil andLegColors:nil],
//                          [IWModel modelWithName:@"Joli 83" andCode:@"J83" andFile:nil andColors:nil andLegColors:nil],
                          nil];
    }
    
    return _cabinetModels;
}

+(NSArray *)cabinet40Types
{
    if (!_cabinet40Types) {
        _cabinet40Types = [[NSArray alloc] initWithObjects:
                           [IWColor colorWithName:@"Cupboard 40" andCode:@"H" andFile:nil] ,
                           [IWColor colorWithName:@"Wall Cabinet 40" andCode:@"B" andFile:nil],
                           [IWColor colorWithName:@"Column Cabinet 40" andCode:@"K" andFile:nil],
                           nil];
    }
    
    return _cabinet40Types;
    
}

+(NSArray *)cabinet40HSizes
{
    if (!_cabinet40HSizes) {
        _cabinet40HSizes = [[NSArray alloc] initWithObjects:
                            [IWColor colorWithName:@"2 doors (80x40x40)" andCode:@"01" andFile:nil] ,
                            [IWColor colorWithName:@"3 doors (120x40x40)" andCode:@"02" andFile:nil] ,
                            [IWColor colorWithName:@"4 doors (160x40x40)" andCode:@"03" andFile:nil] ,
                            [IWColor colorWithName:@"5 doors (200x40x40)" andCode:@"04" andFile:nil] ,
                            [IWColor colorWithName:@"6 doors (240x40x40)" andCode:@"05" andFile:nil] ,
                            [IWColor colorWithName:@"7 doors (280x40x40)" andCode:@"06" andFile:nil] ,
                            [IWColor colorWithName:@"8 doors (320x40x40)" andCode:@"07" andFile:nil] ,
                            nil];
    }
    
    return _cabinet40HSizes;
    
}

+(NSArray *)cabinet40BSizes
{
    if (!_cabinet40BSizes) {
        _cabinet40BSizes = [[NSArray alloc] initWithObjects:
                            [IWColor colorWithName:@"4 doors (80x80x27)" andCode:@"08" andFile:nil] ,
                            [IWColor colorWithName:@"6 doors (80x120x27)" andCode:@"09" andFile:nil] ,
                            [IWColor colorWithName:@"6 doors (120x80x27)" andCode:@"10" andFile:nil] ,
                            [IWColor colorWithName:@"9 doors (120x120x27)" andCode:@"11" andFile:nil] ,
                            nil];
    }
    
    return _cabinet40BSizes;
    
}

+(NSArray *)cabinet40KSizes
{
    if (!_cabinet40KSizes) {
        _cabinet40KSizes = [[NSArray alloc] initWithObjects:
                            [IWColor colorWithName:@"2 doors (40x80x27)" andCode:@"12" andFile:nil] ,
                            [IWColor colorWithName:@"3 doors (40x120x27)" andCode:@"13" andFile:nil] ,
                            [IWColor colorWithName:@"4 doors (40x160x27)" andCode:@"14" andFile:nil] ,
                            nil];
    }
    
    return _cabinet40KSizes;
    
}

+(NSArray *)cabinet55Types
{
    if (!_cabinet55Types) {
        _cabinet55Types = [[NSArray alloc] initWithObjects:
                           [IWColor colorWithName:@"Cupboard 55" andCode:@"H" andFile:nil],
                           [IWColor colorWithName:@"Wall Cabinet 55" andCode:@"B" andFile:nil],
                           [IWColor colorWithName:@"Column Cabinet 55" andCode:@"K" andFile:nil],
                           nil];
    }
    
    return _cabinet55Types;
    
}

+(NSArray *)cabinet55HSizes
{
    if (!_cabinet55HSizes) {
        _cabinet55HSizes = [[NSArray alloc] initWithObjects:
                            [IWColor colorWithName:@"2 doors (110x55x40)" andCode:@"01" andFile:nil] ,
                            [IWColor colorWithName:@"3 doors (165x55x40)" andCode:@"02" andFile:nil] ,
                            [IWColor colorWithName:@"4 doors (220x55x40)" andCode:@"03" andFile:nil] ,
                            [IWColor colorWithName:@"5 doors (275x55x40)" andCode:@"04" andFile:nil] ,
                            [IWColor colorWithName:@"6 doors (330x55x40)" andCode:@"05" andFile:nil] ,
                            nil];
    }
    
    return _cabinet55HSizes;
    
}

+(NSArray *)cabinet55BSizes
{
    if (!_cabinet55BSizes) {
        _cabinet55BSizes = [[NSArray alloc] initWithObjects:
                            [IWColor colorWithName:@"4 doors (110x110x27)" andCode:@"06" andFile:nil] ,
                            [IWColor colorWithName:@"6 doors (165x110x27)" andCode:@"07" andFile:nil] ,
                            [IWColor colorWithName:@"6 doors (110x165x27)" andCode:@"08" andFile:nil] ,
                            [IWColor colorWithName:@"9 doors (165x165x27)" andCode:@"09" andFile:nil] ,
                            nil];
    }
    
    return _cabinet55BSizes;
    
}

+(NSArray *)cabinet55KSizes
{
    if (!_cabinet55KSizes) {
        _cabinet55KSizes = [[NSArray alloc] initWithObjects:
                            [IWColor colorWithName:@"2 doors (55x110x27)" andCode:@"10" andFile:nil] ,
                            [IWColor colorWithName:@"3 doors (55x165x27)" andCode:@"11" andFile:nil] ,
                            [IWColor colorWithName:@"4 doors (55x220x27)" andCode:@"12" andFile:nil] ,
                            nil];
    }
    
    return _cabinet55KSizes;
    
}

+(NSArray *)cabinetColors
{
    if (!_cabinetsColors) {
        _cabinetsColors = [[NSArray alloc] initWithObjects:
                           [[IWColor colorWithName:@"Ultra white" andCode:@"29" andFile:@"Ultra white.jpg"] withCategory:@"Xeramica"],
                           [[IWColor colorWithName:@"Sahara" andCode:@"30" andFile:@"Sahara.jpg"] withCategory:@"Xeramica"],
                           [[IWColor colorWithName:@"Blue Stone" andCode:@"31" andFile:@"Blue Stone.jpg"] withCategory:@"Xeramica"],
                           [[IWColor colorWithName:@"Wood grey" andCode:@"32" andFile:@"Wood Grey.jpg"] withCategory:@"Xeramica"],
                           [[IWColor colorWithName:@"Uni grey" andCode:@"33" andFile:@"Uni Grey.jpg"] withCategory:@"Xeramica"],
                           [[IWColor colorWithName:@"White" andCode:@"36" andFile:@"White.jpg"] withCategory:@"Glass"],
                           [[IWColor colorWithName:@"Taupe" andCode:@"37" andFile:@"Taupe.jpg"] withCategory:@"Glass"],
                           [[IWColor colorWithName:@"Grey" andCode:@"39" andFile:@"Grey.jpg"] withCategory:@"Glass"],
                           [[IWColor colorWithName:@"Brown" andCode:@"40" andFile:@"Brown.jpg"] withCategory:@"Glass"],
                           nil];
    }
    
    return _cabinetsColors;
}

+(NSArray *)cabinetInteriorColors
{
    if (!_cabinetsInteriorColors) {
        _cabinetsInteriorColors = [[NSArray alloc] initWithObjects:
                           [[IWColor colorWithName:@"Transp. / Old oak" andCode:@"80" andFile:@"Transp + Old Oak.jpg"] withCategory:@"Xeramica"],
                           [[IWColor colorWithName:@"Transp. / Smoke oak" andCode:@"81" andFile:@"Transp + Smoke Oak.jpg"] withCategory:@"Xeramica"],
                           [[IWColor colorWithName:@"Transp. / Light grey" andCode:@"82" andFile:@"Transp + Light grey.jpg"] withCategory:@"Xeramica"],
                           [[IWColor colorWithName:@"Black / Old oak" andCode:@"83" andFile:@"Black + Old Oak.jpg"] withCategory:@"Xeramica"],
                           [[IWColor colorWithName:@"Black / Smoke oak" andCode:@"84" andFile:@"Black + Smoke Oak.jpg"] withCategory:@"Xeramica"],
                           [[IWColor colorWithName:@"Black / Light grey" andCode:@"85" andFile:@"Black + Light grey.jpg"] withCategory:@"Xeramica"],
                           nil];
    }
    
    return _cabinetsInteriorColors;
}

+(NSArray *)cabinet83Modules
{
    if (!_cabinets83Modules) {
        _cabinets83Modules = [[NSArray alloc] initWithObjects:
                              [IWColor colorWithName:@"---" andCode:nil andFile:nil],
                              [IWColor colorWithName:@"1 door\n(55x83x50)" andCode:@"1,0" andFile:nil],
                              [IWColor colorWithName:@"2 door\n(55x83x50)" andCode:@"2,0" andFile:nil],
                              [IWColor colorWithName:@"2 door + 1 drawer\n(55x83x50)" andCode:@"2,1" andFile:nil],
                              [IWColor colorWithName:@"3 drawers\n(55x83x50)" andCode:@"0,3" andFile:nil],
                              nil];
    }
    return _cabinets83Modules;
}

+(NSArray *)cabinetC193Sizes
{
    if (!_cabinetC193Sizes) {
        _cabinetC193Sizes = [[NSArray alloc] initWithObjects:
                             [IWColor colorWithName:@"1 door (55x193x40)" andCode:@"1" andFile:nil],
                             [IWColor colorWithName:@"2 door (55x193x40)" andCode:@"2" andFile:nil],
                             [IWColor colorWithName:@"3 door (55x193x40)" andCode:@"3" andFile:nil],
                             [IWColor colorWithName:@"4 door (55x193x40)" andCode:@"4" andFile:nil],
                             nil];
    }
    return _cabinetC193Sizes;
}

+(NSArray *)cabinetStripeColors
{
    if (!_cabinetStripeColors) {
        _cabinetStripeColors = [[NSArray alloc] initWithObjects:
                                [[IWColor colorWithName:@"Ultra white" andCode:@"29" andFile:@"Ultra white.jpg"] withCategory:@"Xeramica"],
                                [[IWColor colorWithName:@"Sahara" andCode:@"30" andFile:@"Sahara.jpg"] withCategory:@"Xeramica"],
                                [[IWColor colorWithName:@"Blue Stone" andCode:@"31" andFile:@"Blue Stone.jpg"] withCategory:@"Xeramica"],
                                [[IWColor colorWithName:@"Wood grey" andCode:@"32" andFile:@"Wood Grey.jpg"] withCategory:@"Xeramica"],
                                [[IWColor colorWithName:@"Uni grey" andCode:@"33" andFile:@"Uni Grey.jpg"] withCategory:@"Xeramica"],
                                [[IWColor colorWithName:@"White" andCode:@"36" andFile:@"White.jpg"] withCategory:@"Glass"],
                                [[IWColor colorWithName:@"Taupe" andCode:@"37" andFile:@"Taupe.jpg"] withCategory:@"Glass"],
                                [[IWColor colorWithName:@"Grey" andCode:@"39" andFile:@"Grey 21.jpg"] withCategory:@"Glass"],
                                [[IWColor colorWithName:@"Brown" andCode:@"40" andFile:@"Brown.jpg"] withCategory:@"Glass"],
                                [[IWColor colorWithName:@"No Stripe" andCode:nil andFile:@"No Stripe.jpg"] withCategory:@"Glass"],
                                
                                nil];
    }
    
    return _cabinetStripeColors;
    
}

+(NSArray *)cabinetSideColors
{
    if (!_cabinetSideColors) {
        _cabinetSideColors = [[NSArray alloc] initWithObjects:
                              [[IWColor colorWithName:@"Ultra white" andCode:@"29" andFile:@"Ultra white.jpg"] withCategory:@"Xeramica"],
                              [[IWColor colorWithName:@"Sahara" andCode:@"30" andFile:@"Sahara.jpg"] withCategory:@"Xeramica"],
                              [[IWColor colorWithName:@"Blue Stone" andCode:@"31" andFile:@"Blue Stone.jpg"] withCategory:@"Xeramica"],
                              [[IWColor colorWithName:@"Wood grey" andCode:@"32" andFile:@"Wood Grey.jpg"] withCategory:@"Xeramica"],
                              [[IWColor colorWithName:@"Uni grey" andCode:@"33" andFile:@"Uni Grey.jpg"] withCategory:@"Xeramica"],
                              [[IWColor colorWithName:@"Old Oak" andCode:@"34" andFile:@"Old Oak.jpg"] withCategory:@"Xeramica"],
                              [[IWColor colorWithName:@"Smoke Oak" andCode:@"35" andFile:@"Smoke Oak.jpg"] withCategory:@"Xeramica"],
                              [[IWColor colorWithName:@"Beton" andCode:@"70" andFile:@"Beton 70.jpg"] withCategory:@"Xeramica"],
                              [[IWColor colorWithName:@"White" andCode:@"36" andFile:@"White.jpg"] withCategory:@"Glass"],
                              [[IWColor colorWithName:@"Taupe" andCode:@"37" andFile:@"Taupe.jpg"] withCategory:@"Glass"],
                              [[IWColor colorWithName:@"Grey" andCode:@"39" andFile:@"Grey 21.jpg"] withCategory:@"Glass"],
                              [[IWColor colorWithName:@"Brown" andCode:@"40" andFile:@"Brown.jpg"] withCategory:@"Glass"],
                              nil];
    }
    
    return _cabinetSideColors;
}

+(NSArray *)cabinetTopColors
{
    if (!_cabinetTopColors) {
        _cabinetTopColors = [[NSArray alloc] initWithObjects:
                             [[IWColor colorWithName:@"Ultra white" andCode:@"29" andFile:@"Ultra white.jpg"] withCategory:@"Xeramica"],
                             [[IWColor colorWithName:@"Sahara" andCode:@"30" andFile:@"Sahara.jpg"] withCategory:@"Xeramica"],
                             [[IWColor colorWithName:@"Blue Stone" andCode:@"31" andFile:@"Blue Stone.jpg"] withCategory:@"Xeramica"],
                             [[IWColor colorWithName:@"Wood grey" andCode:@"32" andFile:@"Wood Grey.jpg"] withCategory:@"Xeramica"],
                             [[IWColor colorWithName:@"Uni grey" andCode:@"33" andFile:@"Uni Grey.jpg"] withCategory:@"Xeramica"],
                             [[IWColor colorWithName:@"Old Oak" andCode:@"34" andFile:@"Old Oak.jpg"] withCategory:@"Xeramica"],
                             [[IWColor colorWithName:@"Smoke Oak" andCode:@"35" andFile:@"Smoke Oak.jpg"] withCategory:@"Xeramica"],
                             [[IWColor colorWithName:@"Calacatta" andCode:@"41" andFile:@"Caltatta.jpg"] withCategory:@"Xeramica"],
                             [[IWColor colorWithName:@"Beton" andCode:@"70" andFile:@"Beton 70.jpg"] withCategory:@"Xeramica"],
                             [[IWColor colorWithName:@"White" andCode:@"36" andFile:@"White.jpg"] withCategory:@"Glass"],
                             [[IWColor colorWithName:@"Taupe" andCode:@"37" andFile:@"Taupe.jpg"] withCategory:@"Glass"],
                             //[[IWColor colorWithName:@"Carrara" andCode:@"38" andFile:@"Matrilux Carara.jpg"] withCategory:@"Glass"],
                             [[IWColor colorWithName:@"Grey" andCode:@"39" andFile:@"Grey 21.jpg"] withCategory:@"Glass"],
                             [[IWColor colorWithName:@"Brown" andCode:@"40" andFile:@"Brown.jpg"] withCategory:@"Glass"],
                             
                             nil];
    }
    
    return _cabinetTopColors;
}

+(NSArray *)cabinetLegColors
{
    if (!_cabinetLegColors) {
        _cabinetLegColors = [[NSArray alloc] initWithObjects:
                             [[IWColor colorWithName:@"White" andCode:@"22" andFile:@"White.jpg"] withCategory:@"legs color"],
                             [[IWColor colorWithName:@"Taupe" andCode:@"23" andFile:@"Taupe.jpg"] withCategory:@"legs color"],
                             [[IWColor colorWithName:@"Brown" andCode:@"24" andFile:@"Brown.jpg"] withCategory:@"legs color"],
                             [[IWColor colorWithName:@"Antracite" andCode:@"25" andFile:@"Antracite 25.jpg"] withCategory:@"legs color"],
                             [[IWColor colorWithName:@"Black" andCode:@"26" andFile:@"Black 90.jpg"] withCategory:@"legs color"],
                             [[IWColor colorWithName:@"Chrome" andCode:@"27" andFile:@"Chrome-Inox.jpg"] withCategory:@"legs color"],
                             [[IWColor colorWithName:@"Wood" andCode:@"28" andFile:@"Wood.jpg"] withCategory:@"legs color"],
                             nil];
    }
    
    return _cabinetLegColors;
}

+(NSArray *)cabinetDrawerColors
{
    if (!_cabinetDrawerColors) {
        _cabinetDrawerColors = [[NSArray alloc] initWithObjects:
                                [[IWColor colorWithName:@"Ultra white" andCode:@"29" andFile:@"Ultra white.jpg"] withCategory:@"Xeramica"],
                                [[IWColor colorWithName:@"Sahara" andCode:@"30" andFile:@"Sahara.jpg"] withCategory:@"Xeramica"],
                                [[IWColor colorWithName:@"Blue Stone" andCode:@"31" andFile:@"Blue Stone.jpg"] withCategory:@"Xeramica"],
                                [[IWColor colorWithName:@"Wood grey" andCode:@"32" andFile:@"Wood Grey.jpg"] withCategory:@"Xeramica"],
                                [[IWColor colorWithName:@"Uni grey" andCode:@"33" andFile:@"Uni Grey.jpg"] withCategory:@"Xeramica"],
                                [[IWColor colorWithName:@"Old Oak" andCode:@"34" andFile:@"Old Oak.jpg"] withCategory:@"Melamine"],
                                [[IWColor colorWithName:@"Smoke Oak" andCode:@"35" andFile:@"Smoke Oak.jpg"] withCategory:@"Melamine"],
                                [[IWColor colorWithName:@"White" andCode:@"36" andFile:@"White.jpg"] withCategory:@"Glass"],
                                [[IWColor colorWithName:@"Taupe" andCode:@"37" andFile:@"Taupe.jpg"] withCategory:@"Glass"],
                                [[IWColor colorWithName:@"Grey" andCode:@"39" andFile:@"Grey 21.jpg"] withCategory:@"Glass"],
                                [[IWColor colorWithName:@"Brown" andCode:@"40" andFile:@"Brown.jpg"] withCategory:@"Glass"],
                                nil];
    }
    
    return _cabinetDrawerColors;
}

@end
