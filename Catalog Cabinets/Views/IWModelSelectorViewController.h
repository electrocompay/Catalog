//
//  IWSelectorView.h
//  Catalog
//
//  Created by Abel Miranda on 4/8/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWCabinet.h"
#import "IWPickerViewController.h"

@class IWModelSelectorViewController;

@protocol IWModelSelectorViewControllerDelegate <NSObject>

-(void) didSelect:(IWModelSelectorViewController*)modelSelectorViewController andColor:(IWColor*)color;
;

@end

@interface IWModelSelectorViewController : UIViewController<IWPickerViewControllerDelegate>

@property (nonatomic, strong) IWCabinet* cabinet;
@property (nonatomic, weak) id<IWModelSelectorViewControllerDelegate> delegate;

@end
