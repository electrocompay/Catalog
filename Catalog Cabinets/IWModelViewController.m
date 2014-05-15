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

@interface IWModelViewController ()

@end

@implementation IWModelViewController{
    
    BrowserTabView *tabController;
    IWModelSelectorViewController *selectorModelView;
    IWSelectorViewController *selectorTopView;
    IWSelectorViewController *selectorSideView;
    IWMultipleSelectorViewController *selectorDoorsView;
    IWSelectorViewController *selectorChairColorView;
    IWSelectorViewController *selectorChairLegsColorView;
    IWDrawerCabinet *drawer;
    IWCabinet *cabinet;
    IBOutlet UIImageView* selectorView;
    IBOutlet IWMenuView *menu;
    IBOutlet IWMenuView *homeMenu;
    UIView* thumbView;
    IWDrawerCabinet *thumbDrawer;
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
    cabinet = [[IWCabinet alloc] init];
    drawer = [[IWDrawerCabinet alloc] init];
    drawer.view = content;
    
    thumbView = [[UIView alloc] init];
    thumbView.frame = selectorView.frame;
    
    thumbDrawer = [[IWDrawerCabinet alloc] init];
    thumbDrawer.view = thumbView;
    
    tabController= [[BrowserTabView alloc] initWithTabTitles:[NSArray arrayWithObjects:@"1. Model",@"2. Top",@"3. Side", @"4. Doors", @"4. Legs"/*, @"4. M1 Color", @"5. M2 Color", @"6. M3 Color", @"7. M4 Color"*/, nil] andDelegate:self];
    
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
        
        selectorModelView = [[IWModelSelectorViewController alloc] initWithNibName:@"IWModelSelectorViewController" bundle:nil];
        [selectorModelView setCabinet:cabinet];
        [selectorModelView setDelegate:self];
        [tabContent addSubview:selectorModelView.view];
        selectorModelView.view.frame = tabContent.bounds;
        //  [selectorModelView setItems:colors];
        
        selectorTopView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
        [selectorTopView setPropertyName:@"table color"];
        [self prepareSelector:selectorTopView withColors:[IWColors tableColors]];
        [selectorTopView setFilteredItems:cabinet.model.colors];
        
        selectorSideView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
        [selectorSideView setPropertyName:@"side color"];
        [self prepareSelector:selectorSideView withColors:[IWColors tableColors]];
        [selectorSideView setFilteredItems:cabinet.model.legColors];
        
        selectorDoorsView = [[IWMultipleSelectorViewController alloc] initWithNibName:@"IWMultipleSelectorViewController" bundle:nil];
        [selectorDoorsView setPropertyName:@"Doors"];
        [selectorDoorsView setCabinet:cabinet];
        [selectorDoorsView setDelegate:self];
        [tabContent addSubview:selectorDoorsView.view];
        selectorDoorsView.view.frame = tabContent.bounds;
        
        /*       selectorChairColorView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
         [selectorChairColorView setPropertyName:@"chair color"];
         [self prepareSelector:selectorChairColorView withColors:[IWColors chairColors]];
         [selectorChairColorView setFilteredItems:chair.model.colors];*/
         
         selectorChairLegsColorView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
         [selectorChairLegsColorView setPropertyName:@"leg color"];
         [self prepareSelector:selectorChairLegsColorView withColors:[IWColors tableLegColors]];
         [selectorChairLegsColorView setFilteredItems:cabinet.model.legColors];
        
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
            selectorModelView = [[IWModelSelectorViewController alloc] initWithNibName:@"IWModelSelectorViewController" bundle:nil];
        }else {
            [tabContent bringSubviewToFront:selectorModelView.view];
        }
    } else if (index == 1){
        if (!selectorTopView) {
            selectorTopView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
            [self prepareSelector:selectorTopView withColors:[IWColors tableColors]];
        } else {
            [tabContent bringSubviewToFront:selectorTopView.view];
        }
        [selectorTopView setFilteredItems:cabinet.model.colors];
    } else if (index == 2){
        if (!selectorSideView) {
            selectorSideView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
            [self prepareSelector:selectorSideView withColors:[IWColors tableLegColors]];
        } else {
            [tabContent bringSubviewToFront:selectorSideView.view];
        }
        [selectorSideView setFilteredItems:cabinet.model.legColors];
    } else if (index == 3){
        [tabContent bringSubviewToFront:selectorDoorsView.view];
    } /*else if (index == 4){
        if (!selectorChairColorView) {
            selectorChairColorView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
            [self prepareSelector:selectorChairColorView withColors:[IWColors chairColors]];
        } else {
            [tabContent bringSubviewToFront:selectorChairColorView.view];
        }
        [selectorChairColorView setFilteredItems:cabinet.model.colors];
    }*/ else if (index == 4){
        if (!selectorChairLegsColorView) {
            selectorChairLegsColorView = [[IWSelectorViewController alloc] initWithNibName:@"IWSelectorViewController" bundle:nil];
            [self prepareSelector:selectorChairLegsColorView withColors:[IWColors chairLegColors]];
        } else {
            [tabContent bringSubviewToFront:selectorChairLegsColorView.view];
        }
        [selectorChairLegsColorView setFilteredItems:cabinet.model.legColors];
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
    
    if (selectorViewController == selectorTopView)
    {
        [cabinet setTop:color];
    } else if (selectorViewController == selectorSideView)
    {
        [cabinet setSide:color];
    } else if (selectorViewController == selectorChairLegsColorView)
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
    [selectorDoorsView setCabinet:cabinet];
    [self drawAll];
}

-(void)didSelectColor:(IWMultipleSelectorViewController *)selectorViewController andColor:(IWColor *)color andIndex:(NSInteger)index
{
    [self drawAll];
}

- (IBAction)changeView_Click:(id)sender
{
    [drawer setFrontView:!drawer.frontView];
    [self drawAll];
}

-(void)drawAll
{
    [drawer clear];
    [drawer drawForniture:cabinet];
    [thumbDrawer setFrontView:!drawer.frontView];
    [thumbDrawer clear];
    [thumbDrawer drawForniture:cabinet];
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
                NSString* pdfFilename = [self generatePDF];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"File Saved" message:[NSString stringWithFormat:@"File %@ saved Successfully", pdfFilename] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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

-(NSString*)generatePDF
{
    // assume this exists and is in some writable place, like Documents
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* pdfFilename = [documentsDirectory stringByAppendingPathComponent:@"filename.pdf"];
    
    // Create the PDF context
    UIGraphicsBeginPDFContextToFile(pdfFilename, CGRectZero, nil); // default page size
    UIGraphicsBeginPDFPageWithInfo(CGRectZero, nil);
    
    // Draw the UIImage -- I think PDF contexts are flipped, so you may have to
    // set a transform -- see the documentation link below if your image draws
    // upside down
    UIImage* image = [self captureViewFrom:content];
    [image drawAtPoint:CGPointZero];
    
    // Ending the context will automatically save the PDF file to the filename
    UIGraphicsEndPDFContext();
    return pdfFilename;
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
