//
//  IWTableSummaryView.m
//  Catalog
//
//  Created by Abel Miranda on 3/5/15.
//  Copyright (c) 2015 Indian Webs. All rights reserved.
//

#import "IWCabinetSummaryView.h"
#import "IWDrawerCabinet.h"
#import "IWPriceManager.h"

NSString* defaultModuleDescriptionText = @"Not available";

@interface IWCabinetSummaryView ()

@end

@implementation IWCabinetSummaryView{
    
    IWCabinet* _cabinet;
    IWPriceManager* _priceManager;
    
    NSArray* _module1Submodules;
    NSArray* _module2Submodules;
    NSArray* _module3Submodules;
    NSArray* _module4Submodules;
    
    IBOutlet UIView* _frontView;
    
    // Cabinet Model
    IBOutlet UILabel* _cabinetModel;

    // Modules titles
    IBOutlet UILabel* _module1Title;
    IBOutlet UILabel* _module2Title;
    IBOutlet UILabel* _module3Title;
    IBOutlet UILabel* _module4Title;

    // Modules description
    IBOutlet UILabel* _module1Desc;
    IBOutlet UILabel* _module2Desc;
    IBOutlet UILabel* _module3Desc;
    IBOutlet UILabel* _module4Desc;
    
    // Modules Prices
    IBOutlet UILabel* _module1Price;
    IBOutlet UILabel* _module2Price;
    IBOutlet UILabel* _module3Price;
    IBOutlet UILabel* _module4Price;

    // Top & Side
    IBOutlet UILabel* _topLength;
    IBOutlet UILabel* _topColor;
    IBOutlet UILabel* _topColorPrice;
    IBOutlet UILabel* _topColorExtraPrice;
    
    IBOutlet UILabel* _sideColor;
    IBOutlet UILabel* _sideColorPrice;
    IBOutlet UILabel* _sideColorExtraPrice;
    
    // Modules Confuguration

    // Module 1
    IBOutlet UILabel* _subModule_1_1_Desc;
    IBOutlet UILabel* _subModule_1_1_Color;
    IBOutlet UILabel* _subModule_1_1_Price;
    IBOutlet UILabel* _subModule_1_1_ExtraPrice;

    IBOutlet UILabel* _subModule_1_2_Desc;
    IBOutlet UILabel* _subModule_1_2_Color;
    IBOutlet UILabel* _subModule_1_2_Price;
    IBOutlet UILabel* _subModule_1_2_ExtraPrice;
    
    IBOutlet UILabel* _subModule_1_3_Desc;
    IBOutlet UILabel* _subModule_1_3_Color;
    IBOutlet UILabel* _subModule_1_3_Price;
    IBOutlet UILabel* _subModule_1_3_ExtraPrice;
    
    // Module 2
    IBOutlet UILabel* _subModule_2_1_Desc;
    IBOutlet UILabel* _subModule_2_1_Color;
    IBOutlet UILabel* _subModule_2_1_Price;
    IBOutlet UILabel* _subModule_2_1_ExtraPrice;
    
    IBOutlet UILabel* _subModule_2_2_Desc;
    IBOutlet UILabel* _subModule_2_2_Color;
    IBOutlet UILabel* _subModule_2_2_Price;
    IBOutlet UILabel* _subModule_2_2_ExtraPrice;
    
    IBOutlet UILabel* _subModule_2_3_Desc;
    IBOutlet UILabel* _subModule_2_3_Color;
    IBOutlet UILabel* _subModule_2_3_Price;
    IBOutlet UILabel* _subModule_2_3_ExtraPrice;

    // Module 3
    IBOutlet UILabel* _subModule_3_1_Desc;
    IBOutlet UILabel* _subModule_3_1_Color;
    IBOutlet UILabel* _subModule_3_1_Price;
    IBOutlet UILabel* _subModule_3_1_ExtraPrice;
    
    IBOutlet UILabel* _subModule_3_2_Desc;
    IBOutlet UILabel* _subModule_3_2_Color;
    IBOutlet UILabel* _subModule_3_2_Price;
    IBOutlet UILabel* _subModule_3_2_ExtraPrice;
    
    IBOutlet UILabel* _subModule_3_3_Desc;
    IBOutlet UILabel* _subModule_3_3_Color;
    IBOutlet UILabel* _subModule_3_3_Price;
    IBOutlet UILabel* _subModule_3_3_ExtraPrice;
    
    //Module 4
    IBOutlet UILabel* _subModule_4_1_Desc;
    IBOutlet UILabel* _subModule_4_1_Color;
    IBOutlet UILabel* _subModule_4_1_Price;
    IBOutlet UILabel* _subModule_4_1_ExtraPrice;
    
    IBOutlet UILabel* _subModule_4_2_Desc;
    IBOutlet UILabel* _subModule_4_2_Color;
    IBOutlet UILabel* _subModule_4_2_Price;
    IBOutlet UILabel* _subModule_4_2_ExtraPrice;
    
    IBOutlet UILabel* _subModule_4_3_Desc;
    IBOutlet UILabel* _subModule_4_3_Color;
    IBOutlet UILabel* _subModule_4_3_Price;
    IBOutlet UILabel* _subModule_4_3_ExtraPrice;
    
    IBOutlet UILabel* _grandTotalPrice;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)initialize
{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    UIView* view = [[[NSBundle mainBundle] loadNibNamed:@"IWCabinetSummaryView" owner:self options:nil] objectAtIndex:0];
    [self addSubview:view];
    self.frame = view.frame;

    _priceManager = [[IWPriceManager alloc] init];
}

