//
//  IWPickerViewViewController.h
//  Catalog
//
//  Created by Abel Miranda on 5/11/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWColor.h"

@class IWSimplePickerViewController;

@protocol IWSimplePickerViewControllerDelegate<NSObject>

-(void)simplePickerViewController :(IWSimplePickerViewController*) simplePickerViewController didSelectRow:(IWColor*) color;

@end

@interface IWSimplePickerViewController : UIView<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id<IWSimplePickerViewControllerDelegate> delegate;
@property (nonatomic, strong) IWColor* selection;
@property (nonatomic) BOOL enabled;
@property (nonatomic) NSInteger selectedIndex;

-(void)reloadAllComponents;
-(void)reset;
-(void)resetAndDisable;
-(void)refresh;

@end
