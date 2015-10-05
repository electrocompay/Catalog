//
//  IWModelViewController.m
//  Catalog
//
//  Created by Abel Miranda on 2/10/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWModelViewController.h"
#import "IWSelectorViewController.h"
#import "IWDrawerCabinet.h"
#import "IWCabinet.h"
#import "IWColors.h"
#import "IWMenuView.h"
#import "IWCatalogViewController.h"
#import "IWModelSelectorViewController.h"
#import "IWMultipleSelectorViewController.h"
#import "IWMultipleSelectorJ193ViewController.h"
#import "IWLegsColorSelectorViewController.h"
#import "NSArray+color.h"
#import "IWPriceManager.h"
#import "IWCabinetSummaryViewController.h"
#import "IWUtils.h"

@interface IWModelViewController ()

@end

@implementation IWModelViewController{
    
    BrowserTabView *tabController;
    IWModelSelectorViewController *selectorModelView;
    IWSelectorViewController *selectorTopView;
    IWSelectorViewController *selectorSideView;
    IWMultipleSelectorViewController *selectorDoorsView;
    IWMultipleSelectorViewController *selectorDoorsJ193View;
    IWLegsColorSelectorViewController *selectorLegsColorView;
    IWMultipleSelectorViewController *selectorModule1View;
    IWMultipleSelectorViewController *selectorModule2View;
    IWMultipleSelectorViewController *selectorModule3View;
    IWMultipleSelectorViewController *selectorModule4View;
    IWDrawerCabinet *drawer;
    IWCabinet *cabinet;
    IBOutlet UIImageView* selectorView;
    IBOutlet IWMenuView *menu;
    IBOutlet IWMenuView *homeMenu;
    UIView* thumbView;
    IWDrawerCabinet *thumbDrawer;
    NSInteger _updating;
    UIButton * button;
    UIButton * button2;


    /* Price controls */
    
    IBOutlet UIButton *priceButton;
    IBOutlet IWPasswordView *passwordDialog;
    IBOutlet UILabel *priceView;
    IBOutlet UIButton *showSummaryButton;
    IBOutlet UILabel *cabinetModelLabel;
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
    _updating = 0;
    cabinet = [[IWCabinet alloc] init];
    drawer = [[IWDrawerCabinet alloc] init];
    drawer.view = content;
    //drawer.offsetY = 50;
    
    thumbView = [[UIView alloc] init];
    thumbView.frame = selectorView.frame;
    
    thumbDrawer = [[IWDrawerCabinet alloc] init];
    thumbDrawer.view = thumbView;
    
    tabController= [[BrowserTabView alloc] initWithTabTitles:[NSArray arrayWithObjects:@"1. Model",@"2. Top color",@"3. Side color", @"4. Door color", nil] andDelegate:self];
    [tabController setBackgroundImage:nil];
    [tabController setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    [self.tabContainer addSubview:tabController];
    [content.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    [menu setItems:[NSMutableArray arrayWithObjects:@"Save", @"Print", @"Mail", nil]];
    [homeMenu setItems:[NSMutableArray arrayWithObjects:@"Visit our web", @"Catalogues", @"Contact us", nil]];
    [menu setDelegate:self];
    [homeMenu setDelegate:self];
    [tabController setTabWidth:135];

    [passwordDialog setDelegate:self];
    [showSummaryButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    showSummaryButton.enabled = [[IWPriceManager getInstance] authenticated];
    [self updateDetails];
}

-(void)viewDidAppear:(BOOL)animated
{
    if (!selectorModelView) {
        [self beginUpdate];
        selectorModelView = [[IWModelSelectorViewController alloc] initWithNibName:@"IWModelSelectorViewController" bundle:nil];
        [selectorModelView setCabinet:cabinet];
        [selectorModelView setDelegate:self];
        [tabContent addSubview:selectorModelView.view];
        selectorModelView.view.frame = tabContent.bounds;
        
        selectorTopView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
        [selectorTopView setPropertyName:@"top color"];
        [self prepareSelector:selectorTopView withColors:[IWColors cabinetTopColors]];
        [selectorTopView setFilteredItems:cabinet.model.colors];
        
        selectorSideView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
        [selectorSideView setPropertyName:@"side color"];
       
        [self prepareSelector:selectorSideView withColors:[IWColors cabinetSideColors]];
        [selectorSideView setFilteredItems:cabinet.model.legColors];
        
        selectorDoorsView = [[IWMultipleSelectorViewController alloc] initWithMode:MultipleSelectorModeNineColors];
        [self prepareMultipleSelectorView:selectorDoorsView];
        
        selectorDoorsJ193View = [[IWMultipleSelectorJ193ViewController alloc] initWithNibName:@"IWMultipleSelectorJ193ViewController" bundle:nil];
        [selectorDoorsJ193View setMode:MultipleSelectorModeFourColors];
        
        [self prepareMultipleSelectorView:selectorDoorsJ193View];

        selectorLegsColorView = [[IWLegsColorSelectorViewController alloc] initWithNibName:@"IWLegsColorSelectorViewController" bundle:nil];
        [selectorLegsColorView setPropertyName:@"Leg color"];
        [selectorLegsColorView setCabinet:cabinet];
        [self prepareSelector:selectorLegsColorView withColors:[IWColors cabinetLegColors]];
        
        selectorModule1View = [[IWMultipleSelectorViewController alloc] initWithMode:MultipleSelectorModeModuleColors];
        [self prepareMultipleSelectorView:selectorModule1View];
        
        selectorModule2View = [[IWMultipleSelectorViewController alloc] initWithMode:MultipleSelectorModeModuleColors];
        [self prepareMultipleSelectorView:selectorModule2View];
        
        selectorModule3View = [[IWMultipleSelectorViewController alloc] initWithMode:MultipleSelectorModeModuleColors];
        [self prepareMultipleSelectorView:selectorModule3View];
        
        selectorModule4View = [[IWMultipleSelectorViewController alloc] initWithMode:MultipleSelectorModeModuleColors];
        [self prepareMultipleSelectorView:selectorModule4View];
        
        [self BrowserTabView:nil didSelecedAtIndex:0];
        [self endUpdate];
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
    NSLog(@"BrowserTabView select Tab at index:  %d",index);
    if (index == 0) {
        [tabContent bringSubviewToFront:selectorModelView.view];
    } else if (index == 1){
        [tabContent bringSubviewToFront:selectorTopView.view];
    } else if (index == 2){
        [tabContent bringSubviewToFront:selectorSideView.view];
    } else if (index == 3){
        if ([cabinet.model.code isEqualToString:@"C193"]) {
            [tabContent bringSubviewToFront:selectorDoorsJ193View.view];
        } else if (cabinet.useDoors){
            [tabContent bringSubviewToFront:selectorDoorsView.view];
        } else if (cabinet.hasLegs){
            [tabContent bringSubviewToFront:selectorLegsColorView.view];
        } else if (cabinet.useModules){
            [tabContent bringSubviewToFront:selectorModule1View.view];
            [drawer activateModule:1];
            [self drawAll];
        }
    } else if (index == 4){
        if (cabinet.useDoors) {
            [tabContent bringSubviewToFront:selectorLegsColorView.view];
        } else {
            if (cabinet.hasLegs)
            {
                [tabContent bringSubviewToFront:selectorModule3View.view];
                [drawer activateModule:3];
                [self drawAll];
            } else
            {
                [tabContent bringSubviewToFront:selectorModule2View.view];
                [drawer activateModule:2];
                [self drawAll];
            }
        }
    } else if (index == 5){
        if (cabinet.hasLegs)
        {
            [tabContent bringSubviewToFront:selectorModule4View.view];
            [drawer activateModule:4];
            [self drawAll];
        } else
        {
            [tabContent bringSubviewToFront:selectorModule3View.view];
            [drawer activateModule:3];
            [self drawAll];
        }
    } else if (index == 6){
        [tabContent bringSubviewToFront:selectorModule4View.view];
        [drawer activateModule:4];
        [self drawAll];
    }
    
}

-(void)prepareSelector:(IWSelectorViewController*)selector withColors:(NSArray*)colors
{
    [selector setDelegate:self];
    [tabContent addSubview:selector.view];
    selector.view.frame = tabContent.bounds;
    [selector setItems:colors];
}

-(void)prepareMultipleSelectorView:(IWMultipleSelectorViewController*)multipleSelectorView
{
    [multipleSelectorView setCabinet:cabinet];
    [multipleSelectorView setDelegate:self];
    [tabContent addSubview:multipleSelectorView.view];
    multipleSelectorView.view.frame = tabContent.bounds;
}

-(void)BrowserTabView:(BrowserTabView *)browserTabView willRemoveTabAtIndex:(NSUInteger)index {
    NSLog(@"BrowserTabView WILL Remove Tab at index:  %d",index);
    
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
    return YES;
}

#pragma mark Model Selection

-(void)didSelectColor:(IWSelectorViewController *)selectorViewController andColor:(IWColor *)color
{
    
    if (selectorViewController == selectorTopView)
    {
        [cabinet setTop:color];
    } else if (selectorViewController == selectorSideView)
    {
        [cabinet setSide:color];
    } else if (selectorViewController == selectorLegsColorView)
    {
        [cabinet setLegsColor: color];
    }
    
    /*else if (selectorViewController == selectorChairModelView)
     {
     [chair setModel:(IWModel*) color];
     } else if (selectorViewController == selectorChairColorView)
     {
     [chair setColor:color];
     } else if (selectorViewController == selectorChairLegsColorView)
     {
     [chair setLegsColor:color];
     }*/
    [selectorDoorsView setCabinet:cabinet];
    [self drawAll];
}

-(void)didSelect:(IWModelSelectorViewController *)modelSelectorViewController andColor:(IWColor *)color
{
    [self beginUpdate];
    [selectorDoorsView setCabinet:cabinet];
    [selectorDoorsJ193View setCabinet:cabinet];
    [tabController removeTabAtIndex:8 animated:NO];
    [tabController removeTabAtIndex:7 animated:NO];
    [tabController removeTabAtIndex:6 animated:NO];
    [tabController removeTabAtIndex:5 animated:NO];
    [tabController removeTabAtIndex:4 animated:NO];
    [tabController removeTabAtIndex:3 animated:NO];
    if (cabinet.useDoors) {
        [tabController addTabWithTitle:@"4. Door color"];
    }
    if (cabinet.hasLegs) {
        [tabController addTabWithTitle:@"5. Leg color"];
    }
    if (cabinet.useModules) {
        if (cabinet.size && cabinet.size.code)
            [tabController addTabWithTitle:@"4. M1 Color"];
        if (cabinet.module2.size && cabinet.module2.size.code)
            [tabController addTabWithTitle:@"5. M2 Color"];
        if (cabinet.module3.size && cabinet.module3.size.code)
            [tabController addTabWithTitle:@"6. M3 Color"];
        if (cabinet.module4.size && cabinet.module4.size.code)
            [tabController addTabWithTitle:@"7. M4 Color"];
        [selectorModule1View setCabinet:cabinet];
        [selectorModule2View setCabinet:cabinet.module2];
        [selectorModule3View setCabinet:cabinet.module3];
        [selectorModule4View setCabinet:cabinet.module4];
    }
    [tabController setTabWidth:135];
    [tabController setSelectedTabIndex:0 animated:NO];
    
    [selectorDoorsView setItems:[IWColors cabinetColors]];
    if ([cabinet.model.code isEqualToString:@"C83"] || [cabinet.model.code isEqualToString:@"J83"] || [cabinet.model.code isEqualToString:@"C193"] ) {
        selectorTopView.items = [cabinet.model.code isEqualToString:@"C193"] ? [[IWColors cabinetTopColors] withoutColor:@"34,35,41,70"] : [IWColors cabinetTopColors];
        
        selectorSideView.items = [cabinet.model.code isEqualToString:@"C193"] ? [[IWColors cabinetSideColors] withoutColor:@"34,35,70"] : [IWColors cabinetSideColors];
    } else {
        [selectorLegsColorView setItems:[IWColors cabinetLegColors]];
        [selectorSideView setItems:[IWColors cabinetSideColors]];
    }
    [self endUpdate];
    [self drawAll];
    [self updateDetails];
}

-(void)beginUpdate
{
    _updating++;
}

-(void)endUpdate;
{
    _updating--;
}

-(void)didSelectColor:(IWMultipleSelectorViewController *)selectorViewController andColor:(IWColor *)color andIndex:(NSInteger)index
{
    [self drawAll];
    [self updateDetails];
}

#pragma mark Menu Actions

- (IBAction)changeView_Click:(id)sender
{
    [drawer setFrontView:!drawer.frontView];
    [self drawAll];
    [self updateDetails];
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

-(void)menuView:(IWMenuView *)menuView didClick:(NSInteger)optionIndex
{
    if (menuView == menu)
    {
        switch (optionIndex) {
            case 0: //Save
            {
                [self generateJPG];
            }
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

- (UIImage *)captureViewFrom:(UIView*)view{
    
    CGRect rect = [view bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
    
}

#pragma mark Render and Export

-(void)drawAll
{
    if (_updating == 0) {
        [drawer clear];
        [drawer drawForniture:cabinet];
     //   [thumbDrawer setFrontView:!drawer.frontView];
     //   [thumbDrawer clear];
     //   [thumbDrawer drawForniture:cabinet];
     //   [selectorView setImage:[self captureViewFrom:thumbView]];
    }
}

-(void)generateJPG
{
    UIImage* image = [self captureViewFrom:content.superview];
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(saveCompletion:didFinishSavingWithError:contextInfo:), nil);
}

- (void)saveCompletion:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo: (void *) contextInfo
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Saved" message:@"Image saved successfully to Photo Album." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)displayComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setSubject:@"Check out this image!"];
    
    // Set up recipients
    // NSArray *toRecipients = [NSArray arrayWithObject:@"first@example.com"];
    // NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    // NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
    
    // [picker setToRecipients:toRecipients];
    // [picker setCcRecipients:ccRecipients];
    // [picker setBccRecipients:bccRecipients];
    
    // Attach an image to the email
    UIImage *coolImage = [self captureViewFrom:content.superview];
    NSData *myData = UIImagePNGRepresentation(coolImage);
    [picker addAttachmentData:myData mimeType:@"image/png" fileName:@"coolImage.png"];
    
    // Fill out the email body text
    NSString *emailBody = @"My cool image is attached";
    [picker setMessageBody:emailBody isHTML:NO];
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Result: canceled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Result: saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Result: sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Result: failed");
            break;
        default:
            NSLog(@"Result: not sent");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)print
{
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    //pic.delegate = del;
    
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = [NSString stringWithFormat:@"New Ticket"];
    pic.printInfo = printInfo;
    
    
    pic.printingItem = [self captureViewFrom:content.superview];
    
    void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
    ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
        if (!completed && error) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error."
                                                         message:[NSString stringWithFormat:@"An error occured while printing: %@", error]
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil, nil];
            
            [av show];
        }
    };
    
    [pic presentAnimated:YES completionHandler:completionHandler];
}

#pragma marks Prices

-(IBAction)priceMenu_Clicked:(id)sender{
        [passwordDialog showLeftTriangle];
        if (passwordDialog.hidden) {
            [self createFackeButton];
            [passwordDialog setHidden:NO];
            [passwordDialog.superview bringSubviewToFront:passwordDialog];
        } else if (![passwordDialog isLeftVisible]){
            [passwordDialog setHidden:YES];
        }
}


#pragma marks extended features

-(void)updateDetails
{
    int modulesCount = [self countModules];
    NSString *moduleWord = modulesCount == 1? @"Module" : @"Modules";
    cabinetModelLabel.text = [NSString stringWithFormat:@"Cabinet %@\n%d %@", cabinet.model.name, [self countModules], moduleWord];
    
    [self updatePrices];
}

-(int)countModules
{
    int modulesCounter = 1;
    
    if (cabinet.module2.size.code) {
        modulesCounter++;
        if (cabinet.module3.size.code) {
            modulesCounter++;
            if (cabinet.module4.size.code) {
                modulesCounter++;
            }
        }
    }

    return modulesCounter;
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
        double price = [pricesManager getCabinetPrice:cabinet];
        [priceView setText:[NSString stringWithFormat:@"%.2f €", price]];
        [priceView setHidden:NO];
        [priceButton setUserInteractionEnabled:NO];
    } else {
        [priceView setHidden:YES];
        [priceButton setUserInteractionEnabled:YES];
    }
    showSummaryButton.enabled = [[IWPriceManager getInstance] authenticated];
}

-(IBAction)viewSummaryClick:(id)sender
{
    IWCabinetSummaryViewController *summaryViewController = [[IWCabinetSummaryViewController alloc] initWithNibName:@"IWSummaryViewController" bundle:Nil];
    [self presentViewController:summaryViewController animated:YES completion:Nil];
    [summaryViewController showSummaryForCabinet:cabinet];
}

@end