-(void)showSummaryForCabinet:(IWCabinet *)cabinet
{
    _cabinet = cabinet;
    IWDrawerCabinet* cabinetDrawer = [[IWDrawerCabinet alloc] init];

    [cabinetDrawer setView:_frontView];
    [cabinetDrawer drawForniture:_cabinet];
    
    [self initializeSubmodulesArrays];
    
    [self setInitialLayout];
    [self updateAttributes];
}

-(void)updateAttributes
{
    
    _cabinetModel.text = _cabinet.model.name;
    
    _grandTotalPrice.text = [NSString stringWithFormat:@"%.2f €",[_priceManager getCabinetPrice:_cabinet]];

    // Modules
    [self showModulesDescriptionsAndPrices];
    
    // Top
    _topLength.text = _cabinet.size.code;
    _topColor.text = _cabinet.top.name;
    
    // Side
    _sideColor.text = _cabinet.side.name;
    
    
/*    [_tableModel setText:_table.model.name];
    _tableType.text = _table.coffee ? @"Coffee table" : @"Dinning table";
    [_tableSize setText:_table.size.name];
    [_tableColor setText:_table.color.name];
    [_tableLegsColor setText:_table.legsColor.name];
    
    float tablePrice = [[IWPriceManager getInstance] getTablePrice:_table];
    [_tablePrice setText:[NSString stringWithFormat:@"%.0f €", tablePrice]];
    [_tableTotalPrice setText:[NSString stringWithFormat:@"%.0f €", tablePrice]];
    
    [_chairModel setText:_chair.model.name];
    [_chairColor setText:_chair.color.name];
    [_chairLegsColor setText:_chair.legsColor.name];
    
    float chairPrice = [[IWPriceManager getInstance] getChairPrice:_chair];
    [_chairPrice setText:[NSString stringWithFormat:@"%.0f €", chairPrice]];
    [_chairTotalPrice setText:[NSString stringWithFormat:@"%.0f €", chairPrice]];

    [_grandTotalPrice setText:[NSString stringWithFormat:@"%.0f €", chairPrice + tablePrice]];
*/
}

-(void) showModulesDescriptionsAndPrices {
    
    // Module 1 (always present)
    _module1Desc.text = _cabinet.size.name;
    
    if([_cabinet.model.code isEqualToString:@"C83"])
    {
        [self printModuleInfo:_cabinet andSubmodules:_module1Submodules];
        _module1Price.text = [NSString stringWithFormat:@"%.2f €",[_priceManager getCabinetPrice:_cabinet forModule:0]];
    } else {
        _module1Price.text = _grandTotalPrice.text;
    }
    
    // Module 2
    if (_cabinet.module2 && ![_cabinet.module2.size.name  isEqual: @"---"]) {

        _module2Title.hidden = NO;
        _module2Desc.hidden = NO;
        _module2Price.hidden = NO;

        _module2Desc.text = _cabinet.module2.size.name;
        [self printModuleInfo:_cabinet.module2 andSubmodules:_module2Submodules];
        _module2Price.text = [NSString stringWithFormat:@"%.2f €",[_priceManager getCabinetPrice:_cabinet forModule:1]];
    }

    // Module 3
    if (_cabinet.module3 && ![_cabinet.module3.size.name  isEqual: @"---"]) {

        _module3Title.hidden = NO;
        _module3Desc.hidden = NO;
        _module3Price.hidden = NO;

        _module3Desc.text = _cabinet.module3.size.name;
        [self printModuleInfo:_cabinet.module3 andSubmodules:_module3Submodules];
        _module3Price.text = [NSString stringWithFormat:@"%.2f €",[_priceManager getCabinetPrice:_cabinet forModule:2]];
    }

    // Module 4
    if (_cabinet.module4 && ![_cabinet.module4.size.name  isEqual: @"---"]) {

        _module4Title.hidden = NO;
        _module4Desc.hidden = NO;
        _module4Price.hidden = NO;

        _module4Desc.text = _cabinet.module4.size.name;
        [self printModuleInfo:_cabinet.module4 andSubmodules:_module4Submodules];
        _module4Price.text = [NSString stringWithFormat:@"%.2f €",[_priceManager getCabinetPrice:_cabinet forModule:3]];
    }
}

