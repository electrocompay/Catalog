//
//  IWSelectorTableViewController.m
//  Catalog
//
//  Created by Abel Miranda on 1/16/15.
//  Copyright (c) 2015 Indian Webs. All rights reserved.
//

#import "IWSelectorTableViewController.h"
#import "IWSimplePickerViewController.h"
#import "IWColors.h"
#import "IWModel.h"

@implementation IWSelectorTableViewController{

    IBOutlet UIButton *btDinningTable;
    IBOutlet UIButton *btCofeeTable;
    IBOutlet IWSimplePickerViewController *pickerSize;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    [pickerSize setDelegate:self];
}

-(IBAction)changeTypeClicked:(id)sender{
    if (sender == btDinningTable) {
        btDinningTable.selected = YES;
        btCofeeTable.selected = NO;
    } else if (sender == btCofeeTable){
        btCofeeTable.selected = YES;
        btDinningTable.selected = NO;
    }
    if (_tableDelegate){
        [_tableDelegate selectorTableViewController:self didSelectCofee:btCofeeTable.selected];
    }
}

-(void)setSelection:(NSInteger)index
{
    NSInteger prevSelection = self.selectedIndex;
    [super setSelection:index];
    if (prevSelection != index){
        [self loadSizes];
    }
}

-(void)loadSizes
{
    IWModel* model = (IWModel*) self.selectedColor;
    NSArray* sizes = model.sizes;
    [pickerSize setItems:sizes];
}

-(void)simplePickerViewController:(IWSimplePickerViewController *)simplePickerViewController didSelectRow:(IWColor *)color
{
    if (_tableDelegate) {
        [_tableDelegate selectorTableViewController: self didSelectSize:color];
    }
}

@end
