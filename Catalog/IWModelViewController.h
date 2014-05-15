//
//  IWModelViewController.h
//  Catalog
//
//  Created by Abel Miranda on 2/10/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrowserTabView.h"
#import "IWSelectorViewController.h"
#import "IWMenuView.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface IWModelViewController : UIViewController<BrowserTabViewDelegate, UIPickerViewDelegate, IWSelectorViewControllerDelegate, IWMenuViewdelegate, MFMailComposeViewControllerDelegate>
{
    IBOutlet UIView *tabContent;
    IBOutlet UIView *content;
}

@property (nonatomic, weak) IBOutlet UIView *tabContainer;

@end
