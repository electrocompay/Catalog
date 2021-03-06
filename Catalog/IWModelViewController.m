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
    UIButton * button;
    UIButton * button2;
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
        
        if ([chair.model.name isEqualToString:@"Rafael-A"] || [chair.model.name isEqualToString:@"Rafael-S"]) {
            selectorChairColorView.items = [[IWColors chairColors] withoutColor:@"15"];
        }
    } else if (selectorViewController == selectorChairColorView)
    {
        [chair setColor:color];
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

@end
