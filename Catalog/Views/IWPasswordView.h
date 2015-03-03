//
//  IWPasswordViewViewController.h
//  Catalog
//
//  Created by Abel Miranda on 1/24/15.
//  Copyright (c) 2015 Indian Webs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IWPasswordView;

@protocol IWPasswordViewDelegate <NSObject>

-(void)passwordView:(IWPasswordView*) passwordView authenticateResult:(BOOL) authenticateResult;

@end

@interface IWPasswordView : UIView


-(void)showLeftTriangle;
-(void)showRightTriangle;
-(BOOL)isLeftVisible;

@property (nonatomic, weak) id<IWPasswordViewDelegate> delegate;

@end
