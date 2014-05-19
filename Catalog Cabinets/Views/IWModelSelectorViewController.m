//
//  IWSelectorView.m
//  Catalog
//
//  Created by Abel Miranda on 4/8/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWModelSelectorViewController.h"
#import "IWPickerViewController.h"
#import "IWColors.h"

@interface IWModelSelectorViewController ()

@end

@implementation IWModelSelectorViewController
{
    IBOutlet IWPickerViewController *pickerModel;
    IBOutlet IWPickerViewController *picker2;
    IBOutlet IWPickerViewController *picker3;
    IBOutlet IWPickerViewController *picker4;
    IBOutlet IWPickerViewController *picker5;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [pickerModel setItems:[IWColors cabinetModels]];
    [pickerModel setDelegate:self];
    [picker2 setDelegate:self];
    [picker3 setDelegate:self];
    [picker4 setDelegate:self];
    [picker5 setDelegate:self];
    [self pickerViewController:pickerModel didSelectRow:pickerModel.selection];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pickerViewController:(IWPickerViewController *)pickerViewController didSelectRow:(IWColor*)color
{
    _cabinet.model = (IWModel*) pickerModel.selection;
    if (_cabinet.useDoors) {
        [self processSelectionDoors:pickerViewController didSelectRow:color];
    } else if (_cabinet.useModules)
    {
        [self processSelectionModules:pickerViewController didSelectRow:color];
    }
    
    if (_delegate) {
        [_delegate didSelect:self andColor:color];
    }
}

-(void)processSelectionDoors:(IWPickerViewController *)pickerViewController didSelectRow:(IWColor*)color
{
    BOOL cascadeChange = NO;
    if (pickerViewController == pickerModel) {
        _cabinet.model = (IWModel*) pickerModel.selection;
        if ([color.code isEqualToString:@"40"]) {
            [picker2 setItems:[IWColors cabinet40Types]];
            [self setModeCube];
        } else if ([color.code isEqualToString:@"55"]){
            [self setModeCube];
            [picker2 setItems:[IWColors cabinet55Types]];
        } else if ([color.code isEqualToString:@"C193"]){
            [self setModeCube];
            picker3.frame = picker2.frame;
            [picker2 setHidden:YES];
            [picker3 setItems:[IWColors cabinetC193Sizes]];
        }
        
        [picker2 reloadAllComponents];
        _cabinet.type = picker2.selection;
        cascadeChange = YES;
        
    }
    
    if (pickerViewController == picker2 || cascadeChange){
        _cabinet.type = picker2.selection;
        if ([_cabinet.model.code isEqualToString:@"40"]) {
            if ([_cabinet.type.code isEqualToString:@"H"]) {
                [picker3 setItems:[IWColors cabinet40HSizes]];
            } else if ([_cabinet.type.code isEqualToString:@"B"]){
                [picker3 setItems:[IWColors cabinet40BSizes]];
            } else if ([_cabinet.type.code isEqualToString:@"K"]){
                [picker3 setItems:[IWColors cabinet40KSizes]];
            }
        } else if ([_cabinet.model.code isEqualToString:@"55"]){
            if ([_cabinet.type.code isEqualToString:@"H"]) {
                [picker3 setItems:[IWColors cabinet55HSizes]];
            } else if ([_cabinet.type.code isEqualToString:@"B"]){
                [picker3 setItems:[IWColors cabinet55BSizes]];
            } else if ([_cabinet.type.code isEqualToString:@"K"]){
                [picker3 setItems:[IWColors cabinet55KSizes]];
            }
            cascadeChange = YES;
        }
        [picker3 reloadAllComponents];
        _cabinet.size = picker3.selection;
    }
    
    if (pickerViewController == picker3 || cascadeChange)
    {
        _cabinet.size = picker3.selection;
    }
    
}

-(void)processSelectionModules:(IWPickerViewController *)pickerViewController didSelectRow:(IWColor*)color
{
    if (pickerViewController == pickerModel) {
        [self setModeCosYJoli83];
    } else if (pickerViewController == picker2) {
        _cabinet.size = picker2.selection;
    } else if (pickerViewController == picker3) {
        _cabinet.module2.size = picker3.selection;
    } else if (pickerViewController == picker4) {
        _cabinet.module3.size = picker4.selection;
    } else if (pickerViewController == picker5) {
        _cabinet.module4.size = picker5.selection;
    }
}

-(void)setModeCosYJoli83
{
    [picker2 setTitle:@"Module 1"];
    [picker2 setItems:[IWColors cabinet83Modules]];
    [picker3 setTitle:@"Module 2"];
    [picker3 setItems:[IWColors cabinet83Modules]];
    [picker4 setTitle:@"Module 3"];
    [picker4 setItems:[IWColors cabinet83Modules]];
    [picker5 setTitle:@"Module 4"];
    [picker5 setItems:[IWColors cabinet83Modules]];
    [picker4 setHidden:NO];
    [picker5 setHidden:NO];
}

-(void)setModeCube
{
    [picker2 setTitle:@"Type"];
    [picker3 setTitle:@"Size"];
    [picker4 setHidden:YES];
    [picker5 setHidden:YES];
    
}

@end
