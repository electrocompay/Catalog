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

const int OFFSET_CUBE_83 = 40;
const int OC = OFFSET_CUBE_83;

@interface IWModelSelectorViewController ()

@end

@implementation IWModelSelectorViewController
{
    IBOutlet IWPickerViewController *pickerModel;
    IBOutlet IWPickerViewController *picker1;
    IBOutlet IWPickerViewController *picker2;
    IBOutlet IWPickerViewController *picker3;
    IBOutlet IWPickerViewController *picker4;
    
    IBOutlet UIView *cube83View;
    IBOutlet UIButton *btCosy83;
    IBOutlet UIButton *btJoly83;
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
    [picker1 setDelegate:self];
    [picker2 setDelegate:self];
    [picker3 setDelegate:self];
    [picker4 setDelegate:self];
    [self pickerViewController:pickerModel didSelectRow:pickerModel.selection];
    
    cube83View.hidden = YES;
    
    [self initialPickersPositions];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pickerViewController:(IWPickerViewController *)pickerViewController didSelectRow:(IWColor*)color
{
    IWColor* prevModel = _cabinet.model;
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

    [self initialPickersPositions];
    if ([_cabinet.model.code isEqualToString:@"C193"])
    {
        [self setC193SizePickerLeftPosition];
    }
    else
    {
        [picker1 setHidden:NO];
    }
    
    cube83View.hidden = YES;
    if ([_cabinet.model.code isEqualToString:@"C83"]) {
        cube83View.hidden = NO;
        [self initialPickersPositions];
        if (![prevModel.code isEqualToString:@"C83"])
            [self movePickersRight];
    }
}

-(void)processSelectionDoors:(IWPickerViewController *)pickerViewController didSelectRow:(IWColor*)color
{
    BOOL cascadeChange = NO;
    if (pickerViewController == pickerModel) {
        _cabinet.model = (IWModel*) pickerModel.selection;
        if ([color.code isEqualToString:@"40"]) {
            [picker1 setItems:[IWColors cabinet40Types]];
            [self setModeCube];
        } else if ([color.code isEqualToString:@"55"]){
            [self setModeCube];
            [picker1 setItems:[IWColors cabinet55Types]];
        } else if ([color.code isEqualToString:@"C193"]){
            [self setModeCube];
            picker2.frame = picker1.frame;
            [picker1 setHidden:YES];
            [picker2 setItems:[IWColors cabinetC193Sizes]];
        }
        
        [picker1 reloadAllComponents];
        _cabinet.type = picker1.selection;
        cascadeChange = YES;
        
    }
    
    if (pickerViewController == picker1 || cascadeChange){
        _cabinet.type = picker1.selection;
        if ([_cabinet.model.code isEqualToString:@"40"]) {
            if ([_cabinet.type.code isEqualToString:@"H"]) {
                [picker2 setItems:[IWColors cabinet40HSizes]];
            } else if ([_cabinet.type.code isEqualToString:@"B"]){
                [picker2 setItems:[IWColors cabinet40BSizes]];
            } else if ([_cabinet.type.code isEqualToString:@"K"]){
                [picker2 setItems:[IWColors cabinet40KSizes]];
            }
        } else if ([_cabinet.model.code isEqualToString:@"55"]){
            if ([_cabinet.type.code isEqualToString:@"H"]) {
                [picker2 setItems:[IWColors cabinet55HSizes]];
            } else if ([_cabinet.type.code isEqualToString:@"B"]){
                [picker2 setItems:[IWColors cabinet55BSizes]];
            } else if ([_cabinet.type.code isEqualToString:@"K"]){
                [picker2 setItems:[IWColors cabinet55KSizes]];
            }
            cascadeChange = YES;
        }
        [picker2 reloadAllComponents];
        _cabinet.size = picker2.selection;
    }
    
    if (pickerViewController == picker2 || cascadeChange)
    {
        _cabinet.size = picker2.selection;
    }
    
}

-(void)processSelectionModules:(IWPickerViewController *)pickerViewController didSelectRow:(IWColor*)color
{

    if (pickerViewController == pickerModel) {
        [self setModeCosYJoli83];
    }
    
    if (pickerViewController == picker1) {
        _cabinet.size = picker1.selection;
        _cabinet.stripe = nil;
        picker2.enabled = YES;
    }
    
    if (pickerViewController == picker2) {
        _cabinet.module2.size = picker2.selection;
        _cabinet.module2.stripe = nil;
        picker3.enabled = YES;
        if (picker2.selectedIndex == 0) {
            [picker3 reset];
            [picker4 resetAndDisable];
            _cabinet.module4.size = picker4.selection;
        }
        
    }
    
    if (pickerViewController == picker3) {
        _cabinet.module3.size = picker3.selection;
        _cabinet.module3.stripe = nil;
        picker4.enabled = YES;
        if (picker3.selectedIndex == 0) {
            [picker4 reset];
            _cabinet.module4.size = picker4.selection;
        }
    }
    
    if (pickerViewController == picker4) {
        _cabinet.module4.size = picker4.selection;
        _cabinet.module4.stripe = nil;
    }
    
    _cabinet.module2.size = picker2.selection;
    _cabinet.module3.size = picker3.selection;
    _cabinet.module4.size = picker4.selection;
    picker1.left = 0;
    
    
    NSInteger weight1 =  _cabinet.drawers.count > 0 ? 2 : _cabinet.colors.count;
    NSInteger weight2 =  _cabinet.module2.drawers.count > 0 ? 2 : _cabinet.module2.colors.count;
    NSInteger weight3 =  _cabinet.module3.drawers.count > 0 ? 2 : _cabinet.module3.colors.count;
    NSInteger weight4 =  _cabinet.module4.drawers.count > 0 ? 2 : _cabinet.module4.colors.count;
    
    picker1.right = weight2;
    picker2.left = weight1;
    picker2.right = weight3;
    picker3.left = weight2;
    picker3.right = weight4;
    picker4.left = weight3;
    picker4.right = 0;
    if (weight1 + weight2 + weight3 == 5) {
        picker4.dissableMoreThan1 = YES;
        if (picker4.left == 1) {
            [picker4 resetAndDisable];
            _cabinet.module4.size = picker4.selection;
        }
    } else {
        picker4.dissableMoreThan1 = NO;
    }
    
    picker3.enabled = picker2.selectedIndex > 0;
    picker4.enabled = picker3.selectedIndex > 0 && !(picker4.dissableMoreThan1 && picker4.left == 1);
    if (weight1 + weight2 + weight3 == 6) {
       // [picker4 resetAndDisable];
        picker4.dissableMoreThan1 = YES;
        picker4.left = 1;
        _cabinet.module4.size = picker4.selection;
    }
    
    //[self refreshPickers];
    
    [_delegate didSelect:self andColor:color];
}

-(void)removeOneDoor:(IWPickerViewController*)picker
{
    NSInteger currentSelection = [picker.items indexOfObject:picker.selection];
    NSMutableArray *array = [NSMutableArray arrayWithArray:picker.items];
    IWColor *color = [array objectAtIndex:1];
    if ([color.code isEqualToString:@"1,0"]) {
        [array removeObject:color];
    }
    [picker setItems:array];
    
    if (currentSelection > 1) {
        picker.selection = [array objectAtIndex:currentSelection--];
    }
}

-(void)setModeCosYJoli83
{
    [picker1 setTitle:@"M1 - Module 1"];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[IWColors cabinet83Modules]];
    [array removeObjectAtIndex:0];
    [picker1 setItems:array];
    [picker2 setItems:[IWColors cabinet83Modules]];
    [picker3 setItems:[IWColors cabinet83Modules]];
    [picker4 setItems:[IWColors cabinet83Modules]];

    [picker1 setSelection:[array objectAtIndex:0]];
    [self processSelectionModules:picker1 didSelectRow:picker1.selection];
    [picker2 setTitle:@"M2 - Module 2"];
    [picker3 setTitle:@"M3 - Module 3"];
    [picker4 setTitle:@"M4 - Module 4"];
    [picker3 setHidden:NO];
    [picker4 setHidden:NO];
}

