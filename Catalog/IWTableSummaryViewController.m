//
//  IWTableSummaryViewController.m
//  Catalog
//
//  Created by Abel Miranda on 3/5/15.
//  Copyright (c) 2015 Indian Webs. All rights reserved.
//

#import "IWTableSummaryViewController.h"
#import "IWTableSummaryView.h"

@interface IWTableSummaryViewController ()

@end

@implementation IWTableSummaryViewController{
    
    IWTable* _table;
    IWChair* _chair;
    IWTableSummaryView* _tableSummaryView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _tableSummaryView = [[IWTableSummaryView alloc] init];
    [viewContainer addSubview:_tableSummaryView];
    [self showSummary];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)showSummaryForTable:(IWTable *)table andChair:(id)chair
{
    _table = table;
    _chair = chair;
    
    [self showSummary];
}

-(void)showSummary
{
    
    if (viewContainer && _table && _chair) {
        [_tableSummaryView showSummaryForTable:_table andChair:_chair];
    }
    
}

@end
