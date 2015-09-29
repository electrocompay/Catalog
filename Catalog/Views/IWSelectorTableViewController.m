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
    IBOutlet UIButton *btWallTable;
    IBOutlet UIButton *btCofeeTable;

    IBOutlet UILabel *lbDinningTable;
    IBOutlet UILabel *lbWallTable;
    IBOutlet UILabel *lbCofeeTable;
    
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
        btWallTable.selected = NO;
        btCofeeTable.selected = NO;
        
        self.tableType = kDinningTable;

    } else if (sender == btWallTable) {
        changed = !btWallTable.selected;
        btWallTable.selected = YES;
        btDinningTable.selected = NO;
        btCofeeTable.selected = NO;

        self.tableType = kWallTable;

    } else if (sender == btCofeeTable) {
        changed = !btCofeeTable.selected;
        btCofeeTable.selected = YES;
        btDinningTable.selected = NO;
        btWallTable.selected = NO;
    
        self.tableType = kCoffeeTable;
    }
    
    if (changed) {
        [self loadSizes];
    }
    
    if (_tableDelegate){
        [_tableDelegate selectorTableViewController:self didSelectOther:self.tableType];
    }
}

-(void)setSelection:(NSInteger)index
{
    NSInteger prevSelection = self.selectedIndex;
    [super setSelection:index];
    if (prevSelection != index){

        [self clearOptions];
        
        if(!(btDinningTable.enabled = [self getSelectedModel].sizes.count > 0)) {
            [self grayOutOption:kDinningTable];
        }
        
        if(!(btWallTable.enabled = [self getSelectedModel].wallSizes.count > 0)) {
            [self grayOutOption:kWallTable];
        }

        if(!(btCofeeTable.enabled = [self getSelectedModel].smallSizes.count > 0)) {
            [self grayOutOption:kCoffeeTable];
        }
        
        if (!btDinningTable.enabled) {
            if (btWallTable.enabled) {
                btWallTable.selected = YES;
            }
            else if (btCofeeTable.enabled) {
                btCofeeTable.selected = YES;
            }
        } else {
            btDinningTable.selected = YES;
        }
        
        self.tableType =  [self getInitialTableType];
        
        [self loadSizes];
    }
}

-(void)clearOptions {
    
    btDinningTable.selected = NO;
    btWallTable.selected = NO;
    btCofeeTable.selected = NO;

    btDinningTable.alpha = 1;
    lbDinningTable.alpha = 1;
    btWallTable.alpha = 1;
    lbWallTable.alpha = 1;
    btCofeeTable.alpha = 1;
    lbCofeeTable.alpha = 1;
}

-(void)grayOutOption:(tableTypeEnum)tableOption {
    
    if (tableOption == kDinningTable) {
        btDinningTable.alpha = 0.4;
        lbDinningTable.alpha = 0.4;
    }
    else if (tableOption == kWallTable) {
        btWallTable.alpha = 0.4;
        lbWallTable.alpha = 0.4;
    }
    else if (tableOption == kCoffeeTable) {
        btCofeeTable.alpha = 0.4;
        lbCofeeTable.alpha = 0.4;
    }
}

-(void)loadSizes
{
    IWModel* model = (IWModel*) self.selectedColor;

    // Load Dinning table sizes by default
    NSArray* sizes = model.sizes;
    
    if (btWallTable.selected) {
        sizes = model.wallSizes;
    }
    else if (btCofeeTable.selected) {
        sizes = model.smallSizes;
    }

    // Be carefull, everything will be in cms
    [self addLengthUnit:sizes];
    
    [pickerSize setItems:sizes];
    if (sizes.count > 0) {
        [self simplePickerViewController:pickerSize didSelectRow:[sizes objectAtIndex:0]];
    }
}

-(void)addLengthUnit:(NSArray*)sizes
{
    NSMutableArray* sizesWithLenght = [[NSMutableArray alloc] init];
    for (int sizeIndex = 0; sizeIndex < sizes.count; sizeIndex++) {
        IWColor* mySizeColor = sizes[sizeIndex];
        mySizeColor.name = [mySizeColor.name stringByReplacingOccurrencesOfString:@" cm" withString:@""];
        mySizeColor.name = [NSString stringWithFormat:@"%@ cm", mySizeColor.name];
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

-(tableTypeEnum)getInitialTableType
{
    
    if([self getSelectedModel].sizes.count > 0) {
        return kDinningTable;
    }
    else if ([self getSelectedModel].wallSizes.count > 0) {
        return kWallTable;
    }
    else if ([self getSelectedModel].smallSizes.count > 0) {
        return kCoffeeTable;
    }
    
    return kDinningTable;
}


@end
