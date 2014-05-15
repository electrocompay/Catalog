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
    [picker2 setTitle:@"Type"];
    [picker3 setDelegate:self];
    [picker3 setTitle:@"Size"];
    [picker4 setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pickerViewController:(IWPickerViewController *)pickerViewController didSelectRow:(IWColor*)color
{
    BOOL cascadeChange = NO;
    if (pickerViewController == pickerModel) {
        _cabinet.model = (IWModel*) pickerModel.selection;
        if ([color.code isEqualToString:@"40"]) {
            [picker2 setItems:[IWColors cabinet40Types]];
        } else if ([color.code isEqualToString:@"55"]){
            [picker2 setItems:[IWColors cabinet55Types]];
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
    
    NSLog(@"model %@", _cabinet.model.code);
    NSLog(@"type %@", _cabinet.type.code);
    NSLog(@"size %@", _cabinet.size.code);
    _cabinet.model = (IWModel*) pickerModel.selection;
    if (_delegate) {
        [_delegate didSelect:self andColor:color];
    }
}



@end
