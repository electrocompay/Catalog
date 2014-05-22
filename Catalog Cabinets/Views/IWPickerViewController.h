//
//  IWPickerViewViewController.h
//  Catalog
//
//  Created by Abel Miranda on 5/11/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWColor.h"

@class IWPickerViewController;

@protocol IWPickerViewControllerDelegate<NSObject>

-(void)pickerViewController :(IWPickerViewController*) pickerViewController didSelectRow:(IWColor*) color;

@end

@interface IWPickerViewController : UIView<UIPickerViewDataSource, UIPickerViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id<IWPickerViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) IWColor* selection;
@property (nonatomic) BOOL enabled;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic) NSInteger left;
@property (nonatomic) NSInteger right;


-(void)reloadAllComponents;
-(void)reset;
-(void)resetAndDisable;
-(void)refresh;

@end
