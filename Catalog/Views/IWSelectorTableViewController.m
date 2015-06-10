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
    BOOL changed = NO;
    if (sender == btDinningTable) {
        changed = !btDinningTable.selected;
        btDinningTable.selected = YES;
        btCofeeTable.selected = NO;
    } else if (sender == btCofeeTable){
        changed = !btCofeeTable.selected;
        btCofeeTable.selected = YES;
        btDinningTable.selected = NO;
    }
    if (changed) {
        [self loadSizes];
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
        btDinningTable.enabled = [self getSelectedModel].sizes.count > 0;
        btCofeeTable.enabled = [self getSelectedModel].smallSizes.count > 0;
        if (!btDinningTable.enabled) {
            btDinningTable.selected = NO;
            btCofeeTable.selected = YES;
        } else {
            btDinningTable.selected = YES;
            btCofeeTable.selected = NO;
        }
        [self loadSizes];
    }
}

-(void)loadSizes
{
    IWModel* model = (IWModel*) self.selectedColor;
    NSArray* sizes = btCofeeTable.selected ? model.smallSizes : model.sizes;
    [pickerSize setItems:sizes];
    if (sizes.count > 0) {
        [self simplePickerViewController:pickerSize didSelectRow:[sizes objectAtIndex:0]];
    }
}

-(void)simplePickerViewController:(IWSimplePickerViewController *)simplePickerViewController didSelectRow:(IWColor *)color
{
    if (_tableDelegate) {
        [_tableDelegate selectorTableViewController: self didSelectSize:color];
    }
}

-(IWModel*)getSelectedModel
{
    return (IWModel*) self.selectedColor;
}

@end
