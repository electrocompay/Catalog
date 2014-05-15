//
//  IWCabinetModelsViewController.m
//  Catalog
//
//  Created by Abel Miranda on 2/11/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWCabinetModelsViewController.h"
#import "IWCube.h"
#import "IWOption.h"
#import "IWType.h"

@interface IWCabinetModelsViewController ()

@end

@implementation IWCabinetModelsViewController
{
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    pickerCube.delegate = self;
    pickerType.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == pickerCube)
            return [IWCube getOptions].count;
    else if (pickerView == pickerType)
            return [IWType getTypeOptionsFor: _cubeCode].count;
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == pickerCube){
            IWOption *option = [[IWCube getOptions] objectAtIndex:row];
            return option.description;
        }
            
   else if (pickerView == pickerType){
            IWOption *option = [[IWType getTypeOptionsFor: _cubeCode] objectAtIndex:row];;
            return option.description;
        }

    return nil;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == pickerCube){
            IWOption *option = [[IWCube getOptions] objectAtIndex:row];
            _cubeCode = option.code;
            [pickerType reloadAllComponents];
            if (_delegate) {
                [_delegate pickerView: pickerView didSelectRow: row inComponent:component];
            }
    }
            
}

@end