-(void)setInitialLayout
{
    // Modules titles
    _module2Title.hidden = YES;
    _module3Title.hidden = YES;
    _module4Title.hidden = YES;
    
    // Modules description
    _module2Desc.hidden = YES;
    _module3Desc.hidden = YES;
    _module4Desc.hidden = YES;
    
    // Modules Prices
    _module2Price.hidden = YES;
    _module3Price.hidden = YES;
    _module4Price.hidden = YES;

    // Hide Extra Prices
    _topColorExtraPrice.hidden = YES;
    _sideColorExtraPrice.hidden = YES;
    
    // Module 1
    _subModule_1_1_Desc.text = defaultModuleDescriptionText;
    _subModule_1_1_Color.hidden = YES;
    _subModule_1_1_Price.hidden = YES;
    
    _subModule_1_2_Desc.text = @"";
    _subModule_1_2_Color.hidden = YES;
    _subModule_1_2_Price.hidden = YES;

    _subModule_1_3_Desc.text = @"";
    _subModule_1_3_Color.hidden = YES;
    _subModule_1_3_Price.hidden = YES;

    _subModule_1_1_ExtraPrice.hidden = YES;
    _subModule_1_2_ExtraPrice.hidden = YES;
    _subModule_1_3_ExtraPrice.hidden = YES;
    
    // Module 2
    _subModule_2_1_Desc.text = defaultModuleDescriptionText;
    _subModule_2_1_Color.hidden = YES;
    _subModule_2_1_Price.hidden = YES;
    
    _subModule_2_2_Desc.text = @"";
    _subModule_2_2_Color.hidden = YES;
    _subModule_2_2_Price.hidden = YES;
    
    _subModule_2_3_Desc.text = @"";
    _subModule_2_3_Color.hidden = YES;
    _subModule_2_3_Price.hidden = YES;

    _subModule_2_1_ExtraPrice.hidden = YES;
    _subModule_2_2_ExtraPrice.hidden = YES;
    _subModule_2_3_ExtraPrice.hidden = YES;
    
    // Module 3
    _subModule_3_1_Desc.text = defaultModuleDescriptionText;
    _subModule_3_1_Color.hidden = YES;
    _subModule_3_1_Price.hidden = YES;
    
    _subModule_3_2_Desc.text = @"";
    _subModule_3_2_Color.hidden = YES;
    _subModule_3_2_Price.hidden = YES;
    
    _subModule_3_3_Desc.text = @"";
    _subModule_3_3_Color.hidden = YES;
    _subModule_3_3_Price.hidden = YES;
    
    _subModule_3_1_ExtraPrice.hidden = YES;
    _subModule_3_2_ExtraPrice.hidden = YES;
    _subModule_3_3_ExtraPrice.hidden = YES;

    // Module 4
    _subModule_4_1_Desc.text = defaultModuleDescriptionText;
    _subModule_4_1_Color.hidden = YES;
    _subModule_4_1_Price.hidden = YES;
    
    _subModule_4_2_Desc.text = @"";
    _subModule_4_2_Color.hidden = YES;
    _subModule_4_2_Price.hidden = YES;
    
    _subModule_4_3_Desc.text = @"";
    _subModule_4_3_Color.hidden = YES;
    _subModule_4_3_Price.hidden = YES;
    
    _subModule_4_1_ExtraPrice.hidden = YES;
    _subModule_4_2_ExtraPrice.hidden = YES;
    _subModule_4_3_ExtraPrice.hidden = YES;
}

-(int)getNumberOfDoors:(NSString *)sizeCode
{
    NSArray *sizeComponents = [sizeCode componentsSeparatedByString:@","];
    return [sizeComponents[0] intValue];
}

-(int)getNumberOfDrawers:(NSString *)sizeCode
{
    NSArray *sizeComponents = [sizeCode componentsSeparatedByString:@","];
    return [sizeComponents[1] intValue];
}