-(void)initialPickersPositions
{
    pickerModel.frame = CGRectMake(14, 0, 170, 192);
    picker1.frame = CGRectMake(230, 0, 170, 192);
    picker2.frame = CGRectMake(430, 0, 170, 192);
    picker3.frame = CGRectMake(630, 0, 170, 192);
    picker4.frame = CGRectMake(830, 0, 170, 192);
}

-(void)movePickersRight
{
    picker4.frame = CGRectMake(picker4.frame.origin.x + OC, picker4.frame.origin.y, picker4.frame.size.width - OC, picker4.frame.size.height);
    picker3.frame = CGRectMake(picker3.frame.origin.x + OC * 2, picker3.frame.origin.y, picker3.frame.size.width - OC, picker3.frame.size.height);
    picker2.frame = CGRectMake(picker2.frame.origin.x + OC * 3, picker2.frame.origin.y, picker2.frame.size.width - OC, picker2.frame.size.height);
    picker1.frame = CGRectMake(picker1.frame.origin.x + OC * 4, picker1.frame.origin.y, picker1.frame.size.width - OC, picker1.frame.size.height);
}

-(void)setC193SizePickerLeftPosition
{
    picker2.frame = CGRectMake(picker1.frame.origin.x, picker1.frame.origin.y, 170, 192);
}

-(void)refreshPickers
{
    [picker1 refresh];
    [picker2 refresh];
    [picker3 refresh];
    [picker4 refresh];
}

-(void)setModeCube
{
    [picker1 setTitle:@"Type"];
    [picker2 setTitle:@"Size"];
    [picker3 setHidden:YES];
    [picker4 setHidden:YES];
}

- (IBAction)cube83CategorySelected:(UIButton *)sender {
    if (sender == btCosy83) {
        btCosy83.selected = YES;
        btJoly83.selected = NO;
    }
    else if (sender == btJoly83) {
        btJoly83.selected = YES;
        btCosy83.selected = NO;
    }
}


@end
