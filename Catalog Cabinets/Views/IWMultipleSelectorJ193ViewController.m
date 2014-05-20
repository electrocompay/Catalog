//
//  IWMultipleSelectorJ193ViewController.m
//  Catalog
//
//  Created by Abel Miranda on 5/19/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWMultipleSelectorJ193ViewController.h"
#import "IWColors.h"

@interface IWMultipleSelectorJ193ViewController ()

@end

@implementation IWMultipleSelectorJ193ViewController
{
    IBOutlet UIButton *oldOak;
    IBOutlet UIButton *smokeOak;
    IWColor *oldOakProp;
    IWColor *smokeOakProp;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        for (IWColor *color in [IWColors cabinetColors]) {
            if ([color.code isEqualToString:@"34"]) {
                oldOakProp = color;
            } else if ([color.code isEqualToString:@"35"]) {
                smokeOakProp = color;
            }
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)select_click:(id)sender
{
    if (sender == oldOak) {
        oldOak.selected = YES;
        smokeOak.selected = NO;
        self.cabinet.stripe = oldOakProp;
    } else if (sender == smokeOak){
        smokeOak.selected = YES;
        oldOak.selected = NO;
        self.cabinet.interiorColor = smokeOakProp;
    }
    if (self.delegate) {
        [self.delegate didSelectColor:self andColor:self.selectedColor andIndex:0];
    }
}

-(void)setCabinet:(IWCabinet *)cabinet
{
    [super setCabinet:cabinet];
    if (!cabinet.interiorColor) {
        cabinet.interiorColor = oldOakProp;
        if (self.delegate) {
            [self.delegate didSelectColor:self andColor:self.selectedColor andIndex:0];
        }
    }
}

@end
