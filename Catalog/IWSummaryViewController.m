//
//  IWSummaryViewController.m
//  Catalog
//
//  Created by Abel Miranda on 3/4/15.
//  Copyright (c) 2015 Indian Webs. All rights reserved.
//

#import "IWSummaryViewController.h"
#import "IWUtils.h"

@interface IWSummaryViewController ()

@end

@implementation IWSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)closeClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}

-(IBAction)saveClick:(id)sender
{
    [[IWUtils getInstance] generateJPG:self.view completionTarget:self completionSelector:@selector(saveCompletion:didFinishSavingWithError:contextInfo:)];
}

-(IBAction)sendEmailClick:(id)sender
{
    [[IWUtils getInstance] displayComposerSheet:self.view viewC:self];
}

-(IBAction)printClick:(id)sender
{
    [[IWUtils getInstance] printView:self.view];
}

- (void)saveCompletion:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo: (void *) contextInfo
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Saved" message:@"Image saved successfully to Photo Album." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


@end
