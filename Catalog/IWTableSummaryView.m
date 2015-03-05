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
    
    IWDrawerTable* tableDrawer = [[IWDrawerTable alloc] init];
    IWDrawerChair* chairDrawer = [[IWDrawerChair alloc] init];

    [tableDrawer setView:_topView];
    [tableDrawer setFrontView:NO];
    [chairDrawer setView:_topView];
    [chairDrawer setFrontView:NO];
    
    [tableDrawer drawForniture:_table];
    [chairDrawer drawForniture:_chair];

    
    [tableDrawer setView:_frontView];
    [tableDrawer setFrontView:YES];
    [chairDrawer setView:_frontView];
    [chairDrawer setFrontView:YES];
    
    [tableDrawer drawForniture:_table];
    [chairDrawer drawForniture:_chair];
    
    [self updateAttributes];
}

-(void)updateAttributes
{
    [_tableModel setText:_table.model.name];
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

}

@end
