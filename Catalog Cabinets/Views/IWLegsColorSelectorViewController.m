//
//  IWLegsColorSelectorViewController.m
//  Catalog
//
//  Created by Abel Miranda on 5/22/14.
//  Copyright (c) 2014 Indian Webs. All rights reserved.
//

#import "IWLegsColorSelectorViewController.h"

@interface IWLegsColorSelectorViewController ()

@end

@implementation IWLegsColorSelectorViewController
{
    IBOutlet UISwitch *_swithShowLegs;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

-(IBAction)switchShowLegs:(id)sender
{
    _cabinet.showLegs = _swithShowLegs.on;
    if (self.delegate) {
        [self.delegate didSelectColor:self andColor:self.selectedColor];
    }

}

@end
