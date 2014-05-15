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

@interface IWPickerViewController : UIView<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id<IWPickerViewControllerDelegate> delegate;
-(void)reloadAllComponents;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) IWColor* selection;

@end
