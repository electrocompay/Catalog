//
//  IWTableSummaryView.h
//  Catalog
//
//  Created by Abel Miranda on 3/5/15.
//  Copyright (c) 2015 Indian Webs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWTable.h"
#import "IWChair.h"

@interface IWTableSummaryView : UIView

-(void)showSummaryForTable:(IWTable*)table andChair:(IWChair*)chair;

@end
