//
//  IWCabinetSummaryViewController.m
//  Catalog
//
//  Created by Abel Miranda on 5/3/15.
//  Copyright (c) 2015 Indian Webs. All rights reserved.
//

#import "IWCabinetSummaryViewController.h"
#import "IWCabinetSummaryView.h"

@interface IWCabinetSummaryViewController ()

@end

@implementation IWCabinetSummaryViewController{
    
    IWCabinet* _cabinet;
    IWCabinetSummaryView* _cabinetSummaryView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set Cabinets Title
    [self setTitle:@"CABINETS CONFIGURATION RESUME"];
    
    _cabinetSummaryView = [[IWCabinetSummaryView alloc] init];
    [viewContainer addSubview:_cabinetSummaryView];
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

-(void)showSummaryForCabinet:(IWCabinet *)cabinet
{
    _cabinet = cabinet;
    
    [self showSummary];
}

-(void)showSummary
{
    
    if (viewContainer && _cabinet) {
        [_cabinetSummaryView showSummaryForCabinet:_cabinet];
    }
    
}

@end