-(void)initializeSubmodulesArrays
{
    _module1Submodules = [[NSArray alloc] init];
    _module2Submodules = [[NSArray alloc] init];
    _module3Submodules = [[NSArray alloc] init];
    _module4Submodules = [[NSArray alloc] init];
    
    NSArray *subSubmodule1;
    NSArray *subSubmodule2;
    NSArray *subSubmodule3;
    
    
    // Module 1
    subSubmodule1 = @[_subModule_1_1_Desc, _subModule_1_1_Color, _subModule_1_1_Price, _subModule_1_1_ExtraPrice];
    subSubmodule2 = @[_subModule_1_2_Desc, _subModule_1_2_Color, _subModule_1_2_Price, _subModule_1_2_ExtraPrice];
    subSubmodule3 = @[_subModule_1_3_Desc, _subModule_1_3_Color, _subModule_1_3_Price, _subModule_1_3_ExtraPrice];
    
    _module1Submodules = @[subSubmodule1, subSubmodule2, subSubmodule3];
    
    // Module 2
    subSubmodule1 = @[_subModule_2_1_Desc, _subModule_2_1_Color, _subModule_2_1_Price, _subModule_2_1_ExtraPrice];
    subSubmodule2 = @[_subModule_2_2_Desc, _subModule_2_2_Color, _subModule_2_2_Price, _subModule_2_2_ExtraPrice];
    subSubmodule3 = @[_subModule_2_3_Desc, _subModule_2_3_Color, _subModule_2_3_Price, _subModule_2_3_ExtraPrice];
    
    _module2Submodules = @[subSubmodule1, subSubmodule2, subSubmodule3];

    // Module 3
    subSubmodule1 = @[_subModule_3_1_Desc, _subModule_3_1_Color, _subModule_3_1_Price, _subModule_3_1_ExtraPrice];
    subSubmodule2 = @[_subModule_3_2_Desc, _subModule_3_2_Color, _subModule_3_2_Price, _subModule_3_2_ExtraPrice];
    subSubmodule3 = @[_subModule_3_3_Desc, _subModule_3_3_Color, _subModule_3_3_Price, _subModule_3_3_ExtraPrice];
    
    _module3Submodules = @[subSubmodule1, subSubmodule2, subSubmodule3];
    
    //Module 4
    subSubmodule1 = @[_subModule_4_1_Desc, _subModule_4_1_Color, _subModule_4_1_Price, _subModule_4_1_ExtraPrice];
    subSubmodule2 = @[_subModule_4_2_Desc, _subModule_4_2_Color, _subModule_4_2_Price, _subModule_4_2_ExtraPrice];
    subSubmodule3 = @[_subModule_4_3_Desc, _subModule_4_3_Color, _subModule_4_3_Price, _subModule_4_3_ExtraPrice];
    
    _module4Submodules = @[subSubmodule1, subSubmodule2, subSubmodule3];
}

-(void)printModuleInfo:(IWCabinet *)cabinetModule andSubmodules:(NSArray *)moduleSubmodules
{
    int doorsCounter;
    int drawersCounter;
    
    doorsCounter = [self getNumberOfDoors:cabinetModule.size.code];
    drawersCounter = [self getNumberOfDrawers:cabinetModule.size.code];
    
    int submoduleIndex = 0;
    for (int drawerIndex = 0; drawerIndex < drawersCounter; drawerIndex++) {
        UILabel* mylabel;
        NSArray* mySubmodules = moduleSubmodules[submoduleIndex];
        
        // Desc
        mylabel = mySubmodules[0];
        mylabel.hidden = NO;
        mylabel.text = @"Drawer";
        
        // Color
        mylabel = mySubmodules[1];
        mylabel.hidden = NO;
        
        IWColor* myColor = cabinetModule.drawers[drawerIndex];
        mylabel.text = myColor.name;
        
        // Price
        mylabel = mySubmodules[2];
        mylabel.hidden = NO;
        mylabel.text = @"0";
        
        submoduleIndex++;
    }
    
    for (int doorIndex = 0; doorIndex < doorsCounter; doorIndex++) {
        UILabel* mylabel;
        NSArray* mySubmodules = moduleSubmodules[submoduleIndex];
        
        // Desc
        mylabel = mySubmodules[0];
        mylabel.hidden = NO;
        mylabel.text = @"Door";
        
        // Color
        mylabel = mySubmodules[1];
        mylabel.hidden = NO;
        
        IWColor* myColor = cabinetModule.colors[doorIndex];
        mylabel.text = myColor.name;
        
        // Price
        mylabel = mySubmodules[2];
        mylabel.hidden = NO;
        mylabel.text = @"0";
        
        submoduleIndex++;
    }
}

@end
