//
//  IWSeletorTableViewController.h
//  Catalog
//
//  Created by Abel Miranda on 1/16/15.
//  Copyright (c) 2015 Indian Webs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "IWSelectorViewController.h"
#import "IWSimplePickerViewController.h"

@class IWSelectorTableViewController;

@protocol IWSelectorTableViewControllerDelegate<NSObject>

- (void) selectorTableViewController: (IWSelectorTableViewController*) selectorTableViewController didSelectSize:(IWColor*) size;
- (void) selectorTableViewController: (IWSelectorTableViewController*) selectorTableViewController didSelectOther:(tableTypeEnum) tableType;

@end

@interface IWSelectorTableViewController : IWSelectorViewController<IWSimplePickerViewControllerDelegate>

@property (nonatomic, assign) tableTypeEnum tableType;
@property (nonatomic, weak) id<IWSelectorTableViewControllerDelegate> tableDelegate;
-(void)loadSizes;

@end
