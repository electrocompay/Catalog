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

@interface IWModelViewController ()

@end

@implementation IWModelViewController{
    
    BrowserTabView *tabController;
    IWSelectorViewController *selectorModelView;
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
}

-(void)viewDidAppear:(BOOL)animated
{
    if (!selectorModelView) {
        
        selectorModelView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
        [selectorModelView setPropertyName:@"table model"];
        [self prepareSelector:selectorModelView withColors:[IWColors tableModels]];
        
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
        if (!selectorModelView) {
            selectorModelView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
            [self prepareSelector:selectorModelView withColors:[IWColors tableModels]];
        }else {
            [tabContent bringSubviewToFront:selectorModelView.view];
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
        [selectorChairColorView setFilteredItems:chair.model.colors];
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
    return NO;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}

-(void)didSelectColor:(IWSelectorViewController *)selectorViewController andColor:(IWColor *)color
{
    if (selectorViewController == selectorModelView)
    {
        [table setModel:(IWModel*) color];
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
            [selectorChairLegsColorView setItems:legsColors];
        } else {
            wood.file = @"Wood.jpg";
            [selectorChairLegsColorView setItems:legsColors];
        }
        
        NSInteger index = [[IWColors chairModels] indexOfObject:color];
        if (index >= 0) {
            if (index == 4 || index == 5 || index==13 || index==14) {
                [selectorChairColorView setItems:[self colorsRemoveIndex:[IWColors chairColors] index:12]];
            } else {
                [selectorChairColorView setItems:[IWColors chairColors]];
            }
        }
    } else if (selectorViewController == selectorChairColorView)
    {
        [chair setColor:color];
    } else if (selectorViewController == selectorChairLegsColorView)
    {
        [chair setLegsColor:color];
    }
    [self drawAll];
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

    [drawerChair drawForniture:chair];
    [drawer drawForniture:table];
    [thumbDrawerChair setFrontView:!drawer.frontView];
    [thumbDrawer setFrontView:!drawer.frontView];

    [thumbDrawer clear];
    [thumbDrawerChair drawForniture:chair];
    [thumbDrawer drawForniture:table];
    [selectorView setImage:[self captureViewFrom:thumbView]];
}

-(IBAction)changeMenuClick:(id)sender
{
    if (menu.hidden)
    {
        [homeMenu setHidden:YES];
        [menu setHidden:NO];
    } else
    {
        [menu setHidden:YES];
    }
}

-(IBAction)changeHomeMenuClick:(id)sender
{
    if (homeMenu.hidden)
    {
        [menu setHidden:YES];
        [homeMenu setHidden:NO];
    } else
    {
        [homeMenu setHidden:YES];
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

-(void)menuView:(IWMenuView *)menuView didClick:(NSInteger)optionIndex
{
    if (menuView == menu)
    {
        switch (optionIndex) {
            case 0: //Save
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Saved" message:@"Image saved successfully to Photo Album." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
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

-(void)generateJPG
{
    UIImage* image = [self captureViewFrom:content];
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
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
    UIImage *coolImage = [self captureViewFrom:content];
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
    
    
    pic.printingItem = [self captureViewFrom:content];
    
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

@end
