//
//  IWBaseViewController.m
//  Catalog
//
//  Created by Abel Miranda on 3/10/15.
//  Copyright (c) 2015 Indian Webs. All rights reserved.
//

#import "IWBaseViewController.h"

@interface IWBaseViewController ()

@end

@implementation IWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
