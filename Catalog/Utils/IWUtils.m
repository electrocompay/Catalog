//
//  IWUtils.m
//  Catalog
//
//  Created by Abel Miranda on 3/9/15.
//  Copyright (c) 2015 Indian Webs. All rights reserved.
//

#import "IWUtils.h"
#import "IWAppDelegate.h"

IWUtils* utils;

@implementation IWUtils

+(IWUtils *)getInstance
{
    if (!utils) {
        utils = [[IWUtils alloc] init];
    }
    return utils;
}

-(void)generateJPG:(UIView *)view completionTarget:(id)completionTarget completionSelector:(SEL)completionSelector
{
    UIImage* image = [self captureViewFrom:view];
    
    UIImageWriteToSavedPhotosAlbum(image, completionTarget, completionSelector, nil);
    
}

-(UIImage *)captureViewFrom:(UIView *)view
{
        CGRect rect = [view bounds];
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [view.layer renderInContext:context];
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
}

-(void)printView:(UIView *)view
{
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    //pic.delegate = del;
    
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = [NSString stringWithFormat:@"New Ticket"];
    pic.printInfo = printInfo;
    
    
    pic.printingItem = [self captureViewFrom:view];
    
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

-(void)displayComposerSheet:(UIView *)view viewC:(UIViewController *)viewC
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
    UIImage *coolImage = [self captureViewFrom:view];
    NSData *myData = UIImagePNGRepresentation(coolImage);
    [picker addAttachmentData:myData mimeType:@"image/png" fileName:@"coolImage.png"];
    
    // Fill out the email body text
    NSString *emailBody = @"My cool image is attached";
    [picker setMessageBody:emailBody isHTML:NO];
    [viewC presentViewController:picker animated:YES completion:nil];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
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
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}


@end
