//
//  IWCabinetModelsViewController.h
//  Catalog
//
//  Created by Abel Miranda on 2/11/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWCabinetModelsViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate> {
    IBOutlet UIPickerView *pickerCube;
    IBOutlet UIPickerView *pickerType;
    IBOutlet UIPickerView *pickerSize;
}

@property NSString* cubeCode;


@property id<UIPickerViewDelegate> delegate;

@end
