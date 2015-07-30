//
//  IWTableSummaryView.m
//  Catalog
//
//  Created by Abel Miranda on 3/5/15.
//  Copyright (c) 2015 Indian Webs. All rights reserved.
//

#import "IWTableSummaryView.h"
#import "IWDrawerTable.h"
#import "IWDrawerChair.h"
#import "IWPriceManager.h"

@interface IWTableSummaryView ()

@end

@implementation IWTableSummaryView{
    
    IWTable* _table;
    IWChair* _chair;
    
    float _tableUnitPrice;
    float _chairUnitPrice;
    
    int _chairCounter;
    float _tableSubTotalPrice;
    float _chairSubTotalPrice;
    float _grandSubTotalPrice;
    
    IBOutlet UIView* _topView;
    IBOutlet UIView* _frontView;
    
    IBOutlet UILabel* _tableModel;
    IBOutlet UILabel* _tableType;
    IBOutlet UILabel* _tableSize;
    IBOutlet UILabel* _tableColor;
    IBOutlet UILabel* _tableLegsColor;
    IBOutlet UILabel* _tablePrice;
    IBOutlet UILabel* _tableTotalPrice;

    IBOutlet UILabel* _chairModel;
    IBOutlet UILabel* _chairColor;
    IBOutlet UILabel* _chairLegsColor;
    IBOutlet UILabel* _chairPrice;
    
    IBOutlet UILabel*  _chairTotalQty;
    IBOutlet UIButton* _chairDecrementQty;
    IBOutlet UIButton* _chairIncrementQty;
    IBOutlet UILabel*  _chairQtyMessage;
    
    IBOutlet UILabel* _chairTotalPrice;
    
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
    UIView* view = [[[NSBundle mainBundle] loadNibNamed:@"IWTableSummaryView" owner:self options:nil] objectAtIndex:0];
    [self addSubview:view];
    self.frame = view.frame;
}

-(void)showSummaryForTable:(IWTable *)table andChair:(IWChair *)chair
{
    _table = table;
    _chair = chair;
    
    _tableUnitPrice = [[IWPriceManager getInstance] getTablePrice:_table];
    _chairUnitPrice = [[IWPriceManager getInstance] getChairPrice:_chair];
    
    // Only Dinning Table goes with chairs
    _chairCounter = 0;
    if (_table.tableType == kDinningTable) {
        _chairCounter = 1;
        
        IWDrawerChair* chairDrawer = [[IWDrawerChair alloc] init];
        
        [chairDrawer setView:_topView];
        [chairDrawer setFrontView:NO];
        
        [chairDrawer drawForniture:_chair];
        
        [chairDrawer setView:_frontView];
        [chairDrawer setFrontView:YES];
        
        [chairDrawer drawForniture:_chair];
    }

    // Always draw table
    IWDrawerTable* tableDrawer = [[IWDrawerTable alloc] init];
    
    [tableDrawer setView:_topView];
    [tableDrawer setFrontView:NO];
    
    [tableDrawer drawForniture:_table];
    
    [tableDrawer setView:_frontView];
    [tableDrawer setFrontView:YES];
    
    [tableDrawer drawForniture:_table];

    // Initial Price values
    _tableSubTotalPrice = _tableUnitPrice;
    _chairSubTotalPrice = _chairUnitPrice*_chairCounter;
    _grandSubTotalPrice = _tableSubTotalPrice + _chairSubTotalPrice;
    
    [self updateAttributes];
}

-(void)enableIncDecButtons:(BOOL)enable {
    if (enable == YES) {
        _chairDecrementQty.enabled = YES;
        _chairIncrementQty.enabled = YES;
        _chairDecrementQty.alpha = 1;
        _chairIncrementQty.alpha = 1;
    }
    else {
        _chairDecrementQty.enabled = NO;
        _chairIncrementQty.enabled = NO;
        _chairDecrementQty.alpha = 0.4;
        _chairIncrementQty.alpha = 0.4;
    }
}

-(IBAction)decrementChairNumber:(id)sender {
    if (_chairCounter > 0) {
        _chairCounter--;
        
        // Update Totals
        _chairSubTotalPrice -= _chairUnitPrice;
        _grandSubTotalPrice -= _chairUnitPrice;
        [self refreshChairCounterAndPrices];
    }
}

-(IBAction)incrementChairNumber:(id)sender {
    _chairCounter++;
    
    // Update Totals
    _chairSubTotalPrice += _chairUnitPrice;
    _grandSubTotalPrice += _chairUnitPrice;
    [self refreshChairCounterAndPrices];
}

-(void)updateAttributes
{
    [_tableModel setText:_table.model.name];
    
    if (_table.tableType == kDinningTable) {
        _tableType.text = kDinningTableText;
    }
    else if (_table.tableType == kWallTable) {
        _tableType.text = kWallTableText;
    }
    else if (_table.tableType == kCoffeeTable) {
        _tableType.text = kCoffeeTableText;
    }
    
    [_tableSize setText:_table.size.name];
    [_tableColor setText:_table.color.name];
    [_tableLegsColor setText:_table.legsColor.name];
    
    if (_table.tableType == kDinningTable) {
        [self enableChairSummary];
    }
    else {
        [self disableChairSummary];
    }
    
    [self refreshChairCounterAndPrices];
}

-(void)disableChairSummary {
    
    _chairModel.text = @"";
    _chairColor.text = @"";
    _chairLegsColor.text = @"";
    
    [self enableIncDecButtons:NO];
    [_chairQtyMessage setText:kChairsNotAvailableMessage];
}

-(void)enableChairSummary {

    _chairModel.text = _chair.model.name;
    _chairColor.text = _chair.color.name;
    _chairLegsColor.text = _chair.legsColor.name;
    
    [self enableIncDecButtons:YES];
    [_chairQtyMessage setText:kSelectChairsNumberMessage];
}

-(void)refreshChairCounterAndPrices {
    
    // Update counter label
    [_chairTotalQty setText:[NSString stringWithFormat:@"%d", _chairCounter]];
    
    // Update prices
    [_tablePrice setText:[NSString stringWithFormat:@"%.0f €", _tableUnitPrice]];
    [_tableTotalPrice setText:[NSString stringWithFormat:@"%.0f €", _tableSubTotalPrice]];
    
    [_chairPrice setText:[NSString stringWithFormat:@"%.0f €", _chairSubTotalPrice]];
    [_chairTotalPrice setText:[NSString stringWithFormat:@"%.0f €", _chairSubTotalPrice]];
    
    [_grandTotalPrice setText:[NSString stringWithFormat:@"%.0f €", _grandSubTotalPrice]];
}

@end
