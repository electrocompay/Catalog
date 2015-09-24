//
//  IWModelViewController.m
//  Catalog
//
//  Created by Abel Miranda on 2/10/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWModelViewController.h"
#import "IWSelectorViewController.h"
#import "IWDrawerTable.h"
#import "IWDrawerChair.h"
#import "IWTable.h"
#import "IWChair.h"
#import "IWColors.h"
#import "IWMenuView.h"
#import "IWCatalogViewController.h"
#import "NSArray+color.h"
#import "IWSelectorTableViewController.h"
#import "IWPriceManager.h"
#import "IWTableSummaryViewController.h"
#import "IWUtils.h"

@interface IWModelViewController ()

@end


@implementation IWModelViewController{
    
    BrowserTabView *tabController;
    IWSelectorTableViewController *selectorTableModelView;
    IWSelectorViewController *selectorTableColorView;
    IWSelectorViewController *selectorTableLegsColorView;
    IWSelectorViewController *selectorChairModelView;
    IWSelectorViewController *selectorChairColorView;
    IWSelectorViewController *selectorChairLegsColorView;
    IWDrawerTable *drawer;
    IWDrawerChair *drawerChair;
    IWTable *table;
    IWChair *chair;
    IBOutlet UIImageView* selectorView;
    IBOutlet IWMenuView *menu;
    IBOutlet IWMenuView *homeMenu;
    UIView* thumbView;
    IWDrawerTable *thumbDrawer;
    IWDrawerChair *thumbDrawerChair;
    UIButton * button;
    UIButton * button2;

    /* Price controls */
    
    IBOutlet UIButton *tablePriceButton;
    IBOutlet UIButton *chairPriceButton;
    IBOutlet IWPasswordView *passwordDialog;
    
    
    /* new*/
    
    __weak IBOutlet UILabel *cabinetModelLabel;
    IBOutlet UILabel *tableNameView;
    IBOutlet UILabel *tableDimensionsView;
    IBOutlet UIButton *showPriceTableButton;
    IBOutlet UILabel *chairNameView;
    IBOutlet UIButton *showPriceChairButton;
    IBOutlet UILabel *bottonDescriptionView;
    IBOutlet UILabel *tablePriceView;
    IBOutlet UILabel *chairPriceView;
    IBOutlet UIButton *showSummaryButton;
    IBOutlet UIImageView *tableTopSize;
    IBOutlet UIImageView *tableFrontSize;
    IBOutlet NSLayoutConstraint *heightConstraint;
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
    table = [[IWTable alloc] init];
    drawer = [[IWDrawerTable alloc] init];
    drawer.view = content;
    drawer.offsetY = 50;
    
    chair = [[IWChair alloc] init];
    drawerChair = [[IWDrawerChair alloc] init];
    drawerChair.view = content;
    drawerChair.offsetY = 50;
    
    thumbView = [[UIView alloc] init];
    thumbView.frame = selectorView.frame;
    
    thumbDrawer = [[IWDrawerTable alloc] init];
    thumbDrawer.view = thumbView;
    
    thumbDrawerChair = [[IWDrawerChair alloc] init];
    thumbDrawerChair.view = thumbView;
    
    tabController= [[BrowserTabView alloc] initWithTabTitles:[NSArray arrayWithObjects:@"1. Table Model",@"2. Table Color",@"3. Table Legs Color", @"4. Chair Model", @"5. Chair Color", @"6. Chair Legs Color", nil] andDelegate:self];
    [tabController setBackgroundImage:nil];
    [tabController setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    [self.tabContainer addSubview:tabController];
    [content.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [menu setItems:[NSMutableArray arrayWithObjects:@"Save", @"Print", @"Mail", nil]];
    [homeMenu setItems:[NSMutableArray arrayWithObjects:@"Visit our web", @"Catalogues", @"Contact us", nil]];
    [menu setDelegate:self];
    [homeMenu setDelegate:self];
    
    [passwordDialog setDelegate:self];

    [showSummaryButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    showSummaryButton.enabled = [[IWPriceManager getInstance] authenticated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    if (!selectorTableModelView) {
        
        selectorTableModelView = [[IWSelectorTableViewController alloc] initWithNibName:@"IWSelectorTableViewController" bundle:nil];
        [selectorTableModelView setPropertyName:@"table model"];
        [self prepareSelector:selectorTableModelView withColors:[IWColors tableModels]];
        [selectorTableModelView setTableDelegate:self];
        
        selectorTableColorView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
        [selectorTableColorView setPropertyName:@"table color"];
        [self prepareSelector:selectorTableColorView withColors:[IWColors tableColors]];
        [selectorTableColorView setFilteredItems:table.model.colors];
        
        selectorTableLegsColorView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
        [selectorTableLegsColorView setPropertyName:@"leg color"];
        [self prepareSelector:selectorTableLegsColorView withColors:[IWColors tableLegColors]];
        [selectorTableLegsColorView setFilteredItems:table.model.legColors];
        
        selectorChairModelView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
        [selectorChairModelView setPropertyName:@"chair model"];
        [self prepareSelector:selectorChairModelView withColors:[IWColors chairModels]];
        
        selectorChairColorView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
        [selectorChairColorView setPropertyName:@"chair color"];
        [self prepareSelector:selectorChairColorView withColors:[IWColors chairColors]];
        [selectorChairColorView setFilteredItems:chair.model.colors];
        
        selectorChairLegsColorView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
        [selectorChairLegsColorView setPropertyName:@"leg color"];
        [self prepareSelector:selectorChairLegsColorView withColors:[IWColors chairLegColors]];
        [selectorChairLegsColorView setFilteredItems:chair.model.legColors];
        
        [self BrowserTabView:nil didSelecedAtIndex:0];
        [selectorTableModelView loadSizes];
        [self drawAll];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark BrowserTabViewDelegate
-(void)BrowserTabView:(BrowserTabView *)browserTabView didSelecedAtIndex:(NSUInteger)index
{
    if (index == 0) {
        if (!selectorTableModelView) {
            selectorTableModelView = [[IWSelectorTableViewController alloc] initWithNibName:@"IWSelectorTableViewController" bundle:nil];
            [self prepareSelector:selectorTableModelView withColors:[IWColors tableModels]];
        }else {
            [tabContent bringSubviewToFront:selectorTableModelView.view];
        }
    } else if (index == 1){
        if (!selectorTableColorView) {
            selectorTableColorView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
            [self prepareSelector:selectorTableColorView withColors:[IWColors tableColors]];
        } else {
            [tabContent bringSubviewToFront:selectorTableColorView.view];
        }
        [selectorTableColorView setFilteredItems:table.model.colors];
    } else if (index == 2){
        if (!selectorTableLegsColorView) {
            selectorTableLegsColorView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
            [self prepareSelector:selectorTableLegsColorView withColors:[IWColors tableLegColors]];
        } else {
            [tabContent bringSubviewToFront:selectorTableLegsColorView.view];
        }

        // This should be very improved...
        NSArray *tableLegColors = [IWColors tableLegColors];
        if ([table.model.name isEqualToString:@"Wings Outdoor"]) {
            for (int colorIndex = 0; colorIndex < tableLegColors.count; colorIndex++) {
                IWColor* legColor = tableLegColors[colorIndex];
                NSString* newColorName = [NSString stringWithFormat:@"Alu. %@", legColor.name];
                legColor.name = newColorName;
            }
        }
        else {
            for (int colorIndex = 0; colorIndex < tableLegColors.count; colorIndex++) {
                IWColor* legColor = tableLegColors[colorIndex];
                legColor.name = [legColor.name stringByReplacingOccurrencesOfString:@"Alu. " withString:@""];
            }
        }

        [selectorTableLegsColorView setFilteredItems:table.model.legColors];
    } else if (index == 3){
        if (!selectorChairModelView) {
            selectorChairModelView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
            [self prepareSelector:selectorChairModelView withColors:[IWColors chairModels]];
        } else {
            [tabContent bringSubviewToFront:selectorChairModelView.view];
        }
    } else if (index == 4){
        if (!selectorChairColorView) {
            selectorChairColorView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
            [self prepareSelector:selectorChairColorView withColors:[IWColors chairColors]];
        } else {
            [tabContent bringSubviewToFront:selectorChairColorView.view];
        }
        [selectorChairColorView resetViewAndSetFilteredItems:chair.model.colors];
    } else if (index == 5){
        if (!selectorChairLegsColorView) {
            selectorChairLegsColorView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
            [self prepareSelector:selectorChairLegsColorView withColors:[IWColors chairLegColors]];
        } else {
            [tabContent bringSubviewToFront:selectorChairLegsColorView.view];
        }
        [selectorChairLegsColorView setFilteredItems:chair.model.legColors];
    }
    
}

-(void)prepareSelector:(IWSelectorViewController*)selector withColors:(NSArray*)colors
{
    [selector setDelegate:self];
    [tabContent addSubview:selector.view];
    selector.view.frame = tabContent.bounds;
    
    [selector setItems:colors];
}

-(void)BrowserTabView:(BrowserTabView *)browserTabView willRemoveTabAtIndex:(NSUInteger)index {
    NSLog(@"BrowserTabView WILL Remove Tab at index:  %d",(unsigned long) index);
}

-(void)BrowserTabView:(BrowserTabView *)browserTabView didRemoveTabAtIndex:(NSUInteger)index{
    NSLog(@"BrowserTabView did Remove Tab at index:  %d",index);
}

-(void)BrowserTabView:(BrowserTabView *)browserTabView exchangeTabAtIndex:(NSUInteger)fromIndex withTabAtIndex:(NSUInteger)toIndex{
    NSLog(@"BrowserTabView exchange Tab  at index:  %d with Tab at index :%d ",fromIndex,toIndex);
}

- (BOOL)browserTabView:(BrowserTabView *)tabView shouldChangeTitle:(NSString *)title {
    if (title.length) {
        return YES;
    };
    return NO;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}

-(void)didSelectColor:(IWSelectorViewController *)selectorViewController andColor:(IWColor *)color
{
    if (selectorViewController == selectorTableModelView)
    {
        [table setModel:(IWModel*) color];
        [table setTableType:[selectorTableModelView getInitialTableType]];
    } else if (selectorViewController == selectorTableColorView)
    {
        [table setColor:color];
    } else if (selectorViewController == selectorTableLegsColorView)
    {
        [table setLegsColor:color];
    } else if (selectorViewController == selectorChairModelView)
    {
        [chair setModel:(IWModel*) color];
        NSArray* legsColors = [IWColors chairLegColors];
        IWColor *wood = [legsColors objectAtIndex:legsColors.count - 1];
        if ([color.code rangeOfString:@"Van Gogh"].location != NSNotFound) {
            wood.file = @"Wood VG.jpg";
            wood.name = @"Black Wood";
            
            [selectorChairLegsColorView setItems:legsColors];
        } else {
            wood.file = @"Wood.jpg";
            wood.name = @"Wood";
            
            [selectorChairLegsColorView setItems:legsColors];
        }
        
        NSInteger index = [[IWColors chairModels] indexOfObject:color];
        if (index >= 0) {
            if (index == 4 || index == 5 || index==13 || index==14) {
                [selectorChairColorView setItems:[self colorsRemoveIndex:[IWColors chairColors] index:12]];
            } else {
                [selectorChairColorView setItems:[IWColors chairColors]];
            }
            if (index == 19 || index == 20) {
                [selectorChairColorView setItems:[self colorsRemoveIndex:[IWColors chairColors] index:15]];
            } else {
                [selectorChairColorView setItems:[IWColors chairColors]];
            }
        }
        
        //if ([chair.model.name isEqualToString:@"Rafael-A"] || [chair.model.name isEqualToString:@"Rafael-S"]) {
        //    selectorChairColorView.items = [[IWColors chairColors] withoutColor:@"15"];
        //}
        
        selectorChairColorView.chairModelForAlternativeView = nil;
        if (chair.model.name != nil) {
            if ([chair.model.name isEqualToString:@"Margueritte-A-S"] ||
                [chair.model.name isEqualToString:@"Margueritte-S-S"] ||
                [chair.model.name isEqualToString:@"Picasso-P"]) {
                selectorChairColorView.optionsItems = chair.model.optionColors;
                selectorChairColorView.chairModelForAlternativeView = chair.model.name;
            }
            else {
                selectorChairColorView.previousChairModelForAlternativeView = nil;
            }
        }

        if (selectorChairColorView) {
            [selectorChairColorView setFilteredItems:chair.model.colors];
            [self didSelectColor:selectorChairColorView andColor:selectorChairColorView.selectedColor];
        }
    } else if (selectorViewController == selectorChairColorView)
    {
        if ([chair.model.name isEqualToString:@"Picasso-P"]) {
            
                if (selectorChairColorView.isOptionSelected) {
                    chair.leatherLinerColor = color;
                }
                else {
                    [chair setColor:color];
                }
        }
        else if (([chair.model.name isEqualToString:@"Margueritte-A-S"]  ||
                  [chair.model.name isEqualToString:@"Margueritte-S-S"])) {
            
            if (selectorChairColorView.isOptionSelected) {
                if (selectorChairColorView.selectedOptionColor) {
                    chair.leatherLinerColor = selectorChairColorView.selectedOptionColor;
                }
            }
            else {
                if (selectorChairColorView.selectedBaseColor) {
                    chair.color = selectorChairColorView.selectedBaseColor;
                }
            }
        }
        else {
            [chair setColor:color];
        }
        
        if ([chair.model.name isEqualToString:@"Rafael-A"]) {
            if ([color.code isEqualToString:@"14"]) {
                chair.model.legColors = [@"22" componentsSeparatedByString:@","];
            } else if ([color.code isEqualToString:@"15"]) {
                chair.model.legColors =  [@"23" componentsSeparatedByString:@","];
            } else if ([color.code isEqualToString:@"18"]) {
                chair.model.legColors = [@"26" componentsSeparatedByString:@","];
            } else if ([color.code isEqualToString:@"42"]) {
                chair.model.legColors = [@"24" componentsSeparatedByString:@","];
            }
        }

        [selectorChairLegsColorView setFilteredItems:chair.model.legColors];
        [selectorChairLegsColorView setItems:[IWColors chairLegColors]];
    } else if (selectorViewController == selectorChairLegsColorView)
    {
        [chair setLegsColor:color];
    }
    [self drawAll];
    [self updateDetails];
}

-(NSArray*)colorsRemoveIndex:(NSArray*)colors index:(NSInteger)index
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:colors];
    [array removeObjectAtIndex:index];
    return array;
}

- (IBAction)changeView_Click:(id)sender
{
    [drawer setFrontView:!drawer.frontView];
    [drawerChair setFrontView:!drawerChair.frontView];
    [self drawAll];
}

-(void)drawAll
{
    [drawer clear];
    
    if (table.tableType == kDinningTable) {
        [drawerChair drawForniture:chair];
    }
    
    [drawer drawForniture:table];
    [thumbDrawerChair setFrontView:!drawer.frontView];
    [thumbDrawer setFrontView:!drawer.frontView];

    [thumbDrawer clear];
    if (table.tableType == kDinningTable) {
        [thumbDrawerChair drawForniture:chair];
    }
    [thumbDrawer drawForniture:table];
    [selectorView setImage:[self captureViewFrom:thumbView]];
}

-(IBAction)changeMenuClick:(id)sender
{
    if (menu.hidden)
    {
        [self createFackeButton];
        [homeMenu setHidden:YES];
        [menu setHidden:NO];
        [menu.superview bringSubviewToFront:menu];
    } else
    {
        [menu setHidden:YES];
    }
}

-(IBAction)changeHomeMenuClick:(id)sender
{
    if (homeMenu.hidden)
    {
        [self createFackeButton];
        [menu setHidden:YES];
        [homeMenu setHidden:NO];
        [homeMenu.superview bringSubviewToFront:homeMenu];
    } else
    {
        [homeMenu setHidden:YES];
    }
}


-(void)createFackeButton
{
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(hideButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"" forState:UIControlStateNormal];
    button.frame = self.view.frame;
    [homeMenu.superview addSubview:button];
    
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 addTarget:self action:@selector(hideButton:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitle:@"" forState:UIControlStateNormal];
    button2.frame = self.view.frame;
    [self.tabContainer addSubview:button2];
}

-(void)hideButton:(id)sender
{
    homeMenu.hidden = YES;
    menu.hidden = YES;
    button.hidden = YES;
    button2.hidden = YES;
    [passwordDialog setHidden:YES];
}

- (UIImage *)captureViewFrom:(UIView*)view{
    
    CGRect rect = [view bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
    
}

-(void)menuView:(IWMenuView *)menuView didClick:(NSInteger)optionIndex
{
    if (menuView == menu)
    {
        switch (optionIndex) {
            case 0: //Save
                [self generateJPG];
                break;
            case 1: //Print
                [self print];
                break;
            case 2: //Mail
                [self displayComposerSheet];
                break;
                
            default:
                break;
        }
        
    } else if (menuView == homeMenu)
    {
        
        switch (optionIndex) {
            case 0:
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.joli.be"]];
                break;
            case 1:
            {
                IWCatalogViewController *catalogViewController = [[IWCatalogViewController alloc] init];
                [self presentViewController:catalogViewController animated:YES completion:nil];
            }
                break;
            case 2:
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.joli.be/contact"]];
                break;
                
            default:
                break;
        }
    }
}

-(void)generateJPG
{
    [[IWUtils getInstance] generateJPG:content.superview completionTarget:self completionSelector:@selector(saveCompletion:didFinishSavingWithError:contextInfo:)];
}

- (void)saveCompletion:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo: (void *) contextInfo
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Saved" message:@"Image saved successfully to Photo Album." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)displayComposerSheet
{
    [[IWUtils getInstance] displayComposerSheet:content.superview viewC:self];
}

-(void)print
{
    [[IWUtils getInstance] printView:content.superview];
}

#pragma marks Prices

-(IBAction)priceMenu_Clicked:(id)sender{
    if (sender == tablePriceButton){
        [passwordDialog showLeftTriangle];
        if (passwordDialog.hidden) {
            [self createFackeButton];
            [passwordDialog setHidden:NO];
            [passwordDialog.superview bringSubviewToFront:passwordDialog];
        } else if (![passwordDialog isLeftVisible]){
            [passwordDialog setHidden:YES];
        }
        
    } else if (sender == chairPriceButton){
        [passwordDialog showRightTriangle];
        if (passwordDialog.hidden) {
            [self createFackeButton];
            [passwordDialog setHidden:NO];
            [passwordDialog.superview bringSubviewToFront:passwordDialog];
        } else if ([passwordDialog isLeftVisible]){
            [passwordDialog setHidden:YES];
        }
    }
    
    // Enable keyboard
    [passwordDialog.passTextView becomeFirstResponder];
}


#pragma marks extended features

- (void)selectorTableViewController:(IWSelectorTableViewController *)selectorTableViewController didSelectSize:(IWColor *)size
{
    table.size = size;
    [self updateDetails];
}

-(void)selectorTableViewController:(IWSelectorTableViewController *)selectorTableViewController didSelectOther:(tableTypeEnum)tableType
{
    table.tableType = tableType;
    
    [self updateDetails];
    [self drawAll];
}

-(void)updateDetails
{
    // Dynamically adapt font size
    tableNameView.numberOfLines = 1;
    tableNameView.adjustsFontSizeToFitWidth = YES;

    [tableNameView setText:table.model.name];
    [tableDimensionsView setText:table.size.name];
    
    // Dynamically adapt font size
    chairNameView.numberOfLines = 1;
    chairNameView.adjustsFontSizeToFitWidth = YES;

    // Disable Chair models and colors
    tabController.tabDisabled = -1;
    [tabController unGrayOutAllTabs];
    if (table.tableType != kDinningTable) {
        int initialTabIndex = 3;
        if ([table.model.name isEqualToString:@"Cube"]) {
            initialTabIndex--;
        }
        [self disableTabsFromIndex:initialTabIndex];
    }

    if ((NSNotFound != [chair.model.name rangeOfString:@"Margueritte"].location) ||
        (NSNotFound != [chair.model.name rangeOfString:@"Gaugin"].location)      ||
        (NSNotFound != [chair.model.name rangeOfString:@"Picasso"].location)) {
        [self disableTabsFromIndex:5];
    }
    
    [chairNameView setText:chair.model.name];
    
    NSString *tableModelName = table.model.name;
    if ([tableModelName isEqualToString:@"Wings Outdoor"] ||
        [tableModelName isEqualToString:@"Wings Indoor"]) {
        tableModelName = @"Wings";
    }

    if ([tableModelName isEqualToString:@"Wings XL"]) {
        tableModelName = @"Chrominox XL";
    }

    NSString *imageName = [[[NSString stringWithFormat:@"%@-%@ ", tableModelName, [[table.size.name stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"Ø" withString:@""]] stringByReplacingOccurrencesOfString:@"/" withString:@" "] lowercaseString];
    UIImage *image = [UIImage imageNamed:[imageName stringByAppendingString:@"p"]];
//    CGRect f = CGRectMake(0, 0, tableTopSize.frame.size.width, image.size.height *( tableTopSize.superview.frame.size.width / image.size.width));
//    [tableTopSize setFrame:f];
    if (image) {
        heightConstraint.constant = image.size.height *(tableTopSize.superview.frame.size.width / image.size.width);
    }
    [tableTopSize setImage: image];
    [tableFrontSize setImage:[UIImage imageNamed:[imageName stringByAppendingString:@"a"]]];
    
    IWColor* tableSize;
    switch (table.tableType) {
        case kDinningTable:
            tableSize = [table.model.sizes objectAtIndex:0];
            break;

        case kWallTable:
            tableSize = [table.model.wallSizes objectAtIndex:0];
            break;

        case kCoffeeTable:
            tableSize = [table.model.smallSizes objectAtIndex:0];
            break;
            
        default:
            break;
    }
    
    [bottonDescriptionView setText:[NSString stringWithFormat:@"(*) Photo table sizes: %@", tableSize.name]];
    
    [self updatePrices];
}

-(void)disableTabsFromIndex:(int)initialTabIndex
{
    tabController.tabDisabled = initialTabIndex;
    
    for (int tabIndex = initialTabIndex; tabIndex < [tabController numberOfTabs]; tabIndex++) {
        [tabController grayOutTabAtIndex:tabIndex];
    }
}

-(void)passwordView:(IWPasswordView *)passwordView authenticateResult:(BOOL)authenticateResult
{
    if (authenticateResult) {
        [self updatePrices];
    }
}

-(void)updatePrices
{
    IWPriceManager *pricesManager = [IWPriceManager getInstance];
    if (pricesManager.authenticated) {
        double tablePrice = [pricesManager getTablePrice:table];
        [tablePriceView setText:[NSString stringWithFormat:@"%.2f", tablePrice]];
        double chairPrice = [pricesManager getChairPrice:chair];
        [chairPriceView setText:[NSString stringWithFormat:@"%.2f", chairPrice]];
        [tablePriceView setHidden:NO];
        [chairPriceView setHidden:NO];
        [tablePriceButton setUserInteractionEnabled:NO];
        [chairPriceButton setUserInteractionEnabled:NO];
    } else {
        [tablePriceView setHidden:YES];
        [chairPriceView setHidden:YES];
        [tablePriceButton setUserInteractionEnabled:YES];
        [chairPriceButton setUserInteractionEnabled:YES];
    }
    showSummaryButton.enabled = [[IWPriceManager getInstance] authenticated];
}

-(IBAction)viewSummaryClick:(id)sender
{
    IWTableSummaryViewController *summaryViewController = [[IWTableSummaryViewController alloc] initWithNibName:@"IWSummaryViewController" bundle:Nil];
    [self presentViewController:summaryViewController animated:YES completion:Nil];
    [summaryViewController showSummaryForTable:table andChair:chair];
}


@end
