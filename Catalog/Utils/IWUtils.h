//
//  IWUtils.h
//  Catalog
//
//  Created by Abel Miranda on 3/9/15.
//  Copyright (c) 2015 Indian Webs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface IWUtils : NSObject<MFMailComposeViewControllerDelegate>

+(IWUtils*)getInstance;
-(void)generateJPG:(UIView*)view completionTarget:(id)completionTarget completionSelector:(SEL)completionSelector;
-(UIImage*)captureViewFrom:(UIView*)view;
-(void)printView:(UIView*)view;
-(void)displayComposerSheet:(UIView*)view viewC:(UIViewController*)viewC;

@end
