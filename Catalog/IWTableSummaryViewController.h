//
//  IWTableSummaryViewController.h
//  Catalog
//
//  Created by Abel Miranda on 3/5/15.
//  Copyright (c) 2015 Indian Webs. All rights reserved.
//

#import "IWSummaryViewController.h"
#import "IWTable.h"
#import "IWChair.h"

@interface IWTableSummaryViewController : IWSummaryViewController

-(void)showSummaryForTable:(IWTable*)table andChair:(IWChair*)chair;

@end
