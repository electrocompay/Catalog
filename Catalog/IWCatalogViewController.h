//
//  IWMainViewController.h
//  Catalog
//
//  Created by Abel Miranda on 2/9/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>
#import "IWBaseViewController.h"

@interface IWCatalogViewController : IWBaseViewController<QLPreviewControllerDataSource, QLPreviewControllerDelegate>

@end
